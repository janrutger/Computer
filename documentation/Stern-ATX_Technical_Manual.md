# Stern-ATX Technical Reference Manual

## 1. Introduction

The **Stern-ATX** is a virtual computer system designed around a custom 16-bit integer-based architecture. It features a modular mainboard design that supports interchangeable CPUs, a unified memory architecture with memory-mapped I/O, and a sophisticated set of peripherals managed by dedicated controllers.

This document provides a technical overview of the system's architecture, memory map, processor options, and peripheral interfaces.

## 2. System Architecture

The system is emulated via a synchronous burst cycle loop (`stern-ATX.py`). The mainboard integrates the following core components:

*   **CPU Socket**: Supports CPU-R3 (Hybrid) and CPU-M1 (Pipelined).
*   **Memory Controller**: Manages 24,576 words of integer RAM.
*   **Interrupt Controller**: Prioritized interrupt handling.
*   **I/O Bus**: Memory-mapped interface for peripherals.
*   **Video Controller**: Text-mode display driver.

## 3. Memory Map

The Stern-ATX uses a flat memory model with specific regions reserved for the kernel, user programs, I/O, and video memory.

| Address Range | Size (Words) | Description |
| :--- | :--- | :--- |
| `00000 - 01023` | 1024 | **Loader / BootROM** |
| `01024 - 08191` | 7168 | **Kernel Space** |
| `08192 - 09215` | 1024 | **Interrupt & Syscall Vectors** |
| `09216 - 18390` | 9175 | **User Program Space** |
| `18391 - 18431` | 41 | **Memory Mapped I/O (MMIO)** |
| `18432 - 22527` | 4096 | **Variables / Heap / Stack** |
| `22528 - 24447` | 1920 | **Video Memory (Text Buffer)** |
| `24448 - 24576` | 128 | Reserved / Unused |

### 3.1 Memory Mapped I/O Detail

Peripherals are mapped downwards from `MEM_IO_END` (18431).

| Device | Base Address | Registers | Description |
| :--- | :--- | :--- | :--- |
| **Keyboard** | `18424` | 1 | Data Register at `+0` |
| **Virtual Disk** | `18416` | 5 | Status, Command, Buffer Ptr, Hash, Block Info |
| **UDC** | `18392` | 12 | Universal Device Controller (8 Channels) |
| **RTC** | `18391` | 1 | Real Time Clock Data |

## 4. Central Processing Units (CPU)

The mainboard supports two CPU architectures, selectable at boot time.

### 4.1 CPU-R3 (Hybrid Architecture)
*   **Type**: Non-pipelined, Fetch-Decode-Execute cycle.
*   **Features**:
    *   Native Integer execution (MemoryR3).
    *   Integrated GPU-R3 co-processor (Mode 1).
    *   10 General Purpose Registers (`R0`-`R9`).
    *   Special Registers: `PC` (Program Counter), `SP` (Stack Pointer).
    *   Internal ALU Registers: `Ra`, `Rb`.

### 4.2 CPU-M1 (Pipeline Architecture)
*   **Type**: 3-Stage Pipeline (Fetch, Decode, Execute).
*   **Features**:
    *   **Robotic Pipeline**: Three independent "robots" handle the stages.
    *   **Branch Prediction**: Static prediction (Backward Taken, Forward Not Taken) with Return Address Stack (RAS).
    *   **Instruction Buffer**: Decouples Fetch and Decode stages.
    *   **Performance**: Higher throughput due to parallelism, though sensitive to pipeline flushes on branch mispredictions.

## 5. Interrupt System

The **Interrupt Controller** manages asynchronous events from peripherals. It queues interrupts to prevent loss during high-load CPU bursts.

### Interrupt Vectors

| Vector | Source | Description |
| :--- | :--- | :--- |
| `0` | **Keyboard** | Triggered on key press. ASCII code written to `MEM_KEYBOARD_DATA`. |
| `1` | **RTC** | Triggered every 200ms. Time (ms) written to `MEM_RTC_IO_ADRES`. |

