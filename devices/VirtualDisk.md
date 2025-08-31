# Virtual Disk API Documentation

This document provides the necessary information for a developer to write a driver for the Virtual Disk, which is implemented in the `VirtualDisk.py` file.

## Overview

The Virtual Disk simulates a disk drive that interacts with the host system through a section of the main memory. It maps its control registers to specific memory addresses, allowing the host CPU to issue commands and read the disk's status. The disk operates on files stored in a real directory on the host machine, but the driver only needs to interact with the memory-mapped I/O interface.

## Memory-Mapped Registers

The virtual disk uses a set of memory-mapped registers for communication with the host. The base address of these registers is provided when the `VirtualDisk` class is instantiated. All registers are offsets from this base address.

| Register Offset | Name                          | Description                                                                                                                              |
| --------------- | ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| +0              | `status_register`             | **(Read/Write for host)** Reports the current status of the disk. The host driver reads this register to check for command completion or errors, and writes to it to acknowledge success and prepare for the next command. |
| +1              | `command_register`            | **(Write-only for host)** The host writes a command code to this register to initiate an operation.                                       |
| +2              | `hostbuffer_adres_register`   | **(Write-only for host)** The host writes the memory address of a buffer that will be used for data transfer (reading or writing blocks, or specifying a filename). |
| +3              | `filehash_register`           | **(Write-only for host)** The host writes the hash of a filename to this register to select a file for an operation.                       |
| +4              | `last_block_register`         | **(Read-only for host)** After a read operation, this register indicates whether the block just read was the last block of the file.       |

## Status Codes

These codes are read from the `status_register` and indicate the state of the virtual disk.

| Code | Name           | Description                                                                                                                              |
| ---- | -------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 0    | `DISK_IDLE`    | The disk is turned on but not yet initialized. It is waiting for an `INIT` command.                                                      |
| 1    | `DISK_READY`   | The disk is initialized and ready to accept commands.                                                                                    |
| 2    | `DISK_SUCCESS` | The previous command completed successfully. The disk sets this status. The host should read this status, set `HOST_BUSY` to process the response, and then set `DISK_READY` when it's ready for the next command. |
| 3    | `DISK_ERROR`   | A general error occurred during the last operation. The disk may need to be re-initialized.                                              |
| 4    | `FILE_ERROR`   | A file-specific error occurred (e.g., file not found, hash mismatch). The disk itself remains in a `DISK_READY` state.                    |
| 5    | `HOST_BUSY`    | The host is currently processing a response from the disk. The disk will wait in this state until the host sets the status back to `DISK_READY`. |

## Command Codes

These codes are written to the `command_register` by the host driver to initiate disk operations.

| Code | Name              | Description                                                                                                                              |
| ---- | ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 0    | `CMD_INIT`        | Initializes the disk, building the file map and preparing it for operations. This command should be sent when the disk is in the `DISK_IDLE` state, or to re-initialize the disk. |
| 1    | `CMD_OPEN_READ`   | Opens an existing file for reading.                                                                                                      |
| 2    | `CMD_OPEN_WRITE`  | Opens an existing file for writing. The file's previous content will be overwritten when the file is closed.                               |
| 3    | `CMD_CREATE_FILE` | Creates a new file.                                                                                                                      |
| 4    | `CMD_READ_BLOCK`  | Reads a block of data from an open file into the host's memory buffer.                                                                   |
| 5    | `CMD_WRITE_BLOCK` | Writes a block of data from the host's memory buffer to an open file.                                                                    |
| 6    | `CMD_CLOSE`       | Closes an open file. If the file was opened for writing and has been modified, its content is written to the disk.                       |

## Command Execution Flow

### 1. Initialization

1.  **Host:** Write `CMD_INIT` (0) to the `command_register`.
2.  **Disk:** The disk initializes itself, scans the real directory for `.txt` files, and builds an internal map of file hashes. When complete, it sets the `status_register` to `DISK_SUCCESS` (2).
3.  **Host:**
    *   Poll the `status_register` until it is `DISK_SUCCESS` or `DISK_ERROR`.
    *   If the status is `DISK_SUCCESS` or `DISK_ERROR`, the host should then set the `status_register` to `HOST_BUSY` (5) to process the response. The host will remain in `HOST_BUSY` state until it is ready to issue a new command, at which point it will set the `status_register` to `DISK_READY` (1) *before* sending the command.

### 2. Opening a File (Read or Write)

1.  **Host:**
    *   Calculate the hash of the filename (e.g., "myfile").
    *   Write the hash to the `filehash_register`.
    *   Write the desired command (`CMD_OPEN_READ` or `CMD_OPEN_WRITE`) to the `command_register`.
2.  **Disk:**
    *   It looks for the file hash in its file map.
    *   If found, it opens the file internally and sets the `status_register` to `DISK_SUCCESS` (2).
    *   If not found, it sets the `status_register` to `FILE_ERROR` (4).
