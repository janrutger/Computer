# ===============================================================
#
#      The Official Stern-Microcode Developer's Guide
#
#                     (2025 Edition)
#
# ===============================================================

## FOREWORD

Welcome, developer, to the Stern-Microcode Assembler System. This guide
provides all the necessary information for you to design and implement your
very own Instruction Set Architecture (ISA) for the Stern CPU. By leveraging
the power of microcode, you can create a highly customized and efficient
set of instructions, tailored to your specific application needs. Please
ensure you have at least 1MB of available disk space before proceeding.

This system is designed for maximum flexibility, allowing the discerning
programmer to define a full ISA of up to 90 unique instructions.

---

## 1. The .uasm File Format

All microcode definitions are stored in plain-text files with the
`.uasm` extension. The assembler reads these files to generate a
`stern_rom.json` file, which the Stern CPU uses as its microcode ROM.

### 1.1 Directives

Directives are special commands to the assembler that control the output
of the ROM. They must appear at the beginning of the file.

*   `.name <rom_name>`
    *   **Purpose:** Defines the base name for the output JSON ROM file.
    *   **Example:** `.name "stern_rom"` will produce `stern_rom.json`.

*   `.append <filename>`
    *   **Purpose:** Appends the compiled microcode to an existing ROM file.
      This is useful for creating modular instruction sets.
    *   **Example:** `.append "base_isa.json"`

*   `.registers <name1> <name2> ...`
    *   **Purpose:** Maps the 10 General Purpose Registers (R0-R9) to
      friendly names for use in the high-level ISA Assembler.
    *   **Example:** `.registers I A B C K L M X Y Z`

### 1.2 Routine Definition

Each instruction in your ISA is defined as a "routine".

*   `def <id>=<name> { ... }`
    *   **Purpose:** Defines a microcode routine.
    *   `<id>`: A unique two-digit opcode (10-99).
    *   `<name>`: A human-readable name for the instruction (e.g., `NOP`).
    *   `{ ... }`: Contains the sequence of micro-operations.

*   `def <id>=<name> { ... } /replace`
    *   **Purpose:** If `/replace` is specified, an existing routine with the
      same ID will be overwritten. Use with caution.

### 1.3 The .format Directive

Inside a `def` block, you must specify the instruction's operand format.
This tells the CPU how to decode the instruction from memory.

*   **Valid Formats:**
    *   `zero`: No operands (e.g., `NOP`).
    *   `one_addr`: Opcode + address (e.g., `JMP 100`).
    *   `one_reg`: Opcode + register (e.g., `PUSH R1`).
    *   `two_reg_reg`: Opcode + register + register (e.g., `ADD R1 R2`).
    *   `two_reg_addr`: Opcode + register + address (e.g., `LD R1 100`).
    *   `two_reg_val`: Opcode + register + value (e.g., `ADDI R1 42`).

### 1.4 Labels and Comments

*   **Labels:** Define jump targets for branch instructions within a routine.
  Labels are local to a routine and are defined with a colon.
    *   **Example:** `:loop_start`

*   **Comments:**
    *   `#`: A full-line comment.
    *   `;`: An in-line comment. These are preserved in the ROM for debugging.

---

## 2. Microcode Instruction Set

These are the fundamental operations available for building your ISA routines.

*   `set_cpu_state(STATE)`: Sets the CPU state. `FETCH` should be the last
  operation of almost every routine.
    *   **States:** `FETCH`, `DECODE`, `EXECUTE`, `HALT`.

*   `set_status_bit(BOOLEAN)`: Sets the 'S' (Status) flag.
    *   **Values:** `TRUE`, `FALSE`.

*   `load_immediate(Rx, value)`: Loads a literal value into a register.
    *   **Example:** `load_immediate(R1, 42)`

*   `move_reg(Rx, Ry)`: Moves the value from register Ry into Rx.
    *   **Example:** `move_reg(Ra, R5)`

*   `alu(OP)`: Performs an Arithmetic Logic Unit operation. Result is stored
  in `Ra`. Sets Z, N, and E flags.
    *   **OPs:** `ADD`, `SUB`, `MUL`, `DIV`, `INC`, `DEC`, `CMP`.
    *   **Note:** `CMP` only sets flags; it does not modify `Ra`.

