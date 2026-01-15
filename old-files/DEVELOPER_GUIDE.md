# Stern-ATX Developer's Guide

## Introduction

Welcome to the **Stern-ATX** computer project! This guide provides instructions on how to build, run, and develop software for the Stern-ATX virtual computer ecosystem.

The Stern-ATX is a high-performance evolution of the previous Stern-XT, featuring an integer-based memory architecture, swappable CPUs (including the pipelined **CPU-M1**), and hardware acceleration via the **GPU_R3**.

## Project Structure

The project is organized into the following main directories:

- `assembler/`: Contains the ISA assembler and linker.
  - `asm/`: Assembly source files and generated output.
    - `apps/`: Compiled application assembly files.
    - `incl/`: Compiled kernel module assembly files.
- `compiler/`: Contains the **Stacks** language compiler.
  - `src/`: Source code for Stacks programs.
    - `libs/`: Standard libraries.
    - `kernel_files/`: OS Kernel modules.
    - `boot_files/`: System bootloaders.
  - `lib/`: Compiled library modules (`.smod`).
- `devices/`: Emulated hardware devices (CPU, Memory, UDC, etc.).
- `documentation/`: Comprehensive system documentation.
- `microcode_assembler/`: Tools for defining the CPU Instruction Set Architecture (ISA).
- `bin/`: Output directory for binaries (`program.bin`, `stern_rom.json`).
- `Vdisk0/`: The virtual disk directory mapped to the emulator.

## Build System (`Makefile`)

The project uses `make` to automate the complex build process, which involves compiling microcode, libraries, the kernel, and user applications. The configuration is defined in `Makefile.mk`.

### Common Commands

- **Build and Run (Default):**
  ```bash
  make run
  ```
  This compiles the default program (`main.stacks`) and assembles the final `program.bin` ROM.

- **Run the emulator:**
  ```bash
  make run
  ```
  This will first build the project and then start the emulator.

- **Build and run a specific program:**
  To build and run a program other than the default, specify its name. For example, to run `fly.stacks`:
  ```bash
  make fly run
  ```

- **Run with the debugger:**
  ```bash
  make debug
  ```
  This runs the emulator with the debugger enabled. You can also specify a program:
  ```bash
  make fly debug
  ```

- **Clean the project:**
  ```bash
  make clean
  ```
  This removes all build artifacts and compiled files.

### How it Works

The build process is as follows:
1.  The `Makefile` compiles any `.stacks` files in `compiler/src/kernel_stacks/` into assembly files located in `assembler/asm/incl/`.
2.  It compiles the main program (e.g., `compiler/src/fly.stacks`) into an intermediate assembly file (`build/main.asm`).
3.  This intermediate file is copied to `assembler/asm/main_stacks.asm`.
4.  The assembler is invoked. It uses `assembler/build.json` to determine which assembly files to include in the final ROM.
5.  The final `program.bin` is written to the `bin/` directory.

## Developing with Stacks

### Writing a Main Program

1.  Create a new `.stacks` file in the `compiler/src/` directory (e.g., `my_program.stacks`).
2.  Add the name of your program (without the extension) to the `MAIN_PROGRAMS` list in `Makefile.mk`.
3.  Build and run your program with `make my_program run`.

### Creating and Using Libraries

The project supports compiling `.stacks` files as libraries (modules) that can be used by other programs.

1.  **Create the library file:** Place your `.stacks` library file in the `compiler/src/libs/` directory.
2.  **Automatic Compilation:** The build system automatically detects these files and compiles them into a module format (`.smod`) using the `--module` flag of the compiler. The output is placed in the `compiler/lib/` directory.
3.  **Usage:** Once compiled, the main programs will be linked with these libraries, and can use the functions and variables defined in them.

### Adding Kernel Modules

1.  Create a new `.stacks` file in the `compiler/src/kernel_stacks/` directory.
2.  The `Makefile` will automatically detect the new file and compile it as part of the build. No further changes to the `Makefile` are needed.

## Running the Emulator

- To run the default program, use `make run`.
- To run a specific program, use `make <program_name> run`.
- To use the debugger, use `make debug` or `make <program_name> debug`.