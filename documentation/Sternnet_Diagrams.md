# Sternnet Protocol & State Diagrams

This document provides visual diagrams to clarify complex interactions within the Sternnet stack.

## 1. SRP Reliable Send Sequence Diagram

This diagram illustrates the "Pumping Loop" mechanism within the `NET_LIB.send` function. It shows how Node A can process other network traffic while waiting for an ACK from Node B, thus preventing deadlocks.

```
   Node A (Sender)                               Node B (Receiver)
       |                                               |
 App calls NET_LIB.send()                               |
       |                                               |
       |------------------ SYN (MSG=100) ------------->|
       |                                               |
       |                                          App calls NET_LIB.read()
       |                                               |
       |                                          [Sees SYN, stores MSG_ID]
       |                                          [Sends SYN+ACK]
       |<----------------- SYN+ACK --------------------|
       |                                               |
[Pumping Loop sees SYN+ACK]                             |
       |                                               |
       |------------------ DATA (PKT=0) -------------->|
       |                                               |
       |                                          App calls NET_LIB.read()
       |                                               |
       |                                          [Sees DATA, sends ACK]
       |<----------------- ACK (PKT=0) ----------------|
       |                                               |
[Pumping Loop sees ACK]                                 |
       |                                               |
       |------------------ FIN ----------------------->|
       |                                               |
       |                                          App calls NET_LIB.read()
       |                                               |
       |                                          [Sees FIN, sends FIN+ACK]
       |<----------------- FIN+ACK --------------------|
       |                                               |
[Pumping Loop sees FIN+ACK]                             |
       |                                               |
NET_LIB.send() returns                                  |
       |                                               |
```

## 2. Connection State Machine (Receiver's Perspective)

This diagram shows the lifecycle of a connection handle (`conn`) within the User Library, as managed by the `NET_LIB.read` function.

```
      +----------------+
      |    INVALID     | --(NET_LIB.listen)--> +----------+
      | (msg_id = -1)  |                       |  LISTEN  |
      +----------------+                       +----------+
             ^                                      |
             | (recv FIN)                           | (recv SYN)
             |                                      v
             +-------------------------------- +-------------+
                                              | ESTABLISHED |
                                              | (msg_id=N)  |
                                              +-------------+
```

*   **INVALID:** The initial state of a connection handle. It is not listening for any specific session.
*   **LISTEN:** After `NET_LIB.listen` is called, the handle is ready to accept a new connection.
*   **ESTABLISHED:** A `SYN` packet has been received, and the `active_msg_id` is now set. The handle will now process `DATA` packets for this session.
*   **Return to INVALID:** When a `FIN` packet is received and processed, the session is closed, and the `active_msg_id` is invalidated, returning the handle to a state where it can be used for a new `LISTEN` operation.