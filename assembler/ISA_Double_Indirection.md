# Understanding Double Indirection in Stern ISA: LDX, STX, and CALLX

The Stern Instruction Set Architecture (ISA) includes several instructions that utilize a concept known as "double indirection" when performing memory access. This means that the address used for the final memory operation is not directly provided by the instruction's operand, but is instead calculated through an intermediate memory lookup, often combined with the index register (R0).

This document explains the behavior of `LDX`, `STX`, and `CALLX` based on their microcode definitions found in `base_rom.uasm`.

## Key Concepts

*   **R0 (Index Register):** In the Stern CPU, R0 is designated as the index register. Its value is implicitly added during indexed memory operations.
*   **`read_mem_adres(address, register)`:** A microcode operation that reads the value from the specified `address` in memory and places it into the `register`.
*   **`store_mem_adres(address, register)`:** A microcode operation that stores the value from the `register` into the specified `address` in memory.
*   **`read_mem_reg(address_register, target_register)`:** A microcode operation that reads the value from the memory address *contained within* `address_register` and places it into `target_register`.
*   **`store_mem_reg(address_register, source_register)`:** A microcode operation that stores the value from `source_register` into the memory address *contained within* `address_register`.
*   **`alu(ADD)`:** An ALU operation that performs `Ra + Rb -> Ra`.

---

## 1. LDX (Load Indexed)

**ISA Format:** `LDX Rx, Address`
**Microcode Definition (from `base_rom.uasm`):**
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

## 2. STX (Store Indexed)

**ISA Format:** `STX Rx, Address`
**Microcode Definition (from `base_rom.uasm`):**
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

## 3. CALLX (Call Indexed)

**ISA Format:** `CALLX Address`
**Microcode Definition (from `base_rom.uasm`):**
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

## 4. INC (Increment Memory)

**ISA Format:** `INC Rx, Address`
**Microcode Definition (from `base_rom.uasm`):**
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

## 5. DEC (Decrement Memory)

**ISA Format:** `DEC Rx, Address`
**Microcode Definition (from `base_rom.uasm`):**
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