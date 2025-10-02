# compiler/codegen.py

from .parser import (
    ASTNode,
    ProgramNode,
    NumberNode,
    StringNode,
    WordNode,
    IfNode,
    VarDeclarationNode,
    # The following nodes will be used in upcoming steps
    # AssignmentNode,
    # VariableNode,
)
from .lexer import TokenType

class CodeGenerator:
    def __init__(self):
        self.header_section = ""
        self.code_section = ""
        self.data_section = ""
        
        self.string_literals = {}
        self.next_string_label = 0
        
        self.symbols = set()

    def generate(self, ast):
        # Reset sections for each generation run
        self.header_section = ""
        self.code_section = ""
        self.data_section = ""
        self.string_literals = {}
        self.next_string_label = 0
        self.symbols = set()
        
        # Main code generation
        self.code_section = self.generate_program(ast)

        # Assemble the final code from sections
        final_assembly = ""
        if self.header_section:
            final_assembly += "# .HEADER\n" + self.header_section + "\n"
        
        final_assembly += "# .CODE\n" + self.code_section
        
        if self.data_section:
            final_assembly += "\n# .DATA\n" + self.data_section
        
        return final_assembly

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

        elif isinstance(node, VarDeclarationNode):
            var_name = node.var_name
            if var_name in self.symbols:
                # Optionally, raise an error for duplicate variable declarations
                return ""
            self.symbols.add(var_name)

            if node.decl_type == 'LIST':
                self.header_section += f". ${var_name} {node.size}\n"
                return ""
            
            elif node.decl_type == 'STRING':
                string_value = node.initial_value
                # Similar to add_string_literal, but with a named label
                special_chars_map = {
                    ' ': '\space',
                    '\n': '\Return',
                    '\t': '\tab',
                }
                asm_chars = []
                for char in string_value:
                    if char in special_chars_map:
                        asm_chars.append(special_chars_map[char])
                    else:
                        asm_chars.append(f"\\{char}")
                
                size = len(asm_chars) + 1
                char_list_str = " ".join(asm_chars)
                
                self.header_section += f". {var_name} {size}\n"
                self.data_section += f"% ${var_name} {char_list_str} \\null\n"
                return ""

            elif node.decl_type == 'VAR':
                self.header_section += f".MALLOC ${node.var_name} {node.initial_value}\n"
                return ""

            elif node.decl_type == 'VALUE':
                self.header_section += f". ${var_name} 1\n"
                self.data_section += f"% {var_name} {node.initial_value}\n"
                return ""

        elif isinstance(node, WordNode):
            return self.generate_word(node)

        elif isinstance(node, IfNode):
            # For now, just generate the content of the branches
            # A real implementation needs labels and jumps
            true_code = self.generate_program(node.true_branch)
            false_code = ""
            if node.false_branch:
                false_code = self.generate_program(node.false_branch)
            return f"# IF statement placeholder\n{true_code}{false_code}"

        else:
            raise Exception(f"Unknown AST node type: {type(node)}")

    def generate_word(self, node):
        op = node.value if node.value is not None else node.token.type.value
        
        if op in self.symbols:
            return f"    ldm A {op}\n    call @push_A\n"

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
                ' ': '\space',
                '\n': '\Return',
                '\t': '\tab', # A reasonable guess
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
            
            # The declaration goes in the header, the data goes in the data section
            self.header_section += f". ${label} {size}\n"
            self.data_section += f"% ${label} {char_list_str} \\null\n"
        
        return self.string_literals[string_value]

# --- Main (for testing) ----------------------------------------------------
if __name__ == '__main__':
    from .lexer import Lexer
    from .parser import Parser

    source = 'VAR my_ptr 1024 VALUE my_val 42 my_ptr my_val + PRINT "test string" LIST my_list 12'
    
    lexer = Lexer(source)
    parser = Parser(lexer)
    ast = parser.parse()
    
    if parser.errors or lexer.errors:
        print("Errors during parsing, aborting code generation.")
    else:
        codegen = CodeGenerator()
        assembly = codegen.generate(ast)

        print(f"--- Source ---\n{source}\n")
        print(f"--- AST ---\n{ast}\n")
        print(f"--- Generated Assembly ---\n{assembly}")
