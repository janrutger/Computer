from collections import deque
import time
import json
# from devices.gpu import GPU
from devices.gpuR3 import GPU_R3 as GPU

# --- Constants ---
# Memory Map
MEM_SIZE = 16384

MEM_INT_VECTORS_START = 3072

class CPU_M1:
    def __init__(self, memory, interrupt_controller=None, rom_path="bin/stern_rom.json", debug_mode=False):
        self.memory = memory
        self.interrupt_controller = interrupt_controller
        self.microcode_rom = {}
        self.instruction_formats = {}
        self._load_microcode_from_json(rom_path)
        self.debug_mode = debug_mode
        self.address_to_symbols = {}

        # General Purpose Registers (R0-R9) - Keys are strings for debugger compatibility
        self.registers = {str(i): 0 for i in range(10)}

        # Special Registers
        self.registers["PC"] = 0
        self.registers["SP"] = self.memory.size - 1
        self.gpu = GPU(self.memory, mode=1)     # mode 1 for R3 memory insted of R2 memory
        
        # Shadow registers
        self.shadow_registers = self.registers.copy()
        
        self.MIR = None # M1 specific: None init
        
        # Flags
        self.flags = {"Z": False, "N": False, "E": False, "S": False}
        self.shadow_flags = self.flags.copy()

        self.interrupts_enabled = False
        self.shadow_interrupts_enabled = False

        # Internal Registers
        self.registers["Ra"] = 0
        self.registers["Rb"] = 0

        # State
        self.state = "FETCH"
        self.instructions_executed = 0
        self.cycles_executed = 0

        # Microcode
        self.current_microcode_sequence = []
        self.microcode_step_index = 0
        self.operand1 = 0 
        self.operand2 = 0
        
        # --- Pipeline Specific Structures ---
        # Buffer holds tuples: (microcode_sequence, operand1, operand2, instruction_pc)
        self.instruction_buffer = deque(maxlen=4)
        
        # Pipeline Register (Latch) between Fetch and Decode
        self.MIR_PC = 0  # Stores the address of the instruction currently in MIR
        self.MIR_NEXT_PC = 0 # Stores the predicted next PC for the instruction in MIR
        
        # Flow control
        self.fetch_stalled = False
        self.pc_was_modified = False
        
        # Pipeline Register (Latch) - Initialize to None so we don't decode garbage at startup
        self.MIR = None
        self.current_instruction_pc = 0
        self.current_predicted_pc = 0
        
        # Performance Counters for Proof of Work
        self.stats = {
            "fetched": 0,
            "predicted_correct": 0,
            "predicted_wrong": 0,
            "flushes": 0
        }
        self.ras = deque(maxlen=64) # Return Address Stack. deque handles overflow by discarding oldest.

    def set_address_to_symbols(self, address_to_symbols):
        self.address_to_symbols = address_to_symbols

    def _load_microcode_from_json(self, file_path):
        with open(file_path, 'r') as f:
            json_data = json.load(f)
        for opcode, data in json_data["instructions"].items():
            code_sequence = [tuple(item["instruction"]) for item in data["code"]]
            self.microcode_rom[opcode] = code_sequence
            self.instruction_formats[opcode] = data.get("format", "zero")

    def tick(self):
        self.cycles_executed += 1
        if self.state == "HALT":
            self._print_stats()
            return

        # --- ROBOT 1: EXECUTE (The Consumer) ---
        # Runs first to clear space in the buffer for the Decoder
        flush_needed = self._tick_execute_stage()
        if flush_needed:
            self._flush_pipeline()
            return

        # --- ROBOT 2: DECODE (The Transformer) ---
        # Runs second to process MIR and potentially unstall Fetch
        self._tick_decode_stage()

        # --- ROBOT 3: FETCH (The Producer) ---
        # Runs last to pull new data from memory
        self._tick_fetch_stage()

        if self.state == "HALT":
            self._print_stats()

    def _print_stats(self):
        print("CPU is halted.")
        print(f"--- Pipeline Stats ---")
        print(f"Instructions Fetched: {self.stats['fetched']}")
        print(f"Predictions Correct : {self.stats['predicted_correct']}")
        print(f"Predictions Wrong   : {self.stats['predicted_wrong']}")
        print(f"Pipeline Flushes    : {self.stats['flushes']}")
        if (self.stats['predicted_correct'] + self.stats['predicted_wrong']) > 0:
            acc = self.stats['predicted_correct'] / (self.stats['predicted_correct'] + self.stats['predicted_wrong']) * 100
            print(f"Prediction Accuracy : {acc:.2f}%")

    def _tick_fetch_stage(self):
        if self.fetch_stalled or self.pc_was_modified:
            return

        # 1. Capture the address BEFORE incrementing
        current_pc = self.registers["PC"]
        
        # 2. Fetch the instruction
        self.MIR = self.memory.read(current_pc)
        
        # 3. Save the address in our "Shadow MIR"
        self.MIR_PC = current_pc
        
        # 4. Determine next PC (Prediction Step)
        prediction = self._predict_next_pc(self.MIR, current_pc)
        self.registers["PC"] = prediction
        self.MIR_NEXT_PC = prediction
        self.stats["fetched"] += 1
        
        if self.debug_mode:
            print(f"[FETCH] Fetched {self.MIR} from {current_pc}")

    def _tick_decode_stage(self):
        # If the buffer is full, we must stall the Fetch robot
        if len(self.instruction_buffer) >= self.instruction_buffer.maxlen:
            self.fetch_stalled = True
            return
        
        self.fetch_stalled = False
        
        if self.MIR is None: # Can happen after a flush
            return

        # Decode logic (Integer based)
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
        operand1 = 0
        operand2 = 0
        
        opcode_str = str(opcode)

        if opcode_str in self.instruction_formats:
            fmt = self.instruction_formats[opcode_str]
            
            if fmt == "one_addr":
                operand1 = rest
            elif fmt == "one_reg":
                operand1 = str(rest)
            elif fmt == "two_reg_reg":
                operand1 = str(rest // 10)
                operand2 = str(rest % 10)
            elif fmt == "two_reg_addr" or fmt == "two_reg_val":
                split_factor = divisor // 10
                if split_factor == 0: split_factor = 1 
                operand1 = str(rest // split_factor)
                operand2 = rest % split_factor
                if is_negative_immediate:
                    operand2 = -operand2
            
            if opcode_str in self.microcode_rom:
                ucode = self.microcode_rom[opcode_str]
                # Push the bundle to the buffer, INCLUDING the saved MIR_PC
                packet = (ucode, operand1, operand2, self.MIR_PC, self.MIR_NEXT_PC)
                self.instruction_buffer.append(packet)
                self.MIR = None # Consume the instruction so we don't decode it again
                if self.debug_mode:
                    print(f"[DECODE] Decoded {opcode} (PC={self.MIR_PC})")
            else:
                print(f"Invalid opcode: {opcode}")
                self.state = "HALT"

    def _tick_execute_stage(self):
        # 1. Check for Interrupts (High Priority)
        if self.state == "FETCH" and self.interrupt_controller and self.interrupts_enabled and self.interrupt_controller.has_pending():
            self._handle_interrupt() # This modifies PC
            return True # Signal Flush

        # Handle SLEEP state (e.g. NOP)
        if self.state == "SLEEP":
            time.sleep(0)
            self.state = "FETCH"
            self.instructions_executed += 1
            self.stats["predicted_correct"] += 1
            if self.pc_was_modified:
                return True # Signal Flush
            return False

        # 2. Load new instruction if idle
        if self.state == "FETCH":
            if self.instruction_buffer:
                packet = self.instruction_buffer.popleft()
                self.current_microcode_sequence = packet[0]
                self.operand1 = packet[1]
                self.operand2 = packet[2]
                self.current_instruction_pc = packet[3] # Capture the PC of this instruction
                self.current_predicted_pc = packet[4]   # Capture what Fetch predicted
                
                self.microcode_step_index = 0
                self.state = "EXECUTE"
                self.pc_was_modified = False
            else:
                return False # Starved

        # 3. Execute Microcode
        if self.state == "EXECUTE":
            if self.microcode_step_index < len(self.current_microcode_sequence):
                step = self.current_microcode_sequence[self.microcode_step_index]
                self.microcode_step_index += 1
                
                # --- PC SWAP LOGIC START ---
                # We need to ensure that if the microcode reads PC (e.g. for CALL),
                # it sees the address of the *next* instruction (Logical PC),
                # not the current Fetch address (Global PC).
                
                real_fetch_pc = self.registers["PC"]
                logical_pc = self.current_instruction_pc + 1
                
                # Only swap to logical PC if we haven't already jumped in a previous step
                if not self.pc_was_modified:
                    self.registers["PC"] = logical_pc

                if self.debug_mode:
                    print(f"    Executing cycle: {step[0]} {step[1:]}")

                self.execute_microcode_step(step, self.operand1, self.operand2)
                
                if not self.pc_was_modified:
                    # Verification: Did the actual execution match the prediction?
                    if self.registers["PC"] == self.current_predicted_pc:
                        # Prediction Correct: Restore the real fetch PC so the Fetch robot continues.
                        self.registers["PC"] = real_fetch_pc
                    else:
                        # Prediction Wrong: The PC is now pointing to the correct target.
                        # Signal a flush so Fetch restarts from this new address.
                        self.pc_was_modified = True
                        self.stats["predicted_wrong"] += 1
            else:
                self.state = "FETCH" # Ready for next
                self.instructions_executed += 1
                if not self.pc_was_modified:
                    self.stats["predicted_correct"] += 1
                if self.pc_was_modified:
                    return True # Signal Flush
        
        return False

    def _flush_pipeline(self):
        self.instruction_buffer.clear()
        self.MIR = None # Invalidate MIR so Decoder doesn't re-process old data
        self.fetch_stalled = False
        self.pc_was_modified = False
        self.stats["flushes"] += 1

    def execute_microcode_step(self, microcode_step, operand1, operand2):
        """
        Optimized execution engine. 
        Inlines argument resolution and assumes integer arithmetic.
        """
        op = microcode_step[0]

        if op == "load_immediate":
            # Inline resolve_arg
            a1 = microcode_step[1]
            reg = operand1 if a1 == 'arg1' else (operand2 if a1 == 'arg2' else a1)
            
            a2 = microcode_step[2]
            val = operand1 if a2 == 'arg1' else (operand2 if a2 == 'arg2' else a2)
            
            if reg in self.registers:
                self.registers[reg] = val

        elif op == "alu":
            alu_op = microcode_step[1]
            if alu_op == "ADD": self.registers["Ra"] += self.registers["Rb"]
            elif alu_op == "SUB": self.registers["Ra"] -= self.registers["Rb"]
            elif alu_op == "MUL": self.registers["Ra"] *= self.registers["Rb"]
            elif alu_op == "DIV":
                if self.registers["Rb"] != 0: self.registers["Ra"] //= self.registers["Rb"]
                else: self.state = "HALT"; print("CPU Runtime Error: Division by zero!")
            elif alu_op == "MOD":
                if self.registers["Rb"] != 0: self.registers["Ra"], self.registers["Rb"] = divmod(self.registers["Ra"], self.registers["Rb"])
                else: self.state = "HALT"; print("CPU Runtime Error: Division by zero!")
            elif alu_op == "DEC": self.registers["Ra"] -= 1
            elif alu_op == "INC": self.registers["Ra"] += 1
            elif alu_op == "AND": self.registers["Ra"] &= self.registers["Rb"]
            
            # Set flags inline
            ra = self.registers["Ra"]
            self.flags["Z"] = (ra == 0)
            self.flags["N"] = (ra < 0)
            self.flags["E"] = (ra == self.registers["Rb"])

        elif op == "move_reg":
            a1 = microcode_step[1]
            Rx = operand1 if a1 == 'arg1' else (operand2 if a1 == 'arg2' else a1)
            a2 = microcode_step[2]
            Ry = operand1 if a2 == 'arg1' else (operand2 if a2 == 'arg2' else a2)
            if Rx in self.registers and Ry in self.registers:
                self.registers[Rx] = self.registers[Ry]

        elif op == "store_mem_adres":
            a1 = microcode_step[1]
            adres = operand1 if a1 == 'arg1' else (operand2 if a1 == 'arg2' else a1)
            a2 = microcode_step[2]
            Rx = operand1 if a2 == 'arg1' else (operand2 if a2 == 'arg2' else a2)
            self.memory.write(adres, self.registers[Rx])

        elif op == "store_mem_reg":
            a1 = microcode_step[1]
            Rx = operand1 if a1 == 'arg1' else (operand2 if a1 == 'arg2' else a1)
            a2 = microcode_step[2]
            Ry = operand1 if a2 == 'arg1' else (operand2 if a2 == 'arg2' else a2)
            self.memory.write(self.registers[Rx], self.registers[Ry])

        elif op == "read_mem_adres":
            a1 = microcode_step[1]
            adres = operand1 if a1 == 'arg1' else (operand2 if a1 == 'arg2' else a1)
            a2 = microcode_step[2]
            Rx = operand1 if a2 == 'arg1' else (operand2 if a2 == 'arg2' else a2)
            self.registers[Rx] = self.memory.read(adres)

        elif op == "read_mem_reg":
            a1 = microcode_step[1]
            Rx = operand1 if a1 == 'arg1' else (operand2 if a1 == 'arg2' else a1)
            a2 = microcode_step[2]
            Ry = operand1 if a2 == 'arg1' else (operand2 if a2 == 'arg2' else a2)
            self.registers[Ry] = self.memory.read(self.registers[Rx])

        elif op == "branch":
            flag = microcode_step[1]
            offset = int(microcode_step[2])
            if flag == "A": self.microcode_step_index += offset
            elif flag == "E" and self.flags["E"]: self.microcode_step_index += offset
            elif flag == "Z" and self.flags["Z"]: self.microcode_step_index += offset
            elif flag == "N" and self.flags["N"]: self.microcode_step_index += offset
            elif flag == "S" and self.flags["S"]: self.microcode_step_index += offset

        elif op == "gpu":
            a1 = microcode_step[1]
            Rx = operand1 if a1 == 'arg1' else (operand2 if a1 == 'arg2' else a1)
            self.gpu.execute(self.registers[Rx])

        elif op == "set_cpu_state":
            self.state = microcode_step[1]
        elif op == "set_status_bit":
            self.flags["S"] = (microcode_step[1] == "TRUE")
        elif op == "set_interrupt_flag":
            self.interrupts_enabled = (microcode_step[1] == "TRUE")
        elif op == "shadow":
            sub = microcode_step[1]
            if sub == "SAVE": self._save_to_shadow()
            elif sub == "RESTORE": self._restore_from_shadow()

    def _handle_interrupt(self):
        # 1. M1 Specific: Rewind PC to the oldest instruction in the pipeline
        if self.instruction_buffer:
            self.registers["PC"] = self.instruction_buffer[0][3]
        elif self.MIR is not None:
            self.registers["PC"] = self.MIR_PC
        
        # 2. Standard Interrupt Logic (Inlined from Base CPU)
        self._save_to_shadow()
        self.interrupts_enabled = False

        if self.interrupt_controller:
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

    def _save_to_shadow(self):
        self.shadow_registers = self.registers.copy()
        self.shadow_flags = self.flags.copy()
        self.shadow_interrupts_enabled = self.interrupts_enabled

    def _restore_from_shadow(self):
        self.registers = self.shadow_registers.copy()
        self.flags = self.shadow_flags.copy()
        self.interrupts_enabled = self.shadow_interrupts_enabled

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

    def _predict_next_pc(self, instruction_int, current_pc):
        # 1. Handle Sign (Negative Immediate Flag)
        if instruction_int < 0:
            return current_pc + 1

        # 2. Extract Opcode (First 2 digits)
        temp_val = instruction_int
        divisor = 1
        while temp_val >= 100:
            temp_val //= 10
            divisor *= 10
        
        opcode = temp_val
        
        # 3. Extract Operands (Rest)
        rest = instruction_int % divisor
        
        # Prediction Logic
        if opcode == 22 or opcode == 24:
            # Unconditional Jumps/Calls
            # Target is operand1 (one_addr) -> rest
            if opcode == 24: 
                self.ras.append(current_pc + 1)
            return rest

        elif opcode == 20 or opcode == 21:
            # Conditional Branches
            # Target is operand2 (two_reg_addr) -> rest % split_factor
            split_factor = divisor // 10
            if split_factor == 0: split_factor = 1
            target = rest % split_factor
            
            # BTFN: If jumping backward, predict TAKEN (Target)
            # If jumping forward, predict NOT TAKEN (current_pc + 1)
            return target if target < current_pc else current_pc + 1

        elif opcode == 12 and self.ras:
            return self.ras.pop()

        # Fallback for all other instructions (ADD, LD, STO, etc.)
        return current_pc + 1