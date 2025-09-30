# Stern-XT Computer Emulation: Fact Sheet

This document provides a comprehensive overview of the Stern-XT computer emulation project, detailing its architecture, components, and capabilities.

## 1. Core Hardware Simulation

The Stern-XT is a complete, emulated computer system built with Python and Pygame. It serves as the foundation for running the custom-designed CPU and interacting with its peripheral devices.

### 1.1. CPU

The heart of the Stern-XT is a custom-designed, microcode-driven CPU.

-   **Architecture**: Operates on a Fetch-Decode-Execute cycle.
-   **ISA**: The Instruction Set Architecture is not fixed. It is defined by a microcode ROM (`stern_rom.json`), allowing for a fully customizable instruction set of up to 90 unique instructions.
-   **Registers**:
    -   10 General-Purpose Registers (GPRs): `R0` through `R9`.
    -   Special Registers: `PC` (Program Counter), `SP` (Stack Pointer), `MIR` (Memory Instruction Register).
    -   Internal ALU Registers: `Ra`, `Rb`.
-   **Flags**: `Z` (Zero), `N` (Negative), `E` (Equal), `S` (Status).
-   **Interrupts**: Features a full interrupt handling system, including context saving/restoring via shadow registers.

### 1.2. Memory

The system features a 16KB (16384 bytes) unified memory space with a pre-defined memory map for different system components.

-   **Total Size**: 16KB
-   **Memory Map**:
    -   `0 - 1023`: **Loader**: The initial bootloader program.
    -   `1024 - 3071`: **Kernel**: The main operating system kernel and Stacks interpreter.
    -   `3072 - 4095`: **Interrupt Vector Table**: Pointers to interrupt service routines.
    -   `4096 - 12287`: **Program Space**: For user programs and libraries.
    -   `12288 - 14335`: **Variable/IO Space & Stack**: Used for global variables, memory-mapped I/O devices, and the system stack (which grows downwards).
    -   `14336 - 16255`: **Video Memory**: A direct-mapped region for the 80x24 character text display.

### 1.3. Interrupt Controller

The `InterruptController` manages hardware interrupts from peripheral devices.

-   **Function**: Queues interrupt requests to prevent them from being lost.
-   **Process**: The CPU checks for pending interrupts, acknowledges them, and jumps to the appropriate Interrupt Service Routine (ISR) defined in the Interrupt Vector Table.

## 2. Development Toolchain

The project includes a sophisticated toolchain for creating both the CPU's instruction set and the software that runs on it.

### 2.1. Microcode Assembler

This tool allows developers to define the CPU's behavior at the most fundamental level.

-   **Input**: `.uasm` files containing microcode definitions.
-   **Output**: `stern_rom.json`, which defines the CPU's complete Instruction Set Architecture (ISA).
-   **Functionality**: Developers can create new instructions, assign opcodes, and specify operand formats (e.g., `two_reg_val`, `one_addr`). This provides immense flexibility in designing the CPU's capabilities.

### 2.2. ISA Assembler

This is the primary tool for writing software for the Stern-XT.

-   **Dynamic ISA**: The assembler is not hard-coded to a specific instruction set. It dynamically reads the `stern_rom.json` file at runtime to learn the available instructions, their mnemonics, opcodes, and formats.
-   **Input**: `.asm` assembly language files.
-   **Output**: A `program.bin` file containing machine code executable by the Stern-XT CPU.
-   **Features**:
    -   Supports labels, constants, and variables.
    -   Handles multiple symbol scopes (local, global subroutines, memory addresses).
    -   Includes directives for memory allocation (`.`), constants (`EQU`), and file inclusion (`include`).
    -   Supports complex, multi-file builds via a `build.json` configuration.

## 3. BIOS and Operating System

The Stern-XT runs a simple, custom-built BIOS and OS, assembled from several modules.

-   **`os_loader`**: The initial program loaded into memory. It is responsible for setting up the system, initializing hardware (like the Virtual Disk), and loading the OS kernel.
-   **`os_kernel`**: The core of the operating system. It contains the command-line interpreter and the Stacks language runtime.
-   **`os_lib_loader`**: Responsible for loading additional libraries and programs into memory.

## 4. Hardware Subsystems

The Stern-XT can be extended with various peripheral devices.

### 4.1. Virtual Disk

A memory-mapped device that simulates a file system.

-   **Functionality**: Allows the CPU to create, read, write, and manage files.
-   **Implementation**: The virtual disk maps files on the host machine's file system (in the `Vdisk0/` directory) into the Stern-XT environment.
-   **Interaction**: The CPU communicates with the disk via a set of memory-mapped registers, using a command/status handshake protocol to perform operations like `OPEN`, `READ`, `WRITE`, and `CLOSE`.
-   **File Identification**: Files are identified by a 64-bit hash of their filename, not by the string name itself.

