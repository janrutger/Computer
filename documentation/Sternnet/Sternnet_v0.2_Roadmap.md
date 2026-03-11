# Sternnet v0.2 Development Roadmap

This document outlines the plan for moving Sternnet from v0.1 (Beta) to v0.2.
The focus is on enabling robust two-way communication, improving memory safety, and enhancing developer ergonomics.

## 1. Core Infrastructure (Critical)

### Task 0: Formalize Buffer Management
*   **Goal:** Replace direct kernel calls with secure syscalls for returning RX buffers to the kernel pool.
*   **New Syscall:** `SYS_NET_FREE (64)`
*   **Kernel Driver:** Implement `NET.free_buffer` handler to accept a buffer pointer and push it back to `net_packet_pool`.
*   **User Lib:** Update `NET.free_buffer` to use this syscall.

### Feature 1: User-Space Packet Retrieval
*   **Goal:** Allow applications to retrieve full packet objects (metadata + payload) from the network stack.
*   **Internal Function:** `_recv_packet ( -- packet_ptr | 0 )`
    *   This is a low-level internal helper. It polls the kernel via `SYS_NET_RECV` and returns a pointer to a raw kernel-managed buffer.
*   **Design Note (Managed Buffer):** To simplify the API for application developers, we will use a "Managed Buffer" approach. The library will contain a dedicated, temporary receive buffer. High-level receive functions will copy the packet data into this buffer and automatically free the underlying kernel buffer.
    *   **Benefit:** The application programmer does not need to manage memory or call `NET.free_buffer`.
    *   **Constraint 1 (Non-Reentrant):** Functions using this buffer (e.g., `SOCKET.recv_text`) are not re-entrant and **MUST NOT** be called from an Interrupt Service Routine.
    *   **Constraint 2 (Volatile Pointer):** The pointer returned by these functions is temporary and is only valid until the next call to the same function.


## 2. Developer Experience (High Priority)

### Naming Convention Note
To maintain a clear architectural distinction, all high-level, application-facing functions will be prefixed with `SOCKET.`. This creates a "socket-like" API for developers. The `NET.` prefix is reserved for direct, low-level kernel driver interactions.

### Safety Feature: Initialization Guard
*   **Goal:** Prevent system crashes caused by using the library before it is initialized.
*   **Mechanism:** The `net_lib` will maintain a private flag, `_lib_is_initialized`.
    *   It is set to `0` by default.
    *   It is set to `1` only after `SOCKET.init` successfully completes.
*   **Enforcement:** All public `SOCKET.*` functions (except `SOCKET.init`) must check this flag at the very beginning. If it is `0`, the function must print a clear error message (e.g., "Error: SOCKET.init must be called first.") and halt execution.
*   **Benefit:** Transforms a cryptic memory fault into a clear, actionable error message for the developer.

### Feature 2: Text-Based Payload Helpers (API Design)
To lower the barrier to entry, we will introduce high-level helper functions to `net_lib` for sending common data types as human-readable text. These functions will wrap the lower-level `NET.send_packet` and handle all necessary data formatting and length calculations.

#### `SOCKET.send_text` (Send Path)
*   **Stack Signature:** `( dest_addr port_id string_ptr -- success )`
*   **Description:** Sends a null-terminated string as an unreliable datagram (`SDP`). This is the primary convenience wrapper for sending text-based data.
*   **Behavior:**
    1.  **Safety Check:** Checks `_lib_is_initialized`. If `0`, prints an error and halts.
    2.  The function will iterate through the memory at `string_ptr` to calculate the payload length, stopping at the null terminator.
    3.  It will then call the internal `NET.send_packet`, providing the calculated length and automatically setting the packet type to `NET_TYPE_SDP`.
    4.  It returns `1` on success or `0` if the payload is too large for a single packet.
*   **Use Case:** Sending chat messages, text commands, or file contents.

#### `SOCKET.send_int` (Send Path)
*   **Stack Signature:** `( dest_addr port_id integer -- success )`
*   **Description:** Converts a standard integer to its text representation and sends it as an unreliable datagram.
*   **Behavior:**
    1.  **Safety Check:** Checks `_lib_is_initialized`. If `0`, prints an error and halts.
    2.  This function will use a new `itoa` utility to convert the `integer` value into a string, storing it in a **dedicated, temporary send buffer** within the library.
    3.  It will then call `SOCKET.send_text`, passing the pointer to this send buffer.
    4.  It returns the success code from the underlying `SOCKET.send_text` call.
