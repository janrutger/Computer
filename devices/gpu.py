import numpy as np

class GPU:
    def __init__(self, memory):
        self.memory = memory

    def execute(self, tdl_ptr):
        # TDL structure:
        #   0: PTR_A
        #   1: PTR_B
        #   2: PTR_RES
        #   3: SCALE
        #   4: OPCODE
        #   5: STATUS

        try:
            # Ensure tdl_ptr is an integer
            tdl_ptr = int(tdl_ptr)
            
            # Read TDL fields
            # We use int() because memory.read returns strings in this architecture
            ptr_a = int(self.memory.read(tdl_ptr))
            ptr_b = int(self.memory.read(tdl_ptr + 1))
            ptr_res = int(self.memory.read(tdl_ptr + 2))
            scale = int(self.memory.read(tdl_ptr + 3))
            opcode = int(self.memory.read(tdl_ptr + 4))

            # Helper to read matrix
            def get_matrix(ptr):
                rows = int(self.memory.read(ptr))
                cols = int(self.memory.read(ptr + 1))
                data_block = self.memory.read_block(ptr + 2, rows * cols)
                # Convert strings to float for numpy
                data = [float(x) for x in data_block]
                return np.array(data).reshape(rows, cols)

            mat_a = get_matrix(ptr_a)
            
            # Initialize result
            result = None

            if opcode == 4: # RELU
                result = np.maximum(0, mat_a)
            elif opcode == 5: # TRANSPOSE
                result = mat_a.T
            elif opcode == 6: # RELU_DERIV
                result = np.where(mat_a > 0, scale, 0)
            else:
                mat_b = get_matrix(ptr_b)
                
                if opcode == 0: # ADD
                    result = mat_a + mat_b
                elif opcode == 1: # SUB
                    result = mat_a - mat_b
                elif opcode == 2: # MUL
                    result = np.multiply(mat_a, mat_b)
                    # Apply scaling for multiplication
                    if scale != 0 and scale != 1:
                        result = result / scale
                elif opcode == 3: # DOT
                    result = np.dot(mat_a, mat_b)
                    # Apply scaling for dot product
                    if scale != 0 and scale != 1:
                        result = result / scale
                else:
                    raise ValueError(f"Invalid Opcode: {opcode}")

            # Write result back
            dest_rows = int(self.memory.read(ptr_res))
            dest_cols = int(self.memory.read(ptr_res + 1))
            
            # Check dimensions
            if result.shape != (dest_rows, dest_cols):
                # Allow reshaping if total size matches (e.g. (1,1) vs (1,))
                if result.size == dest_rows * dest_cols:
                    result = result.reshape(dest_rows, dest_cols)
                else:
                    raise ValueError(f"Result shape {result.shape} mismatch with Dest ({dest_rows}, {dest_cols})")

            # Convert back to int list for memory
            result_data = result.flatten().astype(int).tolist()
            self.memory.write_block(ptr_res + 2, result_data)

            # Set status to 0 (Success)
            self.memory.write(tdl_ptr + 5, 0)

        except Exception as e:
            print(f"[GPU] Error executing TDL: {e}")
            # Set status to error (1 for generic error)
            try:
                self.memory.write(tdl_ptr + 5, 1)
            except:
                pass