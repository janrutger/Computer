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
APPS_DIR := $(ASM_DIR)/apps

# --- Tools ---
COMPILER := python3 compiler/compiler.py
ASSEMBLER := python3 assembler/assembler.py
MICROCODE_ASSEMBLER := python3 $(MICROCODE_DIR)/assembler.py

# --- Main Programs ---
MAIN_PROGRAMS := main fly maze chaos3 chaos3a chaos3b turtle koch fib conway barnsly taylor pi bubble test etb keypress perceptron ml_xor ml_hunter test_dq veins
DEFAULT_PROGRAM := $(firstword $(MAIN_PROGRAMS))

# --- Target Calculation ---
KNOWN_TARGETS := all run run-m1 run-r3 debug clean
SRC_TARGET := $(filter-out $(KNOWN_TARGETS),$(MAKECMDGOALS))
SRC := $(if $(SRC_TARGET),$(SRC_TARGET),$(DEFAULT_PROGRAM))

# --- Output Files ---
PROGRAM_ROM := $(BIN_DIR)/program.bin
MICROCODE_ROM := $(BIN_DIR)/stern_rom.json

# =============================================================================
# Source File Discovery
# =============================================================================

LIB_STACKS_SOURCES    := $(wildcard $(LIB_SRC_DIR)/*.stacks)
KERNEL_STACKS_SOURCES := $(wildcard $(KERNEL_STACKS_SRC_DIR)/*.stacks)
BOOT_FILES_SOURCES    := $(wildcard $(BOOT_FILES_SRC_DIR)/*.stacks)
MAIN_PROGRAMS_SOURCES := $(addsuffix .stacks, $(addprefix $(SRC_DIR)/, $(MAIN_PROGRAMS)))
ALL_ASM_FILES         := $(wildcard $(ASM_DIR)/**/*.asm)
MICROCODE_SOURCES     := $(MICROCODE_DIR)/base_rom.uasm

# --- Define paths for generated files ---
COMPILED_LIBS := $(patsubst $(LIB_SRC_DIR)/%.stacks,$(LIB_OUT_DIR)/%.smod,$(LIB_STACKS_SOURCES))
GENERATED_KERNEL_ASM := $(patsubst $(KERNEL_STACKS_SRC_DIR)/%.stacks,$(INCL_DIR)/%.stacks.asm,$(KERNEL_STACKS_SOURCES))
GENERATED_BOOT_ASM   := $(patsubst $(BOOT_FILES_SRC_DIR)/%.stacks,$(ASM_DIR)/%.stacks.asm,$(BOOT_FILES_SOURCES))
COMPILED_APPS_ASM    := $(patsubst $(SRC_DIR)/%.stacks,$(APPS_DIR)/%.asm,$(MAIN_PROGRAMS_SOURCES))


# Prevent Make from deleting the compiled library files as 'intermediate' files.
.SECONDARY: $(COMPILED_LIBS)


# =============================================================================
# Main Targets
# =============================================================================

.PHONY: all run debug clean $(MAIN_PROGRAMS) directories

all: $(PROGRAM_ROM)

directories:
	@mkdir -p $(BUILD_DIR) $(BIN_DIR) $(LIB_OUT_DIR) $(APPS_DIR) $(BIN_DIR)/apps

run: $(PROGRAM_ROM)
	@echo "====== Running Simulation ======"
	python3 stern-ATX.py

run-m1: $(PROGRAM_ROM)
	@echo "====== Running Simulation (CPU M1) ======"
	python3 stern-ATX.py -cpu m1

run-r3: $(PROGRAM_ROM)
	@echo "====== Running Simulation (CPU R3) ======"
	python3 stern-ATX.py -cpu r3

debug: $(PROGRAM_ROM)
	@echo "====== Running Simulation (Debug) ======"
	python3 stern-ATX.py -debug

clean:
	@echo "====== Cleaning up build artifacts ======"
	rm -rf $(BUILD_DIR) $(BIN_DIR) $(LIB_OUT_DIR) $(APPS_DIR)
	rm -f $(GENERATED_KERNEL_ASM) $(GENERATED_BOOT_ASM) $(COMPILED_APPS_ASM)


# =============================================================================
# Build Rules
# =============================================================================

# --- 1. Final Program ROM Assembly ---
# Depends on all assembly sources AND the microcode ROM being built first.
$(PROGRAM_ROM): directories $(GENERATED_BOOT_ASM) $(GENERATED_KERNEL_ASM) $(COMPILED_APPS_ASM) $(ALL_ASM_FILES) $(MICROCODE_ROM) assembler/buildV2.json
	@echo "====== Assembling Final Program ROM ======"
	$(ASSEMBLER) assembler/buildV2.json

# --- 2. Microcode ROM Assembly ---
$(MICROCODE_ROM): $(MICROCODE_SOURCES)
	@echo "====== Assembling Microcode ROM ======"
	@mkdir -p $(@D)
	$(MICROCODE_ASSEMBLER) $(MICROCODE_SOURCES)

# --- 3. Main Program(s) Compilation ---
$(APPS_DIR)/%.asm: $(SRC_DIR)/%.stacks $(COMPILED_LIBS)
	@echo "====== Compiling Main Program: $< ======"
	@mkdir -p $(@D)
	$(COMPILER) $< -o $@

# --- 4. Stacks Library Compilation ---
$(LIB_OUT_DIR)/%.smod: $(LIB_SRC_DIR)/%.stacks
	@echo "====== Compiling Stacks Library: $< ======"
	@mkdir -p $(@D)
	$(COMPILER) $< --module

# --- 4a. Explicit Library Dependencies ---
# Make needs to be told when one library includes another.
$(LIB_OUT_DIR)/parser_tools.smod:    $(LIB_OUT_DIR)/std_stern_io.smod

$(LIB_OUT_DIR)/fixed_point_lib.smod: $(LIB_OUT_DIR)/std_stern_io.smod
$(LIB_OUT_DIR)/fixed_point_lib.smod: $(LIB_OUT_DIR)/std_string.smod
$(LIB_OUT_DIR)/fixed_point_lib.smod: $(LIB_OUT_DIR)/math_lib.smod

$(LIB_OUT_DIR)/array_lib.smod:       $(LIB_OUT_DIR)/std_stern_io.smod

$(LIB_OUT_DIR)/game_lib.smod:        $(LIB_OUT_DIR)/std_stern_io.smod
$(LIB_OUT_DIR)/game_lib.smod:        $(LIB_OUT_DIR)/std_string.smod
$(LIB_OUT_DIR)/game_lib.smod:        $(LIB_OUT_DIR)/std_heap.smod

$(LIB_OUT_DIR)/vvm_core_lib.smod:    $(LIB_OUT_DIR)/vvm_env_lib.smod


# --- 5. Stacks Kernel Module Compilation ---
$(INCL_DIR)/%.stacks.asm: $(KERNEL_STACKS_SRC_DIR)/%.stacks $(COMPILED_LIBS)
	@echo "====== Compiling Stacks Kernel Module: $< ======"
	@mkdir -p $(@D)
	$(COMPILER) $< -o $@ --block

# --- 6. Stacks Boot File Compilation ---
$(ASM_DIR)/%.stacks.asm: $(BOOT_FILES_SRC_DIR)/%.stacks $(COMPILED_LIBS)
	@echo "====== Compiling Stacks Boot File: $< ======"
	@mkdir -p $(@D)
	$(COMPILER) $< -o $@