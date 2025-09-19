# Universal Device Controller (UDC) Developer Guide

This document provides a comprehensive guide for developers on how to use and extend the Universal Device Controller (UDC) within the Stern-XT computer system. The UDC provides a standardized way for the CPU to communicate with a variety of peripheral devices.

## 1. Architecture Overview

The UDC acts as an intermediary layer between the CPU and the hardware devices. This abstraction simplifies device communication from the CPU's perspective and provides a consistent framework for device developers.

The basic communication flow is:

**CPU <--> UDC <--> Physical Device (e.g., Plotter, Sensor)**

-   **CPU:** Interacts with the UDC by reading and writing to a specific block of memory-mapped registers.
-   **UDC:** A controller, implemented in `devices/UDC.py`, that manages communication channels, command queues, and status registers. It polls the memory-mapped registers for commands from the CPU.
-   **Device:** A Python class (e.g., `devices/plotter.py`) that inherits from the `UDCDevice` base class. It communicates with the UDC through a simple API of `get_command()` and `post_data()`.

## 2. Memory-Mapped I/O

The CPU communicates with the UDC through a set of memory-mapped registers. The default base address for these registers is **12248**.

| Address Offset | Register Name             | Description                                                                                             |
| :------------- | :------------------------ | :------------------------------------------------------------------------------------------------------ |
| +0             | `channel_register`        | (CPU -> UDC) Selects which of the 8 device channels (0-7) to communicate with.                          |
| +1             | `status_register`         | (CPU <-> UDC) Controls and reflects the state of the communication handshake.                           |
| +2             | `command_register`        | (CPU -> UDC) The command code to be executed by the device.                                             |
| +3             | `data_register`           | (CPU <-> UDC) A multi-purpose register for sending data/arguments to the device or receiving data from it. |
| +4 to +11      | `device_type_registers`   | (UDC -> CPU) An array of 8 registers, one for each channel, holding the `device_type` of the connected device. |

### Assembly Definitions

The assembly file `loader_UDC_routines.asm` provides standard definitions for these registers:

```assembly
MALLOC $udc_channel_register 12248
MALLOC $udc_status_register  12249
MALLOC $udc_command_register 12250
MALLOC $udc_data_register    12251

MALLOC $udc_device_type_0    12252
; ... up to
MALLOC $udc_device_type_7    12259
```

## 3. Communication Protocol & Handshake

Communication is stateful and managed by the `status_register`.

### Status Register Values

| Value | Constant              | Description                                                              |
| :---- | :-------------------- | :----------------------------------------------------------------------- |
| 0     | `UDC_WAITING`         | The UDC is idle and waiting for a command from the CPU.                  |
| 1     | `UDC_CPU_WAITING`     | The CPU has sent a command and is waiting for the UDC to acknowledge it. |
| 2     | `UDC_UDC_WAITING`     | The UDC is waiting for a response from the physical device.              |
| 3     | `UDC_ERROR_UDC`       | An internal error occurred in the UDC logic.                             |
| 4     | `UDC_ERROR_DEVICE`    | An error was reported by the target device.                              |

### Sending a Command (CPU -> Device)

The assembly routine `_send_udc_command` implements the standard handshake procedure.

1.  **CPU:** Writes the target `channel`, `command`, and `data` to the corresponding registers.
2.  **CPU:** Sets the `status_register` to `UDC_CPU_WAITING`. This signals the UDC to process the command.
3.  **UDC:** On its next `tick`, the UDC sees the `UDC_CPU_WAITING` status. It reads the registers, validates the command, and places the command in the appropriate channel's command queue.
4.  **UDC:**
    -   If the command expects a response from the device (e.g., `UDC_DEVICE_GET`), the UDC sets the status to `UDC_UDC_WAITING`.
    -   Otherwise, it sets the status back to `UDC_WAITING`, indicating the command was accepted.
5.  **CPU:** Polls the `status_register` in a loop until it is no longer `UDC_CPU_WAITING`. If the status becomes `UDC_WAITING`, the handshake is complete.

### Receiving Data (Device -> CPU)

1.  **Device:** When a device needs to send data back to the CPU (e.g., in response to a `GET` command), it calls `self.udc.post_data(self.channel, data)`.
2.  **UDC:** The UDC places this data in the channel's receive queue.
3.  **UDC:** If the status was `UDC_UDC_WAITING`, the UDC sees the data in the queue, writes it to the `data_register`, and sets the status to `UDC_WAITING`.
4.  **CPU:** After the wait loop (see step 5 above), the CPU can now safely read the returned value from the `data_register`.

## 4. UDC Commands

Commands are simple integer codes. They are divided into two categories: Generic and Device-Specific.

### Generic Commands

These commands are handled by the `UDCDevice` base class and are common to all devices.

