# CPU (Central Processing Unit)
# CPU Architecture (R3 & M1)# CPU Architecture (R3 & M1)

stem.
The Stern-ATX motherboard supports swappable CPU modules. This document describes the two available architecture: the standard **CPU_R3** and h high-perforance **CPU_M1**
The `CPU` class in the Stern-XT simulation models the core functionality of a central processing unit, including instruction fetching, decoding, and execution based on a microcoded architecture. It interacts with memory and the interrupt controller to simulate a complete computer system.
The Stern-`CPUA
Both CPUs share the same Instruction Set Architecture (ISA) defined by the microcode ROM, ensuring binary compatibility.

## 1. CPU_R3 (Default)

The `CPU_R3` is the standard processor for the Stern-ATX. It is an evolution of the classic Stern-XT TX , updated to work with the high-speed **Integer-Based Memory** (mMemoryR3`). It follows a robust, multi-cycle Von Neumann architecture (Fetch-Decode-Execute).otherboard supports swappable CPU modules. This document describes the two available architectures: the standard **CPU_R3** and the high-performance **CPU_M1**.

## Class: `CPU`
Both CPUs share the same Instruction Set Architecture (ISA) defined by the microcode ROM, ensuring binary compatibility.

## 1. CPU_R3 (Default)

The `CPU_R3` is the standard processor for the Stern-ATX. It is an evolution of the classic Stern-XT CPU, updated to work with the high-speed **Integer-Based Memory** (`MemoryR3`). It follows a robust, multi-cycle Von Neumann architecture (Fetch-Decode-Execute).

### Initialization

```python
__init__(self, memory: Memory, interrupt_controller=None, rom_path="bin/stern_rom.json", debug_mode=False)
```

-   **`memory`**: An instance of the `Memory` class, representing the system's main memory.
-   **`interrupt_controller`**: (Optional) An instance of the `InterruptController` for handling external interrupts.
-   **`rom_path`**: The file path to the JSON microcode ROM, which defines the CPU's instruction set.
-   **`debug_mode`**: A boolean flag to enable or disable debug output.

Upon initialization, the CPU loads its microcode and instruction formats, sets up its registers (General Purpose, Special, and internal ALU registers), initializes flags, and defines its initial state.

### Registers

-   **General Purpose Registers (GPRs):** `R0` through `R9` (10 registers).
-   **Special Registers:**
    -   `PC` (Program Counter): Stores the address of the next instruction to be fetched.
    -   `SP` (Stack Pointer): Points to the current top of the system stack.
    -   `MIR` (Memory Instruction Register): Holds the currently fetched instruction.
-   **Internal ALU Registers:** `Ra`, `Rb` (used for arithmetic and logic operations).
-   **Shadow Registers:** Copies of GPRs and flags used to save and restore CPU context during interrupt handling.

### Flags

-   `Z` (Zero Flag): Set if the result of an operation is zero.
-   `N` (Negative Flag): Set if the result of an operation is negative.
-   `E` (Equal Flag): Set if the result of a comparison is equal.
-   `S` (Status Flag): A general-purpose status flag, compatible with ISA `tst`, `tste`, `tstg` instructions.

### CPU States

The CPU operates in distinct states:

-   `FETCH`: Fetches the next instruction from memory.
-   `DECODE`: Decodes the fetched instruction to determine its opcode and operands.
-   `EXECUTE`: Executes the microcode sequence corresponding to the decoded instruction.
-   `HALT`: The CPU is stopped.

### Key Methods

#### `tick()`

Represents a single clock cycle of the CPU. In each `tick`, the CPU progresses through one phase of the Fetch-Decode-Execute cycle. It also includes a check for pending interrupts if interrupts are enabled and the CPU is in the `FETCH` state.

#### `_load_microcode_from_json(self, file_path)`

Loads the microcode instructions and their corresponding instruction formats from a specified JSON file. This populates the `microcode_rom` and `instruction_formats` dictionaries, which define the CPU's behavior for each ISA instruction.

#### `_handle_interrupt()`

Manages the CPU's response to an interrupt. This involves:
1.  Disabling further interrupts.
2.  Acknowledging the interrupt with the `InterruptController` to get the interrupt vector and data.
3.  Writing the interrupt data to a designated memory address.
4.  Saving the current CPU context (registers and flags) to shadow registers.
5.  Looking up the Interrupt Service Routine (ISR) address in the Interrupt Vector Table.
6.  Setting the `PC` to the ISR address to jump to the interrupt handler.
7.  Transitioning the CPU state to `FETCH` to begin executing the ISR.

#### `execute_microcode_step(self, microcode_step, operand1, operand2)`

This method is the core of the CPU's execution unit. It interprets and executes individual micro-operations that make up a higher-level ISA instruction. Each `microcode_step` is a tuple representing a specific micro-operation and its arguments. The `operand1` and `operand2` are derived from the ISA instruction being executed and are used to resolve arguments within the microcode.

