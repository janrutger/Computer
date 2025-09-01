# Virtual Disk Driver Developer's Manual

This document provides the necessary information for a developer to write a driver for the Stern-XT Virtual Disk. The Virtual Disk is a memory-mapped peripheral that simulates a file system on a disk, allowing the CPU to create, read, write, and manage files.

The disk interacts with the host system through a set of memory-mapped registers and follows a specific command-and-status handshake protocol. All file operations are performed on files with a `.txt` extension located in a real directory on the host machine, which the virtual disk exposes to the Stern-XT computer.

## 2. Memory-Mapped I/O

The Virtual Disk is controlled by a set of 5 registers mapped into the computer's memory space. The driver must be initialized with the `baseadres` of this register block.

| Register                    | Offset | Description                                                                                             |
| --------------------------- | ------ | ------------------------------------------------------------------------------------------------------- |
| `status_register`           | +0     | Read by the host to check the disk's status. Written by both host and disk to manage the communication state. |
| `command_register`          | +1     | Written by the host to issue commands to the disk.                                                      |
| `hostbuffer_adres_register` | +2     | Written by the host to provide the memory address of a data buffer for read/write/create operations.      |
| `filehash_register`         | +3     | Written by the host to specify the target file for an operation, using a special hash of the filename.    |
| `last_block_register`       | +4     | Read by the host after a `CMD_READ_BLOCK` to check if the block read was the last one in the file.        |

## 3. Status and Command Codes

### Status Codes (Read from `status_register`)

These codes inform the host about the disk's current state.

| Code           | Value | Description                                                              |
| -------------- | ----- | ------------------------------------------------------------------------ |
| `DISK_IDLE`    | 0     | Disk is on but uninitialized. It only accepts the `CMD_INIT` command.      |
| `HOST_WAITING` | 1     | The host has issued a command and is waiting for the disk to complete it.  |
| `DISK_SUCCESS` | 2     | The disk has successfully completed the last command.                    |
| `DISK_ERROR`   | 3     | A general disk error occurred. After this status is set, the disk will reset to the `DISK_IDLE` state on its next cycle and must be re-initialized with `CMD_INIT` before further use. |
| `FILE_ERROR`   | 4     | A file-specific error occurred (e.g., file not found, hash mismatch). The disk remains ready for other commands. |
| `HOST_BUSY`    | 5     | The host is busy processing the disk's response. The disk will wait.     |

### Command Codes (Written to `command_register`)

These codes are sent by the host to instruct the disk to perform an action.

| Command           | Value | Description                                                              |
| ----------------- | ----- | ------------------------------------------------------------------------ |
| `CMD_INIT`        | 0     | Initializes the disk, building its internal file map. Must be the first command. |
| `CMD_OPEN_READ`   | 1     | Opens an existing file for reading.                                      |
| `CMD_OPEN_WRITE`  | 2     | Opens an existing file for writing (overwrites content).                 |
| `CMD_CREATE_FILE` | 3     | Creates a new file.                                                      |
| `CMD_READ_BLOCK`  | 4     | Reads the next block of data from an open file.                          |
| `CMD_WRITE_BLOCK` | 5     | Writes a block of data to an open file.                                  |
| `CMD_CLOSE`       | 6     | Closes an open file, flushing any written data to the physical file.     |

## 4. Communication Protocol (The Handshake)

The interaction between the host driver and the disk follows a strict handshake protocol to ensure synchronization.

**Note on Initialisation**: The very first command sent to the disk must be `CMD_INIT` while the disk is in the `DISK_IDLE` state. For this specific initial command, the host only needs to write `CMD_INIT` to the `command_register`. The disk will automatically process it on its next cycle and change its status to `DISK_SUCCESS`. The full handshake with `HOST_WAITING` is not required for this first step. For all subsequent commands (including re-initialization with `CMD_INIT`), the full handshake described below must be used.

The standard handshake is as follows:

1.  **Host Issues Command**:
    *   The host writes the necessary parameters to the registers (e.g., `filehash_register`, `hostbuffer_adres_register`).
    *   The host writes the desired command to the `command_register`.
    *   The host writes `HOST_WAITING` to the `status_register` to signal the disk to start processing.

2.  **Disk Processes Command**:
    *   The disk's `access()` cycle detects the `HOST_WAITING` status and executes the command.
    *   Upon completion, the disk updates the `status_register` to `DISK_SUCCESS`, `DISK_ERROR`, or `FILE_ERROR`.

3.  **Host Acknowledges**:
    *   The host polls the `status_register` until the value is no longer `HOST_WAITING`.
    *   The host reads the result (`DISK_SUCCESS`, etc.) to determine the outcome.
    *   The host writes `HOST_BUSY` to the `status_register` to signal that it is now processing the results and the disk should wait.

4.  **Cycle Complete**:
    *   After the host has finished its processing (e.g., copying data from the buffer), it can begin a new cycle by issuing another command.

