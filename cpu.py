from memory import Memory 
import json

class CPU:
    def __init__(self, memory: Memory, rom_path="bin/stern_rom.json"):
        self.memory = memory
        self.microcode_rom = {}
        self.instruction_formats = {}
        self._load_microcode_from_json(rom_path)

        # General Purpose Registers (R0-R9)
        self.registers = {str(i): 0 for i in range(10)}

        # Special Registers
        self.registers["PC"] = 0                       # Program Counter
        self.registers["SP"] = self.memory.size - 1    # Stack Pointer, starts at the top of memory

        self.MIR = "0"  # Memory Instruction Register

        # Flags
        self.flags = {"Z": False, "N": False, "E": False, "S": False}

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
            if self.state == "FETCH":
                #print("Fetching instruction")
                self.MIR = self.memory.read(self.registers["PC"])
                self.registers["PC"] += 1
                print(f"Fetched instruction: {self.MIR}")
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
                    print(f"    Executing cycle: {microcode_step[0]} {microcode_step[1:]}")
                    self.execute_microcode_step(microcode_step, self.operand1, self.operand2)
                else:
                    self.state = "FETCH"

        else:
            print("CPU is halted.")




    def execute_microcode_step(self, microcode_step, operand1, operand2):
        if microcode_step[0] == "set_cpu_state":
            self.state = microcode_step[1]

        elif microcode_step[0] == "set_status_bit":
            if microcode_step[1] == "TRUE":
                self.flags["S"] = True
            else:
                self.flags["S"] = False


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
                self.registers["Ra"] /= self.registers["Rb"]
            elif op == "DEC":
                self.registers["Ra"] -= 1
            elif op == "INC":
                self.registers["Ra"] += 1
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
        for i in range(5):
            print(f"    R{i}: {self.registers[str(i)]:<5} R{i+5}: {self.registers[str(i+5)]}")
        print(f"  Internal Registers: Ra={self.registers['Ra']} Rb={self.registers['Rb']}")