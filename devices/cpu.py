from devices.memory import Memory
import json

# --- Constants ---
MEM_INT_VECTORS_START = 3072

class CPU:
    def __init__(self, memory: Memory, interrupt_controller=None, rom_path="bin/stern_rom.json", debug_mode=False):
        self.memory = memory
        self.interrupt_controller = interrupt_controller
        self.microcode_rom = {}
        self.instruction_formats = {}
        self._load_microcode_from_json(rom_path)
        self.debug_mode = debug_mode

        # General Purpose Registers (R0-R9)
        self.registers = {str(i): 0 for i in range(10)}


        # Special Registers
        self.registers["PC"] = 0  # Program Counter
        self.registers["SP"] = self.memory.size - 1  # Stack Pointer
        # Shadow registers for interrupts
        self.shadow_registers = self.registers.copy()
        
        self.MIR = "0"  # Memory Instruction Register

        # Flags
        self.flags = {"Z": False, "N": False, "E": False, "S": False}
        # Shadow flags for interrupts
        self.shadow_flags = self.flags.copy()
        self.interrupts_enabled = False  # Master Interrupt Enable Flag

        # Internal CPU registers for ALU operations
        self.registers["Ra"] = 0
        self.registers["Rb"] = 0

        # CPU State
        self.state = "FETCH"  # FETCH, DECODE, EXECUTE, HALT

        # Microcode execution
        self.current_microcode_sequence = []
        self.microcode_step_index = 0
        self.operand1 = str(0)
        self.operand2 = str(0)


    def _load_microcode_from_json(self, file_path):
        with open(file_path, 'r') as f:
            json_data = json.load(f)

        for opcode, data in json_data["instructions"].items():
            code_sequence = []
            for item in data["code"]:
                code_sequence.append(tuple(item["instruction"]))
            self.microcode_rom[opcode] = code_sequence
            self.instruction_formats[opcode] = data.get("format", "zero") # Default to zero if format is missing

    def tick(self):
        if self.state != "HALT":
            # --- INTERRUPT CHECK ---
            if self.state == "FETCH" and self.interrupt_controller and self.interrupts_enabled and self.interrupt_controller.has_pending():
                self._handle_interrupt()
                return

            if self.state == "FETCH":
                #print("Fetching instruction")
                self.MIR = self.memory.read(self.registers["PC"])
                self.registers["PC"] += 1
                if self.debug_mode:
                    print(f"Fetched instruction: {self.MIR}, from address {self.registers['PC'] - 1}")
                self.state = "DECODE"

            elif self.state == "DECODE":
                opcode = self.MIR[:2]
                self.operand1 = str(0)
                self.operand2 = str(0)

                if opcode in self.instruction_formats:
                    format = self.instruction_formats[opcode]
                    if format == "zero":
                        pass # No operands
                    elif format == "one_addr":
                        self.operand1 = self.MIR[2:]
                    elif format == "one_reg":
                        self.operand1 = self.MIR[2]
                    elif format == "two_reg_reg":
                        self.operand1 = self.MIR[2]
                        self.operand2 = self.MIR[3]
                    elif format == "two_reg_addr" or format == "two_reg_val":
                        self.operand1 = self.MIR[2]
                        self.operand2 = self.MIR[3:]
                    else:
                        print(f"Unknown instruction format: {format}")
                        self.state = "HALT"
                    
                    if self.debug_mode:
                        print(f"Decoded instruction: {opcode}, format: {format}, arg1: {self.operand1}, arg2: {self.operand2}")

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

            elif self.state == "EXECUTE":
                #print("Executing instruction")
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

    def _restore_from_shadow(self):
        self.registers = self.shadow_registers.copy()
        self.flags = self.shadow_flags.copy()

    def _handle_interrupt(self):
        """The CPU's interrupt acknowledge sequence."""
        # 1. Disable further interrupts temporarily
        self.interrupts_enabled = False

        # 2. Acknowledge the interrupt and get its type (vector) and data
        vector, data = self.interrupt_controller.acknowledge()
        if vector is None and data is None: # Should not happen if we check has_pending(), but for safety
            self.interrupts_enabled = True
            return

        # 3. Write the interrupt data to the designated memory address
        self.interrupt_controller.handle_acknowledged_interrupt(vector, data)
        
        if self.debug_mode:
            print(f"CPU responding to interrupt vector {vector}")

        # 4. Save the current context to shadow registers
        self._save_to_shadow()

        # 5. Look up the ISR address in the Interrupt Vector Table
        vector_address = MEM_INT_VECTORS_START + vector
        isr_address = int(self.memory.read(vector_address))
        if self.debug_mode:
            print(f"CPU: Found ISR address {isr_address} at vector table entry {vector_address}.")

        # 6. Jump to the Interrupt Service Routine (ISR)
        self.registers["PC"] = isr_address

        # 7. The CPU is now ready to fetch the first instruction of the ISR
        self.state = "FETCH"

    def execute_microcode_step(self, microcode_step, operand1, operand2):
        if microcode_step[0] == "set_cpu_state":
            self.state = microcode_step[1]

        elif microcode_step[0] == "set_status_bit":
            if microcode_step[1] == "TRUE":
                self.flags["S"] = True
            else:
                self.flags["S"] = False
        
        elif microcode_step[0] == "set_interrupt_flag":
            if microcode_step[1] == "TRUE":
                self.interrupts_enabled = True
            else:
                self.interrupts_enabled = False
        
        elif microcode_step[0] == "shadow":
            op = microcode_step[1]
            if op == "SAVE":
                self._save_to_shadow()
            elif op == "RESTORE":
                self._restore_from_shadow()

        # branch(FLAG, n-lines)
        elif microcode_step[0] == "branch":
            flag = microcode_step[1]
            offset = int(microcode_step[2])
            if flag == "A":
                self.microcode_step_index += offset
            elif flag == "E" and self.flags["E"]:
                self.microcode_step_index += offset
            elif flag == "Z" and self.flags["Z"]:
                self.microcode_step_index += offset
            elif flag == "N" and self.flags["N"]:
                self.microcode_step_index += offset
            elif flag == "S" and self.flags["S"]:
                self.microcode_step_index += offset

        # load_immediate(reg, value)       eg load_immediate(9, 42)  loading 42 in register R9
        #                                 eg load_immediate(SP, 1024)
        elif microcode_step[0] == "load_immediate":
            reg = self._resolve_arg(microcode_step[1], operand1, operand2)
            val = self._resolve_arg(microcode_step[2], operand1, operand2)
            if reg in self.registers:
                self.registers[reg] = int(val)
            else:
                print(f"load_immediate: Invalid register: {reg}")

        # move_reg(Rx, Ry)        moves Ry into Rx
        #                         eg move_reg(Ra, 6) moves facing R6 into internal register Ra
        #                         eg move_reg(Rb, 7) moves facing R7 into internal register Rb
        #                         eg move_reg(6, Rb) moves internel Rb into facing R6
        elif microcode_step[0] == "move_reg":
            Rx = self._resolve_arg(microcode_step[1], operand1, operand2)
            Ry = self._resolve_arg(microcode_step[2], operand1, operand2)

            if Rx in self.registers and Ry in self.registers:
                self.registers[Rx] = self.registers[Ry]

        # alu(OP)                  Ra + Rb -> Ra (set status flags)
        elif microcode_step[0] == "alu":
            op = microcode_step[1]
            if op == "ADD":
                self.registers["Ra"] += self.registers["Rb"]
            elif op == "SUB":
                self.registers["Ra"] -= self.registers["Rb"]
            elif op == "MUL":
                self.registers["Ra"] *= self.registers["Rb"]
            elif op == "DIV":
                # Perform integer division
                if self.registers["Rb"] != 0:
                    self.registers["Ra"] //= self.registers["Rb"]
                else:
                    # Handle division by zero, e.g., set an error flag or halt
                    print("CPU Runtime Error: Division by zero!")
                    self.state = "HALT"
            elif op == "DEC":
                self.registers["Ra"] -= 1
            elif op == "INC":
                self.registers["Ra"] += 1
            elif op == "AND":
                self.registers["Ra"] &= self.registers["Rb"]
            elif op == "CMP":
                pass # CMP only sets flags
            self._set_flags()

        # store_mem_adres(adres, Rx)      Stores the value of Rx at the adres
        elif microcode_step[0] == "store_mem_adres":
            adres = self._resolve_arg(microcode_step[1], operand1, operand2)
            Rx = self._resolve_arg(microcode_step[2], operand1, operand2)
            self.memory.write(int(adres), self.registers[Rx])

        # store_mem_reg(Rx, Ry)           Stores the value of Ry at the adres in Rx
        elif microcode_step[0] == "store_mem_reg":
            Rx = self._resolve_arg(microcode_step[1], operand1, operand2)
            Ry = self._resolve_arg(microcode_step[2], operand1, operand2)
            self.memory.write(int(self.registers[Rx]), self.registers[Ry])

        # read_mem_adres(adres, Rx)     eg mem_read_adres(42, 3)
        #  Reads the memory adres 42 and place the value in R3
        elif microcode_step[0] == "read_mem_adres":
            adres = self._resolve_arg(microcode_step[1], operand1, operand2)
            Rx = self._resolve_arg(microcode_step[2], operand1, operand2)
            self.registers[Rx] = int(self.memory.read(int(adres)))

        # read_mem_reg(Rx, Ry)           eg mem_read_reg(SP, 7 )
        # Reads the memory adres in SP and place the value in R7
        elif microcode_step[0] == "read_mem_reg":
            Rx = self._resolve_arg(microcode_step[1], operand1, operand2)
            Ry = self._resolve_arg(microcode_step[2], operand1, operand2)
            self.registers[Ry] = int(self.memory.read(self.registers[Rx]))

    # end of core logic, microcode steps

    # Helpers from here
    def _resolve_arg(self, arg, operand1, operand2):
        if arg == 'arg1':
            return operand1
        elif arg == 'arg2':
            return operand2
        else:
            return arg

    def _set_flags(self):
        if self.registers["Ra"] == 0:
            self.flags["Z"] = True
        else:
            self.flags["Z"] = False

        if self.registers["Ra"] < 0:
            self.flags["N"] = True
        else:
            self.flags["N"] = False

        if self.registers["Ra"] == self.registers["Rb"]:
            self.flags["E"] = True
        else:
            self.flags["E"] = False

    def dump_state(self):
        print("CPU State:")
        print(f"  State: {self.state}")
        print(f"  PC: {self.registers['PC']:<5} SP: {self.registers['SP']:<5} MIR: {self.MIR}")
        print(f"  Flags: Z:{int(self.flags['Z'])} N:{int(self.flags['N'])} E:{int(self.flags['E'])} S:{int(self.flags['S'])}")
        print("  General Purpose Registers:")
        for i in range(0, 10, 2):
            print(f"    R{i}: {self.registers[str(i)]:<5} R{i+1}: {self.registers[str(i+1)]}")
        print(f"  Internal Registers: Ra={self.registers['Ra']} Rb={self.registers['Rb']}")
        print(f"  Interrupts Enabled: {self.interrupts_enabled}")
        