*   **Dependencies:** This feature requires the implementation of a general-purpose `itoa` (integer-to-string) function.
    *   **Reminder:** `compiler/src` contains the Stacks system software. `STRatoi` (String to Integer) already exists in `std_string`. We must implement `STRitoa` (Integer to String) in Stacks to complete the set.
*   **Use Case:** Sending sensor readings, game scores, status codes, or other numerical data in a human-readable format.

#### `SOCKET.recv_text` (Receive Path)
*   **Stack Signature:** `( -- string_ptr | 0 )`
*   **Description:** The primary high-level function for receiving text-based data. It handles all buffer management automatically.
*   **Behavior:**
    1.  **Safety Check:** Checks `_lib_is_initialized`. If `0`, prints an error and halts.
    2.  Calls the internal `_recv_packet` to get a raw kernel buffer. If it returns 0, this function also returns 0.
    3.  Copies the payload from the kernel buffer into the library's **dedicated, temporary receive buffer**.
    4.  Calls `NET.free_buffer` on the kernel buffer immediately.
    5.  Returns a pointer to the temporary receive buffer.
*   **Use Case:** Receiving chat messages, commands, or any text-based response.

## 3. Unified Stack Configuration (Medium Priority)

### Feature 3: Two-Stage Network Initialization
*   **Goal:** Safely initialize the network stack by separating kernel resource creation from application-driven configuration, respecting the different lifecycles of the kernel and user applications.
*   **Stage 1: `NET.init` (Boot-time Container Creation)**
    *   **Context:** Called once from `bootfile.stacks` when the system starts.
    *   **Responsibility:** Performs "harmless" setup. It creates the *empty* kernel data structures (`net_port_map` dictionary, `net_packet_pool` deque) and resets the vNIC hardware to a safe, disabled state. It does **not** allocate the large packet buffers.
*   **Stage 2: `SOCKET.init` (User-driven Configuration & Activation)**
    *   **API Signature:** `( host_id rx_pool_size -- success_flag )`
*   **Behavior:**
    *   The first time it is called, it triggers the `SYS_NET_CONFIG` syscall. The kernel handler performs the memory-intensive work: populating the packet pool based on `rx_pool_size`, configuring the vNIC with the `host_id`, enabling the hardware, and returning `1` (success).
    *   Any subsequent call to `SOCKET.init` will be rejected by the kernel. The kernel will print an error message to the console (e.g., "Network already initialized.") and return `0` (failure).
*   **Arguments:**
    *   `host_id`: The desired 32-bit Host ID. If `0`, the kernel will use a default.
    *   `rx_pool_size`: The desired size of the kernel's RX packet buffers in words. If `0`, the kernel will use its default size (256 words). This flexibility is crucial for managing memory in the constrained Stern-ATX environment.
*   **Architectural Alignment:** This two-stage model is a deliberate choice to prevent the "double-init" bugs and memory exhaustion we previously encountered. It provides a clear, robust, and predictable lifecycle for the network driver.

## 4. Syscall Allocation Plan

| ID | Name | Description |
| :--- | :--- | :--- |
| 60 | SYS_NET_BIND | Bind a port to a deque |
| 61 | SYS_NET_SEND | Send a packet |
| 62 | SYS_NET_RECV | Poll for received packets |
| 63 | SYS_NET_GET_ADDR | Get local MAC/IP address |
| 64 | SYS_NET_FREE | **(NEW)** Return RX buffer to pool |
| 65 | SYS_NET_CONFIG | **(NEW)** Configure stack (Host ID, Pool size) |

## 5. Technical Implementation Plan

This checklist breaks down the roadmap into a detailed to-do list, including specific file and integration points.

**Test Maintenance Note:** The `net_test.stacks` program is our primary verification tool. It will require specific updates at certain steps to remain functional as we refactor the underlying system. These required updates are noted below.

**Implementation Strategy Note:** To ensure stability and ease of debugging, it is critical to implement and verify these tasks **step-by-step**. Do not attempt to implement the entire roadmap in one go. Complete one task, verify it (using the debugger or test prints), and only then move to the next.

