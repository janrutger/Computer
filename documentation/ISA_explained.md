
**Format Types:**
- `zero` - No operands
- `one_addr` - One address operand
- `one_reg` - One register operand
- `two_reg_reg` - Two register operands
- `two_reg_val` - Register and immediate value
- `two_reg_addr` - Register and memory address operand

---

## Control Flow Instructions (Opcodes 10-26)

### **NOP (Opcode 10)** - No Operation
- **Format:** `zero`
- **Description:** Does nothing.  Sets CPU to sleep mode.
- **Microcode:** Sets the CPU state to SLEEP, effectively pausing execution.

### **HALT (Opcode 11)** - Halt Execution
- **Format:** `zero`
- **Description:** Stops CPU execution permanently. 
- **Microcode:** Sets the CPU state to HALT. 

### **RET (Opcode 12)** - Return from Subroutine
- **Format:** `zero`
- **Description:** Returns from a subroutine by restoring the program counter from the stack.
- **Microcode:**
  1. Copy SP to temporary register Ra
  2. Increment Ra (advance stack pointer)
  3. Update SP with the incremented value
  4. Read the saved PC from memory at the new SP location
- **Notes:** Complements the CALL and CALLX instructions.

### **EI (Opcode 13)** - Enable Interrupts
- **Format:** `zero`
- **Description:** Enables interrupt processing by setting the interrupt flag.
- **Microcode:** Sets the interrupt flag to TRUE.

### **DI (Opcode 14)** - Disable Interrupts
- **Format:** `zero`
- **Description:** Disables interrupt processing by clearing the interrupt flag. 
- **Microcode:** Sets the interrupt flag to FALSE.

### **RTI (Opcode 15)** - Return from Interrupt
- **Format:** `zero`
- **Description:** Returns from an interrupt handler, restoring the saved register state.
- **Microcode:** Executes the `shadow(RESTORE)` operation to restore all saved processor state.

### **JMPF (Opcode 20)** - Jump if False (Status Bit Clear)
- **Format:** `one_addr`
- **Description:** Branches to address $1 if the status bit (S) is FALSE.
- **Operands:**
  - `$1` - Target address
- **Microcode:**
  1. Test the status bit (S)
  2. If FALSE, load the target address into PC
  3. If TRUE, continue to the next instruction
- **Condition:** Jumps when S = 0

### **JMPT (Opcode 21)** - Jump if True (Status Bit Set)
- **Format:** `one_addr`
- **Description:** Branches to address $1 if the status bit (S) is TRUE.
- **Operands:**
  - `$1` - Target address
- **Microcode:**
  1. Test the status bit (S)
  2. If TRUE, load the target address into PC
  3. If FALSE, continue to the next instruction
- **Condition:** Jumps when S = 1

### **JMP (Opcode 22)** - Unconditional Jump
- **Format:** `one_addr`
- **Description:** Unconditionally branches to the specified address.
- **Operands:**
  - `$1` - Target address
- **Microcode:** Load the target address directly into PC. 

### **CALL (Opcode 24)** - Call Subroutine
- **Format:** `one_addr`
- **Description:** Calls a subroutine at the specified address, saving the return address on the stack.
- **Operands:**
  - `$1` - Target subroutine address
- **Microcode:**
  1. Copy SP to temporary register Ra
  2. Store the current PC (return address) at the stack location (SP)
  3. Decrement SP
  4. Update SP
  5. Load the target address into PC
- **Notes:** Used with RET to implement function calls.

### **CALLX (Opcode 25)** - Call Subroutine with Index Register
- **Format:** `one_addr`
- **Description:** Calls a subroutine using an indexed address calculation (arg1 + R0/index register I).
- **Operands:**
  - `$1` - Base address (indexed via register I)
- **Microcode:**
  1. Copy SP to temporary register Ra
  2. Store the current PC (return address) at SP
  3. Decrement SP
  4. Update SP
  5. Read value from memory at address $1 into Ra
  6. Copy R0 (index register I) to Rb
  7. Add Ra + Rb to compute effective address
  8. Load effective address into PC
- **Notes:** Enables indexed subroutine calls useful for dispatch tables or dynamic branching.

### **INT (Opcode 26)** - Software Interrupt/Syscall
- **Format:** `one_addr`
- **Description:** Triggers a software interrupt/syscall by jumping to a handler determined by an interrupt table.
- **Operands:**
  - `$1` - Base address of the syscall handler table
