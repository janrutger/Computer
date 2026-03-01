# Sternnet Protocol Specification

This document specifies the on-the-wire data formats for the Sternnet.

## 1. Frame Structure (The "Packet")
Sternnet uses a **Unified Fixed Header** of 16 bytes. This collapses Layer 2 (Link) and Layer 4 (Transport) for simplicity and performance.

**Header Layout (16 Bytes):**
`[ DEST (4) ] [ SRC (4) ] [ D_PORT (1) ] [ S_PORT (1) ] [ TYPE (1) ] [ LEN (1) ] [ MSG_ID (2) ] [ PKT_ID (2) ]`

*   **0-3 DEST:** 32-bit Destination Address.
*   **4-7 SRC:** 32-bit Source Address.
*   **8 D_PORT:** 8-bit Destination Port (Service ID).
    *   **0:** Well-Known Port for the Main Application (Default).
    *   **1-255:** User-defined ports (e.g., 10=Chat, 20=File).
*   **9 S_PORT:** 8-bit Source Port. Required for the receiver to send ACKs back to the correct application on the sender's machine.
*   **10 TYPE:** 8-bit Packet Type.
*   **11 LEN:** 8-bit Payload Length (in bytes). Max payload is 240 bytes (256 - 16 header).
*   **12-13 MSG_ID:** 16-bit Message ID (Session ID). Randomly generated at the start of a stream.
*   **14-15 PKT_ID:** 16-bit Packet Sequence Number.
*   **16+ PAYLOAD:** Variable length data (Max 1008 bytes to fit in 1024-word buffer).

**Packet Types Table:**
| Type | Value | Name | Description |
| :--- | :--- | :--- | :--- |
| 0 | `0x00` | `HELLO` | **Infrastructure:** Sent by vNIC to vSwitch on startup to register presence. Ignored by other nodes. |
| 1 | `0x01` | `SYN` | **Control:** Initiates a new reliable session (Stream). Allocates reassembly buffer at receiver. |
| 2 | `0x02` | `DATA` | **Payload:** Contains actual message data. Requires `PKT_ID` for ordering. |
| 3 | `0x03` | `ACK` | **Control:** Acknowledges receipt of a specific `PKT_ID` for a `MSG_ID`. |
| 4 | `0x04` | `FIN` | **Control:** Indicates end of a message/stream. Receiver passes buffer to application. |
| 5 | `0x05` | `RST` | **Control:** Error/Reset. Sent if port is closed or session is unknown. Aborts connection. |

*Note: CRC has been removed as the underlying UDP/IP transport guarantees integrity for this simulation.*

## 2. Addressing Scheme
*   **Address Space:** Flat 32-bit address space.
*   **Capacity:** Effectively infinite.
*   **Assignment:** Dynamic Hashing. `ID = hash(hostname)`.
*   **Reserved:**
    *   `0x00`: Null / Unassigned.
    *   `0xFFFFFFFF`: Broadcast (Sent to all nodes).

## 3. Transport Protocols

### Mode A: SDP (Stern Datagram Protocol) - "Unreliable"
*   Fire and forget (e.g., sending a single `DATA` packet).
*   Used for: Heartbeats, Status updates, Streaming sensor data.
*   No guarantee of delivery.

### Mode B: SRP (Stern Reliable Protocol) - "Reliable"
*   Connection-oriented, using the `SYN`, `ACK`, and `FIN` packet types.
*   **Implementation:** This protocol is implemented entirely in the **User Library (`net_lib`)**. The Kernel is unaware of connections or states.
*   **Responsibility:** The User Library is responsible for connection state, sequence tracking, retransmission timers, and generating `ACK` packets.

## 4. Data Serialization (Payload Encoding)
Since the vNIC hardware truncates all memory values to 8-bit bytes (0-255) for transmission, the application layer must serialize data before sending.

### Recommendation: ASCII Text
For Phase 1, it is strongly recommended to encode all payload data as **ASCII Strings**.
*   **Strings:** Sent as-is (e.g., "Rutger").
*   **Numbers:** Converted to string representation (e.g., 42 -> "42").
*   **Benefits:** Human-readable, easy to debug, avoids endianness issues.

### Binary Data (Advanced)
If raw binary data is required (e.g., for efficiency), the application must manually split 16-bit or 32-bit integers into individual bytes (Big Endian recommended) before placing them in the send buffer.