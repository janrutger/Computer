import json
import os
import sys

def generate_vscode_grammar(rom_path, template_path, output_path):
    """
    Generates a VS Code TextMate grammar by injecting dynamic instructions
    and registers from a stern_rom.json file into a template.
    """
    # 1. Load the ROM file
    try:
        with open(rom_path, 'r') as f:
            rom_data = json.load(f)
    except FileNotFoundError:
        print(f"Error: ROM file not found at {rom_path}. Cannot generate grammar.", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError:
        print(f"Error: Could not parse {rom_path}. Is it valid JSON?", file=sys.stderr)
        sys.exit(1)

    # 2. Extract instructions and registers
    instructions = []
    for data in rom_data.get("instructions", {}).values():
        mnemonic = data.get("name")
        if mnemonic:
            instructions.append(mnemonic)

    registers = list(rom_data.get("register_map", {}).keys())
    # Also include the base register names
    registers.extend([f"R{i}" for i in range(10)])
    # Add special registers
    registers.extend(["PC", "SP"])

    # Remove duplicates and sort for consistency
    unique_instructions = sorted(list(set(instructions)), key=str.lower)
    unique_registers = sorted(list(set(registers)), key=str.lower)

    # 3. Create the regex patterns
    # The \b ensures we match whole words only
    instruction_regex = f"(?i)^\\s*\\b({'|'.join(unique_instructions)})\\b"
    register_regex = f"(?i)\\b({'|'.join(unique_registers)})\\b"

    # 4. Load the template and substitute the placeholders
    try:
        with open(template_path, 'r') as f:
            template_content = f.read()
    except FileNotFoundError:
        print(f"Error: Template file not found at {template_path}. Cannot generate grammar.", file=sys.stderr)
        sys.exit(1)

    # We need to escape the backslashes in our regex strings so they are written correctly
    # into the JSON file. A single backslash in the regex (e.g., \b) must become a
    # double backslash in the JSON string (\\b).
    escaped_instruction_regex = instruction_regex.replace('\\', '\\\\')
    escaped_register_regex = register_regex.replace('\\', '\\\\')
    grammar_content = template_content.replace("%%INSTRUCTION_REGEX%%", escaped_instruction_regex)
    grammar_content = grammar_content.replace("%%REGISTER_REGEX%%", escaped_register_regex)

    # 5. Write the final grammar file
    try:
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, 'w') as f:
            f.write(grammar_content)
        print(f"Successfully generated VS Code grammar at {output_path}")
    except IOError as e:
        print(f"Error writing to {output_path}: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    # Get the absolute path of the directory containing this script
    script_dir = os.path.dirname(os.path.abspath(__file__))
    # The extension root is one level up from the scripts directory
    extension_root = os.path.abspath(os.path.join(script_dir, '..'))
    # The project root is one level up from the extension directory
    project_root = os.path.abspath(os.path.join(extension_root, '..'))

    # Construct absolute paths for all required files
    rom_file = os.path.join(project_root, 'bin', 'stern_rom.json')
    template_file = os.path.join(extension_root, 'syntaxes', 'stern-asm.tmLanguage.template.json')
    output_file = os.path.join(extension_root, 'syntaxes', 'stern-asm.tmLanguage.json')

    generate_vscode_grammar(rom_file, template_file, output_file)
