#!/usr/bin/env python

import pygame
import threading
import time
import sys
import os

from cpu import CPU
from memory import Memory
from devices.interrupt_controller import InterruptController
from devices.keyboard import Keyboard
from devices.sio import SIO

# --- Constants ---
# Memory Map
MEM_SIZE = 16384
MEM_LOADER_START = 0
MEM_KERNEL_START = 1024
MEM_INT_VECTORS_START = 3072
MEM_PROG_START = 4096
MEM_VAR_START = 12288
MEM_IO_END = 12287 # IO devices map downwards from here
MEM_VIDEO_START = 14336
MEM_STACK_END = 14335 # Stack grows downwards from here

# Display
SCREEN_WIDTH_CHARS = 80
SCREEN_HEIGHT_CHARS = 24
CHAR_WIDTH = 10
CHAR_HEIGHT = 20
WINDOW_WIDTH = SCREEN_WIDTH_CHARS * CHAR_WIDTH
WINDOW_HEIGHT = SCREEN_HEIGHT_CHARS * CHAR_HEIGHT

BG_COLOR = (0, 0, 20) # Dark Blue
FG_COLOR = (200, 200, 200) # Light Grey

# Device Memory Locations
MEM_KBD_I0_BASE = MEM_VAR_START -8
MEM_KEYBOARD_DATA = MEM_KBD_I0_BASE + 0 # Keyboard data register at the top of the I/O space


# --- CPU Thread ---
class CpuThread(threading.Thread):
    """Runs the CPU in a background thread."""
    def __init__(self, cpu):
        super().__init__()
        self.cpu = cpu
        self.daemon = True
        self._running = True

    def run(self):
        """Main loop for the CPU."""
        while self._running and self.cpu.state != "HALT":
            try:
                self.cpu.tick()
                # The time.sleep() can be adjusted to control the CPU speed
                # A shorter sleep means a faster CPU.
                time.sleep(1)
            except Exception as e:
                print(f"FATAL CPU Runtime Error: {e}", file=sys.stderr)
                self.cpu.state = "HALT"

    def stop(self):
        self._running = False

# --- Main Application ---
def main():
    # 1. Initialize Pygame
    pygame.init()
    screen = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
    pygame.display.set_caption("Stern-XT Computer")
    font = pygame.font.SysFont('monospace', 18)
    clock = pygame.time.Clock()

    # 2. Initialize Shared Components
    ram = Memory(size=MEM_SIZE)
    interrupt_controller = InterruptController(ram)

    # Register keyboard data address with the interrupt controller
    # Assuming a default interrupt vector for the keyboard, e.g., 0
    KEYBOARD_INTERRUPT_VECTOR = 0 # Define a vector for keyboard interrupts
    interrupt_controller.register_data_address(KEYBOARD_INTERRUPT_VECTOR, MEM_KEYBOARD_DATA)

    # Function to load program.bin into memory
    def load_program_bin(memory, file_path):
        try:
            with open(file_path, 'r') as f:
                program_lines = f.readlines()
            
            # Load program into memory
            loaded_instructions = 0
            for line in program_lines:
                parts = line.strip().split()
                if len(parts) == 2:
                    address = int(parts[0])
                    value = parts[1]
                    memory.write(address, value)
                    loaded_instructions += 1
                elif parts: # If line is not empty but doesn't have 2 parts
                    print(f"Warning: Skipping malformed line in program.bin: {line.strip()}", file=sys.stderr)
            print(f"Loaded {loaded_instructions} instructions from {file_path} into memory.")
        except FileNotFoundError:
            print(f"Error: program.bin not found at {file_path}", file=sys.stderr)
            sys.exit(1)
        except Exception as e:
            print(f"Error loading program.bin: {e}", file=sys.stderr)
            sys.exit(1) 

    # Load the program
    program_bin_path = os.path.join(os.path.dirname(__file__), 'bin', 'program.bin')
    load_program_bin(ram, program_bin_path)

    # 3. Initialize CPU and Peripherals
    cpu = CPU(ram, interrupt_controller)
    cpu.PC = MEM_LOADER_START # Set PC to the start of the loaded program
    keyboard = Keyboard(interrupt_controller, vector=KEYBOARD_INTERRUPT_VECTOR)
    sio = SIO(ram, interrupt_controller)

    # 4. Create and Start Background Threads
    print("Starting background threads (CPU, SIO)...")
    cpu_thread = CpuThread(cpu)
    
    cpu_thread.start()
    sio.start() # SIO still runs in the background for future plotter use

    # 5. Main GUI Loop
    print("Starting GUI... Press keys in the window to generate interrupts.")
    running = True
    while running and cpu_thread.is_alive():
        # --- Event Handling ---
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            # Pass keyboard events to the keyboard device
            if event.type == pygame.KEYDOWN:
                keyboard.handle_key_event(event)

        # --- Drawing Logic --- 
        screen.fill(BG_COLOR)

        # Read the screen buffer from memory and render it
        for y in range(SCREEN_HEIGHT_CHARS):
            for x in range(SCREEN_WIDTH_CHARS):
                mem_addr = MEM_VIDEO_START + (y * SCREEN_WIDTH_CHARS) + x
                char_code = int(ram.read(mem_addr))
                if char_code > 0:
                    char_surface = font.render(chr(char_code), True, FG_COLOR)
                    screen.blit(char_surface, (x * CHAR_WIDTH, y * CHAR_HEIGHT))

        # --- Update Display ---
        pygame.display.flip()
        clock.tick(30) # Limit to 30 FPS

    # 6. Shutdown
    print("GUI loop exited. Halting system...")
    cpu_thread.stop()
    sio.stop()
    pygame.quit()
    print("System shutdown complete.")
    # A small delay to allow background threads to print final messages
    time.sleep(0.001)

if __name__ == "__main__":
    main()