import json

class ROM:
    """
    Manages the microcode ROM data and handles JSON serialization.
    """
    def __init__(self):
        self.routines = {}
        self.register_map = {}

    def add_routine(self, routine_data):
        """
        Adds a parsed routine to the ROM, resolving labels, args, and comments.
        """
        routine_id = routine_data['id']
        routine_name = routine_data['name']
        routine_format = routine_data['format']
        code = routine_data['code']
        branch_instructions = {"branch"}

        # First pass: build a map of labels to their instruction index
        label_map = {}
        instruction_index = 0
        for item in code:
            if item['type'] == 'label':
                if item['name'] in label_map:
                    raise SyntaxError(f"Duplicate label '{item['name']}' in routine '{routine_id}'")
                label_map[item['name']] = instruction_index
            elif item['type'] == 'instruction':
                instruction_index += 1

        # Second pass: build the final code, calculating offsets and translating args
        final_code = []
        current_index = 0
        for item in code:
            if item['type'] == 'instruction':
                instruction_name = item['name']
                args = list(item['args']) # Make a mutable copy

                if instruction_name in branch_instructions:
                    if len(args) < 2:
                        raise SyntaxError(f"Branch instruction '{instruction_name}' requires two arguments.")
                    target_label = args[1]
                    if target_label not in label_map:
                        raise SyntaxError(f"Undefined label '{target_label}' in routine '{routine_id}'")
                    
                    target_index = label_map[target_label]
                    offset = target_index - (current_index + 1)
                    args[1] = f"{offset:+}"
                
                # Translate runtime arguments ($1, $2) and register names (R0-R9)
                translated_args = []
                for arg in args:
                    if arg == '$1':
                        translated_args.append('arg1')
                    elif arg == '$2':
                        translated_args.append('arg2')
                    elif arg.startswith('R') and len(arg) > 1 and arg[1:].isdigit():
                        # Translate GPRs (R0-R9) to their numeric equivalent (0-9)
                        translated_args.append(arg[1:])
                    else:
                        translated_args.append(arg)
                
                instruction_parts = [instruction_name] + translated_args
                
                instruction_object = {
                    "instruction": tuple(instruction_parts),
                    "comment": item['comment']
                }
                final_code.append(instruction_object)
                current_index += 1
        
        self.routines[routine_id] = {
            "name": routine_name,
            "format": routine_format,
            "code": final_code
        }

    def load_from_file(self, file_path):
        """
        Loads an existing ROM file for the .append directive.
        """
        try:
            with open(file_path, 'r') as f:
                data = json.load(f)
                # Handle both old and new formats
                if 'instructions' in data and 'register_map' in data:
                    self.routines = data['instructions']
                    self.register_map = data['register_map']
                else:
                    self.routines = data
        except FileNotFoundError:
            # It's not an error if the append file doesn't exist yet
            pass
        except json.JSONDecodeError as e:
            raise SyntaxError(f"Error decoding JSON from {file_path}: {e}")

    def save_to_file(self, file_path, directives):
        """
        Saves the ROM to a standard JSON file, including the register map.
        """
        # Create the register map from directives if it exists
        if 'registers' in directives:
            gpr_names = directives['registers']
            self.register_map = {name: str(i) for i, name in enumerate(gpr_names)}

        # Sort routines for consistent, predictable output
        sorted_routines = dict(sorted(self.routines.items()))

        # Final ROM structure
        final_rom = {
            "register_map": self.register_map,
            "instructions": sorted_routines
        }

        with open(file_path, 'w') as f:
            json.dump(final_rom, f, indent=4)