The CPU checks for pending interrupts during the `FETCH` state. If the Master Interrupt Flag is enabled, the CPU saves its state to shadow registers and jumps to the ISR address stored at `MEM_INT_VECTORS_START + Vector`.

## 6. Peripherals

### 6.1 Universal Device Controller (UDC)
The UDC manages external devices via a channel-based system. It handles command queuing and status reporting.

*   **Base Address**: `18392`
*   **Channels**: 8 (0-7)
*   **Connected Devices**:
    *   **Channel 0**: Sensor (Reads environmental data).
    *   **Channel 1**: Plotter (Vector graphics output).
    *   **Channel 2**: Virtual LCD (Secondary display).

**Registers:**
*   `Channel` (+0): Selects the active channel.
*   `Status` (+1): Reports `WAITING`, `CPU_WAITING`, `UDC_WAITING`, or `ERROR`.
*   `Command` (+2): Instruction for the device (e.g., `INIT`, `SEND`, `DRAW`).
*   `Data` (+3): Payload for the command.
*   `DeviceType[0-7]` (+4 to +11): Stores the type ID of the device on each channel.

### 6.2 Virtual Disk
Provides file system access to the host OS. It uses a handshake protocol and filename hashing for security and simplicity.

*   **Base Address**: `18416`
*   **Registers**:
    *   `Status` (+0): `IDLE`, `HOST_WAITING`, `SUCCESS`, `ERROR`, `BUSY`.
    *   `Command` (+1): `INIT`, `OPEN`, `CREATE`, `READ`, `WRITE`, `CLOSE`.
    *   `Buffer Ptr` (+2): Pointer to memory buffer for filenames/data.
    *   `File Hash` (+3): 64-bit hash of the target filename.
    *   `Last Block` (+4): Flag indicating EOF during reads.

### 6.3 GPU-R3
A co-processor integrated into the CPU (not MMIO). It executes Task Description Lists (TDLs) stored in main memory.

*   **Capabilities**: Matrix addition, subtraction, multiplication, dot product, and scaling.
*   **VRAM**: Internal storage for matrices to reduce main memory bandwidth.
*   **Execution**: Triggered via the `GPU` microinstruction.

### 6.4 Real Time Clock (RTC)
Provides a steady time base.
*   **Interval**: 200ms (5 Hz).
*   **Data**: Current time in milliseconds (rollover ~31 days).

### 6.5 Keyboard
Captures host keystrokes via Pygame.
*   **Operation**: Writes ASCII code to `18424` and triggers Interrupt Vector 0.

### 6.6 Display
A memory-mapped text display.
*   **Resolution**: 80 columns x 24 rows.
*   **Memory Start**: `22528`.
*   **Format**: 1 integer per character (ASCII).
*   **Refresh**: The memory controller sets a `video_dirty` flag on writes to this region, triggering a screen redraw in the main loop.

## 7. Debugger

The system includes a built-in interactive debugger that can halt the CPU and inspect the system state.

*   **Activation**:
    *   Launch with `-debug` flag.
    *   Triggered by breakpoints set in code or via the debugger console.
*   **Features**:
    *   `step` / `microstep`: Cycle-by-cycle execution.
    *   `inspect`: View memory contents with symbol resolution.
    *   `breakpoints`: Set/Remove execution stops.
    *   `memmap`: Display current memory layout pointers.

## 8. Boot Process

1.  **Power On**: Components initialize. RAM is zeroed.
2.  **Loader**: The `program.bin` file is loaded into memory starting at address `0`.
3.  **CPU Reset**: PC is set to `MEM_LOADER_START` (0).
4.  **Execution**: The CPU begins fetching instructions.
    *   Typically, the boot code initializes the Stack Pointer (`SP`), sets up the Interrupt Vector Table, initializes the UDC and Disk, and then jumps to the Kernel or Main Program.