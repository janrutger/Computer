import json

class ROM:
    """
    Manages the microcode ROM data and handles JSON serialization.
    """
    def __init__(self):
        self.routines = {}

    def add_routine(self, routine_data):
        """
        Adds a parsed routine to the ROM, resolving labels, args, and comments.
        """
        routine_id = routine_data['id']
        routine_name = routine_data['name']
        code = routine_data['code']
        branch_instructions = {"bra", "brz", "brn", "beq", "brs"}

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
                    if not args:
                        raise SyntaxError(f"Branch instruction '{instruction_name}' requires an argument.")
                    target_label = args[0]
                    if target_label not in label_map:
                        raise SyntaxError(f"Undefined label '{target_label}' in routine '{routine_id}'")
                    
                    target_index = label_map[target_label]
                    offset = target_index - (current_index + 1)
                    args[0] = f"{offset:+}"
                
                # Translate runtime arguments ($1, $2)
                translated_args = []
                for arg in args:
                    if arg == '$1':
                        translated_args.append('arg1')
                    elif arg == '$2':
                        translated_args.append('arg2')
                    elif arg.startswith('R') and len(arg) == 2 and arg[1].isdigit():
                        # Translate GPRs (R0-R9) to their numeric equivalent (0-9)
                        translated_args.append(arg[1])
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
            "code": final_code
        }

    def load_from_file(self, file_path):
        """
        Loads an existing ROM file for the .append directive.
        """
        try:
            with open(file_path, 'r') as f:
                self.routines = json.load(f)
        except FileNotFoundError:
            raise FileNotFoundError(f"Append file not found: {file_path}")

    def save_to_file(self, file_path):
        """
        Saves the ROM to a standard JSON file.
        """
        with open(file_path, 'w') as f:
            # Sort keys for consistent, predictable output
            sorted_routines = dict(sorted(self.routines.items()))
            json.dump(sorted_routines, f, indent=4)