*   `branch(FLAG, label)`: Conditional jump to a label.
    *   **FLAGs:**
        *   `A`: Always
        *   `E`: Equal (E flag)
        *   `Z`: Zero (Z flag)
        *   `N`: Negative (N flag)
        *   `S`: Status (S flag)
    *   **Example:** `branch(Z, zero_handler)`

*   `store_mem_adres(address, Rx)`: Stores the value of Rx at a memory address.

*   `store_mem_reg(Rx, Ry)`: Stores the value of Ry at the address held in Rx.

*   `read_mem_adres(address, Rx)`: Reads from a memory address into Rx.

*   `read_mem_reg(Rx, Ry)`: Reads from the memory address held in Rx into Ry.

### 2.1 Runtime Operands

Your microcode can use operands from the high-level instruction.

*   `$1`: The first operand from the ISA instruction.
*   `$2`: The second operand from the ISA instruction.

---

## 3. How to Design Your Own ISA

1.  **Conceptualize:** Plan your instructions on paper. Decide what they do,
  what their names are, and what operands they will take.

2.  **Assign Opcodes:** Assign a unique two-digit opcode (from 10 to 99)
  to each instruction.

3.  **Create .uasm File:** Create a new file, for example, `my_isa.uasm`.

4.  **Define Directives:** Add the `.name` and `.registers` directives at the
  top of your file.

5.  **Write Routines:** For each instruction, create a `def` block.

6.  **Set Format:** Inside each `def` block, specify the correct `.format`.

7.  **Implement Microcode:** Write the sequence of micro-instructions that
  will execute your ISA instruction. Remember to end with
  `set_cpu_state(FETCH)`.

8.  **Assemble:** Run the assembler from your command prompt:
    `python microcode_assembler/assembler.py my_isa.uasm`

9.  **Test:** Load your generated `.json` ROM into the Stern CPU and write
  a test program in your new assembly language!

## 4. EXAMPLE: A `TSTE` (Test-Equal) instruction

```uasm
def 71=TSTE {
    .format two_reg_reg
    move_reg(Ra, $1)        ; Move first operand to Ra
    move_reg(Rb, $2)        ; Move second operand to Rb
    alu(CMP)                ; Compare Ra and Rb, setting flags
    branch(E, true)         ; If Ra == Rb (E flag), branch to 'true'
    set_status_bit(FALSE)   ; Set S to FALSE if not equal
    branch(A, end)          ; Skip to 'end'
:true
    set_status_bit(TRUE)    ; Set S to TRUE if equal
:end
    set_cpu_state(FETCH)    ; Return to FETCH state
}
```

---

## 5. The High-Level ISA Assembler

The Stern system includes a second, powerful assembler for writing programs
in the assembly language you design. This assembler (`assembler/assembler.py`)	ranslates your `.asm` source files into a `program.bin` file that the
Stern CPU can execute.

The most powerful feature of this assembler is its ability to adapt *dynamically*
to your custom ISA. It does this by reading the `stern_rom.json` file that
your microcode assembler creates.

When the ISA assembler starts, it:
1.  Loads the `stern_rom.json` file.
2.  Reads the `"instructions"` map to learn the mnemonics (like `ADD` or `LDI`),
their opcodes, and their required `.format`.
3.  Reads the `"register_map"` to learn the friendly names you assigned
(like `A`, `B`, `C`) with the `.registers` directive.

This means that if you add a new instruction to your `.uasm` file and
reassemble it, the ISA assembler will automatically understand the new
instruction without any need for reprogramming! This creates a seamless and
efficient workflow for developing and testing your own computer architecture.

**Example `.asm` usage:**

```asm
# My test program

LDI A, 42       ; Uses the LDI instruction (two_reg_val)
LDI B, 10       ; and the register names A and B.

ADD A, B        ; The assembler knows ADD takes two registers.

STO A, 2000     ; Store the result at memory address 2000.

HALT
```

This concludes the Stern-Microcode Developer's Guide. Good luck, and may
your processing be swift.

# ===============================================================
