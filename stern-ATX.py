#!/usr/bin/env python

import pygame
import time
import sys
import os
import cProfile
import pstats

from devices.cpu_m1 import CPU_M1 as CPU
# from devices.cpu import CPU

from devices.memoryR2 import Memory
from devices.interrupt_controller import InterruptController
from devices.keyboard import Keyboard
from devices.debugger import Debugger
from devices.VirtualDisk import VirtualDisk
from devices.UDC import UDC
from devices.sensor import Sensor
from devices.plotter import Plotter
from devices.lcd_screen import VirtualLCD
from devices.rtc import RTC


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
MEM_KBD_I0_BASE   = MEM_VAR_START    - 8    # Keyboard device base adres (max 8 registers)
MEM_KEYBOARD_DATA = MEM_KBD_I0_BASE  + 0    # Keyboard data register at the top of the I/O space
MEM_VDSK_I0_BASE  = MEM_KBD_I0_BASE  - 8    # Virtual Disk registers start here (max 8 registers)
MEM_UDC_I0_BASE   = MEM_VDSK_I0_BASE - 24   # UDC virtual controler starts here (max 24 registers)
MEM_RTC_IO_ADRES  = MEM_UDC_I0_BASE  - 1    # RTC memory IO adres (just one register)


# --- Main Application ---
def main():
    # 1. Initialize Pygame
    pygame.init()
    screen = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
    pygame.display.set_caption("Stern-ATX Computer (Synchronous Burst)")
    font = pygame.font.SysFont('monospace', 18)
    clock = pygame.time.Clock()

    # 2. Initialize Shared Components
    ram = Memory(size=MEM_SIZE)
    interrupt_controller = InterruptController(ram)

    # Register keyboard data address with the interrupt controller
    KEYBOARD_INTERRUPT_VECTOR = 0   # Define a vector for keyboard interrupts
    interrupt_controller.register_data_address(KEYBOARD_INTERRUPT_VECTOR, MEM_KEYBOARD_DATA)
    RTC_INTERRUPT_VECTOR = 1        # Define the RTC interrupt
    interrupt_controller.register_data_address(RTC_INTERRUPT_VECTOR, MEM_RTC_IO_ADRES)


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
    debug_mode = "-debug" in sys.argv
    #debug_mode = True      # use this when running in VScode debug mode
    cpu = CPU(ram, interrupt_controller, debug_mode=debug_mode)
    cpu.registers["PC"] = MEM_LOADER_START # Set PC to the start of the loaded program
    keyboard = Keyboard(interrupt_controller, vector=KEYBOARD_INTERRUPT_VECTOR)
    rtc = RTC(interrupt_controller, vector=RTC_INTERRUPT_VECTOR)

    vdisk = VirtualDisk(ram, MEM_VDSK_I0_BASE, "bin/apps")
    udc = UDC(ram, MEM_UDC_I0_BASE)
    debugger = Debugger(cpu, ram)

    # Initialize UDC devices
    sensor1  = Sensor(udc, 0)  # Connect a sensor to channel 0
    plotter1 = Plotter(udc, 1) # Connect a plotter to channel 1
    lcd = VirtualLCD(udc, 2)   # connect an lcd to channel 2

    # Check for debug flag
    if debug_mode:
        debugger.add_breakpoint(0)

    # 4. Main Loop
    print("Starting Stern-ATX System...")
    start_time = time.time()
    
    running = True
    
    # Tuning: BURST_SIZE determines how many CPU cycles run per screen refresh.
    # Higher = Faster CPU, Lower = More responsive GUI.
    BURST_SIZE = 5000
    TARGET_FPS = 60

    while running:
        # --- Event Handling ---
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            # Pass keyboard events to the keyboard device
            if event.type == pygame.KEYDOWN:
                keyboard.handle_key_event(event)

        # --- CPU Burst ---
        # Run a burst of cycles if not halted and not paused by debugger
        if not debugger.in_debug_mode and cpu.state != "HALT":
            for _ in range(BURST_SIZE):
                # Check for breakpoints (Optimization: only check on FETCH)
                if cpu.state == "FETCH" and cpu.registers["PC"] in debugger.breakpoints:
                    debugger.enter_debug_mode()

                cpu.tick()
                
                if cpu.state == "HALT":
                    running = False
                    break

                if cpu.state == "SLEEP":
                    break

        # --- Device Ticks ---
        # Devices tick once per frame/burst
        if not debugger.in_debug_mode:
             rtc.tick()
             vdisk.access()
             udc.tick()
             sensor1.tick()
             plotter1.tick()
             lcd.tick()

             

        # --- Drawing Logic ---
        # plotter1.draw()  # turned of since the FLIP device instruction makes the plotter draw
        lcd.draw()

        if ram.is_video_dirty():
            ram.unset_video_dirty_flag()
            screen.fill(BG_COLOR)
            for y in range(SCREEN_HEIGHT_CHARS):
                for x in range(SCREEN_WIDTH_CHARS):
                    mem_addr = MEM_VIDEO_START + (y * SCREEN_WIDTH_CHARS) + x
                    char_code = int(ram.read(mem_addr))
                    if char_code > 0:
                        char_surface = font.render(chr(char_code), True, FG_COLOR)
                        screen.blit(char_surface, (x * CHAR_WIDTH, y * CHAR_HEIGHT))
            pygame.display.flip()

        # --- Housekeeping ---
        time.sleep(0) # Yield to OS
        # clock.tick(TARGET_FPS) # Maintain stable frame rate

    # 5. Shutdown
    end_time = time.time()
    print("GUI loop exited. Halting system...")

    # --- Performance Stats ---
    print("\n--- Simulation Performance ---")
    elapsed_time = end_time - start_time
    total_instructions = cpu.instructions_executed
    total_cycles = cpu.cycles_executed

    if elapsed_time > 0 and total_instructions > 0 and total_cycles > 0:
        cpi = total_cycles / total_instructions
        core_speed = total_cycles / elapsed_time
        ips = total_instructions / elapsed_time

        # Format Core Speed
        core_speed_val, core_speed_unit = (core_speed / 1_000_000, "MHz") if core_speed > 1_000_000 else ((core_speed / 1_000, "kHz") if core_speed > 1_000 else (core_speed, "Hz"))
        
        # Format IPS
        ips_val, ips_unit = (ips / 1_000_000, "MIPS") if ips > 1_000_000 else ((ips / 1_000, "kIPS") if ips > 1_000 else (ips, "IPS"))

        print(f"  Total Simulation Time : {elapsed_time:.2f} seconds")
        print(f"  Total Cycles (ticks)  : {total_cycles:,}")
        print(f"  Total Instructions    : {total_instructions:,}")        
        print(f"  Average Core Speed    : {core_speed_val:.2f} {core_speed_unit}")
        print(f"  Average CPI           : {cpi:.2f} Cycles/Instruction")
        print(f"  Average Performance   : {ips_val:.2f} {ips_unit} (Instructions/Second)\n")


    pygame.quit()
    print("System shutdown complete.")
    time.sleep(0.002)

if __name__ == "__main__":
    profile = False

    if profile:
        profiler = cProfile.Profile()
        try:
            profiler.enable()
            main()
        finally:
            profiler.disable()
            print("\n--- CProfile Results ---")
            stats = pstats.Stats(profiler).sort_stats('cumulative')
            stats.print_stats(20)
    else:
        main()
    