### 4.2. Universal Device Controller (UDC)

A standardized interface for communicating with a wide range of peripheral devices.

-   **Architecture**: Acts as an abstraction layer between the CPU and devices like plotters, sensors, etc.
-   **Communication**: The CPU interacts with the UDC through a block of memory-mapped registers, selecting a channel and sending commands.
-   **Handshake**: A status register is used to manage a handshake protocol, ensuring reliable, stateful communication.
-   **Extensibility**: New devices can be created by inheriting from a `UDCDevice` base class in Python and implementing a `handle_command` method.

### 4.3. Y-Plotter

A UDC-based device for data visualization.

-   **Technology**: Uses `matplotlib` to render a real-time plot in a separate window.
-   **Functionality**: The CPU sends Y-values to the plotter via the UDC. The plotter automatically increments an internal X-counter for each value, creating a time-series graph.
-   **Commands**: Supports commands to clear the plot (`NEW`), send a Y-value (`SEND`), and change the plot color (`COLOR`).

### 4.4. Virtual LCD Screen

A UDC-based device that provides a powerful, pixel-addressable display.

-   **Technology**: Uses `tkinter` and `Pillow` to render a 640x480 screen.
-   **Color**: Supports a 16-color palette.
-   **Drawing Modes**:
    -   **Pixel Mode**: The CPU can set the color of individual pixels by specifying X/Y coordinates and a color index.
    -   **Sprite Mode**: The CPU can draw 8x8 sprites by specifying a character/sprite index from a loaded `lcd_sprites.json` ROM.
-   **Buffering**: Supports both direct rendering and double-buffering (`FLIP` command) for smooth, flicker-free animation.
-   **Interaction**: The CPU sends commands via the UDC to set the drawing mode (`MODE`), color (`COLOR`), X/Y coordinates, and to trigger a draw (`DRAW`) or buffer flip (`FLIP`).

## 5. Built-in Software

### 5.1. Command-Line Interface (CLI)

The OS kernel provides an interactive command-line interface, allowing users to execute commands, run programs, and inspect the system.

### 5.2. Stacks Language

A high-level, Forth-like programming language integrated into the OS, providing a powerful environment for interaction and development.

-   **Paradigm**: A stack-based language using postfix notation (e.g., `10 20 +`). All operations manipulate a central data stack.

-   **Execution Modes**:
    -   **Immediate Mode (REPL)**: A Read-Eval-Print Loop for interactive use. Commands are typed and executed immediately, making it ideal for quick calculations, testing logic, and inspecting variables. For example: `5 dup * print` will display `25`.
    -   **Program Mode**: For running complete programs. This mode uses a three-phase process (Scan, Compile, Execute) that translates Stacks code into bytecode. This enables complex structures like functions and control flow.

-   **Syntax and Features**:
    -   **Functions**: Reusable blocks of code can be defined with `def my_func { ... }` and called by name.
    -   **Labels**: Named locations for `goto` jumps, defined as `:mylabel`.
    -   **Memory Access**: Read from memory with `@` (fetch) and write to memory with `!` (store).

-   **Core Instructions**:
    -   **Stack**: `dup`, `swap`, `drop`, `over`
    -   **Arithmetic**: `+`, `-`, `*`, `/`, `mod`
    -   **Comparison**: `==`, `!=`, `>`, `<`
    -   **Control Flow**: `goto`, `if/else/end`, `while/do/done`, `ret`
    -   **I/O**: `print`, `&io`

-   **Hardware Access**: The special `&io` command provides a high-level interface to the Universal Device Controller (UDC), allowing Stacks programs to easily send commands and data to any connected peripheral device.

## 6. Debugging

The Stern-XT simulation includes a powerful, interactive command-line debugger for in-depth analysis of the CPU and memory.

-   **Activation**: The debugger can be activated by running the simulation with the `-debug` flag or by setting breakpoints in the code.
-   **Execution Control**:
    -   `step` (`s`): Execute one full high-level instruction.
    -   `microstep` (`ms`): Execute a single micro-code instruction (one clock tick).
    -   `continue` (`c`): Run until the next breakpoint is hit.
-   **Breakpoints**: Users can set (`b`) and remove (`rb`) breakpoints at any memory address to pause execution at specific points.
-   **Inspection**: The debugger can inspect memory (`i`), view the complete memory map (`memmap`), and dump the full CPU state (registers and flags).
