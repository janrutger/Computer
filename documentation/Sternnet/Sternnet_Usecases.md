# Sternnet Use Cases & Sequences

This document provides detailed, step-by-step sequences for common network operations. It serves as a guide for implementing the kernel driver and user libraries.

## 1. System Power-Up and Initialization

This sequence describes the process from starting the `stern-ATX.py` simulation to an application being ready to receive packets.

### Phase A: Host and Hardware (Python)

*   **`stern_switch.py` starts:**
    *   Creates a UDP socket and binds to `localhost:8888`.
    *   Initializes an empty dictionary for its `switching_table`.
    *   Enters a loop, waiting to receive data.

*   **`stern-ATX.py` starts:**
    *   The `VirtualNIC` class is instantiated.
    *   **vNIC State:** The vNIC starts in a `DISABLED` state.
    *   The vNIC creates its own UDP socket and binds to an ephemeral (random) OS port (e.g., `51234`).
    *   The vNIC immediately sends a `HELLO` packet (`TYPE=0`) to the switch at `localhost:8888`.

*   **The Switch Learns:**
    *   The `vSwitch` receives the `HELLO` packet from `('127.0.0.1', 51234)`.
    *   It parses the packet's `SRC_ADDR` (e.g., `0x...`, the hash of the hostname).
    *   It updates its table: `switching_table[0x...] = ('127.0.0.1', 51234)`.
    *   The switch now knows how to reach this client.

### Phase B: Kernel and Application (Stacks)

*   **Kernel Boot & `NET.init`:**
    *   The Stacks OS boots and calls the network driver's `NET.init` function.
    *   **Allocate Buffers:** The kernel allocates two blocks of memory from the heap for the RX and TX ring buffers (e.g., 256 words each).
    *   **Configure vNIC:** The kernel writes the buffer addresses, size, and node ID to the `NIC_RX_BASE`, `NIC_TX_BASE`, `NIC_RING_SZ`, and `NIC_ADDR` registers.
    *   **Enable vNIC:** The kernel writes `2` (ENABLE) to `NIC_CMD`. The vNIC hardware is now active.

*   **Application Starts:**
    *   The main application begins execution.
    *   It creates a `deque` to serve as its incoming message queue.
    *   It calls `NET.bind(0, &my_deque)` to register its interest in the well-known port 0.

**End State:** The system is fully initialized. The vSwitch knows the client's location, the vNIC is active, the Kernel is managing the buffers, and the Application is listening for packets on Port 0.

## 2. Reliable Message Send (SRP) with Pumping Loop

This sequence demonstrates how the User Library sends a message reliably without blocking incoming traffic (preventing deadlocks).

**Scenario:** Node A wants to send "Hello" to Node B.

1.  **Application Call:** App calls `NET_LIB.send(dest_B, port, "Hello")`.
2.  **Library Setup:** `NET_LIB` generates a random `MSG_ID` and constructs a `SYN` packet.
3.  **Send SYN:** `NET_LIB` calls Kernel `NET.send_datagram` to put the `SYN` on the wire.
4.  **Enter Pumping Loop (The Wait):**
    *   The Library needs to wait for `SYN+ACK`. It enters a `WHILE` loop.
    *   **Poll:** Inside the loop, it calls `NET.recv_poll` to check its own RX Deque.
    *   **Case: No Data:** It checks the timeout timer. If not expired, it calls `NOP` (yield CPU) and repeats the loop.
    *   **Case: Data Arrived (The Deadlock Breaker):**
        *   A packet is found in the deque.
        *   **Is it our SYN+ACK?** Yes -> Break loop, proceed to send DATA.
        *   **Is it a SYN from Node C?** Yes -> We are also a server! Process it, send `SYN+ACK` to Node C, then **continue waiting** for our own ACK.
        *   **Is it DATA from Node B?** Yes -> Node B is sending to us simultaneously. Process it, send `ACK` to Node B, then **continue waiting**.
5.  **Send DATA:** Once `SYN+ACK` is received, the Library constructs the `DATA` packet with "Hello".
6.  **Pumping Loop (Again):** It sends the `DATA` and enters the Pumping Loop again, waiting for the final `ACK`.
7.  **Send FIN:** Once `ACK` is received, it sends `FIN`.
8.  **Pumping Loop (Final):** It waits for `FIN+ACK`.
9.  **Return:** Function returns `True` (Success) to the Application.

**Key Takeaway:** By processing incoming packets *while* waiting for outgoing ACKs, the node remains responsive, preventing the "Head-of-Line Blocking" deadlock.

## 3. Unreliable Datagram Send (SDP)

This sequence demonstrates the "Fire and Forget" path used for high-speed, loss-tolerant data (e.g., sensor streams).

**Scenario:** Node A sends a sensor reading to Node B.

1.  **Application Call:** App calls `NET.send_datagram(dest_B, port, data_ptr, len)`.
2.  **Kernel Driver:**
    *   Checks if the TX Ring Buffer has space.
    *   **If Full:** Returns immediately (Drop) or waits briefly with `NOP` (depending on implementation choice).
    *   **If Space:**
        *   Constructs the 16-byte header (Type=`DATA`, MSG_ID=0, PKT_ID=0).
        *   Copies the payload to the Ring Buffer.
        *   Updates `NIC_TX_HEAD`.
3.  **Hardware:** vNIC sees the new head pointer, reads the packet via DMA, and sends it over UDP.
4.  **Return:** The function returns immediately. No ACK is expected or waited for.

## 4. Reliable Message Receive (SRP)

This sequence details how an application receives a reliable stream using the `net_lib`.

**Scenario:** Node B is listening for a message from Node A.

1.  **Application Loop:** App calls `NET_LIB.read(conn_ptr)` periodically.
2.  **Library Logic (Inside `read`):**
    *   **Poll:** Checks the RX Deque. Finds a packet.
    *   **Packet is SYN:** Library sees `TYPE=SYN`. It resets its internal `expected_pkt_id` to 0, stores the `MSG_ID`, and immediately sends a `SYN+ACK` packet back to Node A. It returns `0` (No Data) to the App.
    *   **Packet is DATA (ID=0):** Library sees `TYPE=DATA` and `PKT_ID=0`. This matches `expected_pkt_id`. It increments `expected_pkt_id` to 1, sends an `ACK` (ID=0) to Node A, and returns the data pointer to the App.
    *   **Packet is DATA (ID=0) AGAIN:** (Duplicate). Library sees `PKT_ID < expected_pkt_id`. It re-sends `ACK` (ID=0) and drops the data.
    *   **Packet is FIN:** Library sees `TYPE=FIN`. It sends `FIN+ACK` and returns `-1` (EOF) to the App.
3.  **Application:** Processes the data chunks as they are returned.