- **Microcode:**
  1. Save all processor state (registers + PC) via `shadow(SAVE)`
  2.  Disable interrupts
  3. Read the handler pointer from memory at address $1
  4. Copy R0 (syscall ID) to Rb
  5. Add Ra + Rb to index into the handler table
  6. Read the final handler address from memory
  7. Jump to the handler
- **Notes:** Used for system calls; the syscall ID is passed in register R0/I.

---

## Load Instructions (Opcodes 30-33)

### **LD (Opcode 30)** - Load Register
- **Format:** `two_reg_reg`
- **Description:** Copies the value from one register to another.
- **Operands:**
  - `$1` - Destination register
  - `$2` - Source register
- **Microcode:** Copy the value from register $2 to register $1.

### **LDI (Opcode 31)** - Load Immediate
- **Format:** `two_reg_val`
- **Description:** Loads an immediate (constant) value into a register.
- **Operands:**
  - `$1` - Destination register
  - `$2` - Immediate value
- **Microcode:** Load the immediate value $2 directly into register $1.

### **LDM (Opcode 32)** - Load from Memory
- **Format:** `two_reg_addr`
- **Description:** Loads a value from memory at the specified address into a register. 
- **Operands:**
  - `$1` - Destination register
  - `$2` - Memory address
- **Microcode:** Read value from memory at address $2 and store in register $1.

### **LDX (Opcode 33)** - Load Indexed
- **Format:** `two_reg_addr`
- **Description:** Loads a value from an indexed memory address (address + R0/index register).
- **Operands:**
  - `$1` - Destination register
  - `$2` - Base memory address
- **Microcode:**
  1. Read value from memory at address $2 into Ra
  2. Copy R0 (index register I) to Rb
  3. Add Ra + Rb to compute effective address
  4. Read value from effective address into register $1
- **Notes:** Useful for array/table access with dynamic indexing.

---

## Store Instructions (Opcodes 40-41)

### **STO (Opcode 40)** - Store to Memory
- **Format:** `two_reg_addr`
- **Description:** Stores the value of a register to memory at the specified address.
- **Operands:**
  - `$1` - Source register
  - `$2` - Destination memory address
- **Microcode:** Write the value from register $1 to memory at address $2.

### **STX (Opcode 41)** - Store Indexed
- **Format:** `two_reg_addr`
- **Description:** Stores a register value to an indexed memory address (address + R0/index register).
- **Operands:**
  - `$1` - Source register
  - `$2` - Base memory address
- **Microcode:**
  1. Read value from memory at address $2 into Ra
  2. Copy R0 (index register I) to Rb
  3. Add Ra + Rb to compute effective address
  4. Store value from register $1 to the effective address
- **Notes:** Complements LDX for array/table storage with dynamic indexing.

---

## Arithmetic Instructions (Opcodes 50-65)

### **ADD (Opcode 50)** - Add Registers
- **Format:** `two_reg_reg`
- **Description:** Adds two register values and stores the result in the first register.
- **Operands:**
  - `$1` - Destination register (also first operand)
  - `$2` - Second operand register
- **Microcode:**
  1. Copy $1 to Ra
  2. Copy $2 to Rb
  3. Perform addition:  Ra = Ra + Rb
  4. Copy result Ra back to $1
- **Notes:** $1 contains both the first operand and receives the result.

### **ADDI (Opcode 51)** - Add Immediate
- **Format:** `two_reg_val`
- **Description:** Adds an immediate value to a register. 
- **Operands:**
  - `$1` - Destination register (also first operand)
  - `$2` - Immediate value to add
- **Microcode:**
  1. Copy $1 to Ra
  2. Load immediate $2 into Rb
  3. Perform addition: Ra = Ra + Rb
  4. Copy result Ra back to $1

### **SUB (Opcode 52)** - Subtract Registers
- **Format:** `two_reg_reg`
- **Description:** Subtracts the second register from the first and stores the result in the first register.
- **Operands:**
  - `$1` - Destination register (also first operand)
  - `$2` - Second operand register (subtrahend)
- **Microcode:**
  1. Copy $1 to Ra
  2. Copy $2 to Rb
  3. Perform subtraction: Ra = Ra - Rb
  4. Copy result Ra back to $1

