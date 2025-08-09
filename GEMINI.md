# Project Stern: CPU/Computer Simulation

**Mission Accomplished: Microcoded CPU Simulation Core Implemented**

The core mission of developing a CPU/computer simulation where ISA instructions are designed as small microcode programs running on the CPU's core in Python, with the CPU handling decimal numbers, has been successfully achieved. This foundational element is now in place, providing a robust platform for further development and exploration of computer architecture.

## System Overview

The "Stern" computer system simulates a basic computer architecture with a CPU and RAM. The CPU executes instructions defined by microcode programs, allowing for a flexible and extensible Instruction Set Architecture (ISA).

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
```

(future)
    keyboard(memory)
    display(memory)
    SIO(memory)

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

## Memory Details

*   **Capacity:** 4K of RAM memory.
*   **Data Storage:** Stores data as variable-length numeric strings (e.g., "15879"). Invalid strings (e.g., "dg4895") are not allowed.

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

The ISA handles different addressing methods by having a specific instruction per method (e.g., `LD`, `LDI`, `LDM`, `LDX`).

## Assembler Suite

### ISA Assembler

This assembler translates high-level assembly language (`.asm` files) into machine-executable binary code (`program.bin`). Its "smartness" and understanding of the instruction set are derived from the microcode assembler's output (`stern_rom.json`).

### Microcode Assembler

**Achieved: New Microcode Assembler Implemented and Integrated**

A new assembler to compile microcode assembly has been successfully implemented. This assembler is now a core component of the project, enabling dynamic definition of the CPU's instruction set. The ISA assembler also depends on the output of this microcode assembler for its "smartness" regarding opcode definitions.

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
    *   Example:
        ```uasm
        :loop_start
            ; some instructions
            bra(loop_start) ; Jumps back to loop_start
        ```

*   **Comments:**
    *   **Line Comments:** Start with `#` and are ignored by the assembler.
    *   **Inline Comments:** Start with `;` after an instruction. These comments are preserved in the JSON output and can be used for logging/debugging.
    *   Example: `set_cpu_state(FETCH) ; Reset CPU state`

**Example .uasm Routine:**

```uasm
.name stern_rom
.registers I A B C K L M X Y Z

def 71=TSTE {
    .format two_reg_reg
    move_reg(Ra, $1)        ; Move first operand to Ra
    move_reg(Rb, $2)        ; Move second operand to Rb
    alu_cmp()               ; Compare Ra and Rb, setting flags
    beq(true)               ; If Ra == Rb (E flag is true), branch to 'true'
    set_status_bit(FALSE)   ; Set S to FALSE if not equal
    bra(end)                ; Skip to 'end'
:true
    set_status_bit(TRUE)    ; Set S to TRUE if equal
:end
    set_cpu_state(FETCH)    ; Return to FETCH state
}

def 72=TSTG {
    .format two_reg_reg
    move_reg(Ra, $1)        ; Move first operand to Ra
    move_reg(Rb, $2)        ; Move second operand to Rb
    alu_sub()               ; Perform Ra - Rb, setting flags
    brz(+3)                 ; If Ra == Rb (Z flag is true), branch to set S to FALSE
    brn(+2)                 ; If Ra < Rb (N flag is true), branch to set S to FALSE
    set_status_bit(TRUE)    ; Set S to TRUE if Ra > Rb
    bra(+1)                 ; Skip the next instruction
    set_status_bit(FALSE)   ; Set S to FALSE if Ra <= Rb
    set_cpu_state(FETCH)    ; Return to FETCH state
}
```

## Error Handling

*   The assembler stops compiling at an invalid instruction or directive.
*   The assembler stops compiling at a duplicate ID in the current or appended file.
