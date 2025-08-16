from FileIO import readFile, writeBin
import sys # Import sys for stderr
import json
import os 
 
# --- Optional: Define a custom exception for cleaner handling ---
class AssemblyError(Exception):
    """Custom exception for assembly errors."""
    pass
# --- End Optional ---

class Assembler:
    def __init__(self, var_pointer: int, rom_path="bin/stern_rom.json"):
        self.NextVarPointer = var_pointer
        self.instructions = {}
        self.registers = {}
        self._load_rom(rom_path)

        # Custom map for special character names that have standard ASCII values
        self.special_char_map = {
            "null": 0,    # ASCII for Null character
            "space": 32,  # ASCII for space
            "BackSpace": 8, # ASCII for Backspace (BS)
            "Return": 13,   # ASCII for Carriage Return (CR)
            "Tab": 9,       # ASCII for Horizontal Tab (HT)
            "Newline": 10,  # ASCII for Line Feed (LF)
            # Add other common control characters if needed
        }

        self.symbols = {} # Global symbols (@, $)
        self.labels = {}  # Local labels (:) - cleared per file
        self.constants = {} # Global constants (~) - NEW
        self.assembly = []
        self.binary = []
        self.source = []
        self._current_filename = "" # Store filename for error messages
        self._source_dir = "" # Store source directory for includes
        self._line_map = {} # Map assembly index to (orig_line, orig_file)

        # --- State for saving/restoring ---
        self._saved_symbols = None
        self._saved_constants = None
        self._saved_next_var_pointer = None

    def _load_rom(self, rom_path):
        if not os.path.exists(rom_path):
            raise FileNotFoundError(f"Assembler ROM file not found at: {rom_path}")
        with open(rom_path, 'r') as f:
            rom_data = json.load(f)
        
        self.registers = rom_data.get("register_map", {})
        # Build instructions map from mnemonic to opcode and format
        for opcode, data in rom_data.get("instructions", {}).items():
            mnemonic = data.get("name").lower() # Use lowercase for assembler mnemonics
            self.instructions[mnemonic] = {
                "opcode": opcode,
                "format": data.get("format", "zero")
            }

    def _error(self, line_num, line_content, message):
        display_line_num = line_num if line_num is not None else '?'
        error_message = f"ERROR in '{self._current_filename}', Line ~{display_line_num}: {message}\n  > {line_content.strip()}"
        raise AssemblyError(error_message)

    def read_source(self, sourcefile):
        try:
            self.source = readFile(sourcefile, 1)
        except FileNotFoundError:
             raise
        except Exception as e:
             raise AssemblyError(f"Could not read source file '{sourcefile}': {e}")

    def include_source(self, include_filename, included_from_line):
        try:
            return readFile(include_filename, 1)
        except FileNotFoundError:
            self._error(included_from_line, f"INCLUDE {os.path.basename(include_filename)}", f"Include file not found: '{include_filename}'")
        except Exception as e:
            self._error(included_from_line, f"INCLUDE {os.path.basename(include_filename)}", f"Could not read include file '{include_filename}': {e}")

    def parse_source(self):
        self.assembly = []
        raw_assembly_lines = []
        files_to_include = []

        for line_num, line in enumerate(self.source, 1):
            stripped_line = line.split(';')[0].strip()
            raw_assembly_lines.append((stripped_line, line_num, self._current_filename))
            if not stripped_line or stripped_line.startswith("#"):
                continue
            if stripped_line.upper().startswith("INCLUDE"):
                parts = stripped_line.split()
                if len(parts) == 2:
                    include_name = parts[1]
                    # Construct path relative to the main source file's directory
                    include_path = os.path.join(self._source_dir, "incl", f"{include_name}.asm")
                    files_to_include.append((include_path, line_num))
                else:
                    self._error(line_num, stripped_line, "INCLUDE instruction requires exactly one filename argument")

        processed_assembly = []
        line_map = {}
        final_assembly_index = 0

        for line_content, orig_line_num, filename in raw_assembly_lines:
            if line_content.upper().startswith("INCLUDE"):
                 include_details = next((inc for inc in files_to_include if inc[1] == orig_line_num), None)
                 if include_details:
                     include_path, include_directive_line_num = include_details
                     try:
                         included_source = self.include_source(include_path, include_directive_line_num)
                         include_filename_simple = os.path.basename(include_path)
                         for include_line_num, include_line in enumerate(included_source, 1):
                             stripped_include_line = include_line.split(';')[0].strip()
                             if not stripped_include_line or stripped_include_line.startswith("#"):
                                 continue
                             processed_assembly.append(stripped_include_line)
                             line_map[final_assembly_index] = (include_line_num, include_filename_simple)
                             final_assembly_index += 1
                     except AssemblyError:
                          raise
                     except Exception as e:
                          self._error(include_directive_line_num, line_content, f"Unexpected error processing include '{include_path}': {e}")
            else:
                 processed_assembly.append(line_content)
                 line_map[final_assembly_index] = (orig_line_num, filename)
                 final_assembly_index += 1

        self.assembly = processed_assembly
        self._line_map = line_map

    def parse_symbols(self, prg_start):
        pc = prg_start
        current_pass_labels = {}

        for idx, line in enumerate(self.assembly):
            orig_line_num, orig_filename = self._line_map.get(idx, (idx + 1, self._current_filename))

            if not line or line.startswith("#"):
                continue

            parts = line.split(maxsplit=2)
            directive = parts[0]

            try:
                if directive.upper() == "EQU":
                    if len(parts) != 3:
                        self._error(orig_line_num, line, "EQU directive requires a constant name and a value")
                    const_name = parts[1]
                    value_str = parts[2]

                    if not const_name.startswith("~"):
                        self._error(orig_line_num, line, f"Constant name '{const_name}' must start with '~'.")

                    if const_name in self.constants:
                        self._error(orig_line_num, line, f"Constant '{const_name}' already defined.")

                    resolved_value = None
                    value_str_stripped = value_str.strip()
                    if value_str_stripped.isdigit() or (value_str_stripped.startswith(('-', '+')) and value_str_stripped[1:].isdigit()):
                        resolved_value = str(value_str_stripped)
                    elif value_str_stripped.startswith("\\"):
                        char_name = value_str_stripped[1:]
                        if char_name in self.special_char_map:
                            resolved_value = str(self.special_char_map[char_name])
                        elif len(char_name) == 1:
                            resolved_value = str(ord(char_name))
                        else:
                            self._error(orig_line_num, line, f"Invalid character literal '{value_str_stripped}'. Use \\ followed by a single character or a recognized special character name (e.g., \\space).")
                    else:
                        self._error(orig_line_num, line, f"Invalid value '{value_str}' for EQU.")

                    if resolved_value is not None:
                        self.constants[const_name] = resolved_value
                    continue

                elif directive.startswith("@"):
                    if directive in self.symbols: self._error(orig_line_num, line, f"Symbol '{directive}' already defined.")
                    self.symbols[directive] = pc
                elif directive.startswith(":"):
                    if directive in current_pass_labels: self._error(orig_line_num, line, f"Label '{directive}' already defined.")
                    self.labels[directive] = pc
                    current_pass_labels[directive] = pc
                elif directive.startswith("."):
                    if len(parts) < 3: self._error(orig_line_num, line, "Directive '.' requires a symbol name and size")
                    symbol_name, size_str = parts[1], parts[2]
                    try:
                        size = int(size_str)
                        if size <= 0: raise ValueError("Size must be positive")
                    except ValueError:
                         self._error(orig_line_num, line, f"Invalid size '{size_str}'.")

                    if not symbol_name.startswith("$"): self._error(orig_line_num, line, f"Variable symbol '{symbol_name}' must start with '. ")
                    if symbol_name in self.symbols: self._error(orig_line_num, line, f"Symbol '{symbol_name}' already defined.")

                    self.symbols[symbol_name] = self.NextVarPointer
                    self.NextVarPointer += size
                elif directive.startswith("%"):
                    continue
                elif directive.upper() == "INCLUDE":
                     continue
                else:
                    pc += 1
            except AssemblyError:
                 raise
            except Exception as e:
                 self._error(orig_line_num, line, f"Unexpected error during symbol parsing: {e}")

    def get_adres(self, label: str, line_num: int, line_content: str) -> str:
        if label.startswith(":") and label in self.labels:
            return str(self.labels[label])
        elif label.startswith(("@", "$")) and label in self.symbols:
            return str(self.symbols[label])
        else:
            self._error(line_num, line_content, f"Unknown Symbol, Label, or invalid Address reference '{label}'.")

    def get_value(self, value_str: str, line_num: int, line_content: str) -> str:
        value_str = value_str.strip()
        if not value_str: self._error(line_num, line_content, "Value cannot be empty.")

        if value_str.startswith("~"):
            if value_str in self.constants: return str(self.constants[value_str])
            else: self._error(line_num, line_content, f"Unknown constant '{value_str}'.")

        elif value_str.isdigit() or (value_str.startswith(('-', '+')) and value_str[1:].isdigit()):
            return str(value_str)
        elif value_str.startswith("\\"):
            char_name = value_str[1:]
            if char_name in self.special_char_map:
                return str(self.special_char_map[char_name])
            elif len(char_name) == 1:
                return str(ord(char_name))
            else:
                self._error(line_num, line_content, f"Invalid character literal '\\{char_name}'. Use \\ followed by a single character or a recognized special character name (e.g., \\space).")
        elif value_str.startswith(("@", "$")):
             if value_str in self.symbols: return str(self.symbols[value_str])
             else:
                 if value_str.startswith(":") and value_str in self.labels:
                      print(f"WARNING (Line ~{line_num}): Using label '{value_str}' as immediate value. Ensure this is intended.\n  > {line_content.strip()}", file=sys.stderr)
                      return str(self.labels[value_str])
                 else: self._error(line_num, line_content, f"Unknown symbol '{value_str}' used as value.")
        else: self._error(line_num, line_content, f"Invalid value format '{value_str}'.")

    def generate_binary(self, prg_start):
        self.binary = []
        pc = prg_start
        pc_to_idx_map = {}

        temp_pc = prg_start
        for idx, line in enumerate(self.assembly):
            if not line or line.startswith(("@", ".", ":", "%", "#")) or line.upper() == "INCLUDE" or line.upper().startswith("EQU"):
                continue
            else:
                pc_to_idx_map[temp_pc] = idx
                temp_pc += 1

        for idx, line in enumerate(self.assembly):
            orig_line_num, orig_filename = self._line_map.get(idx, (idx + 1, self._current_filename))

            instruction = line.split()
            if not instruction: continue

            op = instruction[0].lower()

            if op.startswith(("@", ".", ":", "#")) or op.upper() == "INCLUDE" or op.upper() == "EQU":
                continue

            current_line_num_for_error = orig_line_num
            current_line_content_for_error = line

            try:
                if op.startswith("%"):
                    if len(instruction) < 3:
                         self._error(current_line_num_for_error, current_line_content_for_error, "Directive '%' requires a target symbol and at least one value")
                    target_symbol = instruction[1]
                    if not target_symbol.startswith("$") or target_symbol not in self.symbols:
                         self._error(current_line_num_for_error, current_line_content_for_error, f"Invalid or undefined target symbol '{target_symbol}' for '%'.")

                    adres = int(self.symbols[target_symbol])
                    values_to_write = instruction[2:]

                    for value_str in values_to_write:
                        value_to_write = self.get_value(value_str, current_line_num_for_error, current_line_content_for_error)
                        newLine = (adres, value_to_write)
                        self.binary.append(newLine)
                        adres += 1
                    continue

                op_info = self.instructions.get(op)
                if not op_info:
                    self._error(current_line_num_for_error, current_line_content_for_error, f"Unknown instruction '{op}'")

                op_format = op_info['format']
                opcode = op_info['opcode']
                args = instruction[1:]
                num_args = len(args)
                binary_code = opcode

                if op_format == 'zero':
                    if num_args != 0: self._error(current_line_num_for_error, current_line_content_for_error, f"Instruction '{op}' expects 0 arguments, got {num_args}")
                
                elif op_format == 'one_reg':
                    if num_args != 1: self._error(current_line_num_for_error, current_line_content_for_error, f"Instruction '{op}' expects 1 register argument, got {num_args}")
                    reg = args[0].upper()
                    if reg not in self.registers: self._error(current_line_num_for_error, current_line_content_for_error, f"Invalid register '{reg}'")
                    binary_code += self.registers[reg]

                elif op_format == 'one_addr':
                    if num_args != 1: self._error(current_line_num_for_error, current_line_content_for_error, f"Instruction '{op}' expects 1 address argument, got {num_args}")
                    addr = self.get_adres(args[0], current_line_num_for_error, current_line_content_for_error)
                    binary_code += addr

                elif op_format == 'two_reg_reg':
                    if num_args != 2: self._error(current_line_num_for_error, current_line_content_for_error, f"Instruction '{op}' expects 2 register arguments, got {num_args}")
                    reg1, reg2 = args[0].upper(), args[1].upper()
                    if reg1 not in self.registers: self._error(current_line_num_for_error, current_line_content_for_error, f"Invalid register '{reg1}'")
                    if reg2 not in self.registers: self._error(current_line_num_for_error, current_line_content_for_error, f"Invalid register '{reg2}'")
                    binary_code += self.registers[reg1] + self.registers[reg2]

                elif op_format == 'two_reg_val':
                    if num_args != 2: self._error(current_line_num_for_error, current_line_content_for_error, f"Instruction '{op}' expects a register and a value, got {num_args}")
                    reg, val_str = args[0].upper(), args[1]
                    if reg not in self.registers: self._error(current_line_num_for_error, current_line_content_for_error, f"Invalid register '{reg}'")
                    value = self.get_value(val_str, current_line_num_for_error, current_line_content_for_error)
                    binary_code += self.registers[reg] + value

                elif op_format == 'two_reg_addr':
                    if num_args != 2: self._error(current_line_num_for_error, current_line_content_for_error, f"Instruction '{op}' expects a register and an address, got {num_args}")
                    reg, addr_str = args[0].upper(), args[1]
                    if reg not in self.registers: self._error(current_line_num_for_error, current_line_content_for_error, f"Invalid register '{reg}'")
                    address = self.get_adres(addr_str, current_line_num_for_error, current_line_content_for_error)
                    binary_code += self.registers[reg] + address
                
                else:
                    self._error(current_line_num_for_error, current_line_content_for_error, f"Unsupported instruction format '{op_format}' for instruction '{op}'")

                self.binary.append((pc, binary_code))
                pc += 1

            except (ValueError, IndexError, KeyError) as e:
                 self._error(current_line_num_for_error, current_line_content_for_error, f"Error processing instruction: {e}")
            except AssemblyError:
                 raise
            except Exception as e:
                 self._error(current_line_num_for_error, current_line_content_for_error, f"Unexpected error during binary generation: {e}")

        # try:
        #     writeBin(self.binary, output_file)
        # except Exception as e:
        #      raise AssemblyError(f"Failed to write binary output to '{output_file}': {e}")
    

    def save_state(self):
        self._saved_symbols = self.symbols.copy()
        self._saved_constants = self.constants.copy()
        self._saved_next_var_pointer = self.NextVarPointer

    def restore_state(self):
        if self._saved_symbols is not None and \
           self._saved_constants is not None and \
           self._saved_next_var_pointer is not None:
            self.symbols = self._saved_symbols.copy()
            self.constants = self._saved_constants.copy()
            self.NextVarPointer = self._saved_next_var_pointer

    def assemble(self, filename, prog_start, restore=False):
        
        try:
            self.save_state()

            self._current_filename = filename
            self._source_dir = os.path.dirname(filename)
            self.labels = {}

            self.read_source(filename)
            self.parse_source()
            self.parse_symbols(prog_start)
            self.generate_binary(prog_start)
            print(f"--- Successfully assembled {filename}  ---")

        except FileNotFoundError as e:
             print(f"ERROR: Assembly source file not found: {filename}", file=sys.stderr)
             raise
        except AssemblyError as e:
             print(str(e), file=sys.stderr)
             print(f"--- Assembly failed for {filename} ---")
             raise
        except Exception as e:
             print(f"FATAL ERROR during assembly of {filename}: {e}", file=sys.stderr)
             raise AssemblyError(f"Unexpected FATAL ERROR during assembly of {filename}: {e}") from e
        finally:
            if restore:
                self.restore_state()
        return self.binary