### **SUBI (Opcode 53)** - Subtract Immediate
- **Format:** `two_reg_val`
- **Description:** Subtracts an immediate value from a register.
- **Operands:**
  - `$1` - Destination register (also first operand)
  - `$2` - Immediate value to subtract
- **Microcode:**
  1. Copy $1 to Ra
  2. Load immediate $2 into Rb
  3. Perform subtraction: Ra = Ra - Rb
  4. Copy result Ra back to $1

### **MUL (Opcode 60)** - Multiply Registers
- **Format:** `two_reg_reg`
- **Description:** Multiplies two register values and stores the result in the first register. 
- **Operands:**
  - `$1` - Destination register (also first operand)
  - `$2` - Second operand register
- **Microcode:**
  1. Copy $1 to Ra
  2. Copy $2 to Rb
  3. Perform multiplication: Ra = Ra × Rb
  4. Copy result Ra back to $1

### **MULI (Opcode 61)** - Multiply Immediate
- **Format:** `two_reg_val`
- **Description:** Multiplies a register by an immediate value.
- **Operands:**
  - `$1` - Destination register (also first operand)
  - `$2` - Immediate value (multiplier)
- **Microcode:**
  1. Copy $1 to Ra
  2. Load immediate $2 into Rb
  3. Perform multiplication: Ra = Ra × Rb
  4. Copy result Ra back to $1

### **DIVI (Opcode 63)** - Divide Immediate
- **Format:** `two_reg_val`
- **Description:** Divides a register by an immediate value.
- **Operands:**
  - `$1` - Destination register (also dividend)
  - `$2` - Immediate value (divisor)
- **Microcode:**
  1. Copy $1 to Ra
  2. Load immediate $2 into Rb
  3. Perform division: Ra = Ra ÷ Rb
  4. Copy result Ra back to $1
- **Notes:** The quotient is stored in $1. Remainder handling depends on hardware implementation.

### **DMOD (Opcode 65)** - Divide with Modulo
- **Format:** `two_reg_reg`
- **Description:** Divides the first register by the second, storing both quotient and remainder.
- **Operands:**
  - `$1` - Dividend (destination for quotient)
  - `$2` - Divisor (destination for remainder)
- **Microcode:**
  1. Copy $1 to Ra
  2. Copy $2 to Rb
  3. Perform modulo operation: Ra = Ra mod Rb
  4. Copy quotient Ra back to $1
  5. Copy remainder Rb back to $2
- **Notes:** After execution, $1 contains the quotient and $2 contains the remainder. 

---

## Comparison/Test Instructions (Opcodes 70-72)

### **TST (Opcode 70)** - Test Equality with Immediate
- **Format:** `two_reg_val`
- **Description:** Compares a register with an immediate value and sets the status bit if equal.
- **Operands:**
  - `$1` - Register to compare
  - `$2` - Immediate value to compare
- **Microcode:**
  1. Copy $1 to Ra
  2. Load immediate $2 into Rb
  3. Perform comparison: Ra - Rb
  4. If Equal (E flag set): Set status bit = TRUE
  5. If Not Equal: Set status bit = FALSE
- **Notes:** Sets the status bit (S) based on equality.  Used with JMPT/JMPF for conditional branching.

### **TSTE (Opcode 71)** - Test Equality with Register
- **Format:** `two_reg_reg`
- **Description:** Compares two registers and sets the status bit if equal.
- **Operands:**
  - `$1` - First register
  - `$2` - Second register
- **Microcode:**
  1. Copy $1 to Ra
  2. Copy $2 to Rb
  3. Perform comparison: Ra - Rb
  4. If Equal (E flag set): Set status bit = TRUE
  5. If Not Equal: Set status bit = FALSE
- **Notes:** Like TST but compares two registers instead of a register and an immediate.

### **TSTG (Opcode 72)** - Test Greater Than
- **Format:** `two_reg_reg`
- **Description:** Compares two registers and sets the status bit if the first is greater than the second.
- **Operands:**
  - `$1` - First register
  - `$2` - Second register
- **Microcode:**
  1. Copy $1 to Ra
  2. Copy $2 to Rb
  3. Perform subtraction: Ra - Rb
  4. If result is Zero (Z flag) OR Negative (N flag): Set status bit = FALSE
  5. If result is Positive: Set status bit = TRUE
- **Notes:** Sets status bit TRUE if Ra > Rb, FALSE otherwise.  Used for greater-than comparisons.

