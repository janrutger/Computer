# Project Stern: CPU/Computer Simulation

**Mission Accomplished: A Complete, Debuggable Microcoded CPU Simulation**

The core mission of developing a CPU/computer simulation has been successfully achieved and expanded. The system now features a complete hardware simulation, the **Stern-XT**, built with Pygame, which includes a feature-rich, interactive debugger. This provides a robust platform for developing and testing assembly language programs for the Stern architecture.

## System Overview

The "Stern" computer system simulates a complete computer architecture, including a CPU, RAM, and peripheral devices. The CPU executes instructions defined by microcode programs, allowing for a flexible and extensible Instruction Set Architecture (ISA). The system is designed to be debugged and tested from the command line.

### In-Depth Architecture

This repository implements a full-fledged, custom-built computer system called **Stern-XT**. It's not just a single program, but an entire ecosystem that includes a custom CPU, peripheral devices, an assembly language, and the toolchain to compile and run software for it.

Here’s a deeper look at the key components:

#### 1. The Hardware Core (`devices/` directory)

This is the heart of the simulation. It’s a collection of Python classes that emulate the hardware components of the Stern-XT computer:

*   **`cpu.py`**: Implements the Central Processing Unit (CPU). A key feature is that it's a **microcode-based CPU**. This means its instruction set is not hardwired. Instead, it loads a `stern_rom.json` file at startup, which defines the instructions it can execute. This makes the CPU's instruction set completely customizable.
*   **`memory.py`**: Simulates the 16KB of RAM. It's a simple byte-addressable memory block.
*   **`interrupt_controller.py`**: Manages hardware interrupts from peripheral devices, allowing them to signal the CPU for attention.
*   **`keyboard.py`**: Captures keystrokes from your real keyboard and sends keyboard interrupts to the CPU.
*   **`VirtualDisk.py`**: A fascinating device that simulates a disk drive. It allows the Stern-XT computer to read and write to files in the `Vdisk0/` directory on your actual machine, effectively giving the simulated computer persistent storage.
*   **`UDC.py` (Universal Device Controller)**: A generic controller that allows for connecting other, more abstract devices like the `sensor.py` and `plotter.py`. This is a good example of an extensible I/O system.

#### 2. The Toolchain (`microcode_assembler/` and `assembler/` directories)

You can't write software for a new computer without a compiler or assembler. This project has a two-layered toolchain:

*   **`microcode_assembler/`**: This is the lower-level tool. It reads `.uasm` files (microcode assembly) and compiles them into the `stern_rom.json` file. This is where you **define the CPU's instruction set**. For example, you could define what the `ADD` instruction does at the CPU's most fundamental level. The `base_rom.uasm` file contains the standard instruction set for the Stern-XT.
*   **`assembler/`**: This is the higher-level tool, the one you would use to write actual programs. It reads `.asm` files (Stern-XT assembly language) and assembles them into a `program.bin` file. Crucially, this assembler is **"smart"**. It reads the `stern_rom.json` file to understand the available instructions, their opcodes, and their formats. This means if you add a new instruction in the microcode, the assembler will automatically be able to use it.

#### 3. The Main Application (`stern-XT.py` and `Makefile`)

*   **`stern-XT.py`**: This is the main executable that brings everything together. It:
    *   Initializes all the hardware devices (CPU, memory, keyboard, etc.).
    *   Loads the `program.bin` file into the simulated memory.
    *   Starts the CPU in a separate thread.
    *   Runs the main Pygame loop to render the display and handle user input.
    *   Includes the interactive debugger.
*   **`Makefile`**: This file automates the build process. It defines commands like:
    *   `make`: Assembles both the microcode and the ISA assembly code to produce the final `program.bin`.
    *   `make run`: Runs the simulation.
    *   `make debug`: Runs the simulation with the debugger enabled.
    *   `make clean`: Removes the compiled files.

### Summary of the Workflow

