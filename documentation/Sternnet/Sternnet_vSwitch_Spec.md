# Sternnet vSwitch Specification

This document specifies the design of the Sternnet virtual switch.

## 1. Overview
The vSwitch acts as an intelligent Layer 2 switch, not a simple hub. It is a standalone Python process that listens for UDP datagrams and forwards them based on the Sternnet frame header.

## 2. Core Logic

### 2.1 Core Tasks
1.  **Listen:** Binds to a UDP port (e.g., 8888) and waits for incoming datagrams.
2.  **Learn:** For every incoming packet, it reads the 32-bit `SRC_ADDR` from the Sternnet frame header. It updates its internal switching table with the mapping: `table[SRC_ADDR] = sender_ip_port`.
3.  **Decide & Forward:** It reads the 32-bit `DEST_ADDR` from the frame header and acts accordingly:
    *   **If `DEST_ADDR` is `0xFFFFFFFF` (Broadcast):** The packet is sent to *every* client in the switching table.
    *   **If `DEST_ADDR` is a known Unicast (in the table):** The packet is forwarded *only* to the corresponding `(IP, Port)`.
    *   **If `DEST_ADDR` is an unknown Unicast (not in the table):** The packet is **dropped** silently. Flooding is not supported.

### 2.2 Robustness: Unified Handling of Stale and Duplicate Connections
A key design challenge is how the switch handles a known Sternnet Address appearing from a new UDP `(IP, Port)`. This can happen in two scenarios: a legitimate client reboot or a duplicate ID conflict.

*   **Unified Policy:** To handle both cases simply and robustly, the switch follows a single "Last Seen Wins" policy. When a packet arrives with a `SRC_ADDR` that is already in the switching table, but from a new `sender_ip_port`:
    1.  The switch **MUST** print a generic warning to its console (e.g., `INFO: Address 0x... has moved to new port. Possible reboot or duplicate ID.`).
    2.  The switch **MUST** update its table to map the `SRC_ADDR` to the new `sender_ip_port`.

*   **Effect:**
    *   In the case of a reboot, this policy **self-heals** the connection.
    *   In the case of a duplicate ID, this policy **notifies the developer** of a configuration error while allowing the most recently active client to communicate.