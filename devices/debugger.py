import json

class Debugger:
    def __init__(self, cpu, memory):
        self.cpu = cpu
        self.memory = memory
        self.breakpoints = set()
        self.in_debug_mode = False
        self.last_inspected_address = None
        self.symbols_to_address = {}
        self.address_to_symbols = {}
        self.load_symbols()
        # Pass the address_to_symbols to the CPU
        self.cpu.set_address_to_symbols(self.address_to_symbols)

    def load_symbols(self):
        try:
            with open('bin/symbols.json', 'r') as f:
                symbols_data = json.load(f)
                # Load symbols
                if 'symbols' in symbols_data:
                    self.symbols_to_address.update(symbols_data['symbols'])
                # Load labels
                if 'labels' in symbols_data:
                    for label_dict in symbols_data['labels']:
                        self.symbols_to_address.update(label_dict)

                self.address_to_symbols = {v: k for k, v in self.symbols_to_address.items()}
                print("Symbols and labels loaded successfully.")
        except FileNotFoundError:
            print("Warning: 'bin/symbols.json' not found. No symbols will be available.")
        except json.JSONDecodeError:
            print("Warning: Could not decode 'bin/symbols.json'. No symbols will be available.")

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
        print(f"  0     - 8192  : OS/Loader")
        print(f"  8192  - 9216  : Interrupt/SYSCALL Vectors")
        print(f"  9216  - 17407 : Program & Free Memory")
        print(f"  18432 - 22528 : Data and I/O Region")
        print(f"  22528 - 24576 : Video & Stack Region")
        print("\n--- Pointers ---")
        print(f"  Program Counter (PC): {self.cpu.registers['PC']}")
        print(f"  Stack Pointer   (SP): {self.cpu.registers['SP']}")

    def _display_memory_with_symbols(self, start_addr, end_addr):
        output = []
        for addr in range(start_addr, end_addr):
            try:
                value = self.memory.read(addr)
                symbol = self.address_to_symbols.get(addr, '')
                if symbol:
                    output.append(f"[{addr:05d}]: {value:>8} ({symbol})")
                else:
                    output.append(f"[{addr:05d}]: {value:>8}")
            except IndexError:
                output.append(f"[{addr:05d}]: <out of bounds>")
        print("\n".join(output))

    def enter_debug_mode(self):
        self.in_debug_mode = True
        print("\n--- Breakpoint Hit ---")
        self.cpu.dump_state()
        self.interactive_loop()

    def interactive_loop(self):
        help_text = ('''
Available commands:
  step (s)                     - Execute one full instruction
  microstep (ms)               - Execute a single micro-code instruction (one clock tick)
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
''')
        while self.in_debug_mode:
            command = input("Debugger> ").strip().split()
            if not command:
                continue

            cmd = command[0].lower()
            #args = command_parts[1:]
            if cmd in ('s', 'step'):
                # Execute one full instruction (all its micro-steps)
                # and then show the state again.
                if self.cpu.state != "HALT":
                    print(f"\n--- current Step: {self.cpu.state}---")
                    # A full instruction cycle goes from FETCH back to FETCH.
                    # We start by ticking once.
                    self.cpu.tick()
                    # Then we keep ticking as long as we are in the EXECUTE state.
                    while self.cpu.state == "EXECUTE":
                        self.cpu.tick()
                    print(f"\n--- running....: {self.cpu.state}---")
                    self.cpu.dump_state()
                else:
                    print("CPU is halted.")

            elif cmd in ('ms', 'microstep'):
                if self.cpu.state != "HALT":
                    # print(f"\n--- Executing micro-step from state: {self.cpu.state} ---")
                    self.cpu.tick()
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
                    except ValueError:
                        symbol_name = command[1]
                        if symbol_name in self.symbols_to_address:
                            addr = self.symbols_to_address[symbol_name]
                        else:
                            print(f"Unknown symbol or invalid address: {symbol_name}")
                            continue
                    self.add_breakpoint(addr)
                else:
                    print("Usage: b <address_or_symbol>")
            elif cmd in ('rb', 'removebreakpoint'):
                if len(command) > 1:
                    try:
                        addr = int(command[1])
                    except ValueError:
                        symbol_name = command[1]
                        if symbol_name in self.symbols_to_address:
                            addr = self.symbols_to_address[symbol_name]
                        else:
                            print(f"Unknown symbol or invalid address: {symbol_name}")
                            continue
                    self.remove_breakpoint(addr)
                else:
                    print("Usage: rb <address_or_symbol>")
            elif cmd in ('i', 'inspect'):
                if len(command) > 1:
                    try:
                        addr = int(command[1])
                    except ValueError:
                        symbol_name = command[1]
                        if symbol_name in self.symbols_to_address:
                            addr = self.symbols_to_address[symbol_name]
                        else:
                            print(f"Unknown symbol or invalid address: {symbol_name}")
                            continue
                    self._display_memory_with_symbols(addr, addr + 16)
                    self.last_inspected_address = addr
                else:
                    if self.last_inspected_address is not None:
                        self._display_memory_with_symbols(self.last_inspected_address, self.last_inspected_address + 16)
                    else:
                        print("You must first inspect an address with 'i <address_or_symbol>'.")
            elif cmd in ('n', 'next'):
                if self.last_inspected_address is not None:
                    new_addr = self.last_inspected_address + 16
                    self._display_memory_with_symbols(new_addr, new_addr + 16)
                    self.last_inspected_address = new_addr
                else:
                    print("You must first inspect an address with 'i <address>'.")
            elif cmd in ('p', 'prev'):
                if self.last_inspected_address is not None:
                    new_addr = self.last_inspected_address - 16
                    if new_addr < 0:
                        new_addr = 0
                    self._display_memory_with_symbols(new_addr, new_addr + 16)
                    self.last_inspected_address = new_addr
                else:
                    print("You must first inspect an address with 'i <address>'.")
            elif cmd in ('lb', 'listbreakpoints'):
                if self.breakpoints:
                    print("Active breakpoints:")
                    for bp in sorted(list(self.breakpoints)):
                        symbol = self.address_to_symbols.get(bp, '')
                        if symbol:
                            print(f"  {bp} ({symbol})")
                        else:
                            print(f"  {bp}")
                else:
                    print("No breakpoints are set.")
            elif cmd == 'memmap':
                self.show_memory_map()
            elif cmd in ('?', 'help'):
                print(help_text)
            else:
                print(f"Unknown command: {cmd}")
                print(help_text)