if __name__ == "__main__":
    build_file = "bin/build.json"
    if len(sys.argv) > 1:
        build_file = sys.argv[1]

    try:
        with open(build_file, 'r') as f:
            build_config = json.load(f)
    except FileNotFoundError:
        print(f"ERROR: Build configuration file not found at: {build_file}", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError:
        print(f"ERROR: Invalid JSON in build configuration file: {build_file}", file=sys.stderr)
        sys.exit(1)

    output_file = os.path.join(os.path.dirname(build_file), build_config.get("output", "program.bin"))
    var_start = build_config.get("var_start", 12288) # Default if not specified

    assembler = Assembler(var_start)
    combined_binary = []

    print(f"\n--- Starting multi-file assembly from {build_file} ---")

    for source_entry in build_config.get("sources", []):
        file_path = source_entry.get("file")
        base_address = source_entry.get("base_address", 0)
        restore_symbols = source_entry.get("restore_symbols", False)

        if not file_path:
            print("WARNING: Skipping source entry with missing 'file' path.", file=sys.stderr)
            continue

        # Construct absolute path for the assembly file
        # Assuming assembly files are relative to the assembler.py script or project root
        # For now, let's assume they are relative to the project root as per the build.json example
        abs_file_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), file_path)
        
        print(f"Assembling {file_path} (base address: {base_address})...")
        try:
            # The assemble method already handles its own error printing
            current_binary = assembler.assemble(abs_file_path, base_address, restore_symbols)
            combined_binary.extend(current_binary)
        except (AssemblyError, FileNotFoundError):
            print(f"--- Assembly failed for {file_path}. Halting build. ---", file=sys.stderr)
            sys.exit(1)
        except Exception as e:
            print(f"FATAL ERROR during assembly of {file_path}: {e}", file=sys.stderr)
            sys.exit(1)

    print("\n--- Multi-file assembly process completed. ---")

    print(f"Writing combined binary output to '{output_file}'...")
    try:
        writeBin(combined_binary, output_file)
        print("Binary output written successfully.")
    except Exception as e:
        print(f"ERROR: Failed to write combined binary output to '{output_file}': {e}", file=sys.stderr)
        sys.exit(1)