---

## Increment/Decrement Instructions (Opcodes 80-81)

### **INC (Opcode 80)** - Increment Memory Value
- **Format:** `two_reg_addr`
- **Description:** Increments a value stored in memory and optionally copies it to a register.
- **Operands:**
  - `$1` - Destination register (receives original value)
  - `$2` - Memory address containing the value to increment
- **Microcode:**
  1. Read value from memory at address $2 into Ra
  2. Copy Ra to register $1 (preserve original value)
  3. Increment Ra
  4. Store incremented Ra back to memory at address $2
- **Notes:** Both the memory location and the register are updated.  The register gets the original value before incrementing.

### **DEC (Opcode 81)** - Decrement Memory Value
- **Format:** `two_reg_addr`
- **Description:** Decrements a value stored in memory and copies the decremented value to a register. 
- **Operands:**
  - `$1` - Destination register (receives decremented value)
  - `$2` - Memory address containing the value to decrement
- **Microcode:**
  1. Read value from memory at address $2 into Ra
  2. Decrement Ra
  3. Copy decremented Ra to register $1
  4. Store decremented Ra back to memory at address $2
- **Notes:** Both the memory location and the register are updated with the decremented value. 

---

## Logical Instructions (Opcode 82)

### **ANDI (Opcode 82)** - Bitwise AND with Immediate
- **Format:** `two_reg_val`
- **Description:** Performs bitwise AND between a register and an immediate value. 
- **Operands:**
  - `$1` - Destination register (also first operand)
  - `$2` - Immediate value (mask)
- **Microcode:**
  1. Copy $1 to Ra
  2. Load immediate $2 into Rb
  3. Perform bitwise AND: Ra = Ra & Rb
  4. Copy result Ra back to $1
- **Notes:** Used for bit masking and flag clearing operations.

---

## Stack Instructions (Opcodes 90-91)

### **PUSH (Opcode 90)** - Push to Call Stack
- **Format:** `one_reg`
- **Description:** Pushes a register value onto the call stack, decrementing the stack pointer.
- **Operands:**
  - `$1` - Register to push
- **Microcode:**
  1. Copy SP to Ra
  2. Store register $1 value at stack location (SP)
  3. Decrement SP
  4. Update SP
- **Notes:** This is the call stack (used for return addresses). Stack grows downward.

### **POP (Opcode 91)** - Pop from Call Stack
- **Format:** `one_reg`
- **Description:** Pops a value from the call stack into a register, incrementing the stack pointer.
- **Operands:**
  - `$1` - Destination register
- **Microcode:**
  1. Copy SP to Ra
  2. Increment Ra (advance SP upward)
  3. Update SP with incremented value
  4. Read value from memory at new SP location into $1
- **Notes:** This is the call stack.  Complements PUSH for stack-based data operations.

---

## Data Stack Instructions (Opcodes 92-93)

These instructions operate on a separate data stack managed by a stack pointer variable in memory. This is distinct from the hardware call stack (PUSH/POP).

### **STACK (Opcode 92)** - Push to Data Stack
- **Format:** `two_reg_addr`
- **Description:** Pushes a register value onto a data stack.  The stack pointer is stored in memory.
- **Operands:**
  - `$1` - Source register to push
  - `$2` - Memory address containing the data stack pointer
- **Microcode (Post-Increment Push):**
  1. Read the current stack pointer value from memory at address $2 into Ra
  2. Store the value from register $1 at the current stack location (Ra)
  3. Increment Ra (new stack pointer value)
  4. Load address $2 into Rb
  5. Store the new stack pointer Ra back to memory at address $2
- **Notes:** 
  - The stack pointer points to the next empty location (post-increment semantics)
  - Allows multiple independent data stacks, each with its own pointer variable
  - Stack grows upward in memory

### **USTACK (Opcode 93)** - Pop from Data Stack
- **Format:** `two_reg_addr`
- **Description:** Pops a value from a data stack into a register.  The stack pointer is stored in memory. 
- **Operands:**
  - `$1` - Destination register
  - `$2` - Memory address containing the data stack pointer
- **Microcode (Pre-Decrement Pop):**
  1. Read the current stack pointer value from memory at address $2 into Ra
  2. Decrement Ra (new stack pointer value pointing to the top)
  3. Load address $2 into Rb
  4. Store the new stack pointer Ra back to memory at address $2
  5. Read the value from memory at the new stack pointer location (Ra) into $1
