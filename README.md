## **Project "Stern": A Digital Computer Simulation Environment**

### **I. Introduction and Project Overview**
The "Stern" project endeavors to construct a comprehensive simulation of a digital computer system, meticulously detailing the interplay between its Central Processing Unit (CPU) and primary memory. This simulation is designed to provide a robust platform for exploring fundamental computer architecture principles, with a particular emphasis on microcoded instruction execution and variable-length data handling.

### **II. Core System Architecture**
The "Stern" computer system is fundamentally comprised of two principal components:
*   **The Central Processing Unit (CPU):** The computational and control nexus of the system.
*   **Random Access Memory (RAM):** The primary storage medium for both program instructions and data.

*Future Expansion Modules:*
*   Keyboard Input Unit
*   Display Output Unit
*   Serial Input/Output (SIO) Interface

### **III. The Central Processing Unit (CPU)**

#### **A. Operational Paradigm**
The CPU operates on the venerable Fetch-Decode-Execute cycle, ensuring systematic processing of program instructions.

#### **B. Register Set**
The CPU is equipped with a comprehensive set of registers to facilitate efficient data manipulation and program control:
*   **General Purpose Registers (GPRs):** Ten (10) registers, designated R0 through R9. R0 additionally serves as the dedicated Index Register.
*   **Special Purpose Registers (SRs):**
    *   **PC (Program Counter):** Maintains the address of the next instruction to be fetched.
    *   **SP (Stack Pointer):** Manages the system stack, typically pointing to the top of the stack in memory.
    *   **MIR (Memory Instruction Register):** Temporarily holds the instruction currently being processed.
*   **Internal ALU Registers:**
    *   **Ra:** Accumulator for Arithmetic Logic Unit (ALU) operations.
    *   **Rb:** Operand register for ALU operations.

#### **C. Status Flags**
Critical for conditional execution and program flow, the CPU incorporates the following status flags:
*   **Zero Flag (Z):** Set if the result of an operation is zero.
*   **Negative Flag (N):** Set if the result of an operation is negative.
*   **Equal Flag (E):** Set if two compared values are equal.
*   **Status Flag (S):** A user-facing flag, compatible with ISA test instructions (TST, TSTE, TSTG).

#### **D. Microcode Execution Engine**
The CPU's core functionality is driven by a sophisticated microcode execution engine. Each high-level ISA instruction is translated into a sequence of atomic microcode operations, stored within a dynamically loaded ROM.
*   **Microcode Instructions:** A defined set of low-level operations (e.g., `read_mem_reg`, `load_immediate`, `alu_add`, `bra`, `set_cpu_state`).
*   **Dynamic ROM Loading:** The CPU loads its microcode definitions from an external JSON file (`stern_rom.json`), enabling flexible and extensible instruction set definitions.

### **IV. Memory Subsystem**
*   **Capacity:** 4 Kilobytes (4K) of Random Access Memory.
*   **Data Representation:** Memory stores data as variable-length numeric strings (e.g., "15879"), providing flexibility in data precision.

### **V. Instruction Set Architecture (ISA)**
The "Stern" CPU supports a rich Instruction Set Architecture, designed for decimal number processing.
*   **Opcode Range:** Instructions are identified by two-digit opcodes, ranging from `10` to `99`, allowing for up to 90 distinct custom instructions.
*   **Instruction Formats:**
    *   **Zero-Operand:** Opcode only (e.g., `NOP`, `HALT`, `RET`).
    *   **One-Operand:** Opcode followed by an address or register (e.g., `JMP`, `CALL`, `PUSH`, `POP`).
    *   **Two-Operand:** Opcode followed by two arguments (e.g., `ADD`, `SUB`, `LD`, `STO`, `TST`, `MV`).
*   **Addressing Modes:** The ISA explicitly supports various addressing modes through dedicated instructions (e.g., `LD` for direct, `LDI` for immediate, `LDM` for memory-indirect, `LDX` for indexed).

### **VI. The Assembler Suite**

#### **A. ISA Assembler**
*   **Functionality:** Translates high-level assembly language (`.asm` files) into machine-executable binary code (`program.bin`). Its "smartness" and understanding of the instruction set are derived from the microcode assembler's output (the `stern_rom.json`).
*   **Legacy Integration:** Reuses components from prior projects, ensuring robust assembly of traditional programs.

#### **B. Microcode Assembler (New Generation!)**
This newly developed component is pivotal for defining the CPU's micro-operations.
*   **Input:** Microcode assembly source files (`.uasm`).
*   **Output:** A structured JSON ROM file (`stern_rom.json`), directly consumable by the CPU simulation.
*   **Key Features:**
    *   **Directives:** `.name` for output file specification, `.append` for merging with existing ROMs.
    *   **Routine Definition:** `def id=name { instructions }` syntax for modular microcode programming, with an optional `/replace` flag for dynamic updates.
    *   **Argument Handling:** Support for runtime arguments (`$1`, `$2`) passed from ISA instructions.
    *   **Register Mapping:** Direct mapping of GPRs (R0-R9) and SRs (PC, SP, Ra, Rb).
    *   **Branching with Labels:** Local labels within routines for precise control flow (`bra`, `brz`, `brn`, `beq`, `brs`).
    *   **Enhanced Commenting:** Inline comments (`;`) are preserved in the JSON output for debugging and logging purposes.
*   **Impact:** Enables unparalleled flexibility in defining and modifying the CPU's instruction set without altering core CPU logic.

### **VII. System Interoperability**
The "Stern" simulation achieves seamless operation through well-defined interfaces:
*   The ISA Assembler generates `program.bin`, which is loaded into the simulated RAM.
*   The Microcode Assembler produces `stern_rom.json`, which is dynamically loaded by the CPU to define its operational behavior.
*   The CPU fetches instructions from RAM, decodes them using the `stern_rom.json` definitions, and executes the corresponding microcode sequences.