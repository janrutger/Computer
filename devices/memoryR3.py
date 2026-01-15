class Memory:
    def __init__(self, size=4096, video_start=None, video_end=None):
        self.size = size
        # Initialize memory with 0 as int. 
        # This is much faster than ["0"] * size and saves memory.
        self.memory = [0] * size  
        
        # Handle video memory ranges (default to safe values if not provided)
        self.video_start = video_start if video_start is not None else size
        self.video_end = video_end if video_end is not None else size
        self.video_dirty = False

    def read(self, address):
        # if 0 <= address < self.size:
        #     return self.memory[address]
        # return 0
        if 0 <= address < self.size:
            return self.memory[address]
        else:
            raise IndexError("Memory address out of bounds")

    def write(self, address, value):
        if 0 <= address < self.size:
            # Ensure we store an int, regardless of what the CPU/Bus sends
            self.memory[address] = int(value)
            
            # Check dirty flag for video refresh optimization
            if self.video_start <= address < self.video_end:
                self.video_dirty = True

    def read_block(self, address, length):
        if 0 <= address and address + length <= self.size:
            return self.memory[address:address + length]
        return []

    def write_block(self, address, data):
        length = len(data)
        if 0 <= address and address + length <= self.size:
            # Bulk convert and assign is faster than a loop
            int_data = [int(d) for d in data]
            self.memory[address:address + length] = int_data
            
            # Check for overlap with video memory
            # If the block ends before video starts OR starts after video ends, it's safe.
            # Otherwise, mark dirty.
            if not (address + length <= self.video_start or address >= self.video_end):
                 self.video_dirty = True

    def is_video_dirty(self):
        return self.video_dirty

    def unset_video_dirty_flag(self):
        self.video_dirty = False

    def __len__(self):
        return self.size

    def __str__(self):
        return f"Memory (size: {self.size})"

    def dump(self, start=0, end=None):
        if end is None:
            end = self.size
        
        output = []
        for i in range(start, min(end, self.size)):
            # Format as integer; could be enhanced to show hex if preferred
            output.append(f"[{i:04d}]: {self.memory[i]}")
        return "\n".join(output)

    def view_memory(self):
        print("\nEntering memory viewer. Type 'q' to quit.")

        # Memory viewer loop
        while True:
            try:
                print("="*85)
                user_input = input("Enter start and end address (e.g., 0 100) or a single address to view 16 words: ")
                if user_input.lower() == 'q':
                    break
                
                parts = user_input.split()
                if len(parts) == 2:
                    start_addr = int(parts[0])
                    end_addr = int(parts[1])
                    if start_addr > end_addr:
                        print("Error: Start address cannot be greater than end address.")
                        continue
                    print(self.dump(start_addr, end_addr))
                elif len(parts) == 1:
                    start_addr = int(parts[0])
                    # Default to showing 16 words if only one address is given
                    print(self.dump(start_addr, start_addr + 16))
                else:
                    print("Invalid input. Please enter one or two numbers separated by a space, or 'q'.")

            except ValueError:
                print("Invalid input. Please enter valid numbers for the addresses.")
            except IndexError as e:
                print(f"Error: {e}")

        print("Exiting memory viewer.")