- **Phase 1: Core Infrastructure & Memory Management**
  *This phase establishes the foundational safety and memory management required for all subsequent features.*
  - [ ] **Implement `NET.init` (Boot-time Stage 1)**
    - **File:** `net_driver.stacks`
    - **Task:** Update `NET.init` to perform lightweight container creation.
    - **Logic:**
      - Define global `VALUE _net_is_configured 0`.
      - In `NET.init`: Create the *empty* `net_port_map` (DICT) and `net_packet_pool` (DEQUE) containers. Reset vNIC hardware.
      - **Design Note:** Creating empty containers is a low-cost operation. The memory-intensive work of allocating and adding the actual packet buffers to the pool is deferred to `SYS_NET_CONFIG`.
  - [ ] **Implement `SYS_NET_CONFIG` Syscall (Stage 2)**
    - **Task 1.1 (Handler):** In `net_driver.stacks`, create the `_net_config_handler` function.
      - **Logic:** Check `_net_is_configured`. If 1, print error and return `0`. Otherwise, set flag to 1, perform "heavy" initialization (populating packet pool, configuring hardware), and return `1`.
    - **Task 1.2 (Integration):** In `syscalls.stacks`, update the syscall dispatch table to route ID `65` to the `_net_config_handler` function.
  - [ ] **Implement `SYS_NET_FREE` Syscall (ID 64)**
    - **Task 2.1 (Handler):** In `net_driver.stacks`, create the kernel-side handler function (e.g., `_net_free_handler`).
      - **Logic:** Accept a `buffer_ptr` from the stack and add it back to the kernel's `net_packet_pool`.
    - **Task 2.2 (Integration):** In `syscalls.stacks`, update the syscall dispatch table to route ID `64` to the `_net_free_handler` function.
    - **Test Update:** Update `net_test.stacks` to use `SYS_NET_FREE` (via `int`) instead of the deprecated `NET.free_buffer` direct call.
  - [ ] **Implement `SOCKET.init` (User-space)**
    - **File:** `net_lib.stacks`
    - **Task:** Implement `SOCKET.init` in `net_lib.stacks`.
    - **Logic:** Call the configuration syscall. On success, allocate internal buffers and set the `_lib_is_initialized` flag.
    - **Test Update:** Update `net_test.stacks` to call `0 0 SOCKET.init` instead of the deprecated `NET_LIB.init`.

- **Phase 2: Developer Experience & API Implementation**
  *This phase builds the high-level, easy-to-use functions that application developers will interact with.*
  - [ ] **Implement `STRitoa` Utility**
    - **File:** `std_string.stacks`
    - **Task:** Create a new, general-purpose `itoa` (integer-to-string) function.
    - **Signature:** `( integer buffer_ptr buffer_size -- success_flag )`
    - **Design Note:** This signature is aligned with `STRatoi` for API consistency. It writes into a caller-provided buffer and performs bounds checking against `buffer_size` to prevent overflows. It returns `1` on success and `0` on failure (e.g., buffer too small). The `buffer_ptr` is expected to be a pointer to a `LIST` or a similar contiguous block of memory.
    - **Logic:** Implement the standard algorithm to convert an integer to a null-terminated string, ensuring not to write past the provided buffer size.
  - [ ] **Implement `SOCKET.send_text`**
    - **File:** `net_lib.stacks`
    - **Task:** Create the primary wrapper for sending string data.
    - **Dependencies:** Add `USE std_string` to the library for `STRlen`.
    - **Safety:** Check `_lib_is_initialized`. If 0, print error and HALT.
    - **Logic:**
      - Use `STRlen` to calculate payload length.
      - Perform a bounds check against max payload size.
      - Call `SYS_NET_SEND` and return success/failure.
  - [ ] **Implement `SOCKET.send_int`**
    - **File:** `net_lib.stacks`
    - **Task:** Create the convenience wrapper for sending integers.
    - **Safety:** Check `_lib_is_initialized`. If 0, print error and HALT.
    - **Logic:**
      - Call `STRitoa`, passing the integer, the internal `_send_buffer` pointer, and its size (16).
      - Call `SOCKET.send_text` with the pointer to the `_send_buffer`.
      - Return the success code from `SOCKET.send_text`.
  - [ ] **Implement `SOCKET.recv_text` (Managed Buffer)**
    - **File:** `net_lib.stacks`
    - **Task:** Implement the primary high-level function for receiving text data.
    - **Safety:** Check `_lib_is_initialized`. If 0, print error and HALT.
    - **Logic:**
      1. Call `SYS_NET_RECV` to get a raw kernel buffer pointer. Return `0` if empty.
      2. Extract payload pointer and length from the raw packet.
      3. **Safety Check:** Truncate copy length if the payload is larger than the internal `_recv_buffer`.
      4. Copy payload data into the `_recv_buffer`.
      5. **Critical:** Write a `0` (null terminator) after the copied data.
      6. Call `SYS_NET_FREE` on the original raw kernel buffer.
      7. Return a pointer to the data portion of the `_recv_buffer` (e.g., `_recv_buffer_ptr + 2`).

