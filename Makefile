# Define output files
MICROCODE_ROM = bin/stern_rom.json
PROGRAM_BIN = bin/program.bin

# Microcode source files
MICROCODE_SOURCES = microcode_assembler/base_rom.uasm

# ISA source files (read from build.json)
# This is a bit tricky for make, as it can't easily parse JSON directly.
# For simplicity, we'll list the main ones here.
# In a more complex scenario, you might use a script to generate this list.
ISA_SOURCES = $(shell find assembler/asm -name "*.asm")

# Assembler scripts
MICROCODE_ASSEMBLER_SCRIPT = microcode_assembler/assembler.py
ISA_ASSEMBLER_SCRIPT = assembler/assembler.py

all: $(PROGRAM_BIN)

$(MICROCODE_ROM): $(MICROCODE_SOURCES) $(MICROCODE_ASSEMBLER_SCRIPT) microcode_assembler/parser.py
	@echo "Assembling microcode..."
	python3 $(MICROCODE_ASSEMBLER_SCRIPT) $(MICROCODE_SOURCES)

$(PROGRAM_BIN): $(ISA_SOURCES) $(MICROCODE_ROM) $(ISA_ASSEMBLER_SCRIPT) bin/build.json
	@echo "Assembling ISA code..."
	python3 $(ISA_ASSEMBLER_SCRIPT) bin/build.json

run: $(PROGRAM_BIN)
	@echo "Running simulation..."
	python3 stern-XT.py

debug: $(PROGRAM_BIN)
	@echo "Running simulation in debug mode..."
	python3 stern-XT.py -debug

clean:
	@echo "Cleaning up build artifacts..."
	rm -f $(PROGRAM_BIN) $(MICROCODE_ROM)
	