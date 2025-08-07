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
    sleep(0.01)

print("Computer stopped.")

