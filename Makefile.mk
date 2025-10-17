# =============================================================================
# Main Build Makefile for the Stern-XT Computer Project
#
# This Makefile is responsible for:
#   1. Assembling the Microcode ROM.
#   2. Compiling Stacks language libraries into the `compiler/lib` directory.
#   3. Compiling kernel modules written in Stacks (.stacks -> .stacks.asm).
#   4. Compiling the main Stacks program (e.g., fly.stacks -> build/main.asm).
#   5. Copying the compiled program to `assembler/asm/main_stacks.asm`.
#   6. Assembling the final Program ROM from all assembly sources.
# =============================================================================

# --- Stop on Error ---
.DELETE_ON_ERROR:

# =============================================================================
# Configuration
# =============================================================================

# --- Directories ---
BUILD_DIR := build
BIN_DIR := bin
SRC_DIR := compiler/src
LIB_SRC_DIR := $(SRC_DIR)/libs
LIB_OUT_DIR := compiler/lib
KERNEL_STACKS_SRC_DIR := $(SRC_DIR)/kernel_files
BOOT_FILES_SRC_DIR := $(SRC_DIR)/boot_files
ASM_DIR := assembler/asm
INCL_DIR := $(ASM_DIR)/incl
MICROCODE_DIR := microcode_assembler

# --- Tools ---
COMPILER := python3 compiler/compiler.py
ASSEMBLER := python3 assembler/assembler.py
MICROCODE_ASSEMBLER := python3 $(MICROCODE_DIR)/assembler.py

# --- Main Programs ---
MAIN_PROGRAMS := main fly maze chaos3 turtle test
DEFAULT_PROGRAM := $(firstword $(MAIN_PROGRAMS))

# --- Target Calculation ---
KNOWN_TARGETS := all run debug clean
SRC_TARGET := $(filter-out $(KNOWN_TARGETS),$(MAKECMDGOALS))
SRC := $(if $(SRC_TARGET),$(SRC_TARGET),$(DEFAULT_PROGRAM))

# --- Output Files ---
PROGRAM_ROM := $(BIN_DIR)/program.bin
MICROCODE_ROM := $(BIN_DIR)/stern_rom.json
# Intermediate file for the compiled main program
MAIN_ASM_TEMP_TARGET := $(BUILD_DIR)/main.asm
# Final destination for the compiled main program
MAIN_ASM_FINAL_TARGET := $(ASM_DIR)/main_stacks.asm

# =============================================================================
# Source File Discovery
# =============================================================================

LIB_STACKS_SOURCES    := $(wildcard $(LIB_SRC_DIR)/*.stacks)
KERNEL_STACKS_SOURCES := $(wildcard $(KERNEL_STACKS_SRC_DIR)/*.stacks)
BOOT_FILES_SOURCES    := $(wildcard $(BOOT_FILES_SRC_DIR)/*.stacks)
ALL_ASM_FILES         := $(wildcard $(ASM_DIR)/**/*.asm)
MICROCODE_SOURCES     := $(MICROCODE_DIR)/base_rom.uasm

# --- Define paths for generated files ---
COMPILED_LIBS := $(patsubst $(LIB_SRC_DIR)/%.stacks,$(LIB_OUT_DIR)/%.smod,$(LIB_STACKS_SOURCES))
GENERATED_KERNEL_ASM := $(patsubst $(KERNEL_STACKS_SRC_DIR)/%.stacks,$(INCL_DIR)/%.stacks.asm,$(KERNEL_STACKS_SOURCES))
GENERATED_BOOT_ASM   := $(patsubst $(BOOT_FILES_SRC_DIR)/%.stacks,$(ASM_DIR)/%.stacks.asm,$(BOOT_FILES_SOURCES))


# =============================================================================
# Main Targets
# =============================================================================

.PHONY: all run debug clean $(MAIN_PROGRAMS)

all: $(PROGRAM_ROM)

run: $(PROGRAM_ROM)
	@echo "====== Running Simulation ======"
	python3 stern-XT.py

debug: $(PROGRAM_ROM)
	@echo "====== Running Simulation (Debug) ======"
	python3 stern-XT.py -debug

clean:
	@echo "====== Cleaning up build artifacts ======"
	rm -rf $(BUILD_DIR) $(BIN_DIR) $(LIB_OUT_DIR)
	rm -f $(GENERATED_KERNEL_ASM) $(GENERATED_BOOT_ASM) $(MAIN_ASM_FINAL_TARGET)


# =============================================================================
# Build Rules
# =============================================================================

# --- 1. Final Program ROM Assembly ---
# Depends on all assembly sources AND the microcode ROM being built first.
$(PROGRAM_ROM): $(GENERATED_BOOT_ASM) $(GENERATED_KERNEL_ASM) $(MAIN_ASM_FINAL_TARGET) $(ALL_ASM_FILES) $(MICROCODE_ROM) assembler/build.json
	@echo "====== Assembling Final Program ROM ======"
	$(ASSEMBLER) assembler/build.json

# --- 2. Microcode ROM Assembly ---
$(MICROCODE_ROM): $(MICROCODE_SOURCES)
	@echo "====== Assembling Microcode ROM ======"
	@mkdir -p $(@D)
	$(MICROCODE_ASSEMBLER) $(MICROCODE_SOURCES)

# --- 3. Install Compiled Main Program ---
# Copies the temporary compiled file to its final destination.
$(MAIN_ASM_FINAL_TARGET): $(MAIN_ASM_TEMP_TARGET)
	@echo "====== Installing compiled program: $< -> $@ ======"
	cp $< $@

# --- 4. Main Program Compilation (Temporary) ---
$(MAIN_ASM_TEMP_TARGET): $(SRC_DIR)/$(SRC).stacks $(COMPILED_LIBS)
	@echo "====== Compiling Main Program: $(SRC).stacks ======"
	@mkdir -p $(@D)
	$(COMPILER) $< -o $@

# --- 5. Stacks Library Compilation ---
$(LIB_OUT_DIR)/%.smod: $(LIB_SRC_DIR)/%.stacks
	@echo "====== Compiling Stacks Library: $< ======"
	$(COMPILER) $< --module

# --- 5a. Explicit Library Dependencies ---
# Make needs to be told when one library includes another.
$(LIB_OUT_DIR)/parser_tools.smod: $(LIB_OUT_DIR)/std_stern_io.smod

# --- 6. Stacks Kernel Module Compilation ---
$(INCL_DIR)/%.stacks.asm: $(KERNEL_STACKS_SRC_DIR)/%.stacks $(COMPILED_LIBS)
	@echo "====== Compiling Stacks Kernel Module: $< ======"
	$(COMPILER) $< -o $@ --block

# --- 7. Stacks Boot File Compilation ---
$(ASM_DIR)/%.stacks.asm: $(BOOT_FILES_SRC_DIR)/%.stacks $(COMPILED_LIBS)
	@echo "====== Compiling Stacks Boot File: $< ======"
	$(COMPILER) $< -o $@

# --- Dynamic Target Handling ---
$(MAIN_PROGRAMS):
	@: # No-op phony target

# This links the phony program targets to the intermediate compiled file.
$(MAIN_ASM_TEMP_TARGET): $(MAIN_PROGRAMS)