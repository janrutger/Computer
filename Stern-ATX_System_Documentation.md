# Stern-ATX System Architecture

## 1. Introduction

The **Stern-ATX** is the next-generation evolution of the virtual computer system. It represents a major architectural shift from the previous Stern-XT platform, transitioning from a string-based emulation environment to a high-performance **integer-based system**.

This new platform features a redesigned motherboard capable of hosting interchangeable CPU architectures (M1 and R3) and utilizes a new memory controller (`MemoryR3`) to eliminate runtime type conversions, significantly boosting execution speed.

## 2. Core Architecture

### 2.1. Motherboard & Memory
The heart of the system is the Stern-ATX motherboard, which integrates the `MemoryR3` silicon.

*   **Integer Storage**: Unlike the previous generation which stored memory values as strings (e.g., "100", "613-1"), the ATX platform stores pure integers.
*   **Performance**: This change removes the overhead of string-to-int parsing during every fetch and read/write cycle.
*   **Binary Compatibility**: The system maintains compatibility with existing `.bin` program files. The ATX Loader automatically detects legacy string patterns (like `613-1`) and converts them into signed integers (e.g., `-6131`) during the boot process.

### 2.2. Dual CPU Support
The Stern-ATX supports swappable CPU modules, allowing developers to test different micro-architectures.

*   **CPU-R3 (Hybrid)**: The classic, robust architecture updated for the integer-based memory system. It is the default processor.
*   **CPU-M1 (Pipeline)**: A new, high-performance architecture featuring a deeper instruction pipeline, designed specifically for the ATX platform.

## 3. Memory Map

The system addresses 16KB (16,384 words) of unified memory. I/O devices are memory-mapped into a specific region, growing downwards from the Variable space.

| Address Range | Description |
| :--- | :--- |
| `00000 - 01023` | **Loader**: Bootloader and system initialization. |
| `01024 - 03071` | **Kernel**: OS Kernel and Stacks Language Interpreter. |
| `03072 - 04095` | **Vectors**: Interrupt and Syscall vector tables. |
| `04096 - 12246` | **Program Space**: User programs and heap. |
| `12247 - 12287` | **Memory Mapped I/O**: (See Detail Below) |
| `12288 - 14335` | **Variables & Stack**: Global variables and system stack (grows down). |
| `14336 - 16383` | **Video Memory**: 80x24 Character Display buffer. |

### 3.1. I/O Map Detail

| Address | Device | Description |
| :--- | :--- | :--- |
| `12247` | **RTC** | Real Time Clock (1 Register). |
| `12248 - 12271` | **UDC** | Universal Device Controller (24 Registers). |
| `12272 - 12279` | **Virtual Disk** | File System Interface (8 Registers). |
| `12280 - 12287` | **Keyboard** | Input Device (8 Registers). |

## 4. Instruction Decoding & Binary Format

The transition to integer memory required a change in how instructions are decoded, specifically regarding negative immediate values.

### 4.1. The "613-1" Problem
In the old text-based memory, an instruction like `MUL R3, -1` was stored as the string `"613-1"` (Opcode `61`, Reg `3`, Value `-1`). As an integer, this is not a valid number.

### 4.2. The ATX Solution
1.  **Loader**: When loading a binary, the system parses `"613-1"`, combines the digits, and negates the result to store the integer `-6131`.
2.  **Decoder**: The CPU decoder recognizes negative integers as instructions containing a negative immediate operand.
    *   It takes the absolute value (`6131`).
    *   Extracts the Opcode (`61`).
    *   Extracts the Register (`3`).
    *   Extracts the Operand (`1`) and negates it back to `-1` because the original instruction integer was negative.

## 5. Peripherals

The Stern-ATX retains compatibility with Stern-XT peripherals while adding new capabilities.

*   **Universal Device Controller (UDC)**: The primary bus for external devices like the **Virtual LCD**, **Plotter**, and **Sensors**.
*   **Virtual Disk**: Provides persistent storage by mapping host files to the virtual environment.
*   **RTC (Real Time Clock)**: *New in ATX*. A dedicated hardware clock mapped to Interrupt Vector 1, allowing for precise timekeeping and timed events.

## 6. Hardware Acceleration: GPU_R3

The **GPU_R3** is a specialized co-processor designed for high-performance matrix operations and neural network calculations. It is tightly integrated with the `MemoryR3` integer system.

### 6.1. Key Features
*   **Matrix Processing**: Native support for matrix addition, subtraction, multiplication, and dot products.
*   **TDL Chaining**: Executes complex pipelines defined by linked lists of **Task Description Lists (TDLs)** in a single CPU cycle.
*   **VRAM Caching**: Internal caching mechanism to minimize main memory I/O during deep learning forward passes.
*   **Integer/Fixed-Point**: Handles scaling natively, allowing for fixed-point arithmetic on integer hardware.

### 6.2. Programming Model
The GPU is controlled by constructing TDLs in main memory. Each TDL specifies the operation, operands (matrix pointers), result destination, and a pointer to the next TDL.

*   **Supported Operations**: ADD, SUB, MUL, DOT (Matrix Multiplication), RELU, TRANS (Transpose), THRESH.

*For detailed programming instructions and memory layouts, refer to the `GPU_R3_Manual.md`.*

## 7. Usage

The `stern-ATX.py` emulator is the entry point for the system.

### 7.1. Basic Execution
Run the system with the default CPU-R3:
```bash
python stern-ATX.py
```

### 6.2. Selecting a CPU
To run with the high-performance M1 pipeline CPU:
```bash
python stern-ATX.py -cpu m1
```
To explicitly select the R3 CPU:
```bash
python stern-ATX.py -cpu r3
```

### 6.3. Debugging
Launch the integrated debugger (breakpoints, memory inspection, stepping):
```bash
python stern-ATX.py -debug
```

## 7. Performance Metrics

The Stern-ATX includes a built-in performance profiler that reports statistics upon system shutdown:

*   **Core Speed**: The effective clock speed of the emulation (Hz/kHz/MHz).
*   **IPS**: Instructions Per Second.
*   **CPI**: Cycles Per Instruction (Lower is better).

*Note: The M1 CPU typically achieves a lower CPI due to its pipeline architecture, though the raw emulation speed depends on the host machine.*