import numpy as np

class GPU_R3:
    """
    A GPU designed for the MemoryR3 (integer-based) architecture.
    It uses an internal VRAM to store matrices, avoiding costly conversions
    to and from main memory during chained calculations.
    """
    def __init__(self, memory, mode=0): # 0 = XT string memory compatible 1 = integer memory
        self.memory = memory
        self.vram = {} # VRAM Storage: { handle_id: {'data': numpy_array, 'dirty': bool} }
        self.mode = mode

    def _load_matrix_from_ram(self, ptr):
        # MemoryR3 is integer based, no extra int() conversion needed
        if self.mode == 1:
            rows = (self.memory.read(ptr))
            cols = (self.memory.read(ptr + 1))
        else:
            rows = int(self.memory.read(ptr))
            cols = int(self.memory.read(ptr + 1))

        data_block = self.memory.read_block(ptr + 2, rows * cols)
        return np.array(data_block, dtype=float).reshape(rows, cols)

    def _save_matrix_to_ram(self, ptr, matrix):
        if self.mode == 1:
            rows = (self.memory.read(ptr))
            cols = (self.memory.read(ptr + 1))
        else:
            rows = int(self.memory.read(ptr))
            cols = int(self.memory.read(ptr + 1))
        
        if matrix.shape != (rows, cols):
            if matrix.size == rows * cols:
                matrix = matrix.reshape(rows, cols)
            else:
                raise ValueError(f"Shape mismatch: {matrix.shape} vs RAM ({rows},{cols})")
        
        # Convert float back to int for storage in MemoryR3
        result_data = matrix.flatten().astype(int).tolist()
        self.memory.write_block(ptr + 2, result_data)

    def execute(self, tdl_ptr):
        try:
            tdl_ptr = int(tdl_ptr)
            
            while tdl_ptr != 0:
                # Read TDL fields
                if self.mode == 1:
                    arg_a = (self.memory.read(tdl_ptr))
                    arg_b = (self.memory.read(tdl_ptr + 1))
                    arg_res = (self.memory.read(tdl_ptr + 2))
                    scale = (self.memory.read(tdl_ptr + 3))
                    opcode = (self.memory.read(tdl_ptr + 4))
                    next_tdl_ptr = (self.memory.read(tdl_ptr + 6))
                else:
                    arg_a = int(self.memory.read(tdl_ptr))
                    arg_b = int(self.memory.read(tdl_ptr + 1))
                    arg_res = int(self.memory.read(tdl_ptr + 2))
                    scale = int(self.memory.read(tdl_ptr + 3))
                    opcode = int(self.memory.read(tdl_ptr + 4))
                    next_tdl_ptr = int(self.memory.read(tdl_ptr + 6))
                

                # --- Operations ---
                
                # 12: FREE (Free VRAM Handle)
                if opcode == 12:
                    if arg_a != 0 and arg_a in self.vram:
                        del self.vram[arg_a]
                    if arg_b != 0 and arg_b in self.vram:
                        del self.vram[arg_b]
                    if arg_res != 0 and arg_res in self.vram:
                        del self.vram[arg_res]

                # Math Operations (VRAM -> VRAM)
                else:
                    if arg_a not in self.vram:
                        # Implicit Upload: Treat arg_a as RAM pointer
                        matrix = self._load_matrix_from_ram(arg_a)
                        self.vram[arg_a] = {'data': matrix, 'dirty': False}
                    mat_a = self.vram[arg_a]['data']
                    result = None

                    if opcode == 4: result = np.maximum(0, mat_a)
                    elif opcode == 5: result = mat_a.T
                    elif opcode == 6: result = np.where(mat_a > 0, scale, 0)
                    else:
                        if arg_b not in self.vram:
                            # Implicit Upload: Treat arg_b as RAM pointer
                            matrix = self._load_matrix_from_ram(arg_b)
                            self.vram[arg_b] = {'data': matrix, 'dirty': False}
                        mat_b = self.vram[arg_b]['data']
                        
                        if opcode == 0: result = mat_a + mat_b
                        elif opcode == 1: result = mat_a - mat_b
                        elif opcode == 2: result = np.multiply(mat_a, mat_b)
                        elif opcode == 3: result = np.dot(mat_a, mat_b)
                        else: raise ValueError(f"Invalid GPU Opcode: {opcode}")

                        if opcode in [2, 3] and scale != 0 and scale != 1:
                            result = result / scale

                    # All math results are stored in VRAM and marked as dirty.
                    self.vram[arg_res] = {'data': result, 'dirty': True}

                self.memory.write(tdl_ptr + 5, 0) # Success
                
                # Chaining: Read next TDL pointer from offset 6
                tdl_ptr = next_tdl_ptr
            
            # After the chain, write all dirty matrices back to main memory.
            for handle, entry in self.vram.items():
                if entry['dirty']:
                    self._save_matrix_to_ram(handle, entry['data'])

        except Exception as e:
            print(f"[GPU_R3] Error executing TDL: {e}")
            try: self.memory.write(tdl_ptr + 5, 1) # Error
            except: pass
        finally:
            # Clean the slot-cache after the last TDL of the list
            self.vram = {}

