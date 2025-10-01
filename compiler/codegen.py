# compiler/codegen.py

from .parser import (
    ASTNode,
    ProgramNode,
    NumberNode,
    StringNode,
    WordNode
)
from .lexer import TokenType

class CodeGenerator:
    def __init__(self):
        self.assembly_code = ""
        self.data_section = ""
        self.string_literals = {}
        self.next_string_label = 0

    def generate(self, ast):
        self.assembly_code = ""
        self.data_section = ""
        self.string_literals = {}
        self.next_string_label = 0
        
        # Main code generation
        main_code = self.generate_program(ast)

        # Assemble the final code
        # For now, let's just put data at the end.
        # A proper assembler would handle sections better.
        self.assembly_code = "# .CODE\n" + main_code
        if self.data_section:
            self.assembly_code += "\n# .DATA\n" + self.data_section
        
        return self.assembly_code

    def generate_program(self, node):
        code = ""
        for statement in node.statements:
            code += self.generate_statement(statement)
        return code

    def generate_statement(self, node):
        if isinstance(node, NumberNode):
            return f"    ldi A {node.value}\n    call @push_A\n"
        
        elif isinstance(node, StringNode):
            label = self.add_string_literal(node.value)
            return f"    ldi A ${label}\n    call @push_A\n"

        elif isinstance(node, WordNode):
            return self.generate_word(node)
        
        else:
            raise Exception(f"Unknown AST node type: {type(node)}")

    def generate_word(self, node):
        op = node.value if node.value is not None else node.token.type.value
        
        op_map = {
            '+':    '@rt_add',
            '-':    '@rt_sub',
            '*':    '@rt_mul',
            '//':   '@rt_div',
            '%':    '@rt_mod',
            '==':   '@rt_eq',
            '!=':   '@rt_neq',
            '>':    '@rt_gt',
            '<':    '@rt_lt',
            'DUP':  '@rt_dup',
            'SWAP': '@rt_swap',
            'DROP': '@rt_drop',
            'OVER': '@rt_over',
            'PRINT': '@rt_print_tos',
        }

        if op.upper() in op_map:
            return f"    call {op_map[op.upper()]}\n"
        elif op in op_map: # for operators like '+'
            return f"    call {op_map[op]}\n"
        else:
            # For now, assume it's a function call (identifier)
            # This will be expanded in Phase 2 for function definitions
            return f"    call @{op}\n"

    def add_string_literal(self, string_value):
        if string_value not in self.string_literals:
            label = f"str_{self.next_string_label}"
            self.next_string_label += 1
            self.string_literals[string_value] = label
            
            special_chars_map = {
                ' ': '\\space',
                '\n': '\\Return',
                '\t': '\\tab', # A reasonable guess
            }

            asm_chars = []
            for char in string_value:
                if char in special_chars_map:
                    asm_chars.append(special_chars_map[char])
                else:
                    # Just escape the character
                    asm_chars.append(f"\\{char}")
            
            # The size is the number of characters + 1 for the null terminator
            size = len(asm_chars) + 1
            
            char_list_str = " ".join(asm_chars)
            
            # Add both the size declaration and the data definition
            self.data_section += f". ${label} {size}\n"
            self.data_section += f"% ${label} {char_list_str} \\null\n"
        
        return self.string_literals[string_value]

# --- Main (for testing) ----------------------------------------------------
if __name__ == '__main__':
    from .lexer import Lexer
    from .parser import Parser

    source = '10 20 + PRINT WHILE test'
    
    lexer = Lexer(source)
    parser = Parser(lexer)
    ast = parser.parse()
    
    if parser.errors or lexer.errors:
        print("Errors during parsing, aborting code generation.")
        # exit()

    codegen = CodeGenerator()
    assembly = codegen.generate(ast)

    print(f"--- Source ---\n{source}\n")
    print(f"--- AST ---\n{ast}\n")
    print(f"--- Generated Assembly ---\n{assembly}")