## 6. Affected Files List

The following files will be modified to implement Sternnet v0.2:

*   **Kernel Space:**
    *   `compiler/src/kernel_files/net_driver.stacks`: Implementation of new syscall handlers (`_net_config_handler`, `_net_free_handler`).
    *   `compiler/src/kernel_files/syscalls.stacks`: Update to the syscall dispatch table to register IDs 64 and 65.
    *   `compiler/src/boot_files/bootfile.stacks`: Ensure `NET.init` is called at boot.

*   **User Space Libraries:**
    *   `compiler/src/libs/net_lib.stacks`: Implementation of `SOCKET.*` functions and buffer management.
    *   `compiler/src/libs/std_string.stacks`: Addition of the `STRitoa` utility function.

## 7. Addendum: Detailed Initialization Architecture

This section details the architectural decision to implement a **Two-Stage Initialization** process for the network stack. This design addresses critical lifecycle management issues encountered during early implementation attempts.

### The Problem: Lifecycle Mismatch
Treating the kernel driver as a stateless service that could be fully initialized by a user application led to:
*   **Memory Exhaustion:** Repeated calls to `SOCKET.init` (e.g., restarting a test) caused the driver to re-allocate kernel structures without freeing old ones.
*   **Timeouts:** "Lazy initialization" of the packet pool inside `NET.recv` meant the pool might be empty when the first packet arrived if the timing wasn't perfect.

### The Solution: Two-Stage Initialization

We separate the **creation** of kernel resources (Boot) from their **configuration** (User Application).

#### Stage 1: `NET.init` (Boot-Time)
*   **Context:** Called once from `bootfile.stacks` during kernel startup.
*   **Responsibility:** Lightweight Container Creation.
*   **Actions:**
    1.  Creates empty kernel data structures: `net_port_map` (Dict) and `net_packet_pool` (Deque).
    2.  Sets the internal `_net_is_configured` flag to `0`.
    3.  Resets the vNIC hardware to a safe, disabled state.
*   **Impact:** Ensures valid pointers exist for the driver's internal logic from the moment the kernel runs, removing the need for complex "lazy init" checks in `NET.bind` or `NET.recv`.

#### Stage 2: `SYS_NET_CONFIG` (User-Space)
*   **Context:** Triggered by the application calling `SOCKET.init`.
*   **Responsibility:** Heavy Configuration & Activation.
*   **Actions:**
    The kernel handler for this syscall (`_net_config_handler`) is the "General Contractor" of the network stack. It performs the following sequence:
    1.  **Pop Arguments:** Retrieves `host_id` and `rx_pool_size` from the stack.
    2.  **Guard Check:** Reads the `_net_is_configured` flag.
        - If `1`, the network is already up. The handler prints an error ("Network already initialized."), pushes `0` (failure) to the stack, and returns. This is the critical step that prevents double-init memory leaks.
    3.  **Set Guard Flag:** If the check passes, the handler immediately sets `_net_is_configured` to `1`. This marks the point of no return and makes the operation more atomic.
    4.  **Perform "Heavy" Initialization:**
        - **4a. Populate Packet Pool:** It enters a loop, allocating `rx_pool_size` packet buffers from the kernel heap and adding their pointers to the `net_packet_pool` deque. This is the main memory-intensive step.
        - **4b. Configure vNIC:** It writes the `host_id` to the vNIC's `NIC_ADDR` register.
        - **4c. Enable vNIC:** It writes the `ENABLE` command to the vNIC's `NIC_CMD` register, activating the hardware. This is done last to ensure the software stack is fully ready before the first packet can arrive.
    5.  **Return Success:** The handler pushes `1` (success) to the stack, signaling to the user-space `SOCKET.init` function that the network is online.

### Summary of Benefits
*   **Robustness:** Prevents double-allocation crashes.
*   **Predictability:** The heavy memory cost is incurred only when the app requests it, and the hardware is enabled only when the software is fully ready.
*   **Simplicity:** Removes fragile "lazy init" logic from the hot paths of the driver.