import argparse
import json
import os

from parser import Parser

from rom import ROM

def main():
    """
    Main function for the microcode assembler.
    """
    parser = argparse.ArgumentParser(
        description="Assembler for the CPU's microcode."
    )
    parser.add_argument(
        "input_file",
        help="The input assembly file to process."
    )
    parser.add_argument(
        "-o", "--output",
        help="The output JSON file. If not provided, it will be derived from the .name directive in the source file."
    )
    args = parser.parse_args()

    print(f"Assembling {args.input_file}...")

    if not os.path.exists(args.input_file):
        print(f"Error: Input file '{args.input_file}' not found.")
        return

    try:
        # 1. Parse the source file
        parser = Parser(args.input_file)
        parser.parse()

        # 2. Initialize the ROM
        rom = ROM()

        # 3. Handle .append directive
        if 'append' in parser.directives:
            rom.load_from_file(parser.directives['append'])

        # 4. Add/replace routines from the source file
        for routine_id, routine_data in parser.routines.items():
            if routine_data['replace'] or routine_id not in rom.routines:
                rom.add_routine(routine_data)
            elif routine_id in rom.routines and not routine_data['replace']:
                 raise SyntaxError(f"Duplicate routine ID '{routine_id}' found. Use /replace to overwrite.")

        # 5. Determine output file name
        output_dir = "bin"
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)

        output_filename = args.output
        if not output_filename:
            if 'name' in parser.directives:
                output_filename = f"{parser.directives['name']}.json"
            else:
                base_name = os.path.splitext(os.path.basename(args.input_file))[0]
                output_filename = f"{base_name}.json"
        
        output_file = os.path.join(output_dir, output_filename)

        # 6. Save the final ROM
        rom.save_to_file(output_file, parser.directives)
        print(f"Assembly complete. ROM saved to {output_file}")

    except (SyntaxError, FileNotFoundError) as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
