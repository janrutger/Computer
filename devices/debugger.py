class Debugger:
    def __init__(self, cpu, memory):
        self.cpu = cpu
        self.memory = memory
        self.breakpoints = set()
        self.in_debug_mode = False
        self.last_inspected_address = None

    def add_breakpoint(self, addr):
        self.breakpoints.add(addr)
        print(f"Breakpoint added at address {addr}")

    def remove_breakpoint(self, addr):
        if addr in self.breakpoints:
            self.breakpoints.remove(addr)
            print(f"Breakpoint removed from address {addr}")
        else:
            print(f"No breakpoint found at address {addr}")

    def show_memory_map(self):
        print("--- Memory Map & Pointers ---")
        print(f"  0     - 1023  : Loader")
        print(f"  1024  - 3071  : Kernel")
        print(f"  3072  - 4095  : Interrupt/SYSCALL Vectors")
        print(f"  4096  - 12287 : Program & Free Memory")
        print(f"  12288 - 14335 : Data and I/O Region")
        print(f"  14336 - 16383 : Video & Stack Region")
        print("\n--- Pointers ---")
        print(f"  Program Counter (PC): {self.cpu.registers['PC']}")
        print(f"  Stack Pointer   (SP): {self.cpu.registers['SP']}")

    def enter_debug_mode(self):
        self.in_debug_mode = True
        print("\n--- Breakpoint Hit ---")
        self.cpu.dump_state()
        self.interactive_loop()

    def interactive_loop(self):
        help_text = ("""
Available commands:
  step (s)                     - Execute one full instruction
  continue (c)                 - Continue execution to the next breakpoint
  quit (q)                     - Quit the simulation
  breakpoint (b) <addr>        - Set a breakpoint at <addr>
  removebreakpoint (rb) <addr> - Remove a breakpoint from <addr>
  listbreakpoints (lb)         - List all active breakpoints
  inspect (i) [addr]           - Inspect 16 bytes of memory at [addr] or last address
  next (n)                     - Inspect the next 16 bytes of memory
  prev (p)                     - Inspect the previous 16 bytes of memory
  memmap                       - Show the memory map and pointers
  help (?)                     - Show this help message
""")
        while self.in_debug_mode:
            command = input("Debugger> ").strip().lower().split()
            if not command:
                continue

            cmd = command[0]
            if cmd in ('s', 'step'):
                # Execute one full instruction (all its micro-steps)
                # and then show the state again.
                if self.cpu.state != "HALT":
                    # A full instruction cycle goes from FETCH back to FETCH.
                    # We start by ticking once.
                    self.cpu.tick()
                    # Then we keep ticking as long as we are in the EXECUTE state.
                    while self.cpu.state == "EXECUTE":
                        self.cpu.tick()
                    print("\n--- After Step ---")
                    self.cpu.dump_state()
                else:
                    print("CPU is halted.")

            elif cmd in ('c', 'continue'):
                self.in_debug_mode = False
                # We need to tell the CPU thread to continue, not just exit the loop
                # This is handled by the `in_debug_mode` flag
            elif cmd in ('q', 'quit'):
                self.cpu.state = "HALT"
                self.in_debug_mode = False
            elif cmd in ('b', 'breakpoint'):
                if len(command) > 1:
                    try:
                        addr = int(command[1])
                        self.add_breakpoint(addr)
                    except ValueError:
                        print("Invalid address for breakpoint.")
                else:
                    print("Usage: b <address>")
            elif cmd in ('rb', 'removebreakpoint'):
                if len(command) > 1:
                    try:
                        addr = int(command[1])
                        self.remove_breakpoint(addr)
                    except ValueError:
                        print("Invalid address for breakpoint.")
                else:
                    print("Usage: rb <address>")
            elif cmd in ('i', 'inspect'):
                if len(command) > 1:
                    try:
                        addr = int(command[1])
                        print(self.memory.dump(addr, addr + 16))
                        self.last_inspected_address = addr
                    except ValueError:
                        print("Invalid address for inspection.")
                else:
                    if self.last_inspected_address is not None:
                        print(self.memory.dump(self.last_inspected_address, self.last_inspected_address + 16))
                    else:
                        print("You must first inspect an address with 'i <address>'.")
            elif cmd in ('n', 'next'):
                if self.last_inspected_address is not None:
                    new_addr = self.last_inspected_address + 16
                    print(self.memory.dump(new_addr, new_addr + 16))
                    self.last_inspected_address = new_addr
                else:
                    print("You must first inspect an address with 'i <address>'.")
            elif cmd in ('p', 'prev'):
                if self.last_inspected_address is not None:
                    new_addr = self.last_inspected_address - 16
                    if new_addr < 0:
                        new_addr = 0
                    print(self.memory.dump(new_addr, new_addr + 16))
                    self.last_inspected_address = new_addr
                else:
                    print("You must first inspect an address with 'i <address>'.")
            elif cmd in ('lb', 'listbreakpoints'):
                if self.breakpoints:
                    print("Active breakpoints at addresses:", sorted(list(self.breakpoints)))
                else:
                    print("No breakpoints are set.")
            elif cmd == 'memmap':
                self.show_memory_map()
            elif cmd in ('?', 'help'):
                print(help_text)
            else:
                print(f"Unknown command: {cmd}")
                print(help_text)
