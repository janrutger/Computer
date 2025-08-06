
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