1.  **Define the ISA**: You write microcode in a `.uasm` file to define the instructions your CPU will understand.
2.  **Assemble the Microcode**: You run `make` (or the `microcode_assembler` directly) to create `stern_rom.json`.
3.  **Write a Program**: You write a program in Stern-XT assembly language in a `.asm` file.
4.  **Assemble the Program**: You run `make` again (or the `assembler` directly) to create `program.bin`.
5.  **Run the Simulation**: You execute `make run` or `python3 stern-XT.py` to boot up your virtual computer and run the program.

### Internal Architecture Overview

```
 computer
    test.asm --> ISA Assembler --> program.bin --> memory
                                     ^
                                     | (depends on)
                                     |
    .uasm files --> Microcode Assembler --> stern_rom.json --> cpu(memory)
                                                                general purpose registers (GPR)
                                                                Special Registers         (SR)
                                                                Flags                     (FLAGS)
                                                                microcode executer (loads from stern_rom.json)

    Peripherals (Keyboard, SIO, Display) <--> Interrupt Controller <--> CPU

    Debugger <--> CPU & Memory
```

## Stern-XT Hardware

The Stern-XT is the primary hardware simulation, implemented in `stern-XT.py`. It uses the Pygame library to provide a graphical display and handle keyboard input. The hardware simulation is responsible for initializing the CPU, memory, and all peripheral devices.

### Memory Map (16KB Total)

This architecture uses a sophisticated, segmented memory model:

| Address Range (Decimal) | Description                               |
| ----------------------- | ----------------------------------------- |
| 0 - 1023                | Loader                                    |
| 1024 - 3071               | Kernel                                    |
| 3072 - 4095               | Interrupt / SYSCALL Vectors               |
| 4096 - 12287              | Program & Free Memory                     |
| 12288 - 14335             | Data and I/O Region  This region is centered around the $VAR_START address (12288) and is split: • Upward (12288 ->): For static program variables and arrays. • Downward (<- 12287): For memory-mapped hardware device registers                     |
| 14336 - 16383             | Video & Stack Region This region is centered around the $VIDEO_MEM address (14336) and is also split: • Upward (14336 ->): The video display buffer. • Downward (<- 14335): The system stack, which grows towards the program data area.       |

### Key Architectural Summary:
* OS Space (0 - 4095): The lower 4KB of memory are dedicated to the foundational OS components (Loader, Kernel, Vectors), creating a protected system area.
* User Space (4096 - 16383): The upper 12KB are for user applications and their data.
* Efficient Memory Pools: The design cleverly creates two flexible data regions. The program's static data grows upwards from $VAR_START, while the stack grows downwards from below $VIDEO_MEM. This allows the two regions to expand towards each other, making maximum use of the available memory.
* Standardized I/O: Device registers are neatly organized in the memory space just below $VAR_START, providing a consistent interface for hardware communication.              |

### Devices

The Stern-XT hardware supports a variety of peripheral devices, each running in its own thread:

*   **Display:** A Pygame window that renders the video memory.
*   **Keyboard:** Captures key presses from the Pygame window and sends interrupts to the CPU.
*   **SIO (Serial I/O):** A placeholder for future serial communication.
*   **Interrupt Controller:** Manages interrupts from devices and communicates them to the CPU.

## The Stern-XT Debugger

A powerful, interactive command-line debugger is integrated into the Stern-XT simulation. It allows for in-depth analysis and control of the CPU and memory.

### Activating the Debugger

To start the simulation with the debugger active, use the `-debug` flag:

```bash
python3 stern-XT.py -debug
```

This will start the simulation and automatically set a breakpoint at the first instruction (address 0).

### Debugger Commands

The debugger provides a rich set of commands for controlling the simulation and inspecting its state:

| Command                      | Alias | Description                                                     |
| ---------------------------- | ----- | --------------------------------------------------------------- |
| `step`                       | `s`   | Execute one full instruction                                    |
| `continue`                   | `c`   | Continue execution to the next breakpoint                       |
| `quit`                       | `q`   | Quit the simulation                                             |
| `breakpoint <addr>`          | `b`   | Set a breakpoint at `<addr>`                                    |
| `removebreakpoint <addr>`    | `rb`  | Remove a breakpoint from `<addr>`                               |
| `listbreakpoints`            | `lb`  | List all active breakpoints                                     |
| `inspect [addr]`             | `i`   | Inspect 16 bytes of memory at `[addr]` or the last address      |
| `next`                       | `n`   | Inspect the next 16 bytes of memory                             |
| `prev`                       | `p`   | Inspect the previous 16 bytes of memory                         |
| `memmap`                     |       | Show the memory map and pointers                                |
| `help`                       | `?`   | Show the help message                                           |

## CPU Details

The CPU operates on a standard Fetch-Decode-Execute cycle.

### Registers

*   **General Purpose Registers (GPRs):** 10 registers (R0 - R9), where R0 is also the designated Index register.
*   **Special Registers:**
    *   `PC` (Program Counter)
    *   `SP` (Stack Pointer)
    *   `MIR` (Memory Instruction Register)
*   **Internal ALU Registers:** `Ra`, `Rb` (used for arithmetic and logic operations).

### Flags

*   `Z` (Zero-flag)
*   `N` (Negative-flag)
*   `E` (Equal-flag)
*   `S` (Status flag): Used as a facing flag to the CPU, compatible with ISA `tst`, `tste`, `tstg` instructions.

### Microcode Execution

The CPU executes microcode instructions stored in a Python dictionary, acting as a ROM file. The microcode executer is called with the opcode and its arguments.

**Supported Microcode Instructions:**

*   `read_mem_reg(Rx, Ry)`: Reads the memory address in Rx and places the value in Ry.
*   `read_mem_adres(adres, Rx)`: Reads the memory address and places the value in Rx.
*   `load_immediate(Rx, value)`: Loads a value into register Rx.
*   `move_reg(Rx, Ry)`: Moves the value from Ry into Rx.
*   `alu_add()`: `Ra + Rb -> Ra` (sets status flags).
*   `alu_sub()`: `Ra - Rb -> Ra` (sets status flags).
*   `alu_mul()`: `Ra * Rb -> Ra` (sets status flags).
*   `alu_div()`: `Ra / Rb -> Ra` (sets status flags).
*   `alu_inc()`: `Ra + 1 -> Ra` (sets status flags).
*   `alu_dec()`: `Ra - 1 -> Ra` (sets status flags).
*   `alu_cmp()`: Sets status flags based on `Ra` and `Rb`.
*   `store_mem_reg(Rx, Ry)`: Stores the value of Ry at the address in Rx.
*   `store_mem_adres(adres, Rx)`: Stores the value of Rx at the address.
*   `bra(n-lines)`: Branch Always (relative jump in microcode).
*   `brz(n-lines)`: Branch if Zero flag is set.
*   `brn(n-lines)`: Branch if Negative flag is set.
*   `beq(n-lines)`: Branch if Equal flag is set.
*   `brs(n-lines)`: Branch if Status flag is set.
*   `set_cpu_state(STATE)`: Sets the CPU state (FETCH, DECODE, EXECUTE, HALT).
*   `set_status_bit(BOOLEAN)`: Sets the Status flag (TRUE or FALSE).

## Instruction Set Architecture (ISA)

The ISA supports a maximum of 90 instructions, indicated by two-digit numbers from 10 to 99.

### Instruction Types and Decoding

*   **Zero Operand:** `opcode` (e.g., `nop` = "10", `halt` = "11")
*   **One Operand:**
    *   `opcode + address` (e.g., `jmp 10` = "2210")
    *   `opcode + register` (e.g., `push R2` = "902")
