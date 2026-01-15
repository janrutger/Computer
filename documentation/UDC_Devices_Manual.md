# Universal Device Controller (UDC) Manual

## 1. Introduction

The Universal Device Controller (UDC) is a standardized interface for connecting peripheral devices to the Stern-ATX computer. It abstracts the complexity of different hardware by providing a uniform channel-based communication protocol. This allows the CPU to interact with diverse devices like plotters, sensors, and screens using a common set of memory-mapped registers and commands.

## 2. Architecture

The UDC acts as a bridge between the CPU and up to 8 peripheral devices.

*   **Channels**: The UDC supports 8 independent channels (0-7). Each channel can host one device.
*   **Memory Mapping**: The CPU communicates with the UDC via a block of registers mapped into the system's I/O memory space (starting at `MEM_UDC_I0_BASE`).
*   **Handshake Protocol**: A robust status/command handshake ensures reliable data transfer and synchronization between the fast CPU and potentially slower peripherals.
*   **Buffering**: The UDC maintains internal send and receive queues for each channel to decouple CPU execution from device processing.

## 3. Memory-Mapped Registers

The UDC interface consists of a control block followed by device type registers.

| Register | Offset | R/W | Description |
| :--- | :--- | :--- | :--- |
| **Channel** | `+0` | R/W | Selects the active channel (0-7) for subsequent operations. |
| **Status** | `+1` | R/W | Indicates the current state of the UDC or the selected device. |
| **Command** | `+2` | R/W | The instruction code to be sent to the device. |
| **Data** | `+3` | R/W | The data payload (argument) for the command, or data received from the device. |
| **DevType 0** | `+4` | R | Device Type ID for Channel 0. |
| **...** | ... | ... | ... |
| **DevType 7** | `+11` | R | Device Type ID for Channel 7. |

## 4. Communication Protocol

The UDC uses a state machine to manage communication. The `Status` register reflects the current state.

### 4.1 Status Codes

| Status | Value | Description |
| :--- | :--- | :--- |
| `UDC_WAITING` | 0 | The UDC is idle and ready to accept a new command from the CPU. |
| `UDC_CPU_WAITING` | 1 | The CPU has written a command and data, and is waiting for the UDC to acknowledge. |
| `UDC_UDC_WAITING` | 2 | The UDC has accepted a command that requires a response (e.g., `GET`) and is waiting for the device to provide data. |
| `UDC_ERROR_UDC` | 3 | An internal UDC error occurred (e.g., invalid channel). |
| `UDC_ERROR_DEVICE` | 4 | The device reported an error. The error code is available in the `Data` register. |

### 4.2 Sending a Command (CPU -> Device)

1.  **Select Channel**: Write the target channel index to the `Channel` register.
2.  **Check Idle**: Read `Status`. Wait until it is `UDC_WAITING`.
3.  **Write Data**: Write the argument for the command to the `Data` register.
4.  **Write Command**: Write the command opcode to the `Command` register.
5.  **Signal UDC**: Write `UDC_CPU_WAITING` to the `Status` register.
6.  **Wait for Ack**: Poll `Status` until it returns to `UDC_WAITING` (success) or `UDC_ERROR_DEVICE` (failure).

### 4.3 Receiving Data (Device -> CPU)

For commands that return data (like `GET`):

1.  **Send Command**: Follow steps 1-5 above.
2.  **Wait for Data**: The `Status` will transition to `UDC_UDC_WAITING` while the device fetches data.
3.  **Read Data**: Poll `Status`. When it becomes `UDC_WAITING`, the requested data is available in the `Data` register.

## 5. Generic Commands

These commands are supported by the UDC itself or are common to all devices.

| Command | Value | Description |
| :--- | :--- | :--- |
| `INIT` | 0 | Initializes the device on the selected channel. Returns the Device Type ID. |
| `ONLINE` | 1 | Activates the device. Must be called after `INIT` before sending other commands. |
| `OFFLINE` | 2 | Deactivates the device. |
| `RESET` | 3 | Resets the device to its default state. |

## 6. Device Types

| ID | Name | Description |
| :--- | :--- | :--- |
| 0 | `GENERIC` | Placeholder or unknown device. |
| 1 | `PLOTTER` | Y-Plotter for graphing data. |
| 2 | `SENSOR` | Input device for reading environmental values. |
| 3 | `SCREEN` | Virtual LCD for graphics and text. |

---

## 7. Device Reference: Y-Plotter (Type 1)

The Plotter is a graphical output device designed for visualizing data streams. It automatically increments its X-axis (time) for every Y-value received.

### 7.1 Commands

| Command | Value | Argument | Description |
| :--- | :--- | :--- | :--- |
| `NEW` | 10 | - | Clears the plot and resets the X-counter to 0. |
| `SEND` | 11 | Y-Value | Adds a point at `(current_x, Y-Value)` and increments `current_x`. |
| `GET` | 12 | - | *Not supported.* |
| `COLOR` | 13 | Color ID | Sets the line color (0-7). |
| `MODE` | 14 | Mode ID | *Reserved for future use.* |
| `DRAW` | 17 | Y-Value | Same as `SEND`. |
| `FLIP` | 18 | - | Forces a redraw of the plot window. |