- **Notes:**
  - The stack pointer points to the top of the stack (pre-decrement semantics)
  - Complements STACK for data stack operations
  - Allows independent data stack management

---

## Graphics Instructions (Opcode 94)

### **GPU (Opcode 94)** - GPU Command
- **Format:** `one_reg`
- **Description:** Sends a graphics command to the GPU.  The specific command is encoded in the register.
- **Operands:**
  - `$1` - Register containing the GPU command
- **Microcode:** Execute GPU operation with command specified in $1.
- **Notes:** Implementation-specific; behavior depends on GPU design and command encoding.

---

## Instruction Summary Table

| Opcode | Mnemonic | Format | Description |
|--------|----------|--------|-------------|
| 10 | NOP | zero | No operation |
| 11 | HALT | zero | Halt execution |
| 12 | RET | zero | Return from subroutine |
| 13 | EI | zero | Enable interrupts |
| 14 | DI | zero | Disable interrupts |
| 15 | RTI | zero | Return from interrupt |
| 20 | JMPF | one_addr | Jump if false (status bit clear) |
| 21 | JMPT | one_addr | Jump if true (status bit set) |
| 22 | JMP | one_addr | Unconditional jump |
| 24 | CALL | one_addr | Call subroutine |
| 25 | CALLX | one_addr | Call with indexed address |
| 26 | INT | one_addr | Software interrupt/syscall |
| 30 | LD | two_reg_reg | Load register |
| 31 | LDI | two_reg_val | Load immediate |
| 32 | LDM | two_reg_addr | Load from memory |
| 33 | LDX | two_reg_addr | Load indexed |
| 40 | STO | two_reg_addr | Store to memory |
| 41 | STX | two_reg_addr | Store indexed |
| 50 | ADD | two_reg_reg | Add registers |
| 51 | ADDI | two_reg_val | Add immediate |
| 52 | SUB | two_reg_reg | Subtract registers |
| 53 | SUBI | two_reg_val | Subtract immediate |
| 60 | MUL | two_reg_reg | Multiply registers |
| 61 | MULI | two_reg_val | Multiply immediate |
| 63 | DIVI | two_reg_val | Divide by immediate |
| 65 | DMOD | two_reg_reg | Divide with modulo |
| 70 | TST | two_reg_val | Test equality (immediate) |
| 71 | TSTE | two_reg_reg | Test equality (register) |
| 72 | TSTG | two_reg_reg | Test greater than |
| 80 | INC | two_reg_addr | Increment memory |
| 81 | DEC | two_reg_addr | Decrement memory |
| 82 | ANDI | two_reg_val | Bitwise AND immediate |
| 90 | PUSH | one_reg | Push to call stack |
| 91 | POP | one_reg | Pop from call stack |
| 92 | STACK | two_reg_addr | Push to data stack |
| 93 | USTACK | two_reg_addr | Pop from data stack |
| 94 | GPU | one_reg | GPU command |

---

## Key Registers

- **PC** - Program Counter (instruction pointer)
- **SP** - Stack Pointer (for call stack)
- **R0/I** - Index register (used in indexed addressing modes)
- **Ra, Rb** - Temporary registers (used internally by microcode)
- **S** - Status bit (used for conditional branching)

## Addressing Modes

1. **Register Addressing** - Direct register value (e.g., LD R1, R2)
2. **Immediate Addressing** - Constant value (e.g., LDI R1, 42)
3. **Memory/Absolute Addressing** - Value at memory address (e.g., LDM R1, 1000)
4. **Indexed Addressing** - Base address + index register (e.g., LDX R1, 1000 where index = R0)

---

## Notes on Stack Operations

The STERN ISA supports two distinct stacks:

1. **Call Stack (PUSH/POP)** - Hardware managed, accessed via the SP register
   - Used for return addresses (RET, CALL, CALLX)
   - PUSH decrements SP, POP increments SP

2. **Data Stacks (STACK/USTACK)** - Software managed, pointer stored in memory
   - Multiple independent data stacks possible
   - Each stack has its own pointer variable in memory
   - More flexible for complex data structure management

---

Generated:  2026-01-15
Source: https://github.com/janrutger/Computer/blob/1df4498b4c46ec2344eddae4ca3025a69f4e58fe/microcode_assembler/base_rom.uasm