if __name__ == "__main__":
    # Mock Memory Class for testing
    class MockMemory:
        def __init__(self):
            self.memory = [0] * 2000
        
        def read(self, ptr):
            if 0 <= ptr < len(self.memory):
                return self.memory[ptr]
            return 0
            
        def write(self, ptr, value):
            if 0 <= ptr < len(self.memory):
                self.memory[ptr] = int(value)
                
        def read_block(self, ptr, length):
            return self.memory[ptr:ptr+length]
            
        def write_block(self, ptr, data):
            for i, val in enumerate(data):
                self.memory[ptr + i] = int(val)

    print("--- Starting GPU_R3 Self-Test ---")
    
    mem = MockMemory()
    gpu = GPU_R3(mem)

    # 1. Setup Data
    # Matrix A (2x2) at 100: [[1, 2], [3, 4]]
    mem.write(100, 2) # Rows
    mem.write(101, 2) # Cols
    mem.write_block(102, [1, 2, 3, 4])

    # Matrix B (2x2) at 200: [[10, 20], [30, 40]]
    mem.write(200, 2)
    mem.write(201, 2)
    mem.write_block(202, [10, 20, 30, 40])

    # Matrix C (Result) at 300: Empty 2x2
    mem.write(300, 2)
    mem.write(301, 2)
    mem.write_block(302, [0, 0, 0, 0])

    # 2. Setup TDL Chain
    # TDL 1 at 1000: C = A + B
    # Expected C (temp) = [[11, 22], [33, 44]]
    mem.write(1000, 100)  # Arg A
    mem.write(1001, 200)  # Arg B
    mem.write(1002, 300)  # Arg Res (C)
    mem.write(1003, 0)    # Scale
    mem.write(1004, 0)    # Opcode ADD
    mem.write(1005, 0)    # Status
    mem.write(1006, 1010) # Next TDL -> 1010

    # TDL 2 at 1010: C = C * A (Element-wise)
    # Expected C (final) = [[11*1, 22*2], [33*3, 44*4]] = [[11, 44], [99, 176]]
    mem.write(1010, 300)  # Arg A (C from previous step, in VRAM)
    mem.write(1011, 100)  # Arg B (A, in VRAM)
    mem.write(1012, 300)  # Arg Res (C)
    mem.write(1013, 0)    # Scale
    mem.write(1014, 2)    # Opcode MUL
    mem.write(1015, 0)    # Status
    mem.write(1016, 0)    # Next TDL -> 0 (End)

    # 3. Execute
    print("Executing TDL Chain...")
    gpu.execute(1000)

    # 4. Verify
    result = mem.read_block(302, 4)
    expected = [11, 44, 99, 176]
    
    print(f"Result in RAM: {result}")
    
    if result == expected:
        print("SUCCESS: Result matches expected values.")
    else:
        print(f"FAILURE: Expected {expected}, got {result}")

    # Verify VRAM is empty
    if not gpu.vram:
        print("SUCCESS: VRAM cleared.")
    else:
        print(f"FAILURE: VRAM not cleared: {gpu.vram}")