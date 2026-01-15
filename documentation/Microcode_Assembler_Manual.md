# Stern-ATX Microcode Assembler Manual

## 1. Introduction

The Stern-ATX Microcode Assembler is a command-line tool that translates microcode assembly files (`.uasm`) into a JSON-based ROM file (e.g., `stern_rom.json`). This ROM file defines the complete Instruction Set Architecture (ISA) for the Stern-ATX family of CPUs (including CPU-R3 and CPU-M1).

By writing `.uasm` files, you can create new machine instructions, assign them opcodes, and specify the exact sequence of primitive micro-operations the CPU must perform to execute them.

## 2. Usage

The assembler is run from the command line.

```bash
python3 microcode_assembler/assembler.py [options] <input_file>
```

### Arguments

*   **`<input_file>`**: The path to the source `.uasm` file you want to assemble.
*   **`-o, --output <output_file>`**: (Optional) The name of the output JSON file. If not provided, the name is derived from the `.name` directive within the source file. The output is always placed in the `bin/` directory.

### Example

```bash
# Assemble the base ROM
python3 microcode_assembler/assembler.py microcode_assembler/base_rom.uasm
```

This command will read `base_rom.uasm`, process its contents, and (based on the `.name "stern_rom"` directive inside) produce the file `bin/stern_rom.json`.

## 3. UASM File Syntax

A `.uasm` file consists of top-level directives and a series of instruction definitions. Comments can be added using a semicolon (`;`); everything after the semicolon on a line is ignored.

```uasm
; Top-level directives
.name "my_custom_rom"

; Instruction definition
def 10=NOP {
    .format zero
    set_cpu_state(SLEEP) ; A microinstruction
}
```

## 4. Top-Level Directives

These directives control the overall assembly process and output.

### `.name "rom_name"`

Specifies the base name for the output JSON ROM file. For example, `.name "stern_rom"` will result in `stern_rom.json`. This is a required directive if you are not specifying an output file with the `-o` flag.

### `.append "path/to/base_rom.json"`

Loads an existing ROM file before processing the current file. This allows you to extend or modify a base ROM. New instruction definitions will be added to the set. If you define an instruction with an opcode that already exists in the base ROM, you must use the `/replace` flag, or the assembler will raise an error.

### `.registers <alias1> <alias2> ...`

This directive is a convention for documenting the friendly alias names for registers (e.g., `I` for `R0`, `A` for `R1`). The microcode assembler itself does not use these aliases for substitution, but the main ISA assembler (`assembler.py`) may use them.

**Example from `base_rom.uasm`:**
```uasm
.registers I A B C K L M X Y Z
```

## 5. Instruction Definition (`def`)

The core of a `.uasm` file is the set of instruction definitions. Each `def` block creates one machine instruction for the CPU.

### Syntax

```uasm
def <opcode>=<mnemonic> [/replace] {
    ... body ...
}
```

*   **`<opcode>`**: A unique integer (typically 0-99) that identifies the instruction in machine code.
*   **`<mnemonic>`**: The human-readable name for the instruction used in assembly language (e.g., `LDI`, `ADD`, `JMP`).
*   **`[/replace]`**: An optional flag. If you are using `.append` to load a base ROM, you must include `/replace` to overwrite an existing instruction that has the same opcode.
*   **`{ ...body... }`**: The block containing the microcode that implements the instruction.

## 6. Instruction Body

Inside the `{}` block, you define the instruction's behavior and its operand format.

### `.format` Directive

This directive is crucial. It tells the main ISA assembler how to parse the operands for this machine instruction from the raw machine code.

*   **Syntax**: `.format <format_name>`
*   **Valid Formats**:
    *   `zero`: No operands (e.g., `HALT`).
    *   `one_reg`: One register operand (e.g., `PUSH R1`).
    *   `one_addr`: One address/value operand (e.g., `JMP 1024`).
    *   `two_reg_reg`: Two register operands (e.g., `ADD R1, R2`).
    *   `two_reg_val`: One register and one immediate value (e.g., `LDI R1, 42`).
    *   `two_reg_addr`: One register and one memory address (e.g., `STO R1, 2000`).

### Microinstructions

These are the 13 primitive operations the CPU can execute in a single clock cycle. They are the building blocks of your machine instructions. For a detailed description of each, see the `Microcode_Manual.md`.

The available microinstructions are: `load_immediate`, `move_reg`, `alu`, `store_mem_adres`, `store_mem_reg`, `read_mem_adres`, `read_mem_reg`, `branch`, `set_cpu_state`, `set_status_bit`, `set_interrupt_flag`, `shadow`, and `gpu`.

### Operands and Runtime Arguments

Microinstructions can take several types of arguments:
*   **Literals**: A fixed value, such as a register name (`Ra`, `SP`, `R0`), a number (`42`), or a string (`TRUE`).
*   **Runtime Arguments (`$1`, `$2`)**: These are placeholders that get replaced at runtime by the operands of the machine instruction being executed.
    *   `$1`: The first operand of the machine instruction.
    *   `$2`: The second operand of the machine instruction.

### Labels and Branching

Inside a `def` block, you can define local labels to control the flow of microcode execution.

*   **Defining a Label**: Start a line with a colon, e.g., `:my_label`.
*   **Branching**: Use the `branch` microinstruction to jump to a label based on a CPU flag. For example, `branch(Z, is_zero)` will jump to the `:is_zero` label if the Zero flag is set.

## 7. Complete Example: `ADDI`

Let's break down the `ADDI` (Add Immediate) instruction from `base_rom.uasm`. The desired assembly syntax is `ADDI Rx, value`.

```uasm
def 51=ADDI {
    .format two_reg_val      ; 1. Format: Register, Value
    move_reg(Ra, $1)         ; 2. Move the value of the first operand (Rx) into internal register Ra
    load_immediate(Rb, $2)   ; 3. Load the second operand (the immediate value) into internal register Rb
    alu(ADD)                 ; 4. Perform Ra = Ra + Rb
    move_reg($1, Ra)         ; 5. Move the result from Ra back into the destination register (Rx)
}
```

**Explanation:**

1.  **`.format two_reg_val`**: This tells the main assembler that `ADDI` takes two operands: a register and a value. When the assembler sees `ADDI R3, 10`, it will encode it and know that `R3` is the first operand and `10` is the second.
2.  **`move_reg(Ra, $1)`**: At runtime, `$1` will be `R3`. This micro-op copies the contents of register `R3` into the CPU's internal `Ra` register.
3.  **`load_immediate(Rb, $2)`**: At runtime, `$2` will be `10`. This micro-op loads the literal value `10` into the CPU's internal `Rb` register.
4.  **`alu(ADD)`**: The ALU performs the addition `Ra + Rb` and stores the result back in `Ra`.
5.  **`move_reg($1, Ra)`**: Finally, this micro-op copies the result from `Ra` back into the original destination register (`R3`), completing the operation.