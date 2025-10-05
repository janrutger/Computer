# Stern-XT Developer's Guide

## Introduction

Welcome to the Stern-XT computer project! This guide provides instructions on how to build, run, and develop software for the Stern-XT virtual computer. The project includes a compiler for the "Stacks" language, an assembler, and an emulator for the Stern-XT hardware.

## Project Structure

The project is organized into the following main directories:

- `assembler/`: Contains the assembler for the Stern-XT CPU.
  - `asm/`: Source code for the OS, libraries, and other assembly programs.
- `compiler/`: Contains the compiler for the Stacks language.
  - `src/`: Source code for programs written in Stacks (`.stacks` files).
    - `libs/`: Libraries for the Stacks language.
    - `kernel_stacks/`: Kernel modules written in Stacks.
- `devices/`: Emulated hardware devices for the Stern-XT computer (CPU, Memory, Screen, etc.).
- `microcode_assembler/`: The assembler for the CPU's microcode.
- `bin/`: Output directory for compiled binaries, including the final `program.bin` ROM.
- `Vdisk0/`: The virtual disk for the emulator.

## Build System (`Makefile`)

The project uses `make` to automate the build process. The main configuration is in `Makefile.mk`.

### Common Commands

- **Build the default program:**
  ```bash
  make
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