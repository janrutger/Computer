# Project Stern-XT: A Complete Virtual Computer Ecosystem

## Overview

Welcome to Project Stern-XT, a comprehensive, simulated computer system. This repository contains a complete, vertically integrated environment, from a custom-designed CPU and hardware peripherals to a unique high-level programming language, compiler, and operating system.

It is a hands-on playground for learning how computers *really* work, with the feel of building and programming a classic 8-bit or 16-bit home computer from the ground up.

## Project Quality & Fun Factor

This project is both **high-quality** and incredibly **fun** for anyone interested in computer science fundamentals.

*   **Extremely Comprehensive:** It's a full-stack environment, including a microcode-driven CPU, hardware simulation, an assembler, a high-level language ("Stacks"), a compiler, and a basic operating system.
*   **Well-Documented:** With a Developer's Guide, a language manual, and numerous READMEs, the project is designed to be understood and used by others.
*   **Educational:** It provides a fantastic environment for learning and experimenting with the core concepts of computing. You can explore everything from CPU design to compiler construction.
*   **Creative Freedom:** The entire system is open for modification. You can write your own games and applications, add new instructions to the CPU, or even extend the operating system.

## Architecture

The Stern-XT is a full-stack system, with each layer building on the one below it.

#### 1. Hardware & CPU Simulation (`devices/`, `stern-XT.py`)
At the lowest level is the Stern-XT hardware emulator, written in Python. It simulates a custom CPU, RAM, and peripherals like a screen, keyboard, and virtual disk. The CPU's instruction set is defined by microcode, making it highly flexible.

#### 2. Microcode Assembler (`microcode_assembler/`)
This tool compiles microcode source files (`.uasm`) into a `stern_rom.json` file. This file defines the instruction set for the simulated CPU, allowing its architecture to be easily modified and extended.

#### 3. Assembler (`assembler/`)
The assembler translates Stern-XT assembly code (`.asm`) into a `program.bin` file. This binary contains the machine code that the emulated computer runs. It dynamically reads the `stern_rom.json` to know what instructions are available.

#### 4. The "Stacks" Language & Compiler (`compiler/`)
"Stacks" is a custom, high-level programming language designed for this project. It is a stack-oriented language that uses Reverse Polish Notation (RPN), similar to Forth. The compiler translates Stacks code (`.stacks`) into Stern-XT assembly.

#### 5. Operating System & Kernel (`compiler/src/kernel_files/`)
The system runs a basic operating system and kernel written almost entirely in the Stacks language itself. These modules provide fundamental functionalities like system calls and hardware interaction.

## Getting Started

The project uses `make` to automate the build and execution process.

*   **Build the default program:**
    ```bash
    make
    ```

*   **Run the emulator:**
    ```bash
    make run
    ```

*   **Run with the interactive debugger:**
    ```bash
    make debug
    ```

*   **Build and run a specific program** (e.g., `maze.stacks`):
    ```bash
    make maze run
    ```

## Example Program: `maze.stacks`

To give you a taste of what's possible, here is a simple program written in Stacks that generates and draws a maze-like pattern on the screen.

```stacks
# maze.stacks
#
# Generates a simple random maze on the virtual LCD screen.

# --- Variable Declarations ---
VALUE X 0
VALUE Y 0

# --- Function Definitions ---

# Initializes the LCD screen on UDC channel 2
DEF screen {
  0 AS X
  0 AS Y
  IO 2 ONLINE   ; Bring screen online
  IO 2 NEW      ; Clear the screen
  3 IO 2 COLOR  ; Set draw color to Cyan
  3 IO 2 MODE   ; Set to Sprite mode with double buffering
}


# --- Main Program ---

screen  ; Initialize the screen

# Loop through each row (Y)
WHILE Y 60 < DO
  # Loop through each column (X)
  WHILE X 80 < DO
    # Generate a random number to decide between wall and path
    RND 2 * 999 // 0 == IF
        129 IO 2 DRAW  ; Draw a wall sprite ('/')
    ELSE
        130 IO 2 DRAW  ; Draw a path sprite ('\')
    END
    X 1 + AS X
    X IO 2 X         ; Set next X coordinate
  DONE
  IO 2 FLIP          ; Flip the buffer to show the completed row
  0 AS X
  X IO 2 X           ; Reset X coordinate for next row
  Y 1 + AS Y
  Y IO 2 Y           ; Set next Y coordinate
DONE
```