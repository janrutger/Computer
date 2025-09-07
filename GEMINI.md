# Project Stern: CPU/Computer Simulation

**Mission Accomplished: A Complete, Debuggable Microcoded CPU Simulation**

The core mission of developing a CPU/computer simulation has been successfully achieved and expanded. The system now features a complete hardware simulation, the **Stern-XT**, built with Pygame, which includes a feature-rich, interactive debugger. This provides a robust platform for developing and testing assembly language programs for the Stern architecture.

## System Overview

The "Stern" computer system simulates a complete computer architecture, including a CPU, RAM, and peripheral devices. The CPU executes instructions defined by microcode programs, allowing for a flexible and extensible Instruction Set Architecture (ISA). The system is designed to be debugged and tested from the command line.

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
| 14336 - 16383             | Video & Stack Region This region is centered around the $VIDEO_MEM address (14336) and is also split: • Upward (14336 ->): The video display buffer. • Downward (<- 14335): The system stack, which grows towards the program data area.       

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
