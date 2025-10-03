import argparse
from lexer import Lexer
from parser import Parser
from codegen import CodeGenerator
import os

def main():
    parser = argparse.ArgumentParser(description='Compile a source file to assembly.')
    parser.add_argument('input_file', help='The source file to compile.')
    parser.add_argument('-o', '--output', help='The output assembly file.')

    # 👇 Add the new flag here
    parser.add_argument(
        '-module', '--module',
        action='store_true',  # Defines it as a boolean flag (True if present)
        default=False,        # Sets the default value if the flag is omitted
        help='Compile the file as a module (run as main program).'
    )
    

    args = parser.parse_args()

    # If no output file is specified, create one based on the input file name
    if not args.output:
        base_name = os.path.splitext(args.input_file)[0]
        args.output = base_name + '.asm'

    if args.module:
        setModule = True
    else:
        setModule = False


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
        codegen = CodeGenerator()
        assembly = codegen.generate(ast, setModule)

        with open(args.output, 'w') as f:
            f.write(assembly)
        
        print(f"Successfully compiled '{args.input_file}' to '{args.output}'.")

    except Exception as e:
        print(f"--- CODEGEN ERROR---\n{e}")
        exit(1)

if __name__ == '__main__':
    main()