An example of this handshake can be found in the `check_status` function of the `SelftestVirtualDisk.py` script.

## 5. Filename Hashing

The disk identifies files not by their string name, but by a 64-bit hash of the filename. The filename to be hashed is the *base name* of the file on the physical disk, without the `.txt` extension.

The hashing algorithm is as follows:
```python
MODULUS = 10**12    # 1,000,000,000,000 (one trillion)
hash_value = 0
for char in filename_string:
    hash_value = (hash_value * 31 + ord(char)) % MODULUS
return hash_value
```
The driver must implement this exact algorithm to interact with files.

## 6. File Operations

All operations require the standard handshake protocol described above, with the exception of the initial `CMD_INIT`.

### `CMD_INIT`
*   **Purpose**: Initializes or re-initializes the disk. On initialization, it scans the physical directory for all `.txt` files. On re-initialization (e.g., after a disk change), it safely closes all open files before re-scanning.
*   **Parameters**: None.
*   **Action**:
    *   **Initial Boot**: When the disk status is `DISK_IDLE`, simply write `CMD_INIT` to the `command_register`. The disk will process this on its own and set its status to `DISK_SUCCESS`.
    *   **Re-initialization**: When the disk is already initialized and a re-init is needed, the full handshake must be performed. Write `CMD_INIT` to `command_register` and then `HOST_WAITING` to `status_register`.

### `CMD_CREATE_FILE`
*   **Purpose**: Creates a new, empty `.txt` file and opens it for writing.
*   **Parameters**:
    *   `hostbuffer_adres_register`: Address of a buffer containing the null-terminated filename (max 12 characters, without extension).
    *   `filehash_register`: The hash of the filename provided in the buffer.
*   **Action**:
    1.  Prepare the filename in a memory buffer.
    2.  Write the buffer address to `hostbuffer_adres_register`.
    3.  Calculate and write the filename hash to `filehash_register`.
    4.  Write `CMD_CREATE_FILE` to `command_register`.
    5.  Perform handshake.
*   **Result**: The file is created on the physical disk and is opened in write mode.

### `CMD_OPEN_READ` / `CMD_OPEN_WRITE`
*   **Purpose**: Opens an existing file for reading or writing.
*   **Parameters**:
    *   `filehash_register`: The hash of the file's base name.
*   **Action**:
    1.  Calculate and write the filename hash to `filehash_register`.
    2.  Write `CMD_OPEN_READ` or `CMD_OPEN_WRITE` to `command_register`.
    3.  Perform handshake.
*   **Result**: The file is now open in the specified mode. For reading, the file's content is loaded into the disk's internal buffer. For writing, the disk's internal buffer is cleared.

### `CMD_READ_BLOCK`
*   **Purpose**: Reads a chunk of data from a file previously opened with `CMD_OPEN_READ`.
*   **Parameters**:
    *   `filehash_register`: The hash of the open file.
    *   `hostbuffer_adres_register`: Address of a host buffer (at least 12 bytes) where the disk will write the data.
*   **Action**:
    1.  Write the host buffer address to `hostbuffer_adres_register`.
    2.  Ensure `filehash_register` still holds the correct hash.
    3.  Write `CMD_READ_BLOCK` to `command_register`.
    4.  Perform handshake.
*   **Result**:
    *   The disk copies up to 12 bytes from its internal buffer to the host's buffer.
    *   The `last_block_register` is updated. The host must read this register to check for end-of-file.
        *   `PENDING_BLOCK` (0): More data is available to be read.
        *   `LAST_BLOCK` (1): This was the final block of the file.

### `CMD_WRITE_BLOCK`
*   **Purpose**: Writes a chunk of data to a file previously opened with `CMD_OPEN_WRITE` or `CMD_CREATE_FILE`.
*   **Parameters**:
    *   `filehash_register`: The hash of the open file.
    *   `hostbuffer_adres_register`: Address of a host buffer containing the data to write. If the data is less than 12 bytes, it should be null-terminated.
*   **Action**:
    1.  Prepare the data in the host buffer.
    2.  Write the buffer address to `hostbuffer_adres_register`.
    3.  Ensure `filehash_register` still holds the correct hash.
    4.  Write `CMD_WRITE_BLOCK` to `command_register`.
    5.  Perform handshake.
*   **Result**: The data is appended to the disk's internal buffer for the file. The file is marked as 'dirty'.

### `CMD_CLOSE`
*   **Purpose**: Closes an open file. If the file was written to, this command flushes the changes from the internal buffer to the physical file on the host system.
*   **Parameters**:
    *   `filehash_register`: The hash of the open file to close.
*   **Action**:
    1.  Ensure `filehash_register` holds the correct hash.
    2.  Write `CMD_CLOSE` to `command_register`.
    3.  Perform handshake.
*   **Result**: The file is no longer open. Any pending writes are committed.
