import re

# --- Validation Definitions ---

VALID_GPRS = {f"R{i}" for i in range(10)}
VALID_SRS = {"PC", "SP", "Ra", "Rb"}
VALID_REGISTERS = VALID_GPRS.union(VALID_SRS)
VALID_RUNTIME_ARGS = {"$1", "$2"}

def is_register(arg): return arg in VALID_REGISTERS
def is_gpr(arg): return arg in VALID_GPRS
def is_sr(arg): return arg in VALID_SRS
def is_runtime_arg(arg): return arg in VALID_RUNTIME_ARGS
def is_label(arg): return arg.isidentifier() # Simple check for label syntax
def is_numeric(arg): return arg.isnumeric()
def is_bool_str(arg): return arg.upper() in ["TRUE", "FALSE"]
def is_cpu_state(arg): return arg.upper() in ["FETCH", "DECODE", "EXECUTE", "HALT"]
def is_alu_op(arg): return arg.upper() in ["ADD", "SUB", "MUL", "DIV", "INC", "DEC", "CMP"]
def is_branch_flag(arg): return arg.upper() in ["A", "E", "Z", "N", "S"]

# Arg types: REG, GPR, SR, RUNTIME, LABEL, NUM, BOOL, STATE
# A list defines valid types for that position, e.g., [is_gpr, is_runtime_arg]
ARG_VALIDATORS = {
    "read_mem_reg"  : [[is_register, is_runtime_arg], [is_register, is_runtime_arg]],
    "read_mem_adres": [[is_numeric,  is_runtime_arg], [is_register, is_runtime_arg]],
    "load_immediate": [[is_register, is_runtime_arg], [is_numeric,  is_runtime_arg]],
    "move_reg"      : [[is_register, is_runtime_arg], [is_register, is_runtime_arg]],
    "store_mem_reg" : [[is_register, is_runtime_arg], [is_register, is_runtime_arg]],
    "store_mem_adres": [[is_numeric, is_runtime_arg], [is_register, is_runtime_arg]],
    "branch": [[is_branch_flag], [is_label]],
    "set_cpu_state" : [[is_cpu_state]],
    "set_status_bit": [[is_bool_str]],
    "alu": [[is_alu_op]],
}

VALID_INSTRUCTIONS = {name: len(validators) for name, validators in ARG_VALIDATORS.items()}
VALID_INSTRUCTIONS.update({"nop": 0})



