from devices.cpu import CPU
from collections import deque
import time

class CPU_M1(CPU):
    def __init__(self, memory, interrupt_controller=None, rom_path="bin/stern_rom.json", debug_mode=False):
        super().__init__(memory, interrupt_controller, rom_path, debug_mode)
        
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
        
        # Override state to ensure we start correctly
        self.state = "FETCH" 

        # Performance Counters for Proof of Work
        self.stats = {
            "fetched": 0,
            "predicted_correct": 0,
            "predicted_wrong": 0,
            "flushes": 0
        }
        self.ras = deque(maxlen=64) # Return Address Stack. deque handles overflow by discarding oldest.

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

        # Decode logic (simplified adaptation from cpu.py)
        opcode = self.MIR[:2]
        operand1 = "0"
        operand2 = "0"

        if opcode in self.instruction_formats:
            fmt = self.instruction_formats[opcode]
            if fmt == "one_addr": operand1 = self.MIR[2:]
            elif fmt == "one_reg": operand1 = self.MIR[2]
            elif fmt == "two_reg_reg": operand1 = self.MIR[2]; operand2 = self.MIR[3]
            elif fmt == "two_reg_addr" or fmt == "two_reg_val": operand1 = self.MIR[2]; operand2 = self.MIR[3:]
            
            if opcode in self.microcode_rom:
                ucode = self.microcode_rom[opcode]
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

    def _handle_interrupt(self):
        # Rewind PC to the oldest instruction in the pipeline before saving context.
        # This ensures we resume execution at the instruction that was pending, not the one being fetched.
        if self.instruction_buffer:
            self.registers["PC"] = self.instruction_buffer[0][3]
        elif self.MIR is not None:
            self.registers["PC"] = self.MIR_PC
        
        super()._handle_interrupt()

   

    def _predict_next_pc(self, instruction, current_pc):
        # 1. Validation
        if not instruction or len(instruction) < 2:
            return current_pc + 1

        opcode = instruction[:2]

        # 2. Unconditional Jumps/Calls (Opcode 22/24)
        if opcode == "22" or opcode == "24":
            try:
                # Slice and convert only if it's a jump candidate
                target = int(instruction[2:])
                if opcode == "24": 
                    self.ras.append(current_pc + 1)
                return target
            except ValueError:
                # This handles the '613-1' case - if it's not a valid int, 
                # it's not a jump address.
                return current_pc + 1

        # 3. Conditional Branches (Opcode 20/21) - Static BTFN Prediction
        elif opcode == "20" or opcode == "21":
            try:
                target = int(instruction[2:])
                # BTFN: If jumping backward, predict TAKEN (Target)
                # If jumping forward, predict NOT TAKEN (current_pc + 1)
                return target if target < current_pc else current_pc + 1
            except ValueError:
                return current_pc + 1

        # 4. Returns (Opcode 12)
        elif opcode == "12" and self.ras:
            return self.ras.pop()

        # Fallback for all other instructions (ADD, LD, STO, etc.)
        return current_pc + 1