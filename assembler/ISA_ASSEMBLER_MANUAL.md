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
*   [Memory Pre-load (%)](#memory-pre-load--)
*   [Addressing Modes](#addressing-modes)
*   [Example Program](#example-program)

## Introduction

The Stern-XT ISA assembler translates assembly language programs (`.asm` files) into machine-readable binary code (`.bin` files) that can be loaded into the Stern-XT's memory and executed by the CPU.

## Usage

To assemble a program, run the assembler from the command line and provide the path to the source file:

```bash
python3 assembler/assembler.py assembler/asm/my_program.asm
```

This will generate a `program.bin` file in the `bin` directory.

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

*   **Memory Addresses (\`):** Symbols prefixed with ` (e.g., `$my_variable`, `$INT_VECTORS`) represent memory addresses, typically defined using the `.` directive. These are global symbols and are stored in the assembler's symbol table, allowing them to be referenced across multiple source files.

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

The `include` directive includes the content of another file into the current file. This is useful for sharing constants, macros, or subroutines across multiple files.

```assembly
include "incl/my_subroutines.asm"
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
*   **Indexed:** The operand is a base address plus an index register (e.g., `ldx A I`).

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
