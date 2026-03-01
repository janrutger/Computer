# Sternnet User Library Specification (`net_lib.stacks`)

This document specifies the high-level standard library that application programmers use to access the network. It abstracts away the complexity of the raw Kernel API.

## 1. Overview
The `net_lib` provides a "Socket-like" interface. It handles the gritty details of the Reliable Protocol (SRP), such as sequence number tracking, duplicate detection, and automatic ACK generation.

**Philosophy:** "Complexity in the Library, Simplicity in the Kernel."

## 2. Data Structures
To manage a reliable connection, the library needs to track state.

*   **Connection Handle (`conn`):** A simple list or memory block containing:
    *   `[0]`: Pointer to the RX Deque (The Mailbox).
    *   `[1]`: `expected_pkt_id` (The next sequence number we want).
    *   `[2]`: `remote_addr` (Who we are talking to).
    *   `[3]`: `remote_port` (The service we are talking to).
    *   `[4]`: `active_msg_id` (The Session ID of the current stream).
    *   `[5]`: `local_port` (The port we are bound to).

## 3. API Specification

### 3.1 Initialization & Binding
*   `NET_LIB.listen ( port -- conn_ptr )`
    *   **Goal:** Setup a server to receive messages.
    *   **Logic:**
        1.  Allocates a new `conn` structure.
        2.  Creates a new Deque.
        3.  Calls Kernel `NET.bind`.
        4.  Initializes `expected_pkt_id = 0`.
        5.  Initializes `active_msg_id = -1` (Invalid).
        6.  Stores `local_port = port`.
        5.  Returns the `conn_ptr`.

### 3.2 Sending Data
*   `NET_LIB.send ( dest port data_ptr len -- success )`
    *   **Goal:** Send data reliably.
    *   **Logic:** Implements the "Stop-and-Wait" protocol in User Space.
    *   **Ephemeral Binding:** If the application has not explicitly bound a port (via `listen`), this function MUST automatically bind to a random "Ephemeral Port" (range 128-255) to ensure it can receive ACKs.
    *   **Retransmission:**
        *   `SRP_TIMEOUT_MS`: 500ms.
        *   `SRP_MAX_RETRIES`: 5.
    *   **The "Pumping" Loop:** When waiting for an ACK, this function MUST NOT just sleep. It must enter a loop that:
        1.  Checks the RX Deque (`NET.recv_poll`).
        2.  If a packet arrives, call `NET_LIB.process_packet` (internal handler).
            *   If it's our ACK: Break the loop, send next chunk.
            *   If it's a packet from someone else: Handle it (e.g., send an ACK back), then continue waiting.
        3.  Checks for Timeout.

### 3.3 Receiving Data (The "Magic" Function)
*   `NET_LIB.read ( conn_ptr -- data_ptr len status )`
    *   **Goal:** Get the next valid chunk of data, handling ACKs automatically.
    *   **Status Codes:** `1`=Data, `0`=No Data (Try again), `-1`=Connection Closed (FIN).
    *   **Internal Logic:**
        1.  **Poll:** Check the Deque in `conn_ptr`. If empty, return `0`.
        2.  **Inspect:** Read the packet header.
        3.  **Handle SYN:** If `TYPE == SYN`:
            *   **Case A (Retransmission):** `MSG_ID == active_msg_id`.
                *   The Sender missed our previous SYN+ACK.
                *   **Re-Send SYN+ACK**.
                *   Return `0`.
            *   **Case B (New Session):** `MSG_ID != active_msg_id`.
                *   Reset `expected_pkt_id = 0`.
                *   Store `active_msg_id = Packet.MSG_ID`.
                *   Send `SYN+ACK`.
                *   Return `0`.
        4.  **Handle DATA:** If `TYPE == DATA`:
            *   **Case A (Good):** `PKT_ID == expected_pkt_id` AND `MSG_ID == active_msg_id`.
                *   Increment `expected_pkt_id`.
                *   Send `ACK` for this ID.
                *   Return `data_ptr` and `1`.
            *   **Case B (Duplicate):** `PKT_ID < expected_pkt_id`.
                *   We already processed this. The ACK must have been lost.
                *   **Re-Send ACK** for this ID.
                *   Drop data and return `0`.
            *   **Case C (Out of Order):** `PKT_ID > expected_pkt_id`.
                *   Ignore/Drop. Sender will retry the correct one.
                *   Return `0`.
        5.  **Handle FIN:** If `TYPE == FIN`:
            *   Send `FIN+ACK`.
            *   Set `active_msg_id = -1` (Invalidate Session).
            *   Return `-1`.