### 7.2 Colors
0: Black, 1: Red, 2: Green, 3: Blue, 4: Yellow, 5: Magenta, 6: Cyan, 7: White.

---

## 8. Device Reference: Sensor (Type 2)

The Sensor is a simple input device that provides numerical readings.

### 8.1 Commands

| Command | Value | Argument | Description |
| :--- | :--- | :--- | :--- |
| `GET` | 12 | - | Returns a random integer (0-255) representing the sensor reading. |

---

## 9. Device Reference: Virtual LCD (Type 3)

The Virtual LCD is a high-resolution (640x480) graphics display. It supports pixel-level drawing and a sprite-based mode.

### 9.1 Internal State
The LCD maintains internal registers for the cursor position, color, and mode. These are set via commands, not direct memory access.

*   `X`: Current X coordinate.
*   `Y`: Current Y coordinate.
*   `Color`: Active color index.
*   `Mode`: Active display mode.

### 9.2 Modes

| Mode | Description | Coordinate System |
| :--- | :--- | :--- |
| **0** | **Pixel Mode** (Direct) | 640 x 480 pixels. Draws immediately. |
| **1** | **Sprite Mode** (Direct) | 80 x 60 blocks (8x8 pixels each). Draws immediately. |
| **2** | **Pixel Mode** (Buffered) | 640 x 480 pixels. Draws to shadow buffer. Requires `FLIP`. |
| **3** | **Sprite Mode** (Buffered) | 80 x 60 blocks. Draws to shadow buffer. Requires `FLIP`. |

### 9.3 Commands

| Command | Value | Argument | Description |
| :--- | :--- | :--- | :--- |
| `NEW` | 10 | - | Clears the screen (or shadow buffer in buffered modes) and resets X/Y to 0. |
| `COLOR` | 13 | Color ID | Sets the drawing color (0-15). Used for pixels and sprite foregrounds. |
| `MODE` | 14 | Mode ID | Sets the operating mode (0-3). |
| `X` | 15 | Value | Sets the internal X coordinate. |
| `Y` | 16 | Value | Sets the internal Y coordinate. |
| `DRAW` | 17 | Value | **Pixel Mode**: Draws a pixel at (X,Y) with color `Value`. <br> **Sprite Mode**: Draws sprite ID `Value` at block (X,Y). |
| `FLIP` | 18 | - | Copies the shadow buffer to the screen (Modes 2 & 3 only). |

### 9.4 Color Palette (16 Colors)

| ID | Color | ID | Color | ID | Color | ID | Color |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | Black | 4 | Purple | 8 | Orange | 12 | Grey |
| 1 | White | 5 | Green | 9 | Brown | 13 | Light Green |
| 2 | Red | 6 | Blue | 10 | Light Red | 14 | Light Blue |
| 3 | Cyan | 7 | Yellow | 11 | Dark Grey | 15 | Light Grey |

### 9.5 Sprites
In Sprite Mode, the `DRAW` command argument is an index into the `lcd_sprites.json` ROM. This allows drawing text characters and custom icons (like Pacman or aliens) efficiently.

---

## 10. Error Codes

If a device operation fails, the UDC returns `UDC_ERROR_DEVICE` in the Status register, and one of the following codes in the Data register:

| Code | Name | Description |
| :--- | :--- | :--- |
| 0 | `DEV_ERROR_UNKNOWN` | Non-specific error. |
| 1 | `DEV_ERROR_DEVICE` | Invalid command for this device type. |
| 2 | `DEV_ERROR_VALUE` | Invalid argument value (e.g., out of bounds). |
| 3 | `DEV_ERROR_INDEX` | Invalid channel index. |
| 4 | `DEV_ERROR_OFFLINE` | Command received while device was offline. |

## 11. Example: Using the Plotter (Assembly)

```asm
; Initialize Plotter on Channel 1
LDI A 1             ; Channel 1
STO A 18392         ; Write to Channel Register
LDI A 0             ; Command: INIT
STO A 18394         ; Write to Command Register
LDI A 1             ; Status: UDC_CPU_WAITING
STO A 18393         ; Write to Status Register
; ... wait for status 0 ...

; Bring Online
LDI A 1             ; Command: ONLINE
STO A 18394
LDI A 1             ; Status: UDC_CPU_WAITING
STO A 18393
; ... wait for status 0 ...

; Send Data Point 50
LDI A 50            ; Data: 50
STO A 18395         ; Write to Data Register
LDI A 11            ; Command: SEND
STO A 18394
LDI A 1             ; Status: UDC_CPU_WAITING
STO A 18393
; ... wait for status 0 ...
```