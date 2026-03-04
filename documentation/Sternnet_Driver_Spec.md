# Sternnet Kernel Driver & Transport Protocol Specification

This document specifies the software interface and behavior of the Sternnet kernel driver.

## 1. Overview
The kernel driver is responsible for managing the vNIC hardware and implementing the Transport Layer protocols (SDP and SRP). It exposes a set of system calls for applications to use the network.

## 2. The "Switchboard": Port Binding
The driver acts as a central switchboard, routing incoming packets to the correct application buffer based on the `SRV` (Service/Port) field in the packet header.

*   **Mechanism:** An application MUST create a `deque` and bind it to a specific port number. The kernel maintains an internal table mapping port numbers to deque pointers.
*   **Well-Known Ports:** Port `0` is reserved for the Main Application. Senders can default to this port if the target service is unknown.
*   **API:** `NET.bind ( port_id deque_ptr -- )`

### 2.1 Data Serialization (The "Byte-Squeeze")
Because the vNIC maps 1 Memory Word to 1 Network Byte, the Driver is responsible for serializing headers.

*   **Writing Headers:** The Driver MUST NOT write 32-bit integers directly to the TX Ring. It must split them into 4 bytes (Big Endian) and write them to 4 consecutive ring slots.
    *   *Example:* `DEST_ADDR` (32-bit) occupies 4 slots. `MSG_ID` (16-bit) occupies 2 slots.
*   **Reading Headers:** In the ISR, the Driver must read 4 consecutive slots to reconstruct the 32-bit `DEST_ADDR` or 2 slots for `MSG_ID`.
*   **Payloads:** Application payloads are assumed to be byte-aligned (ASCII or pre-serialized).

### 2.2 Packet Polling and Demultiplexing
The `NET.recv_poll` function is the critical "Demultiplexer" of the system. It is called by the application or kernel main loop to check for new packets.

**Workflow:**
*   **Check for Data:** The function first checks if `NIC_RX_TAIL != NIC_RX_HEAD`. If they are equal, it returns immediately.
*   **Process Packet:** If data exists:
    *   **Read Packet Info:** Read the packet's `LENGTH` and `SRV` (Port) ID from the ring buffer.
    *   **Lookup Port:** Find the application Deque bound to this `SRV` ID.
    *   **Check Application Buffer:** Check if the target Deque has space.
        *   **If Space Available:**
            *   Copy the packet from the Ring Buffer to a new list.
            *   Push the list pointer to the application's Deque.
            *   Reset the port's "drop counter".
        *   **If Deque is Full (Congestion Control):**
            *   **Drop Packet:** Do not copy the data. The application is overwhelmed, so we shed load here to keep the hardware ring open.
    *   **Advance Hardware Tail:** Update `NIC_RX_TAIL` to point to the next packet in the ring buffer.
    *   **Update Hardware Register:** Write the new `NIC_RX_TAIL` value to the MMIO register to signal to the vNIC that space has been freed.

## 3. Transport Protocols

### 3.1 Mode A: SDP (Stern Datagram Protocol) - Unreliable
This mode provides a simple, fire-and-forget datagram service.

*   **API:** `NET.send_datagram ( dest_addr srv_id data_ptr len -- )`
*   **Behavior:** The function constructs a single `DATA` packet and places it on the vNIC's TX ring buffer. It returns immediately. There is no guarantee of delivery.
*   **Receiving:** The application polls its bound deque. If data is present, it can be read.

### 3.2 Mode B: SRP (Stern Reliable Protocol)
The Kernel **does not** implement the Reliable Protocol logic directly. Instead, it provides the raw packet delivery mechanism that the **User Library** uses to implement SRP.

*   **Kernel Role:** Stateless packet shuffling.
*   **Library Role:** Sequence tracking, ACK generation, Retransmission, and Flow Control.

### 3.3 Design Rationale: Why Two Modes?
The decision to support both an unreliable (SDP) and a reliable (SRP) protocol is fundamental to the design of a versatile network stack.

*   **SDP (like UDP):** Provides a low-latency, low-overhead mechanism for sending data where timeliness is more important than guaranteed delivery. This is essential for applications like real-time status updates, streaming sensor data, or network heartbeats. The implementation cost is minimal.

*   **SRP (like TCP):** Provides guaranteed, in-order delivery at the cost of higher latency and overhead due to handshakes and acknowledgments. This is necessary for applications where data integrity is critical, such as file transfers or critical command-and-control messages.

Forcing all traffic through the reliable SRP would make many real-time applications unacceptably slow. Providing both modes allows the application developer to choose the correct tool for their specific needs.

## 4. Kernel API Summary

*   `NET.init ( -- )`: Initializes the driver and the vNIC hardware.
*   `NET.bind ( port_id deque_ptr -- )`: Binds a port to a deque.
*   `NET.send_datagram ( dest srv data len -- )`: Unreliable send.
*   `NET.recv_poll ( deque_ptr -- data_ptr len )`: Non-blocking check for data on a deque. Returns `0 0` if empty.