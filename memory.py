
class Memory:
    def __init__(self, size=4096):
        self.size = size
        self.memory = ["0"] * size  # Initialize memory with "0" as string

    def read(self, address):
        if 0 <= address < self.size:
            return self.memory[address]
        else:
            raise IndexError("Memory address out of bounds")

    def write(self, address, value):
        if 0 <= address < self.size:
            # Ensure the value is a string, as per the specification
            self.memory[address] = str(value)
        else:
            raise IndexError("Memory address out of bounds")

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
