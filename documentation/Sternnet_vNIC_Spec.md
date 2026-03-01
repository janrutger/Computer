# Sternnet Virtual NIC (vNIC) Specification

This document specifies the design of the Virtual Network Interface Controller.

## 1. Overview
The vNIC is a memory-mapped device that uses DMA (Direct Memory Access) via ring buffers to communicate with the CPU. It is responsible for moving packets between the host's UDP socket and the Stern-ATX's main memory.

## 2. Memory Map

**Base Location:** `0x47C7` - `0x47D6` (Decimal `18375` - `18390`)
*Note: This sits immediately below the RTC in the IO space.*

### 2.1 Registers
| Offset | Name | R/W | Description |
| :--- | :--- | :--- | :--- |
| 0 | `NIC_STATUS` | R | **Bitmask:** Bit 0 (1): `LINK_UP`, Bit 1 (2): `RX_RDY` (data available), Bit 2 (4): `TX_RDY` (ready to send), Bit 7 (128): `ERROR`. |
| 1 | `NIC_CMD` | W | 1=RESET, 2=ENABLE (Start DMA monitoring). |
| 2 | `NIC_ADDR` | R/W | The 32-bit Node ID. Typically `hash(hostname)`. 0=Unset, -1 (or 0xFFFFFFFF)=Broadcast. |
| 3 | `NIC_RX_BASE`| R/W | **Pointer** to start of RX Ring Buffer in RAM. |
| 4 | `NIC_RX_HEAD`| R | RX Ring Head (Written by NIC). |
| 5 | `NIC_RX_TAIL`| R/W | RX Ring Tail (Written by Kernel). |
| 6 | `NIC_TX_BASE`| R/W | **Pointer** to start of TX Ring Buffer in RAM. |
| 7 | `NIC_TX_HEAD`| R/W | TX Ring Head (Written by Kernel). |
| 8 | `NIC_TX_TAIL`| R | TX Ring Tail (Written by NIC). |
| 9 | `NIC_RING_SZ`| R/W | Size of the rings in words (e.g., 64, 128, 256). Must be a power of 2 for efficient index wrapping. |

## 3. Interrupts
*   **Vector:** The vNIC shall trigger **Interrupt Vector 2** when a packet is successfully placed in the RX Ring Buffer.

## 4. Internal Logic

### 4.1 Concurrency Model (Non-Blocking Polling)
The vNIC operates in a non-blocking mode within the main simulation thread. Its `tick()` method is called once per simulation frame.

### 4.2 Initialization Sequence (The "Handshake")
To prevent the vNIC from reading invalid memory on boot, it starts in a **DISABLED** state.

1.  **Power On:** vNIC is disabled. It ignores the UDP socket and does not touch RAM.
2.  **OS Allocation:** The Kernel allocates two memory blocks for the Ring Buffers.
3.  **Configuration:** The Kernel writes the buffer addresses to `NIC_RX_BASE` and `NIC_TX_BASE`, and sets `NIC_RING_SZ`.
4.  **Activation:** The Kernel writes `2` (ENABLE) to `NIC_CMD`.
5.  **Running:** The vNIC now actively polls the Ring Buffers and Socket in its `tick()` loop.

### 4.3 Core Tasks in `tick()`
*   **RX Task (Socket -> RAM):**
    1.  Read packet from UDP socket.
    2.  Perform address filtering (drop if not for this `NIC_ADDR` or broadcast).
    3.  Check if space exists in RX Ring. If Full: **Drop Packet Silently**.
    4.  Write `[LENGTH]` then `[PACKET_BYTES...]` to `RAM[RX_BASE + RX_HEAD]`.
    5.  Update `RX_HEAD` pointer in the register map.
    6.  Trigger Interrupt Vector 2.
*   **TX Task (RAM -> Socket):**
    1.  Check if `TX_HEAD != TX_TAIL` (i.e., if the Kernel has written a packet).
    2.  Read `LENGTH` from `RAM[TX_BASE + TX_TAIL]`.
    3.  Read the packet bytes from RAM.
    4.  Send the packet via the host UDP socket.
    5.  Update `TX_TAIL` pointer in the register map.

### 4.4 Data Format in RAM
Since Stern-ATX memory stores integers, the interface to the byte-oriented network requires strict serialization.

*   **1 Address = 1 Byte:** The vNIC treats each memory address in the Ring Buffer as a single 8-bit byte.
*   **Truncation:** If a value > 255 is stored in a Ring Buffer slot, the vNIC will truncate it (`Value % 256`) before transmission.
*   **Multi-Byte Fields:** A 32-bit value (like `DEST_ADDR`) MUST be written to 4 consecutive memory addresses (Big Endian).
*   **Packet Format in Ring:** `[ LENGTH (1 word) ] [ HEADER_BYTE_0 ] ... [ HEADER_BYTE_15 ] [ PAYLOAD_BYTE_0 ] ...`
*   **Atomicity:** The Kernel MUST write the full `LENGTH` and all `DATA` bytes before updating the `TX_HEAD` register. The vNIC relies on `LENGTH` to know exactly how many bytes to read for the UDP packet. It does *not* send partial fragments.

### 4.5 Driver Implementation Guidelines
*   **TX Flow Control:** The Kernel Driver MUST check if the TX Ring has space before writing.
    *   If the Ring is full, the Driver MUST execute a `NOP` (or `SLEEP`) instruction inside its wait loop to yield the CPU timeslice.
*   **Reliability:** The vNIC hardware does **not** generate ACKs.
    *   Packet reliability is the responsibility of the Software Stack (Layer 3/4).
    *   If a packet is dropped due to a full RX Ring, the Sender's software stack must detect the timeout and retransmit.

## 5. Design Notes

### 5.1 Buffer Sizing
The `NIC_RING_SZ` register makes the buffer size a runtime decision for the Kernel, not a fixed hardware constraint. This allows for a trade-off between memory usage and network performance.

*   **Small Buffers (e.g., 64 words):**
    *   **Pros:** Low memory footprint, suitable for simple devices or memory-constrained systems.
    *   **Cons:** Lower maximum packet size, leading to higher header overhead and potentially lower throughput. More susceptible to packet loss if the CPU is busy.
*   **Large Buffers (e.g., 1024 words):**
    *   **Pros:** Higher throughput due to larger packets. Can absorb more incoming packets during CPU-intensive tasks, reducing retransmissions.
    *   **Cons:** High static memory usage (e.g., 2KB for both RX/TX rings).

### 5.2 Memory Packing Strategy (The "Byte-Squeeze")
A critical architectural decision was made to map **1 Memory Word to 1 Network Byte** (Unpacked), rather than packing 4 bytes into 1 word.

*   **The Trade-off:** This approach wastes memory density in the ring buffers (storing 8 bits in a full integer container).
*   **The Benefit:** It provides **Zero-Copy String Compatibility**. In Stacks, strings are stored as arrays of integers (1 char per word). By matching this format in the hardware, the OS can copy strings directly to the network buffer without a slow, complex bit-shifting loop.
*   **Conclusion:** Given that the Stern-ATX is a high-level emulation where logic simplicity and text handling are prioritized over raw RAM density, the "Unpacked" model is the superior choice.