class Parser:
    """
    Parses a .uasm microcode assembly file.
    """
    def __init__(self, file_path):
        self.file_path = file_path
        self.lines = self._read_lines()
        self.directives = {}
        self.routines = {}

    def _read_lines(self):
        with open(self.file_path, 'r') as f:
            return f.readlines()

    def parse(self):
        active_lines = [line for line in self.lines if not line.strip().startswith('#')]
        self._parse_directives(active_lines)
        self._parse_routines(active_lines)

    def _parse_directives(self, lines):
        for line in lines:
            stripped_line = line.strip()
            if stripped_line.startswith('.name'):
                match = re.match(r'\.name\s+"(.*?)"', stripped_line)
                if match: self.directives['name'] = match.group(1)
            elif stripped_line.startswith('.append'):
                match = re.match(r'\.append\s+"(.*?)"', stripped_line)
                if match: self.directives['append'] = match.group(1)
            elif stripped_line.startswith('.registers'):
                parts = stripped_line.split()
                if len(parts) > 1:
                    self.directives['registers'] = parts[1:]
                else:
                    raise SyntaxError("Invalid .registers directive: must be followed by register names")

    def _parse_routines(self, lines):
        i = 0
        while i < len(lines):
            stripped_line = lines[i].strip()
            if not stripped_line or stripped_line.startswith('.'):
                i += 1
                continue

            if stripped_line.startswith('def'):
                match = re.match(r'def\s+(\w+)=(\w+)(.*)', stripped_line)
                if not match:
                    raise SyntaxError(f"Invalid def syntax: {stripped_line}")
                
                routine_id, routine_name, rest = match.groups()
                replace_flag = '/replace' in rest

                if routine_id in self.routines and not replace_flag:
                    raise SyntaxError(f"Duplicate routine ID: {routine_id}")

                # Find the routine body
                start_brace_index = stripped_line.find('{')
                if start_brace_index == -1:
                    raise SyntaxError(f"Expected '{{ ' after def: {stripped_line}")

                routine_body_lines = []
                brace_level = 1 # Start with the opening brace of the def
                j = i + 1 # Start searching from the next line

                while j < len(lines) and brace_level > 0:
                    current_line = lines[j]
                    brace_level += current_line.count('{')
                    brace_level -= current_line.count('}')
                    routine_body_lines.append(current_line)
                    j += 1
                
                if brace_level != 0:
                    raise SyntaxError(f"Unmatched braces in routine '{routine_id}'")

                # Extract content between braces and clean up
                cleaned_body = []
                if routine_body_lines:
                    # Handle the first line (after the opening brace)
                    first_body_line = routine_body_lines[0].split('{', 1)[-1].strip()
                    if first_body_line:
                        cleaned_body.append(first_body_line)
                    
                    # Add intermediate lines
                    for k in range(1, len(routine_body_lines) - 1):
                        cleaned_body.append(routine_body_lines[k].strip())

                    # Handle the last line (before the closing brace)
                    if len(routine_body_lines) > 1: # Check if there's a distinct last line
                        last_body_line = routine_body_lines[-1].rsplit('}', 1)[0].strip()
                        if last_body_line:
                            cleaned_body.append(last_body_line)
                    elif not first_body_line: # Case for def {} on a single line with no content
                        pass # Already handled by first_body_line
                
                parsed_code, routine_format = self._parse_routine_code(cleaned_body)

                self.routines[routine_id] = {
                    'id': routine_id,
                    'name': routine_name,
                    'replace': replace_flag,
                    'format': routine_format,
                    'code': parsed_code
                }
                i = j # Move index past the processed routine
            else:
                i += 1 # Move to the next line if not a def

    def _parse_routine_code(self, code_lines):
        parsed_code = []
        routine_format = "zero" # Default format
        for line in code_lines:
            line = line.strip()
            if not line: continue

            if line.startswith('.format'):
                parts = line.split()
                if len(parts) == 2:
                    routine_format = parts[1]
                else:
                    raise SyntaxError(f"Invalid .format directive: {line}")
                continue

            comment = None
            if ';' in line:
                parts = line.split(';', 1)
                line, comment = parts[0].strip(), parts[1].strip()
            if line.startswith(':'):
                parsed_code.append({'type': 'label', 'name': line[1:]})
                continue
            match = re.match(r'(\w+)\((.*?)\)', line)
            if not match:
                if line: raise SyntaxError(f"Invalid instruction format: {line}")
                continue
            instruction_name, args_str = match.groups()
            args = [arg.strip() for arg in args_str.split(',') if arg.strip()] if args_str else []
            if instruction_name not in VALID_INSTRUCTIONS:
                raise SyntaxError(f"Unknown instruction: '{instruction_name}'")
            expected_args = VALID_INSTRUCTIONS[instruction_name]
            if len(args) != expected_args:
                raise SyntaxError(f"'{instruction_name}' expects {expected_args} args, got {len(args)}.")
            if instruction_name in ARG_VALIDATORS:
                validators = ARG_VALIDATORS[instruction_name]
                for i, arg in enumerate(args):
                    if not any(validator(arg) for validator in validators[i]):
                        raise SyntaxError(f"Invalid arg '{arg}' for '{instruction_name}' at pos {i}.")
            parsed_code.append({'type': 'instruction', 'name': instruction_name, 'args': args, 'comment': comment})
        return parsed_code, routine_format