Here's a breakdown of the supported microcode instructions:

-   **`set_cpu_state(STATE)`**:
    Sets the CPU's current state (e.g., `FETCH`, `DECODE`, `EXECUTE`, `HALT`).

-   **`set_status_bit(BOOLEAN)`**:
    Sets the `S` (Status) flag to `TRUE` or `FALSE`.

-   **`set_interrupt_flag(BOOLEAN)`**:
    Enables or disables the master interrupt flag (`interrupts_enabled`).

-   **`shadow(OPERATION)`**:
    Manages the saving and restoring of CPU context for interrupt handling.
    -   `SAVE`: Copies current registers and flags to shadow registers.
    -   `RESTORE`: Restores registers and flags from shadow registers.

-   **`branch(FLAG, n-lines)`**:
    Performs conditional or unconditional jumps within the microcode sequence.
    -   `FLAG`: Specifies the condition for branching (`A` for always, `E` for Equal, `Z` for Zero, `N` for Negative, `S` for Status).
    -   `n-lines`: The relative offset (number of microcode steps) to jump.

-   **`load_immediate(REG, VALUE)`**:
    Loads an immediate `VALUE` into the specified `REG`ister (e.g., `R0`-`R9`, `PC`, `SP`, `Ra`, `Rb`).

-   **`move_reg(DEST_REG, SRC_REG)`**:
    Copies the value from `SRC_REG` to `DEST_REG`. Both can be GPRs or internal ALU registers.

-   **`alu(OPERATION)`**:
    Performs an Arithmetic Logic Unit operation on `Ra` and `Rb`, storing the result in `Ra` and updating the CPU flags.
    -   `ADD`: `Ra = Ra + Rb`
    -   `SUB`: `Ra = Ra - Rb`
    -   `MUL`: `Ra = Ra * Rb`
    -   `DIV`: `Ra = Ra // Rb` (integer division, handles division by zero).
    -   `INC`: `Ra = Ra + 1`
    -   `DEC`: `Ra = Ra - 1`
    -   `CMP`: Compares `Ra` and `Rb` and sets flags accordingly (no change to `Ra`).

-   **`store_mem_adres(ADDRESS, REG)`**:
    Stores the value of `REG` at the specified memory `ADDRESS`.

-   **`store_mem_reg(ADDR_REG, DATA_REG)`**:
    Stores the value of `DATA_REG` at the memory address contained in `ADDR_REG`.

-   **`read_mem_adres(ADDRESS, REG)`**:
    Reads the value from the specified memory `ADDRESS` and loads it into `REG`.

-   **`read_mem_reg(ADDR_REG, DATA_REG)`**:
    Reads the value from the memory address contained in `ADDR_REG` and loads it into `DATA_REG`.

#### `_set_flags()`

Updates the `Z`, `N`, and `E` flags based on the result of the last ALU operation (specifically, the value in `Ra` and the comparison between `Ra` and `Rb`).

#### `dump_state()`
.

## 2. CPU_M1 (Pipeline Architecture)

The `CPU_M1` is a next-generation processor designed for high throughput. Unlike the R3, which executes one instruction at a time, the M1 utilizes a **3-Stage Pipeline** to process multiple instructions in parallel.

### Pipeline Stages (Robots)

1.  **Fetch Unit**:
    *   Prefetches instructions from memory into the `MIR`.
    *   Uses a **Branch Predictor** (BTFN) to speculatively determine the next PC address.
2.  **Decode Unit**:
    *   Decodes the integer instruction from the `MIR`.
    *   Pushes the decoded microcode sequence into an **Instruction Buffer**.
3.  **Execute Unit**:
    *   Pops microcode sequences from the buffer.
    *   Executes them against the ALU.
    *   **Verification**: Checks if the Branch Predictor was correct. If not, it flushes the pipeline and rewinds the PC.

### Key Differences from R3
*   **Parallelism**: Fetch, Decode, and Execute occur simultaneously in a single `tick()`.
*   **Throughput**: Capable of significantly higher Instructions Per Second (IPS).
*   **Idle Handling**: Implements "Idle Skipping" via the `SLEEP` state to efficiently yield host CPU time during I/O waits.
*   **Simulation Overhead**: Due to the complexity of simulating three parallel stages in Python, the M1 `tick()` is computationally heavier. While the *virtual* CPU is faster (higher IPS), the *simulation* may run slower in wall-clock time on the host machine compared to the simpler R3.

*   Prints a comprehensive overview of the CPU's current state, including:
    -    Current CPU state (FETCH, DECODE, EXECUTE, HALT).
    -   Values of `PC`, `SP`, and `MIR`.
    -   Status of all flags (`Z`, `N`, `E`, `S`).
    -   Values of all General Purpose Registers (`R0` .. `R9`).
    -    Values of internal ALU registers (`Ra`, `Rb`).
    -   Whether interrupts are currently enabled.

