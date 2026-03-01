# Sternnet Architecture Overview

## 1. Overview
Sternnet is a custom packet-switched network designed for the Stern-ATX ecosystem. It follows a simplified layered model inspired by the OSI model and early Ethernet.

**Design Philosophy:** "Simple, Explicit, Interrupt-Driven."

## 2. System Components

### 2.1 The Medium (The "Wire")
*   **Implementation:** Host-side UDP Datagrams (Localhost).
*   **Topology:** Star Topology.
*   **Components:**
    *   **vSwitch:** A standalone Python UDP Server that acts as a Layer 2 switch.
    *   **vNIC:** A memory-mapped DMA device within `stern-ATX.py`.

### 2.2 Detailed Specifications
The detailed design of each component is specified in separate documents:

*   **Sternnet vSwitch Specification:** Defines the logic for the central switch, including its learning and forwarding behavior.
*   **Sternnet vNIC Specification:** Defines the hardware interface for the virtual network card, including its MMIO registers and DMA ring buffer mechanism.
*   **Sternnet Protocol Specification:** Defines the on-the-wire frame structure and the application-level protocols (SDP and SRP).
*   **Sternnet Driver Specification:** Defines the kernel-level software API for raw packet I/O (SDP).
*   **Sternnet User Library Specification:** Defines the high-level `net_lib` that implements the Reliable Protocol (SRP) and connection state management.
*   **Sternnet Use Cases:** Provides detailed, step-by-step sequences for common network operations.
*   **Sternnet Diagrams:** Visual diagrams of protocol sequences and state machines.
*   **Sternnet ADR:** Architecture Decision Records documenting trade-offs and final decisions.

## 3. Implementation Phases

1.  **Phase 1: The Virtual Iron**
    *   Build `stern_switch.py` (The server).
    *   Implement the `VirtualNIC` class in `stern-ATX.py`.
    *   Verify basic connectivity.

2.  **Phase 2: The Driver**
    *   Write the Stacks kernel driver (`net_driver.stacks`) to manage the vNIC's ring buffers.
    *   Implement the Interrupt Service Routine (Stateless Demultiplexer).

3.  **Phase 3: The Application**
    *   Implement `net_lib.stacks` (Reliable Protocol Logic).
    *   Build a simple application (e.g., a chat program) to prove end-to-end functionality.

## 4. The Layered Model

Sternnet collapses the traditional 7-layer OSI model into a practical 4-layer stack optimized for the Stern-ATX environment.

| Layer | Name | Component | Responsibility |
| :--- | :--- | :--- | :--- |
| **4** | **Application** | User Code | Business logic, data serialization. |
| **3** | **Transport** | `net_lib` (SRP) / Kernel (SDP) | Reliability, ordering, flow control (SRP) or raw datagrams (SDP). |
| **2** | **Network / Link** | Kernel Driver & vSwitch | Packet framing, addressing, switching, ring buffer management. |
| **1** | **Physical** | UDP / vNIC Hardware | Moving bytes between Host OS and Guest RAM. |

## 5. Key Architectural Decisions

### 5.1 User-Space Reliability (The "Microkernel" Approach)
To keep the Kernel simple and fast, the complex logic for reliable transmission (retries, ACKs, sequence numbers) is pushed up to the **User Library (`net_lib`)**. The Kernel acts only as a fast packet shuffler. This prevents a single stalled connection from hanging the OS.

### 5.2 The "Byte-Squeeze" (Word-to-Byte Impedance Mismatch)
The Stern-ATX uses 16-bit/32-bit integers, but the network is byte-oriented.
*   **Decision:** The vNIC hardware truncates outgoing words to bytes (`Val % 256`).
*   **Implication:** The software stack must manually serialize higher-order integers into byte streams before sending.