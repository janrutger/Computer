# GPU_R3 Developer Manual

## Overview
The **GPU_R3** is a specialized matrix processing unit designed for the Stern-ATX architecture. It is optimized for the **MemoryR3** integer-based memory system but maintains backward compatibility with legacy string-based memory.

Key features:
- **Numpy Backend**: Uses high-performance numpy arrays for calculations.
- **Internal VRAM**: Caches matrices during execution chains to minimize slow RAM I/O.
- **TDL Chaining**: Executes linked lists of Task Description Lists (TDLs), allowing complex pipelines (e.g., Neural Network forward passes) to run in a single CPU tick.
- **Integer/Fixed-Point Support**: Handles scaling natively for fixed-point arithmetic.

## Architecture

### Memory Modes
The GPU can be initialized in two modes via the constructor `GPU_R3(memory, mode=...)`:
- **Mode 0 (Legacy)**: Reads/Writes memory values as strings (requires conversion).
- **Mode 1 (Integer)**: Reads/Writes memory values directly as integers (High Performance).

### Matrix Memory Format
Matrices are stored in main memory as linear blocks:
- **Offset 0**: Number of Rows (Integer)
- **Offset 1**: Number of Columns (Integer)
- **Offset 2...N**: Data elements (Row-major order)

### VRAM & Caching
The GPU possesses an internal VRAM dictionary.
1. **Implicit Load**: When an instruction references a memory address not in VRAM, the GPU automatically loads the matrix from RAM into VRAM.
2. **Temporary Storage**: Intermediate results are stored in VRAM.
3. **Write-Back**: At the end of a TDL chain, only "dirty" matrices (results) are written back to main memory.
4. **Scope**: VRAM is cleared automatically after the `execute()` method returns.

## Task Description List (TDL)

The GPU is controlled via TDLs stored in main memory. Each TDL is a 7-word block.

| Offset | Field | Description |
| :--- | :--- | :--- |
| `+0` | **Arg A** | Pointer to Matrix A (or VRAM handle) |
| `+1` | **Arg B** | Pointer to Matrix B (or VRAM handle) |
| `+2` | **Result** | Pointer to Result Matrix (or VRAM handle) |
| `+3` | **Scale** | Divisor for fixed-point math (0 or 1 = no scaling) |
| `+4` | **Opcode** | Operation ID (see Opcodes below) |
| `+5` | **Status** | Written by GPU: `0` = Success, `1` = Error |
| `+6` | **Next** | Pointer to next TDL (0 = End of Chain) |

## Instruction Set (Opcodes)

| Opcode | Mnemonic | Operation | Description |
| :--- | :--- | :--- | :--- |
| `0` | **ADD** | `Res = A + B` | Element-wise addition. |
| `1` | **SUB** | `Res = A - B` | Element-wise subtraction. |
| `2` | **MUL** | `Res = (A * B) / Scale` | Element-wise multiplication with scaling. |
| `3` | **DOT** | `Res = (A . B) / Scale` | Matrix multiplication (Dot Product) with scaling. |
| `4` | **RELU** | `Res = max(0, A)` | Rectified Linear Unit (Activation function). |
| `5` | **TRANS** | `Res = A.T` | Matrix Transposition. |
| `6` | **THRESH** | `Res = (A > 0) ? Scale : 0` | Thresholding / Step function. |
| `12` | **FREE** | `del VRAM[A], VRAM[B]...` | Frees VRAM handles to save memory during long chains. |

## Usage Example (Python/Stern-XT)

### 1. Initialization
```python
from devices.memoryR3 import Memory
from devices.gpuR3 import GPU_R3

mem = Memory(size=16384)
# Initialize in Mode 1 (Integer Mode)
gpu = GPU_R3(mem, mode=1)
```

### 2. Setting up Data
```python
# Matrix A (2x2) at address 100
mem.write(100, 2) # Rows
mem.write(101, 2) # Cols
mem.write_block(102, [10, 20, 30, 40])

# Matrix B (2x2) at address 200
mem.write(200, 2)
mem.write(201, 2)
mem.write_block(202, [2, 2, 2, 2])

# Result Matrix C placeholder at address 300
mem.write(300, 2)
mem.write(301, 2)
```

### 3. Creating a TDL
```python
TDL_ADDR = 1000
mem.write(TDL_ADDR + 0, 100)  # Arg A
mem.write(TDL_ADDR + 1, 200)  # Arg B
mem.write(TDL_ADDR + 2, 300)  # Result
mem.write(TDL_ADDR + 3, 0)    # Scale (No scaling)
mem.write(TDL_ADDR + 4, 0)    # Opcode 0 (ADD)
mem.write(TDL_ADDR + 5, 0)    # Status (Init to 0)
mem.write(TDL_ADDR + 6, 0)    # Next TDL (0 = End)
```

### 4. Execution
```python
# Execute the TDL at address 1000
gpu.execute(1000)

# Check Result at 300
# Expected: [12, 22, 32, 42]
print(mem.read_block(302, 4))
```

## Error Handling
If an exception occurs during execution (e.g., dimension mismatch, invalid opcode):
1. The GPU catches the exception.
2. It writes `1` to the **Status** field (`TDL+5`) of the failing TDL.
3. Execution of the chain stops immediately.
4. VRAM is cleared.