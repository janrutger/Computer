# Define output files
MICROCODE_ROM = bin/stern_rom.json
PROGRAM_BIN = bin/program.bin
SYMBOLS = bin/symbols.json
COMPILED_ASM = assembler/asm/main.asm


# Microcode source files
MICROCODE_SOURCES = microcode_assembler/base_rom.uasm

# Source files
ISA_SOURCES = $(shell find assembler/asm -name "*.asm")
COMPILER_SOURCES = $(shell find compiler -name "*.py")
LIB_STACKS_SOURCES = $(shell find compiler/src/libs -name "*.stacks")

# --- Dynamic Source File Selection ---
# Any command-line target that isn't a known rule (run, debug, clean, all)
# is assumed to be the name of the source file to compile.
# Example: `make fly` will set SRC to 'fly'.
KNOWN_TARGETS := run debug all clean
SRC_TARGET := $(filter-out $(KNOWN_TARGETS),$(MAKECMDGOALS))

# Set SRC to the found target, or default to 'main' if no target is given.
SRC := $(if $(SRC_TARGET),$(firstword $(SRC_TARGET)),main)
MAIN_STACKS_SOURCE = compiler/src/$(SRC).stacks

# Find compiled library modules
COMPILED_LIBS = $(patsubst compiler/src/libs/%.stacks,compiler/lib/%.smod,$(LIB_STACKS_SOURCES))

# Assembler scripts
MICROCODE_ASSEMBLER_SCRIPT = microcode_assembler/assembler.py
ISA_ASSEMBLER_SCRIPT = assembler/assembler.py
COMPILER_SCRIPT = compiler/compiler.py

all: $(PROGRAM_BIN)
 
# Rule to compile a single .stacks library file into a .smod module
compiler/lib/%.smod: compiler/src/libs/%.stacks $(COMPILER_SOURCES)
	@echo "Compiling Stacks library: $<"
	@mkdir -p compiler/lib
	python3 $(COMPILER_SCRIPT) $< --module
 
# The main compiled ASM depends on the main source file AND any compiled libraries
# The pipe symbol '|' makes $(COMPILED_LIBS) an "order-only" prerequisite.
# This ensures libraries are built first before the main compilation command is run.
$(COMPILED_ASM): $(MAIN_STACKS_SOURCE) $(COMPILER_SOURCES) | $(COMPILED_LIBS)
	@echo "Compiling Stacks language to assembly..."
	python3 $(COMPILER_SCRIPT) $(MAIN_STACKS_SOURCE) -o $(COMPILED_ASM)

$(MICROCODE_ROM): $(MICROCODE_SOURCES) $(MICROCODE_ASSEMBLER_SCRIPT) microcode_assembler/parser.py
	@echo "Assembling microcode..."
	python3 $(MICROCODE_ASSEMBLER_SCRIPT) $(MICROCODE_SOURCES)

# The program binary depends on the compiled assembly file now
$(PROGRAM_BIN): $(COMPILED_ASM) $(ISA_SOURCES) $(MICROCODE_ROM) $(ISA_ASSEMBLER_SCRIPT) assembler/build.json
	@echo "Assembling ISA code..."
	python3 $(ISA_ASSEMBLER_SCRIPT) assembler/build.json

run: $(PROGRAM_BIN)
	@echo "Running simulation..."
	python3 stern-XT.py

debug: $(PROGRAM_BIN)
	@echo "Running simulation in debug mode..."
	python3 stern-XT.py -debug

clean:
	@echo "Cleaning up build artifacts..."
	rm -f $(PROGRAM_BIN) $(MICROCODE_ROM) $(SYMBOLS) $(COMPILED_ASM)
	rm -rf compiler/lib

# --- Phony and Dynamic Targets ---
# This makes `make <src_name>` work. It declares the dynamic target as .PHONY,
# which forces the compilation rule to run every time.
.PHONY: $(SRC_TARGET)
$(SRC_TARGET): $(COMPILED_ASM)