*   **Two Operand:**
    *   `opcode + register + address` (e.g., `inc R0 100` = "800100")
    *   `opcode + register + register` (e.g., `add R2 R1` = "5021")
    *   `opcode + register + value` (e.g., `addi R4 42` = "51442")
### Reference ISA as designed for the first generation Stern systems

| | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | NOP | HALT | RET | EI | DI | RTI | | | | |
| 2 | JMPF | JMPT | JMP | JMPX | CALL | CALLX | INT | CXTSW | | |
| 3 | LD | LDI | LDM | LDX | | | | | | |
| 4 | STO | STX | | | | | | | | |
| 5 | ADD | ADDI | SUB | SUBI | SUBR | | | | | |
| 6 | MUL | MULI | DIV | DIVI | DIVR | DMOD | | | | |
| 7 | TST | TSTE | TSTG | | | | | | | |
| 8 | INC | DEC | ANDI | XORX | | | | | | |
| 9 | PUSH | POP | | | | | | | | |			


## Assembler Suite

The project includes a suite of assemblers for both microcode and ISA-level programming.

### ISA Assembler

This assembler translates high-level assembly language (`.asm` files) into machine-executable binary code (`program.bin`). Its "smartness" and understanding of the instruction set are derived from the microcode assembler's output (`stern_rom.json`).

### Microcode Assembler

The microcode assembler compiles microcode assembly (`.uasm` files) into a JSON ROM file (`stern_rom.json`), which defines the CPU's instruction set.

#### Microcode Assembly (.uasm) Format

The `.uasm` files define the microcode routines that constitute the CPU's instruction set. Each routine corresponds to an ISA opcode and specifies the sequence of micro-operations the CPU executes for that instruction.

**Key Elements:**

*   **Directives:**
    *   `.name <name_of_rom>`: Defines the base name for the output JSON ROM file.
    *   `.append <name_of_file>`: Appends the compiled microcode to an existing JSON ROM file.
    *   `.registers <name1> <name2> ...`: Maps the 10 GPRs to friendly names for the ISA Assembler.

*   **Routine Definition:**
    *   `def <id>=<name> { <instructions> }`: Defines a microcode routine.
        *   `<id>`: The unique two-digit opcode (e.g., `10`, `21`).
        *   `<name>`: A human-readable name for the routine (e.g., `NOP`, `JMPT`).
        *   `<instructions>`: One or more microcode instructions.
    *   `def <id>=<name> { <instructions> } /replace`: If `/replace` is specified, an existing routine with the same ID will be overwritten.
    *   **`.format` Directive:** Within a `def` block, `.format <scheme>` signals the encoding scheme to the CPU and ISA assembler. Valid schemes: `zero`, `one_addr`, `one_reg`, `two_reg_reg`, `two_reg_addr`, `two_reg_val`.

*   **Microcode Instructions:**
    *   Each line within a routine defines a single micro-operation.
    *   Syntax: `instruction_name(arg1, arg2, ...)`
    *   Arguments can be:
        *   **Literals:** Numeric values or boolean (`TRUE`, `FALSE`).
        *   **Special Registers:** `PC`, `SP`, `Ra`, `Rb`.
        *   **General Purpose Registers (GPRs):** `R0` through `R9` (represented as single digits `0-9` in the microcode instruction arguments).
        *   **Runtime Operands:** `$1`, `$2` (reflecting `arg1` and `arg2` passed from the ISA instruction).

*   **Branching with Labels:**
    *   Labels are local to each routine and are defined with a colon (e.g., `:start`).
    *   Branch instructions (`bra`, `brz`, `brn`, `beq`, `brs`) use labels to specify jump targets. The assembler calculates the relative offset.

*   **Comments:**
    *   **Line Comments:** Start with `#` and are ignored by the assembler.
    *   **Inline Comments:** Start with `;` after an instruction. These comments are preserved in the JSON output and can be used for logging/debugging.