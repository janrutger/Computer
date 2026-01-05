import numpy as np

class GPU_R3:
    """
    A GPU designed for the MemoryR3 (integer-based) architecture.
    It uses an internal VRAM to store matrices, avoiding costly conversions
    to and from main memory during chained calculations.
    """
    def __init__(self, memory):
        self.memory = memory
        self.vram = {} # VRAM Storage: { handle_id: {'data': numpy_array, 'dirty': bool} }

    def execute(self, tdl_ptr):
        try:
            tdl_ptr = int(tdl_ptr)
            
            while tdl_ptr != 0:
                # Read TDL fields
                arg_a = int(self.memory.read(tdl_ptr))
                arg_b = int(self.memory.read(tdl_ptr + 1))
                arg_res = int(self.memory.read(tdl_ptr + 2))
                scale = int(self.memory.read(tdl_ptr + 3))
                opcode = int(self.memory.read(tdl_ptr + 4))
                next_tdl_ptr = int(self.memory.read(tdl_ptr + 6))

                # --- Helper Functions for DMA (Direct Memory Access) ---
                def load_matrix_from_ram(ptr):
                    # MemoryR3 is integer based, no extra int() conversion needed
                    rows = self.memory.read(ptr)
                    cols = self.memory.read(ptr + 1)
                    data_block = self.memory.read_block(ptr + 2, rows * cols)
                    return np.array(data_block, dtype=float).reshape(rows, cols)

                def save_matrix_to_ram(ptr, matrix):
                    rows = self.memory.read(ptr)
                    cols = self.memory.read(ptr + 1)
                    
                    if matrix.shape != (rows, cols):
                        if matrix.size == rows * cols:
                            matrix = matrix.reshape(rows, cols)
                        else:
                            raise ValueError(f"Shape mismatch: {matrix.shape} vs RAM ({rows},{cols})")
                    
                    # Convert float back to int for storage in MemoryR3
                    result_data = matrix.flatten().astype(int).tolist()
                    self.memory.write_block(ptr + 2, result_data)

                # --- Operations ---
                
                # 10: UPLOAD (RAM -> VRAM)
                if opcode == 10:
                    # Check if VRAM slot is dirty (modified by GPU). 
                    # If so, preserve it (don't overwrite with old RAM data).
                    if arg_res in self.vram and self.vram[arg_res]['dirty']:
                        pass # Skip upload to preserve dirty data
                    else:
                        matrix = load_matrix_from_ram(arg_a)
                        self.vram[arg_res] = {'data': matrix, 'dirty': False}
                    
                # 11: DOWNLOAD (VRAM -> RAM)
                elif opcode == 11:
                    if arg_a in self.vram:
                        entry = self.vram[arg_a]
                        save_matrix_to_ram(arg_res, entry['data']) # arg_res is the RAM pointer
                        entry['dirty'] = False # Mark as clean (synced with RAM)
                    else:#
                        raise ValueError(f"VRAM Handle {arg_a} not found")

                # 12: FREE (Free VRAM Handle)
                elif opcode == 12:
                    if arg_a in self.vram:
                        del self.vram[arg_a]

                # Math Operations (VRAM -> VRAM)
                else:
                    if arg_a not in self.vram:
                        # Implicit Upload: Treat arg_a as RAM pointer
                        matrix = load_matrix_from_ram(arg_a)
                        self.vram[arg_a] = {'data': matrix, 'dirty': False}
                    mat_a = self.vram[arg_a]['data']
                    result = None

                    if opcode == 4: result = np.maximum(0, mat_a)
                    elif opcode == 5: result = mat_a.T
                    elif opcode == 6: result = np.where(mat_a > 0, scale, 0)
                    else:
                        if arg_b not in self.vram:
                            # Implicit Upload: Treat arg_b as RAM pointer
                            matrix = load_matrix_from_ram(arg_b)
                            self.vram[arg_b] = {'data': matrix, 'dirty': False}
                        mat_b = self.vram[arg_b]['data']
                        
                        if opcode == 0: result = mat_a + mat_b
                        elif opcode == 1: result = mat_a - mat_b
                        elif opcode == 2: result = np.multiply(mat_a, mat_b)
                        elif opcode == 3: result = np.dot(mat_a, mat_b)
                        else: raise ValueError(f"Invalid GPU Opcode: {opcode}")

                        if opcode in [2, 3] and scale != 0 and scale != 1:
                            result = result / scale

                    # --- Smart Result Handling ---
                    if next_tdl_ptr == 0:
                        # Last op in chain: write result to RAM using arg_res as a pointer.
                        save_matrix_to_ram(arg_res, result)
                    else:
                        # Intermediate op: store result in VRAM using arg_res as a handle.
                        self.vram[arg_res] = {'data': result, 'dirty': True}

                self.memory.write(tdl_ptr + 5, 0) # Success
                
                # Chaining: Read next TDL pointer from offset 6
                tdl_ptr = next_tdl_ptr
            
            # Clean the slot-cache after the last TDL of the list
            self.vram = {}

        except Exception as e:
            print(f"[GPU_R3] Error executing TDL: {e}")
            try: self.memory.write(tdl_ptr + 5, 1) # Error
            except: pass