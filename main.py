# the central computers
# Knows about the memory and CPU

# Load some program in memory
# Starts the CPU ticks


from memory import Memory
from cpu import CPU
from time import sleep

memory = Memory()
cpu = CPU(memory)

# Load a program into memory
memory.write(0, 10)
memory.write(1, 31530)
memory.write(2, 31612)
memory.write(3, 5056)
memory.write(4, 5265)
memory.write(5, 40616)
memory.write(6, 11)


# run the CPU ticks
while cpu.state != "HALT":
    cpu.tick()
    sleep(0.01)

print("Computer stopped.")