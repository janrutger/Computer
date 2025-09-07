# Stern-XT Devices

This directory contains the Python code for the simulated hardware devices of the Stern-XT computer. These devices provide the core functionality of the computer, including the CPU, memory, and peripheral I/O.

## Overview

The Stern-XT computer system is a collection of simulated hardware components that work together to create a functional computer. The main components are:

*   **CPU:** The central processing unit, which executes instructions from memory.
*   **Memory:** The main memory of the computer, which stores the program and data.
*   **Interrupt Controller:** Manages interrupts from peripheral devices.
*   **Keyboard:** A keyboard device that allows user input.
*   **SIO (Serial I/O):** A serial input/output device for communication.
*   **Debugger:** A debugger that allows you to inspect and control the state of the CPU and memory.
*   **Virtual Disk:** A virtual disk drive that allows you to store and retrieve data from a file on the host system.

These devices are all implemented as Python classes and are instantiated and managed by the main `stern-XT.py` script.

## CPU

The `cpu.py` file contains the implementation of the Stern-XT CPU. The CPU is a micro-coded CPU that executes instructions from a JSON ROM file. The CPU has the following features:

*   10 general-purpose registers (R0-R9)
*   A program counter (PC), stack pointer (SP), and memory instruction register (MIR)
*   Zero, Negative, Equal, and Status flags
*   A micro-code executer that loads and executes micro-code from a ROM file

The CPU operates on a standard Fetch-Decode-Execute cycle. It fetches an instruction from memory, decodes it, and then executes the corresponding micro-code routine.

For more information on the CPU, see the `cpu.md` file.

## Memory

The `memory.py` file contains the implementation of the Stern-XT memory. The memory is a 16KB address space that is used to store the program, data, and I/O devices. The memory map is as follows:

| Address Range (Decimal) | Description |
| --- | --- |
| 0 - 1023 | Loader |
| 1024 - 3071 | Kernel |
| 3072 - 4095 | Interrupt / SYSCALL Vectors |
| 4096 - 12287 | Program & Free Memory |
| 12288 - 14335 | Data and I/O Region |
| 14336 - 16383 | Video & Stack Region |

## Interrupt Controller

The `interrupt_controller.py` file contains the implementation of the interrupt controller. The interrupt controller is responsible for managing interrupts from peripheral devices and communicating them to the CPU. The interrupt controller has the following features:

*   A queue for pending interrupts
*   A mechanism for enabling and disabling interrupts
*   A way to acknowledge interrupts

For more information on the interrupt controller, see the `interrupt_controller.md` file.

## Keyboard

The `keyboard.py` file contains the implementation of the keyboard device. The keyboard device is a simple device that captures key presses from the Pygame window and sends interrupts to the CPU.

## SIO

The `sio.py` file contains a placeholder for a serial I/O device. This device is not yet implemented.

## Debugger

The `debugger.py` file contains the implementation of the debugger. The debugger is a command-line tool that allows you to inspect and control the state of the CPU and memory. The debugger has the following commands:

| Command | Alias | Description |
| --- | --- | --- |
| `step` | `s` | Execute one full instruction |
| `continue` | `c` | Continue execution to the next breakpoint |
| `quit` | `q` | Quit the simulation |
| `breakpoint <addr>` | `b` | Set a breakpoint at `<addr>` |
| `removebreakpoint <addr>` | `rb` | Remove a breakpoint from `<addr>` |
| `listbreakpoints` | `lb` | List all active breakpoints |
| `inspect [addr]` | `i` | Inspect 16 bytes of memory at `[addr]` or the last address |
| `next` | `n` | Inspect the next 16 bytes of memory |
| `prev` | `p` | Inspect the previous 16 bytes of memory |
| `memmap` | | Show the memory map and pointers |
| `help` | `?` | Show the help message |

For more information on the debugger, see the `debugger.md` file.

## Virtual Disk

The `VirtualDisk.py` file contains the implementation of the virtual disk. The virtual disk is a device that allows you to store and retrieve data from a file on the host system. The virtual disk has the following features:

*   The ability to create, open, and close virtual disks
*   The ability to read and write data to the virtual disk
*   A command-line interface for managing virtual disks

For more information on the virtual disk, see the `VirtualDisk-MANUAL.md` file.
