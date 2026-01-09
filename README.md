# Project Stern-ATX: The Next-Generation Virtual Computer Ecosystem

## Overview

Welcome to **Project Stern-ATX**, the high-performance evolution of the Stern-XT virtual computer system. This repository contains a complete, vertically integrated environment, from custom-designed CPU architectures and hardware peripherals to a unique high-level programming language, compiler, and operating system.

The Stern-ATX platform represents a major architectural shift, transitioning from a string-based emulation environment to a high-performance **integer-based system**. It features a redesigned motherboard capable of hosting interchangeable CPU architectures and specialized co-processors like the GPU_R3.

It remains a hands-on playground for learning how computers *really* work, offering the feel of building and programming a classic system from the ground up, but with modern performance capabilities.

## Key Features

*   **High-Performance Architecture:** The new `MemoryR3` silicon stores data as integers, eliminating runtime type conversions and significantly boosting execution speed.
*   **Swappable CPUs:** The motherboard supports multiple CPU modules:
    *   **CPU-R3 (Hybrid):** The robust, default processor updated for the ATX platform.
    *   **CPU-M1 (Pipeline):** A next-gen architecture featuring a deep instruction pipeline and branch prediction.
*   **Hardware Acceleration:** Includes the **GPU_R3**, a specialized matrix processing unit for high-speed linear algebra and neural network computations.
*   **Full-Stack Environment:** Includes a microcode-driven CPU, hardware simulation, an assembler, the "Stacks" high-level language compiler, and a custom OS kernel.
*   **Educational & Fun:** Explore concepts like pipelining, microcode, compiler design, and OS development in a controlled, documented environment.

## System Architecture

The Stern-ATX is a layered system:

#### 1. Hardware Simulation (`devices/`, `stern-ATX.py`)
At the core is the Stern-ATX motherboard emulator. It manages the 16KB unified memory map, the interrupt controller, and the bus for peripherals.
*   **Memory:** 16KB Integer-based storage.
*   **Peripherals:** Universal Device Controller (UDC), Real Time Clock (RTC @ 30Hz), Virtual Disk, and GPU.

#### 2. Microcode Assembler (`microcode_assembler/`)
Compiles microcode source files (`.uasm`) into the `stern_rom.json` firmware. This defines the instruction set (ISA) for the CPUs, allowing for easy modification and extension of machine instructions.

#### 3. Assembler (`assembler/`)
Translates assembly code (`.asm`) into the `program.bin` machine code. It dynamically adapts to the instruction set defined in the microcode ROM.

#### 4. The "Stacks" Language & Compiler (`compiler/`)
"Stacks" is the system's native high-level programming language. It uses Reverse Polish Notation (RPN) and compiles directly to Stern-ATX assembly. It supports libraries, structures, and inline assembly.

#### 5. Operating System (`compiler/src/kernel_files/`)
The system runs a lightweight OS written in Stacks. It handles system calls, manages the heap, and provides drivers for the UDC devices (Screen, Keyboard, Disk).

## Getting Started

The project uses `make` to automate the build and execution process.

*   **Build and Run (Default CPU-R3):**
    ```bash
    make run
    ```

*   **Run with the M1 Pipeline CPU:**
    You can select the CPU architecture via command-line arguments to the emulator.
    ```bash
    python stern-ATX.py -cpu m1
    ```

*   **Run with the Interactive Debugger:**
    ```bash
    make debug
    ```

*   **Build and Run a Specific Program:**
    ```bash
    make maze run
    ```

## Example Program: `maze.stacks`

Here is a simple program written in Stacks that generates a random maze on the virtual LCD screen.

```stacks
# maze.stacks
# Generates a simple random maze on the virtual LCD screen.

# --- Variable Declarations ---
VALUE X 0
VALUE Y 0

# --- Function Definitions ---
DEF screen {
  0 AS X
  0 AS Y
  IO 2 ONLINE   ; Bring screen online
  IO 2 NEW      ; Clear the screen
  3 IO 2 COLOR  ; Set draw color to Cyan
  3 IO 2 MODE   ; Set to Sprite mode with double buffering
}

# --- Main Program ---
screen  ; Initialize

# Loop through each row (Y)
WHILE Y 60 < DO
  # Loop through each column (X)
  WHILE X 80 < DO
    # Randomly choose wall or path
    RND 2 * 999 // 0 == IF
        129 IO 2 DRAW  ; Draw wall ('/')
    ELSE
        130 IO 2 DRAW  ; Draw path ('\')
    END
    X 1 + AS X
    X IO 2 X         ; Set next X
  DONE
  IO 2 FLIP          ; Show row
  0 AS X
  X IO 2 X           ; Reset X
  Y 1 + AS Y
  Y IO 2 Y           ; Set next Y
DONE
```