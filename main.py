# the central computers
# Knows about the memory and CPU

# Load some program in memory
# Starts the CPU ticks

from assembler.FileIO import readFile
from memory import Memory
from cpu import CPU
from time import sleep

memory = Memory()
cpu = CPU(memory)

# load a program
program = readFile("./assembler/bin/program.bin", 0)
for line in program:
    memory.write(int(line[0]), (line[1]))



# run the CPU ticks
while cpu.state != "HALT":
    cpu.tick()
    # sleep(0.01) # You might want to comment this out for faster execution


# after running
print("\nComputer has halted.")
print("="*50)
cpu.dump_state()
print("="*50)
print("\nEntering memory viewer. Type 'q' to quit.")

# Memory viewer loop
while True:
    try:
        print("="*50)
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
            print(memory.dump(start_addr, end_addr))
        elif len(parts) == 1:
            start_addr = int(parts[0])
            # Default to showing 16 words if only one address is given
            print(memory.dump(start_addr, start_addr + 16))
        else:
            print("Invalid input. Please enter one or two numbers separated by a space, or 'q'.")

    except ValueError:
        print("Invalid input. Please enter valid numbers for the addresses.")
    except IndexError as e:
        print(f"Error: {e}")

print("Exiting memory viewer.")