
class Memory:
    def __init__(self, size=4096):
        self.size = size
        self.memory = ["0"] * size  # Initialize memory with "0" as string

        self.video_dirty = True   # Start dirty to draw the initial frame
        
        # These constants are from stern-XT.py
        video_start = 14336
        video_width = 80
        video_height = 24
        self.video_end = video_start + (video_width * video_height)
        self.video_start = video_start

    def read(self, address):
        if 0 <= address < self.size:
            return self.memory[address]
        else:
            raise IndexError("Memory address out of bounds")

    def write(self, address, value):
        if 0 <= address < self.size:
            # Ensure the value is a string, as per the specification
            self.memory[address] = str(value)
            if self.video_start <= address < self.video_end:
                self.video_dirty = True
        else:
            raise IndexError("Memory address out of bounds")


    def read_block(self, address, length):
        """Reads a contiguous block of memory, simulating DMA."""
        if not (0 <= address < self.size and 0 <= address + length <= self.size):
            raise IndexError(f"Memory block read out of bounds: addr={address}, len={length}")
        # Returns a list of strings
        return self.memory[address:address + length]

    def write_block(self, address, data):
        """Writes a contiguous block of memory, simulating DMA."""
        length = len(data)
        if not (0 <= address < self.size and 0 <= address + length <= self.size):
            raise IndexError(f"Memory block write out of bounds: addr={address}, len={length}")

        # Convert all data to string before writing
        str_data = [str(d) for d in data]
        self.memory[address:address + length] = str_data

        # Check if the write operation overlaps with video memory
        write_end = address + length
        if max(address, self.video_start) < min(write_end, self.video_end):
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