3.  **Host:**
    *   Poll the `status_register` until it is `DISK_SUCCESS` or `FILE_ERROR`.
    *   If the status is `DISK_SUCCESS` or `FILE_ERROR`, the host should then set the `status_register` to `HOST_BUSY` (5) to process the response. The host will remain in `HOST_BUSY` state until it is ready to issue a new command, at which point it will set the `status_register` to `DISK_READY` (1) *before* sending the command.

### 3. Creating a File

1.  **Host:**
    *   Write the filename (max 12 characters, null-terminated) to a buffer in memory.
    *   Write the starting address of this buffer to the `hostbuffer_adres_register`.
    *   Calculate the hash of the filename and write it to the `filehash_register`.
    *   Write `CMD_CREATE_FILE` (3) to the `command_register`.
2.  **Disk:**
    *   It reads the filename from the host buffer, calculates the hash, and verifies it against the hash in the `filehash_register`. 
    *   If the hashes match and the file does not already exist, it creates the file and opens it for writing. It then sets the `status_register` to `DISK_SUCCESS` (2).
    *   If the hash is incorrect or the file already exists, it sets the `status_register` to `FILE_ERROR` (4).
3.  **Host:**
    *   Poll the `status_register` until it is `DISK_SUCCESS` or `FILE_ERROR`.
    *   If the status is `DISK_SUCCESS` or `FILE_ERROR`, the host should then set the `status_register` to `HOST_BUSY` (5) to process the response. The host will remain in `HOST_BUSY` state until it is ready to issue a new command, at which point it will set the `status_register` to `DISK_READY` (1) *before* sending the command.


### 4. Reading a Block

This operation assumes a file is already open for reading.

1.  **Host:**
    *   Write the memory address of the host-side buffer (where the data should be placed) to the `hostbuffer_adres_register`. 
    *   Ensure the correct file hash is still in the `filehash_register`.
    *   Write `CMD_READ_BLOCK` (4) to the `command_register`.
2.  **Disk:**
    *   It reads a block of data (of `bufferSize`, typically 12 bytes) from the currently open file and writes it to the host's memory buffer.
    *   It updates the `last_block_register`. If this is the final block of the file, it writes `LAST_BLOCK` (1); otherwise, it writes `PENDING_BLOCK` (0).
    *   It sets the `status_register` to `DISK_SUCCESS` (2).
3.  **Host:**
    *   Poll the `status_register` until it is `DISK_SUCCESS` or `FILE_ERROR`.
    *   If the status is `DISK_SUCCESS` or `FILE_ERROR`, the host should then set the `status_register` to `HOST_BUSY` (5) to process the response. The host will remain in `HOST_BUSY` state until it is ready to issue a new command, at which point it will set the `status_register` to `DISK_READY` (1) *before* sending the command.


### 5. Writing a Block

This operation assumes a file is already open for writing.

1.  **Host:**
    *   Place the data to be written into a buffer in memory.
    *   Write the address of this buffer to the `hostbuffer_adres_register`.
    *   Ensure the correct file hash is still in the `filehash_register`.
    *   Write `CMD_WRITE_BLOCK` (5) to the `command_register`.
2.  **Disk:**
    *   It reads the block of data from the host's buffer and appends it to its internal file buffer.
    *   It marks the file as "dirty" and sets the `status_register` to `DISK_SUCCESS` (2).
3.  **Host:**
    *   Poll the `status_register` until it is `DISK_SUCCESS` or `FILE_ERROR`.
    *   If the status is `DISK_SUCCESS` or `FILE_ERROR`, the host should then set the `status_register` to `HOST_BUSY` (5) to process the response. The host will remain in `HOST_BUSY` state until it is ready to issue a new command, at which point it will set the `status_register` to `DISK_READY` (1) *before* sending the command.


### 6. Closing a File

1.  **Host:**
    *   Ensure the hash of the file to be closed is in the `filehash_register`.
    *   Write `CMD_CLOSE` (6) to the `command_register`.
2.  **Disk:**
    *   If the file was opened for writing and is "dirty", the disk writes its internal buffer to the actual file on the host's filesystem.
    *   It removes the file from its list of open files.
    *   It sets the `status_register` to `DISK_SUCCESS` (2).
3.  **Host:**
    *   Poll the `status_register` until it is `DISK_SUCCESS` or `FILE_ERROR`.
    *   If the status is `DISK_SUCCESS` or `FILE_ERROR`, the host should then set the `status_register` to `HOST_BUSY` (5) to process the response. The host will remain in `HOST_BUSY` state until it is ready to issue a new command, at which point it will set the `status_register` to `DISK_READY` (1) *before* sending the command.


## Filename Hashing

The disk uses a simple and fast hashing algorithm to identify files. The driver must use the exact same algorithm to generate the hashes that are written to the `filehash_register`. This hashing is performed by the internal `_myhash` function within the `VirtualDisk` class.

The algorithm is as follows:

```
MODULUS = 10**12

function hash(string):
    hash_value = 0
    for each character in string:
        hash_value = (hash_value * 31 + ASCII_value(character)) % MODULUS
    return hash_value
```

**Note:** The filename used for hashing should **not** include the `.txt` extension. For example, for the file `program.txt`, the string to be hashed is `"program"`.
