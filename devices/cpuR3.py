from devices.memoryR3 import Memory
from devices.gpuR3 import GPU_R3 as GPU
import json
import time

# --- Constants ---
MEM_INT_VECTORS_START = 8192

class CPU_R3:
    """
    The CPU R3 is a hybrid architecture.
    It uses the simple, non-pipelined Fetch-Decode-Execute cycle of the original Stern-XT CPU,
    but it is upgraded to work with the Integer-based MemoryR3 and GPU_R3 (Mode 1).
    """
    def __init__(self, memory, interrupt_controller=None, rom_path="bin/stern_rom.json", debug_mode=False):
        self.memory = memory
        self.interrupt_controller = interrupt_controller
        self.microcode_rom = {}
        self.instruction_formats = {}
        self._load_microcode_from_json(rom_path)
        self.debug_mode = debug_mode
        self.address_to_symbols = {}

        # General Purpose Registers (R0-R9) - Keys are strings for compatibility with microcode args
        self.registers = {str(i): 0 for i in range(10)}

        # Special Registers
        self.registers["PC"] = 0  # Program Counter
        self.registers["SP"] = self.memory.size - 1  # Stack Pointer
        
        # Initialize GPU in Mode 1 (Integer Mode)
        self.gpu = GPU(self.memory, mode=1)
        
        # Shadow registers for interrupts
        self.shadow_registers = self.registers.copy()
        
        self.MIR = 0  # Memory Instruction Register (Integer)

        # Flags & Shadow flags for interrupts
        self.flags = {"Z": False, "N": False, "E": False, "S": False}
        self.shadow_flags = self.flags.copy()

        self.interrupts_enabled = False  # Master Interrupt Enable Flag
        self.shadow_interrupts_enabled = False

        # Internal CPU registers for ALU operations
        self.registers["Ra"] = 0
        self.registers["Rb"] = 0

        # CPU State
        self.state = "FETCH"  # FETCH, DECODE, EXECUTE, HALT
        self.instructions_executed = 0
        self.cycles_executed = 0

        # Microcode execution
        self.current_microcode_sequence = []
        self.microcode_step_index = 0
        self.operand1 = 0
        self.operand2 = 0

    def set_address_to_symbols(self, address_to_symbols):
        self.address_to_symbols = address_to_symbols

    def _load_microcode_from_json(self, file_path):
        with open(file_path, 'r') as f:
            json_data = json.load(f)

        for opcode, data in json_data["instructions"].items():
            code_sequence = []
            for item in data["code"]:
                code_sequence.append(tuple(item["instruction"]))
            # Store opcodes as Integers for R3 architecture
            self.microcode_rom[int(opcode)] = code_sequence
            self.instruction_formats[int(opcode)] = data.get("format", "zero")

    def tick(self):
        self.cycles_executed += 1
        if self.state != "HALT":
            # --- INTERRUPT CHECK ---
            if self.state == "FETCH" and self.interrupt_controller and self.interrupts_enabled and self.interrupt_controller.has_pending():
                self._handle_interrupt()
                return

            if self.state == "FETCH":
                self.instructions_executed += 1
                # MemoryR3 returns an integer directly
                self.MIR = self.memory.read(self.registers["PC"])
                self.registers["PC"] += 1
                if self.debug_mode:
                    print(f"Fetched instruction: {self.MIR}, from address {self.registers['PC'] - 1}")
                self.state = "DECODE"

            elif self.state == "DECODE":
                # Integer-based decoding logic (Adapted from CPU_M1)
                instruction_int = self.MIR
                
                # 1. Handle Sign (Negative Immediate Flag)
                is_negative_immediate = False
                if instruction_int < 0:
                    is_negative_immediate = True
                    instruction_int = abs(instruction_int)

                # 2. Extract Opcode (First 2 digits)
                temp_val = instruction_int
                divisor = 1
                while temp_val >= 100:
                    temp_val //= 10
                    divisor *= 10
                
                opcode = temp_val
                
                # 3. Extract Operands based on Format
                rest = instruction_int % divisor
                self.operand1 = 0
                self.operand2 = 0
                
                if opcode in self.instruction_formats:
                    fmt = self.instruction_formats[opcode]
                    
                    if fmt == "one_addr":
                        self.operand1 = rest
                    elif fmt == "one_reg":
                        self.operand1 = str(rest) # Register names are strings
                    elif fmt == "two_reg_reg":
                        self.operand1 = str(rest // 10)
                        self.operand2 = str(rest % 10)
                    elif fmt == "two_reg_addr" or fmt == "two_reg_val":
                        split_factor = divisor // 10
                        if split_factor == 0: split_factor = 1 
                        self.operand1 = str(rest // split_factor)
                        self.operand2 = rest % split_factor
                        if is_negative_immediate:
                            self.operand2 = -self.operand2
                    
                    if self.debug_mode:
                        print(f"Decoded instruction: {opcode}, format: {fmt}, arg1: {self.operand1}, arg2: {self.operand2}")

                    if opcode in self.microcode_rom:
                        self.current_microcode_sequence = self.microcode_rom[opcode]
                        self.microcode_step_index = 0
                        self.state = "EXECUTE"
                    else:
                        print(f"Invalid opcode for this ROM: {opcode}")
                        self.state = "HALT"
                else:
                    print(f"Invalid opcode: {opcode}")
                    self.state = "HALT"

            elif self.state == "SLEEP":
                self.state = "FETCH"
                # time.sleep(0)         # sleep is useless in an unthreaded model

            elif self.state == "EXECUTE":
                if self.microcode_step_index < len(self.current_microcode_sequence):
                    microcode_step = self.current_microcode_sequence[self.microcode_step_index]
                    self.microcode_step_index += 1
                    if self.debug_mode:
                        print(f"    Executing cycle: {microcode_step[0]} {microcode_step[1:]}")
                    self.execute_microcode_step(microcode_step, self.operand1, self.operand2)
                else:
                    self.state = "FETCH"

        else:
            print("CPU is halted.")

    def _save_to_shadow(self):
        self.shadow_registers = self.registers.copy()
        self.shadow_flags = self.flags.copy()
        self.shadow_interrupts_enabled = self.interrupts_enabled

    def _restore_from_shadow(self):
        self.registers = self.shadow_registers.copy()
        self.flags = self.shadow_flags.copy()
        self.interrupts_enabled = self.shadow_interrupts_enabled

    def _handle_interrupt(self):
        self._save_to_shadow()
        self.interrupts_enabled = False

        vector, data = self.interrupt_controller.acknowledge()
        if vector is None and data is None:
            self.interrupts_enabled = True
            return

        self.interrupt_controller.handle_acknowledged_interrupt(vector, data)
        
        if self.debug_mode:
            print(f"CPU responding to interrupt vector {vector}")

        vector_address = MEM_INT_VECTORS_START + vector
        isr_address = int(self.memory.read(vector_address))
        if self.debug_mode:
            print(f"CPU: Found ISR address {isr_address} at vector table entry {vector_address}.")

        self.registers["PC"] = isr_address
        self.state = "FETCH"

    def execute_microcode_step(self, microcode_step, operand1, operand2):
        op = microcode_step[0]

        if op == "set_cpu_state":
            self.state = microcode_step[1]
        elif op == "set_status_bit":
            self.flags["S"] = (microcode_step[1] == "TRUE")
        elif op == "set_interrupt_flag":
            self.interrupts_enabled = (microcode_step[1] == "TRUE")
        elif op == "shadow":
            sub = microcode_step[1]
            if sub == "SAVE": self._save_to_shadow()
            elif sub == "RESTORE": self._restore_from_shadow()

        elif op == "branch":
            flag = microcode_step[1]
            offset = int(microcode_step[2])
            if flag == "A": self.microcode_step_index += offset
            elif flag == "E" and self.flags["E"]: self.microcode_step_index += offset
            elif flag == "Z" and self.flags["Z"]: self.microcode_step_index += offset
            elif flag == "N" and self.flags["N"]: self.microcode_step_index += offset
            elif flag == "S" and self.flags["S"]: self.microcode_step_index += offset

        elif op == "load_immediate":
            reg = self._resolve_arg(microcode_step[1], operand1, operand2)
            val = self._resolve_arg(microcode_step[2], operand1, operand2)
            if reg in self.registers:
                self.registers[reg] = int(val)

        elif op == "move_reg":
            Rx = self._resolve_arg(microcode_step[1], operand1, operand2)
            Ry = self._resolve_arg(microcode_step[2], operand1, operand2)
            if Rx in self.registers and Ry in self.registers:
                self.registers[Rx] = self.registers[Ry]

        elif op == "alu":
            alu_op = microcode_step[1]
            if alu_op == "ADD": self.registers["Ra"] += self.registers["Rb"]
            elif alu_op == "SUB": self.registers["Ra"] -= self.registers["Rb"]
            elif alu_op == "MUL": self.registers["Ra"] *= self.registers["Rb"]
            elif alu_op == "DIV":
                if self.registers["Rb"] != 0: self.registers["Ra"] //= self.registers["Rb"]
                else: print("CPU Runtime Error: Division by zero!"); self.state = "HALT"
            elif alu_op == "MOD":
                if self.registers["Rb"] != 0: self.registers["Ra"], self.registers["Rb"] = divmod(self.registers["Ra"], self.registers["Rb"])
                else: print("CPU Runtime Error: Division by zero!"); self.state = "HALT"
            elif alu_op == "DEC": self.registers["Ra"] -= 1
            elif alu_op == "INC": self.registers["Ra"] += 1
            elif alu_op == "AND": self.registers["Ra"] &= self.registers["Rb"]
            self._set_flags()

        elif op == "store_mem_adres":
            adres = self._resolve_arg(microcode_step[1], operand1, operand2)
            Rx = self._resolve_arg(microcode_step[2], operand1, operand2)
            self.memory.write(int(adres), self.registers[Rx])

        elif op == "store_mem_reg":
            Rx = self._resolve_arg(microcode_step[1], operand1, operand2)
            Ry = self._resolve_arg(microcode_step[2], operand1, operand2)
            self.memory.write(int(self.registers[Rx]), self.registers[Ry])

        elif op == "read_mem_adres":
            adres = self._resolve_arg(microcode_step[1], operand1, operand2)
            Rx = self._resolve_arg(microcode_step[2], operand1, operand2)
            self.registers[Rx] = int(self.memory.read(int(adres)))

        elif op == "read_mem_reg":
            Rx = self._resolve_arg(microcode_step[1], operand1, operand2)
            Ry = self._resolve_arg(microcode_step[2], operand1, operand2)
            self.registers[Ry] = int(self.memory.read(self.registers[Rx]))

        elif op == "gpu":
            Rx = self._resolve_arg(microcode_step[1], operand1, operand2)
            self.gpu.execute(self.registers[Rx])

    # Helpers
    def _resolve_arg(self, arg, operand1, operand2):
        if arg == 'arg1': return operand1
        elif arg == 'arg2': return operand2
        else: return arg

    def _set_flags(self):
        ra = self.registers["Ra"]
        self.flags["Z"] = (ra == 0)
        self.flags["N"] = (ra < 0)
        self.flags["E"] = (ra == self.registers["Rb"])

    def dump_state(self):
        print("CPU State:")
        print(f"  State: {self.state}")
        pc_symbol = self.address_to_symbols.get(self.registers['PC'], '')
        sp_symbol = self.address_to_symbols.get(self.registers['SP'], '')
        pc_str = f"{self.registers['PC']}" + (f" ({pc_symbol})" if pc_symbol else "")
        sp_str = f"{self.registers['SP']}" + (f" ({sp_symbol})" if sp_symbol else "")
        print(f"  PC: {pc_str:<20} SP: {sp_str:<20} MIR: {self.MIR}")
        print(f"  Flags: Z:{int(self.flags['Z'])} N:{int(self.flags['N'])} E:{int(self.flags['E'])} S:{int(self.flags['S'])}")
        print("  General Purpose Registers:")
        for i in range(0, 10, 2):
            print(f"    R{i}: {self.registers[str(i)]:<5} R{i+1}: {self.registers[str(i+1)]}")
        print(f"  Internal Registers: Ra={self.registers['Ra']} Rb={self.registers['Rb']}")
        print(f"  Interrupts Enabled: {self.interrupts_enabled}")