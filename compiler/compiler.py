import argparse
from lexer import Lexer
from parser import Parser
from codegen import CodeGenerator, AsmGenerator
from simplgen import SimplGenerator
import os
import json

def main():
    parser = argparse.ArgumentParser(description='Compile a source file to assembly.')
    parser.add_argument('input_file', help='The source file to compile.')
    parser.add_argument('-o', '--output', help='The output assembly file.')
    
    parser.add_argument(
        '--target',
        choices=['asm', 'simpl'],
        default='asm',
        help='Target architecture: "asm" (default) or "simpl".'
    )

    # Add the flag to compile as a library module
    parser.add_argument(
        '-module', '--module',
        action='store_true',  # Defines it as a boolean flag (True if present)
        default=False,        # Sets the default value if the flag is omitted
        help='Compile the file as a module (run as main program).'
    )
    parser.add_argument(
        '--block',
        action='store_true',
        default=False,
        help='Compile the file as a non-executable code block.'
    )
    

    args = parser.parse_args()

    is_module_compilation = args.module

    if args.target == 'simpl':
        input_filename = os.path.basename(args.input_file)
        base_name = os.path.splitext(input_filename)[0]
        
        if not args.output:
            output_dir = "compiler/src/simpl_libs"
            args.output = os.path.join(output_dir, f"simpl_{base_name}_lib.stacks")
            
        macro_name = f"load_simpl_{base_name}"

    elif args.module:
        # For modules, output is .smod and .sym, not .asm
        # Get just the filename from the input path (e.g., "math_lib.stacks")
        input_filename = os.path.basename(args.input_file)
        # Get the module name without extension (e.g., "math_lib")
        module_name = os.path.splitext(input_filename)[0]
        
        # Define the output directory for libraries
        output_dir = "compiler/lib"
        smod_output = os.path.join(output_dir, f"{module_name}.smod")
        sym_output = os.path.join(output_dir, f"{module_name}.sym")
    else:
        # If no output file is specified for a normal compile, create .asm
        if not args.output:
            base_name = os.path.splitext(args.input_file)[0]
            args.output = base_name + '.asm'


    try:
        with open(args.input_file, 'r') as f:
            source = f.read()
    except FileNotFoundError:
        print(f"Error: Input file not found: {args.input_file}")
        exit(1)

    lexer = Lexer(source)
    parser = Parser(lexer)
    ast = parser.parse()

    if parser.errors or lexer.errors:
        print("Errors during parsing, aborting code generation.")
        if lexer.errors:
            print("\n--- LEXER ERRORS ---")
            for err in lexer.errors:
                print(err)
        if parser.errors:
            print("\n--- PARSER ERRORS ---")
            for err in parser.errors:
                print(err)
        exit(1)
    
    try:
        if args.target == 'simpl':
            codegen = SimplGenerator()
            output = codegen.generate(ast, macro_name=macro_name)
            
            os.makedirs(os.path.dirname(args.output), exist_ok=True)
            with open(args.output, 'w') as f:
                f.write(output)
            print(f"Successfully compiled '{args.input_file}' to '{args.output}' (Target: SIMPL).")

        elif is_module_compilation:
            codegen = AsmGenerator()
            assembly = codegen.generate(ast, is_module_compilation, args.block)
            # Write the .smod file
            os.makedirs(os.path.dirname(smod_output), exist_ok=True)
            with open(smod_output, 'w') as f:
                f.write(assembly)
            print(f"Successfully compiled module to '{smod_output}'.")

            # Write the .sym file
            constants_to_export = {
                const_name: node.value
                for const_name, node in codegen.constants.items()
            }
            symbols_to_export = {
                "functions": list(codegen.function_symbols),
                "variables": list(codegen.symbols.values()),
                "constants": constants_to_export
            }
            with open(sym_output, 'w') as f:
                json.dump(symbols_to_export, f, indent=2)
            print(f"Successfully wrote symbols to '{sym_output}'.")
        else:
            codegen = AsmGenerator()
            assembly = codegen.generate(ast, is_module_compilation, args.block)
            with open(args.output, 'w') as f:
                f.write(assembly)
            print(f"Successfully compiled '{args.input_file}' to '{args.output}'.")

    except Exception as e:
        print(f"--- CODEGEN ERROR---\n{e}")
        exit(1)

if __name__ == '__main__':
    main()
