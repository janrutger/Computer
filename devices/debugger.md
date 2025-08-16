# Debugger

The `Debugger` class provides a powerful, interactive command-line interface for controlling and inspecting the Stern-XT CPU and memory during simulation.

## Class: `Debugger`

### Initialization

```python
__init__(self, cpu, memory)
```

-   **`cpu`**: An instance of the CPU being debugged.
-   **`memory`**: An instance of the system's memory.

Upon initialization, the debugger sets up a set to store breakpoint addresses, initializes its debug mode state, and tracks the last memory address inspected for convenience.

### Key Methods

#### `add_breakpoint(self, addr)`

Adds a breakpoint at the specified memory address. When the CPU's Program Counter (PC) reaches this address, the simulation will pause and enter debug mode.

-   **`addr`**: The memory address where the breakpoint should be set.

#### `remove_breakpoint(self, addr)`

Removes an existing breakpoint from the specified memory address.

-   **`addr`**: The memory address from which the breakpoint should be removed.

#### `show_memory_map(self)`

Prints a detailed overview of the Stern-XT's memory map, including the defined regions (Loader, Kernel, Vectors, Program, Data/IO, Video/Stack) and the current values of the Program Counter (PC) and Stack Pointer (SP).

#### `enter_debug_mode(self)`

Activates the interactive debugger. This method is typically called when a breakpoint is hit. It prints a notification, dumps the current CPU state, and then enters the `interactive_loop` to accept user commands.

#### `interactive_loop(self)`

This is the main loop of the debugger, where it continuously prompts the user for commands and executes them. It provides a rich set of commands for stepping through code, inspecting memory, managing breakpoints, and viewing the system state.

### Debugger Commands

The following commands are available within the interactive debugger loop:

| Command                      | Alias | Description                                                     |
| :--------------------------- | :---- | :-------------------------------------------------------------- |
| `step`                       | `s`   | Execute one full instruction (all its micro-steps) and then show the CPU state. |
| `continue`                   | `c`   | Continue execution until the next breakpoint is encountered or the simulation halts. |
| `quit`                       | `q`   | Immediately halt the CPU and exit the simulation.               |
| `breakpoint <addr>`          | `b`   | Set a breakpoint at the specified memory address `<addr>`.      |
| `removebreakpoint <addr>`    | `rb`  | Remove a breakpoint from the specified memory address `<addr>`. |
| `listbreakpoints`            | `lb`  | Display a list of all currently active breakpoints.             |
| `inspect [addr]`             | `i`   | Inspect and display 16 bytes of memory starting from `[addr]`. If `[addr]` is omitted, it inspects from the last inspected address. |
| `next`                       | `n`   | Inspect the next 16 bytes of memory relative to the last inspected address. |
| `prev`                       | `p`   | Inspect the previous 16 bytes of memory relative to the last inspected address. |
| `memmap`                     |       | Show the detailed memory map and the current values of the PC and SP. |
| `help`                       | `?`   | Display this help message, listing all available commands.      |
