# Stern-XT ISA Assembler & Linker Manual

## 1. Introduction

The Stern-XT ISA Assembler (`assembler.py`) is a Python-based tool that converts assembly source code (`.asm`) into machine code binaries (`.bin`). It functions as both an assembler and a linker, allowing for the creation of complex software systems consisting of a kernel (BootROM) and separate loadable applications.

## 2. Usage

The assembler is executed via the command line and typically takes a build configuration file as an argument.

```bash
python3 assembler/assembler.py [build_config_file]
```

If no argument is provided, it defaults to `assembler/buildV2.json`.

## 3. Build Configuration (Linker)

The build process is controlled by a JSON configuration file. This file defines memory layouts, source files, and how symbols are shared between different parts of the system.

### Structure

The JSON file contains two main sections: `bootrom` and `apps`.

#### `bootrom` Section
This section defines the main system binary (Kernel/OS).

*   **`output`**: Path to the generated binary file (e.g., `../bin/program.bin`).
*   **`var_start`**: The starting memory address for dynamic variable allocation (used by the `.` directive).
*   **`sources`**: A list of source objects to be assembled and linked together sequentially.
    *   `file`: Path to the `.asm` source file.
    *   `base_address`: The memory address where this code will be loaded.
    *   `restore_symbols`: (Boolean)
        *   `false`: Symbols defined in this file are kept in the assembler's memory. Subsequent files can reference them. (Typical for the Kernel).
        *   `true`: Symbols defined in this file are discarded after assembly. (Typical for overlays).

#### `apps` Section
This section defines standalone applications that link against the BootROM's symbols but are output as separate binary files.

*   **`base_address`**: Default load address for applications.
*   **`restore_symbols`**: (Boolean, usually `true`). Ensures that an app's local symbols do not pollute the global namespace for the next app being built.
*   **`sources`**: A list of application definitions.
    *   `file`: Path to the app's source code.
    *   `output`: Path to the specific binary output for this app.

### Example `buildV2.json`

```json
{
  "bootrom": {
    "output": "../bin/program.bin",
    "var_start": 18432,
    "sources": [
      { "file": "asm/bootfile.stacks.asm", "base_address": 0, "restore_symbols": false }
    ]
  },
  "apps": {
    "base_address": 9216,
    "sources": [
      { "file": "asm/apps/game.asm", "output": "../bin/apps/game.bin" }
    ]
  }
}
```

## 4. Assembly Syntax

### Symbols and Labels

The assembler uses specific prefixes to denote the scope and type of symbols:

*   **`@GlobalLabel`**: Defines a global subroutine or jump target. These are stored in the symbol table and can be referenced by other files if not restored.
*   **`:LocalLabel`**: Defines a local label. These are cleared between files and are typically used for local loops or branches.
*   **`$Variable`**: Defines a memory address (variable).
*   **`~Constant`**: Defines a constant value (see `EQU`).

### Directives

Directives control the assembly process and memory allocation.

*   **`EQU ~NAME value`**: Defines a constant. The name must start with `~`.
    *   Example: `EQU ~MAX_LIVES 3`
*   **`. $Name Size`**: Allocates `Size` bytes of memory for a variable starting at the current `var_pointer`.
    *   Example: `. $player_score 1`
*   **`MALLOC $Name Address`**: Defines a symbol at a specific, fixed memory address.
    *   Example: `MALLOC $SCREEN_BUFFER 4096`
*   **`% $Name value1 value2 ...`**: Pre-loads memory at the address of `$Name` with the specified values.
    *   Example: `% $msg \H \e \l \l \o 0`
*   **`INCLUDE filename`**: Includes another assembly file inline.

### Values and Literals

*   **Decimal**: `100`, `-5`
*   **Characters**: `\c` (e.g., `\A` for 65).
*   **Special Characters**:
    *   `\null` (0)
    *   `\space` (32)
    *   `\Return` (13)
    *   `\Newline` (10)
    *   `\ESC` (27)
    *   `\Tab` (9)
    *   `\BackSpace` (8)

### Instructions

Instructions follow the format defined in the CPU's ROM (`stern_rom.json`).
*   **Format**: `OPCODE [Operand1] [Operand2]`
*   **Example**: `LDI A 10`, `ADD A B`, `JMP @start`

## 5. Error Handling

The assembler provides detailed error messages including the file name, line number, and the specific line content where the error occurred. It detects:
*   Undefined symbols.
*   Duplicate symbol definitions.
*   Invalid register names.
*   Incorrect number of arguments for instructions.
*   File I/O errors.

## 6. Symbol Export

When building the `bootrom`, the assembler automatically generates a `symbols.json` file in the output directory. This file contains all global symbols and their addresses, which is useful for debugging or for external tools to resolve addresses.