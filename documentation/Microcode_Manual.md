# Stern-ATX Microcode Reference Manual

This document describes the 13 microinstructions supported by the Stern-ATX processor family (CPU-R3 and CPU-M1). These microinstructions form the building blocks for defining the CPU's Instruction Set Architecture (ISA) in the `stern_rom.json` file.

## Overview

The microcode engine executes a sequence of these primitive operations for each machine instruction fetched from memory. Both the hybrid `CPU-R3` and the pipelined `CPU-M1` share this common micro-architecture, ensuring compatibility of the microcode ROM.

## Argument Resolution

Many instructions accept arguments. These can be:
*   **Literals**: Direct values (e.g., `"PC"`, `"Ra"`, `0`).
*   **`arg1`**: Resolves to the first operand of the decoded machine instruction.
*   **`arg2`**: Resolves to the second operand of the decoded machine instruction.

## Microinstruction Set

### 1. `load_immediate`
Loads a value directly into a register.

*   **Format**: `["load_immediate", target_register, value]`
*   **Arguments**:
    *   `target_register`: The register to write to (e.g., `"Ra"`, `"PC"`, `"SP"`, `"0"`-`"9"`).
    *   `value`: The integer value to load.
*   **Example**: `["load_immediate", "Ra", "arg1"]` (Loads the first instruction operand into Ra).

### 2. `move_reg`
Copies a value from one register to another.

*   **Format**: `["move_reg", dest_register, src_register]`
*   **Arguments**:
    *   `dest_register`: The register to write to.
    *   `src_register`: The register to read from.
*   **Example**: `["move_reg", "Ra", "PC"]` (Copies PC to Ra).

### 3. `alu`
Performs an Arithmetic Logic Unit operation. Operations generally use internal registers `Ra` and `Rb`.

*   **Format**: `["alu", operation]`
*   **Arguments**:
    *   `operation`: One of the following strings:
        *   `"ADD"`: `Ra = Ra + Rb`
        *   `"SUB"`: `Ra = Ra - Rb`
        *   `"MUL"`: `Ra = Ra * Rb`
        *   `"DIV"`: `Ra = Ra / Rb` (Integer division)
        *   `"MOD"`: `Ra = Ra % Rb`
        *   `"AND"`: `Ra = Ra & Rb` (Bitwise AND)
        *   `"INC"`: `Ra = Ra + 1`
        *   `"DEC"`: `Ra = Ra - 1`
*   **Flags**: Updates `Z` (Zero), `N` (Negative), and `E` (Equal) flags based on the result in `Ra`.

### 4. `store_mem_adres`
Writes a register's value to a specific memory address.

*   **Format**: `["store_mem_adres", address, source_register]`
*   **Arguments**:
    *   `address`: The memory address to write to.
    *   `source_register`: The register containing the data.
*   **Example**: `["store_mem_adres", "arg2", "R1"]`

### 5. `store_mem_reg`
Writes a register's value to a memory address stored in another register.

*   **Format**: `["store_mem_reg", address_register, source_register]`
*   **Arguments**:
    *   `address_register`: The register containing the target memory address.
    *   `source_register`: The register containing the data.
*   **Example**: `["store_mem_reg", "SP", "Ra"]` (Push Ra to stack).

### 6. `read_mem_adres`
Reads a value from a specific memory address into a register.

*   **Format**: `["read_mem_adres", address, dest_register]`
*   **Arguments**:
    *   `address`: The memory address to read from.
    *   `dest_register`: The register to store the value in.
*   **Example**: `["read_mem_adres", "arg1", "Ra"]`

### 7. `read_mem_reg`
Reads a value from a memory address stored in a register.

*   **Format**: `["read_mem_reg", address_register, dest_register]`
*   **Arguments**:
    *   `address_register`: The register containing the source memory address.
    *   `dest_register`: The register to store the value in.
*   **Example**: `["read_mem_reg", "PC", "MIR"]`

### 8. `branch`
Conditionally jumps within the current microcode sequence. This is used to implement complex logic within a single machine instruction.

*   **Format**: `["branch", condition, offset]`
*   **Arguments**:
    *   `condition`:
        *   `"A"`: Always branch.
        *   `"E"`: Branch if Equal flag is set.
        *   `"Z"`: Branch if Zero flag is set.
        *   `"N"`: Branch if Negative flag is set.
        *   `"S"`: Branch if Status flag is set.
    *   `offset`: Integer number of steps to jump (relative to current step).
*   **Example**: `["branch", "Z", "2"]` (Skip next 2 micro-ops if Zero).

### 9. `set_cpu_state`
Changes the main state of the CPU.

*   **Format**: `["set_cpu_state", state]`
*   **Arguments**:
    *   `state`: Typically `"FETCH"` (to end the instruction) or `"HALT"`.
*   **Example**: `["set_cpu_state", "FETCH"]`

### 10. `set_status_bit`
Manually sets the 'S' (Status) flag.

*   **Format**: `["set_status_bit", value]`
*   **Arguments**:
    *   `value`: `"TRUE"` or `"FALSE"`.

### 11. `set_interrupt_flag`
Enables or disables the master interrupt switch.

*   **Format**: `["set_interrupt_flag", value]`
*   **Arguments**:
    *   `value`: `"TRUE"` (Enable) or `"FALSE"` (Disable).

### 12. `shadow`
Manages context switching for interrupts.

*   **Format**: `["shadow", action]`
*   **Arguments**:
    *   `action`:
        *   `"SAVE"`: Copies current registers and flags to shadow storage.
        *   `"RESTORE"`: Restores registers and flags from shadow storage.

### 13. `gpu`
Triggers the GPU co-processor.

*   **Format**: `["gpu", pointer_register]`
*   **Arguments**:
    *   `pointer_register`: The register containing the address of the Task Description List (TDL) in memory.
*   **Action**: The CPU pauses (or continues in parallel depending on implementation) while the GPU executes the TDL chain.