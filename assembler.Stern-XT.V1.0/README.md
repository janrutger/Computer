# Stern-XT ISA Assembler Manual

This document provides a comprehensive guide to using the ISA assembler for the Stern-XT computer.

## Table of Contents

*   [Introduction](#introduction)
*   [Usage](#usage)
*   [Syntax](#syntax)
    *   [Labels](#labels)
    *   [Symbol Types and Scope](#symbol-types-and-scope)
    *   [Instructions](#instructions)
    *   [Operands](#operands)
    *   [Comments](#comments)
*   [Directives](#directives)
    *   [EQU](#equ)
    *   [Memory Allocation (.)](#memory-allocation--)
    *   [Include](#include)
*   [Memory Pre-load (%)] (#memory-pre-load--)
*   [Addressing Modes](#addressing-modes)
*   [Example Program](#example-program)

## Introduction

The Stern-XT ISA assembler translates assembly language programs (`.asm` files) into machine-readable binary code (`.bin` files) that can be loaded into the Stern-XT's memory and executed by the CPU.

## Usage

The Stern-XT ISA assembler now primarily operates using a `build.json` configuration file, which allows for orchestrating complex multi-file assembly processes. While it is designed for multi-file projects, you can still assemble a single `.asm` file by defining it within a `build.json`.

To use the assembler, run it from the command line. By default, it will look for `bin/build.json`. You can also specify a different build configuration file as an argument:

```bash
python3 assembler/assembler.py bin/my_project_build.json
```

#### Assembling a Single File with `build.json`

To assemble a single `.asm` file, create a `build.json` that specifies only that file:

```json
{
  "output": "my_single_program.bin",
  "var_start": 12288,
  "sources": [
    {
      "file": "asm/my_program.asm",
      "base_address": 0,
      "restore_symbols": false
    }
  ]
}
```

Then, run the assembler with this specific `build.json`:

```bash
python3 assembler/assembler.py bin/my_single_program_build.json
```

## Syntax

### Labels

Labels are used to mark specific locations in the code, such as the target of a jump or the beginning of a subroutine. A label is defined by a name followed by a colon (`:`).

```assembly
:my_label
    NOP
```

### Symbol Types and Scope

The assembler supports different types of symbols, each with a specific prefix and scope:

*   **Local Labels (`:`):** Labels defined with a colon (e.g., `:my_label`) are local to the current source file. They are primarily used for jumps and branches within the same file. When used with a `CALL` instruction (e.g., `CALL :my_label`), the assembler will push the return address onto the stack. However, using `CALL` with local labels is generally not recommended for standard subroutine calls, as their local scope can lead to unexpected behavior when combined with `RET` instructions from other files or global subroutines. Use at your own risk (AYOR).

*   **Subroutine Calls (`@`):** Symbols prefixed with `@` (e.g., `@print_string`) are used to define and call subroutines. These symbols are global and are stored in the assembler's symbol table, allowing them to be referenced across multiple source files.

*   **Constants (`~`):** Symbols prefixed with `~` (e.g., `~MY_CONSTANT`) are used to define constants with the `EQU` directive. These are global symbols and can be used across multiple source files.

*   **Memory Addresses (`)`:** Symbols prefixed with ` (e.g., `$my_variable`, `$INT_VECTORS`) represent memory addresses, typically defined using the `.` directive. These are global symbols and are stored in the assembler's symbol table, allowing them to be referenced across multiple source files.

When multiple source files are compiled together, global symbols (`@`, `~`, `) are resolved across all files, enabling modular programming.

### Instructions

Instructions are the mnemonics for the CPU's operations, as defined in the `stern_rom.json` file. The assembler is case-insensitive for instructions. (to be sure: it is lower case)

```assembly
    ldi A 42
    add B A
```

### Operands

Operands are the data or addresses that instructions operate on. They can be:

*   **Registers:** `R0` through `R9`, or their friendly names defined in the `.uasm` file (e.g., `I`, `A`, `B`, '...').
*   **Numeric Literals:** Decimal values (e.g., `42`, `1024`). Character literals using the `\char` notation are also supported, where `\c` represents the ASCII value of character `c` (e.g., `\a` for ASCII 97, `\0` for ASCII 48).
*   **Labels:** The address of a label (e.g., `jmp :my_loop`). 
*   **Constants:** Defined with the `EQU` directive.

### Comments

Comments are ignored by the assembler and are used for adding explanatory notes to the code. A comment is anything on a line that follows a semicolon (`;`).

```assembly
ldi A 42 ; Load the value 42 into register A
```

## Directives

Directives are special commands to the assembler that control the assembly process.

### EQU

The `EQU` directive assigns a constant value to a symbol.

```assembly
EQU ~MY_CONSTANT 100
ldi A ~MY_CONSTANT ; This is equivalent to ldi A 100
```

### Memory Allocation (`.`)

The `.` directive is used to declare a memory region. The syntax is:

```assembly
. $mem_name size
```

*   `$mem_name`: The name of the memory region, which must start with a `.
*   `size`: The size of the memory region in bytes.

This directive is typically used at the beginning of a program to define variables and other data structures.

```assembly
. $my_variable 1 ; a single byte variable
. $my_array 10    ; an array of 10 bytes
```
When a memory allocation name (e.g., `$my_var`) is used as an operand where a value is expected (e.g., `ldi Z $my_var`), the assembler will use the *address* of that label/memory location, not the content stored at that address. To load the content, use an instruction like `ld` (load direct) or `ldx` (load indexed).

### Include

The `include` directive includes the content of another .asm file into the current file. This is useful for sharing constants, macros, or subroutines across multiple files.

```assembly
include "incl/my_subroutines"
```

### Memory Pre-load (`%`)

The `%` directive is used to pre-load specific memory addresses with data. This is particularly useful for initializing variables, data structures, or even entire strings directly into memory at assembly time.

**Syntax:**

```assembly
% $memory_address value1 [value2, ...]
```

*   `$memory_address`: The symbolic name of the memory location (e.g., a variable defined with the `.` directive) or a direct numeric address.
*   `value1, value2, ...`: One or more byte values to be stored sequentially starting from `$memory_address`. These can be numeric literals or character literals using the `\char` notation.

**Examples:**

```assembly
; Pre-load a single variable
. $my_var 1
% $my_var 42 ; Loads the value 42 into $my_var

; Pre-load an array
. $my_array 5
% $my_array 10 20 30 40 50 ; Loads 10, 20, 30, 40, 50 into $my_array

; Pre-load a string using character literals
. $my_string 6
% $my_string \h \e \l \l \o 0 ; Loads "hello" followed by a null terminator

; Pre-load a direct memory address (not supported)

```

## Addressing Modes

The assembler supports several addressing modes, which are determined by the instruction used:

*   **Immediate:** The operand is a literal value (e.g., `ldi A 42`).
*   **Register:** The operand is a register (e.g., `push A`).
*   **Direct:** The operand is a memory address (e.g., `jmp 1024`).
*   **Indexed (with Double Indirection):** An instruction like `ldx R1, 100` first fetches the value at address `100`, adds the content of the index register `R0` to it, and then uses this result as the final address to read from.

### Double Indirection in Stern ISA: LDX, STX, and CALLX

The Stern Instruction Set Architecture (ISA) includes several instructions that utilize a concept known as "double indirection" when performing memory access. This means that the address used for the final memory operation is not directly provided by the instruction's operand, but is instead calculated through an intermediate memory lookup, often combined with the index register (R0).

This document explains the behavior of `LDX`, `STX`, and `CALLX` based on their microcode definitions found in `base_rom.uasm`.

#### Key Concepts

*   **R0 (Index Register):** In the Stern CPU, R0 is designated as the index register. Its value is implicitly added during indexed memory operations.
*   **`read_mem_adres(address, register)`:** A microcode operation that reads the value from the specified `address` in memory and places it into the `register`.
*   **`store_mem_adres(address, register)`:** A microcode operation that stores the value from the `register` into the specified `address` in memory.
*   **`read_mem_reg(address_register, target_register)`:** A microcode operation that reads the value from the memory address *contained within* `address_register` and places it into `target_register`.
*   **`store_mem_reg(address_register, source_register)`:** A microcode operation that stores the value from `source_register` into the memory address *contained within* `address_register`.
*   **`alu(ADD)`:** An ALU operation that performs `Ra + Rb -> Ra`.

---

#### 1. LDX (Load Indexed)

**ISA Format:** `LDX Rx, Address`
**Microcode Definition (from `base_rom.uasm`):
```uasm
def 33=LDX {
    .format two_reg_addr
    read_mem_adres($2, Ra)   ; 1. Read value from memory(op2) into Ra
    move_reg(Rb, R0)         ; 2. Rb = R0 (index register)
    alu(ADD)                 ; 3. Ra = Ra + Rb (effective address: Memory[Address] + R0)
    read_mem_reg(Ra, $1)     ; 4. Read value from effective address (Ra) into $1
    set_cpu_state(FETCH)
}
```

**Explanation:**

`LDX` performs a load operation with double indirection and indexing.
1.  The CPU first reads the value stored at the `Address` specified as the second operand (`$2`). This value is placed into the internal `Ra` register.
2.  The content of the index register `R0` is moved into the internal `Rb` register.
3.  The ALU adds `Ra` and `Rb`. So, `Ra` now holds `(Value at Address) + R0`. This is the *effective memory address* for the final load.
4.  Finally, the CPU reads the value from the memory location pointed to by this `effective address` (which is in `Ra`) and places it into the destination register `Rx` (the first operand, `$1`).

**In simpler terms:** `LDX Rx, Address` means `Rx = Memory[ Memory[Address] + R0 ]`

**Example:**
If `Memory[100]` contains `500`, and `R0` contains `10`, then `LDX R1, 100` would result in `R1 = Memory[ Memory[100] + R0 ] = Memory[ 500 + 10 ] = Memory[510]`.

---

#### 2. STX (Store Indexed)

**ISA Format:** `STX Rx, Address`
**Microcode Definition (from `base_rom.uasm`):
```uasm
def 41=STX {
    .format two_reg_addr
    read_mem_adres($2, Ra)   ; 1. Read value from memory(op2) into Ra
    move_reg(Rb, R0)         ; 2. Rb = R0 (index register)
    alu(ADD)                 ; 3. Ra = Ra + Rb (effective address: Memory[Address] + R0)
    store_mem_reg(Ra, $1)    ; 4. Store value of op1 at effective address (Ra)
    set_cpu_state(FETCH)
}
```

**Explanation:**

`STX` performs a store operation with double indirection and indexing, similar to `LDX`.
1.  The CPU first reads the value stored at the `Address` specified as the second operand (`$2`). This value is placed into the internal `Ra` register.
2.  The content of the index register `R0` is moved into the internal `Rb` register.
3.  The ALU adds `Ra` and `Rb`. So, `Ra` now holds `(Value at Address) + R0`. This is the *effective memory address* where the data will be stored.
4.  Finally, the CPU stores the value from the source register `Rx` (the first operand, `$1`) into the memory location pointed to by this `effective address` (which is in `Ra`).

**In simpler terms:** `STX Rx, Address` means `Memory[ Memory[Address] + R0 ] = Rx`

**Example:**
If `Memory[100]` contains `500`, `R0` contains `10`, and `R1` contains `99`, then `STX R1, 100` would result in `Memory[ Memory[100] + R0 ] = R1`, which means `Memory[ 500 + 10 ] = 99`, so `Memory[510] = 99`.

---

#### 3. CALLX (Call Indexed)

**ISA Format:** `CALLX Address`
**Microcode Definition (from `base_rom.uasm`):
```uasm
def 25=CALLX {
    .format one_addr
    move_reg(Ra, SP)        ; Ra = SP
    store_mem_reg(SP, PC)   ; Store PC (return address) at SP
    alu(DEC)                ; Decrement SP
    move_reg(SP, Ra)        ; Update SP

    ; Calculate effective address: arg1 + R0 (index register I)
    read_mem_adres($1, Ra)  ; 1. Ra = value at address arg1
    move_reg(Rb, R0)        ; 2. Rb = R0 (index register)
    alu(ADD)                ; 3. Ra = Ra + Rb (effective address: Memory[arg1] + R0)
    move_reg(PC, Ra)        ; 4. Load effective address into PC
    set_cpu_state(FETCH)
}
```

**Explanation:**

`CALLX` is similar to `CALL`, but the target address for the jump is calculated using double indirection and indexing. It also pushes the current Program Counter (PC) onto the stack for a return.
1.  The current `PC` (return address) is pushed onto the stack.
2.  The CPU then reads the value stored at the `Address` specified as the operand (`$1`). This value is placed into the internal `Ra` register.
3.  The content of the index register `R0` is moved into the internal `Rb` register.
4.  The ALU adds `Ra` and `Rb`. So, `Ra` now holds `(Value at Address) + R0`. This is the *effective memory address* for the jump.
5.  Finally, this `effective address` (in `Ra`) is loaded into the `PC`, causing the CPU to jump to that location.

**In simpler terms:** `CALLX Address` means `PC = Memory[ Memory[Address] + R0 ]` (after pushing the return address to stack).

**Example:**
If `Memory[200]` contains `700`, and `R0` contains `5`, then `CALLX 200` would push the current PC to stack, and then set `PC = Memory[ Memory[200] + R0 ] = Memory[ 700 + 5 ] = Memory[705]`. The program would then continue execution from address `Memory[705]`.

---

#### 4. INC (Increment Memory)

**ISA Format:** `INC Rx, Address`
**Microcode Definition (from `base_rom.uasm`):
```uasm
def 80=INC {
    .format two_reg_addr
    read_mem_adres($2, Ra)   ; 1. Read value from memory(op2) into internal register Ra
    move_reg($1, Ra)         ; 2. Move the original value from Ra to the destination register op1
    alu(INC)
    store_mem_adres($2, Ra)   ; 3. Store the incremented value back to memory(op2)
    set_cpu_state(FETCH)
}
```

**Explanation:**

`INC` increments the value stored at a specified memory address.
1.  The CPU reads the value from the `Address` specified as the second operand (`$2`) into the internal `Ra` register.
2.  The *original* value (from `Ra`) is moved to the destination register `Rx` (the first operand, `$1`).
3.  The ALU increments the value in `Ra` (`Ra = Ra + 1`).
4.  The incremented value from `Ra` is then stored back to the `Address` specified by `$2`.

**In simpler terms:** `INC Rx, Address` means `Memory[Address] = Memory[Address] + 1`. The register `Rx` will receive the *original* value that was at `Memory[Address]` before the increment.

**Note on Microcode:** The `move_reg($1, Ra)` instruction appears to be misplaced if the intent was for `Rx` to receive the *incremented* value. As written, `Rx` receives the value *before* incrementation.

**Example:**
If `Memory[300]` contains `42`, and `R1` contains `0` (before execution), then `INC R1, 300` would result in:
*   `Memory[300]` becoming `43`.
*   `R1` becoming `42` (the original value).

---

#### 5. DEC (Decrement Memory)

**ISA Format:** `DEC Rx, Address`
**Microcode Definition (from `base_rom.uasm`):
```uasm
def 81=DEC {
    .format two_reg_addr
    read_mem_adres($2, Ra)   ; 1. Read value from memory(op2) into internal register Ra
    alu(DEC)
    move_reg($1, Ra)         ; 2. Move the decremented value back to the destination register op1
    store_mem_adres($2, Ra)  ; 3. Store the decremented value back to memory(op2)
    set_cpu_state(FETCH)
}
```

**Explanation:**

`DEC` decrements the value stored at a specified memory address.
1.  The CPU reads the value from the `Address` specified as the second operand (`$2`) into the internal `Ra` register.
2.  The ALU decrements the value in `Ra` (`Ra = Ra - 1`).
3.  The decremented value from `Ra` is then moved to the destination register `Rx` (the first operand, `$1`).
4.  The decremented value from `Ra` is then stored back to the `Address` specified by `$2`.

**In simpler terms:** `DEC Rx, Address` means `Memory[Address] = Memory[Address] - 1`. The register `Rx` will receive the *decremented* value.

**Example:**
If `Memory[400]` contains `10`, and `R2` contains `0` (before execution), then `DEC R2, 400` would result in:
*   `Memory[400]` becoming `9`.
*   `R2` becoming `9` (the decremented value).

---

This document clarifies the behavior of these memory-accessing instructions, including the double indirection for `LDX`, `STX`, and `CALLX`, and the direct memory access for `INC` and `DEC`.

## Example Program

Here is a simple program that loads a value into a register, adds another value to it, and then halts.

```assembly
; My first assembly program

. $my_var 1 ; a variable
EQU ~START_VALUE 10

:start
    ldi A ~START_VALUE ; Load register A with 10
    addi A 5           ; Add 5 to register A
    sto A $my_var      ; Store the result in our variable
    halt               ; Halt the CPU
```