| Code | Constant              | Description                                                              |
| :--- | :-------------------- | :----------------------------------------------------------------------- |
| 0    | `UDC_DEVICE_INIT`     | Initializes the device. The device responds with its `device_type`.      |
| 1    | `UDC_DEVICE_ONLINE`   | Brings an initialized device online, making it ready for commands.       |
| 2    | `UDC_DEVICE_OFFLINE`  | Takes a device offline. It will not process device-specific commands.    |
| 3    | `UDC_DEVICE_RESET`    | Resets the device to its initial, uninitialized state.                   |

### Device-Specific Commands

These commands are unique to a device's functionality. The `Plotter` device, for example, defines:

| Code | Constant             | Description                               |
| :--- | :------------------- | :---------------------------------------- |
| 10   | `UDC_DEVICE_NEW`     | Clears the plot.                          |
| 11   | `UDC_DEVICE_SEND`    | Sends a Y-value to be plotted.            |
| 12   | `UDC_DEVICE_GET`     | (Used by Sensor) Requests data.           |
| 13   | `UDC_DEVICE_COLOR`   | Sets the color of the plot.               |
| 14   | `UDC_DEVICE_MODE`    | Changes the mode of the device.           |

## 5. Device Types

Each device has a type, which the UDC uses to validate commands.

| Code | Constant  | Description                               |
| :--- | :-------- | :---------------------------------------- |
| 0    | `GENERIC` | The default type for an uninitialized device. |
| 1    | `PLOTTER` | A plotter device.                         |
| 2    | `SENSOR`  | A sensor device.                          |

When a device is initialized (`UDC_DEVICE_INIT`), it returns its type, which the UDC stores in the corresponding `device_type_register`.

## 6. Error Handling

The UDC can report errors via the `status_register`. When the status is `UDC_ERROR_DEVICE` (4), the `data_register` will contain a specific error code.

| Code | Constant             | Description                       |
| :--- | :------------------- | :-------------------------------- |
| 0    | `DEV_ERROR_UNKNOWN`  | An unspecified error occurred.    |
| 1    | `DEV_ERROR_DEVICE`   | Invalid command for this device.  |
| 2    | `DEV_ERROR_VALUE`    | Invalid data value for the command. |
| 3    | `DEV_ERROR_INDEX`    | Invalid channel index.            |
| 4    | `DEV_ERROR_OFFLINE`  | Command sent to an offline device.|

## 7. Developing a New UDC Device

To create a new device:

1.  **Create a Python Class:** Inherit from `UDCDevice`.
2.  **`__init__`:** Call the parent `super().__init__(device_type, udc, channel)`.
3.  **Implement `handle_command(self, command, data)`:** This is the core of your device logic. Use a series of `if/elif` statements to process device-specific commands. If a command is not recognized, call `self.udc.post_error(self.channel, DEV_ERROR_DEVICE)`.
4.  **Implement `on_` hooks (Optional):** Override methods like `on_init`, `on_online`, `on_offline`, and `on_reset` to add custom logic when the device's state changes. For example, the `Plotter` uses `on_online` to create its display window and `on_offline` to close it.
5.  **Integrate into `stern-XT.py`:** Instantiate your new device and pass it to the main simulation loop.

### Example: `Plotter.handle_command`

```python
def handle_command(self, command, data):
    if command == UDC_DEVICE_NEW:
        self.x_buffer.clear()
        self.y_buffer.clear()
        self.x_counter = 0
        self.dirty = True
    elif command == UDC_DEVICE_SEND:
        self.y_buffer.append(data)
        self.x_buffer.append(self.x_counter)
        self.x_counter += 1
        self.dirty = True
    # ... other commands
    else:
        self.udc.post_error(self.channel, DEV_ERROR_DEVICE)
```

## 8. Using the UDC in the "Stacks" Language

The "Stacks" language provides a high-level command, `&io`, for interacting with the UDC. This command simplifies the process of sending commands to UDC devices by wrapping the low-level assembly routines.

### The `&io` Command

The `&io` command is a versatile tool for UDC communication. It takes three arguments from the stack:

1.  **Data:** The value to be sent to the device (placed in the `data_register`).
2.  **Command:** The UDC command code (placed in the `command_register`).
3.  **Channel:** The target device channel (placed in the `channel_register`).

After executing the command, `&io` pushes the value from the `data_register` back onto the stack. This is useful for commands that return data, such as `UDC_DEVICE_GET`.

### Example Usage

**Initialize and turn on a plotter on channel 1:**

```
0 0 1 &io   ; Initialize channel 1 (data=0, command=INIT, channel=1)
0 1 1 &io   ; Set channel 1 online (data=0, command=ONLINE, channel=1)
```

**Send data points to the plotter:**

```
100 11 1 &io  ; Send value 100 (command=SEND, channel=1)
150 11 1 &io  ; Send value 150
120 11 1 &io  ; Send value 120
```

**Get a value from a sensor on channel 0:**

```
0 12 0 &io  ; Get data (data=0, command=GET, channel=0)
.           ; Print the returned value from the stack
```

The `&io` command is implemented in the `rt_udc_control` routine in `kernel_runtime.asm`, which uses the `_send_udc_command` helper to perform the actual communication. This makes interacting with hardware devices from the high-level Stacks environment both simple and powerful.
