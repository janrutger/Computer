import os
import json

from parser import (
    ASTNode,
    ProgramNode,
    NumberNode,
    StringNode,
    WordNode,
    IfNode,
    WhileNode,
    VarDeclarationNode,
    FunctionDefinitionNode,
    BacktickNode,
    GotoNode,
    LabelNode,
    AsNode,
    AddressOfNode,
    DereferenceNode,
    IONode,
    UseNode,
    # The following nodes will be used in upcoming steps
    # AssignmentNode,
    # VariableNode,
)
from lexer import TokenType

class CodeGenerator:
    def __init__(self):
        self.header_section = ""
        self.code_section = ""
        self.data_section = ""
        self.functions_section = ""
        
        self.string_literals = {}
        self.next_string_label = 0
        self.while_loop_count = 0
        self.if_label_count = 0
        
        self.symbols = set()
        self.current_context = "_main" # To scope labels for if/while
        self.function_symbols = set()
        self.labels = {}
        
        self.udc_commands = {
            # Generic Commands
            'INIT': 0, 'ONLINE': 1, 'OFFLINE': 2, 'RESET': 3,
            # Device-Specific Commands
            'NEW': 10, 'SEND': 11, 'GET': 12, 'COLOR': 13, 'MODE': 14,
            'X': 15, 'Y': 16, 'DRAW': 17, 'FLIP': 18,
        }



    def generate(self, ast, setModule=False):
        # Reset sections for each generation run
        self.header_section = ""
        self.code_section = ""
        self.data_section = ""
        self.functions_section = ""
        self.string_literals = {}
        self.next_string_label = 0
        self.while_loop_count = 0
        self.if_label_count = 0
        self.symbols = set()
        self.function_symbols = set()
        self.current_context = "_main"
        self.labels = {}
        
        # Add the required $_start_memory_ symbol for pointer operations.
        self.header_section += ". $_start_memory_ 1\n"
        self.data_section += "% $_start_memory_ 0\n"
        self.symbols.add("$_start_memory_")

        # Main code generation
        self.code_section = self.generate_program(ast, is_module_compilation=setModule)

        # Assemble the final code from sections
        final_assembly = ""

        if setModule:
            # For a module, we only care about functions and data.
            # The main code section is not even generated for modules.
            if self.functions_section:
                final_assembly += "# .FUNCTIONS\n" + self.functions_section
            if self.data_section:
                final_assembly += "\n# .DATA\n" + self.data_section
        else:
            # For a normal program, assemble all sections.
            if self.header_section:
                final_assembly += "# .HEADER\n" + self.header_section + "\n"
            
            # For a runnable program, add the final 'ret' instruction.
            self.code_section += "    ret\n"

            final_assembly += "# .CODE\n" + self.code_section
            
            if self.functions_section:
                final_assembly += "\n# .FUNCTIONS\n" + self.functions_section
                
            if self.data_section:
                final_assembly += "\n# .DATA\n" + self.data_section

        return final_assembly

    def generate_program(self, node, is_module_compilation=False):
        code = ""
        for statement in node.statements:
            # When compiling a module, only process declarations and function definitions.
            # Ignore all other "mainline" code.
            if is_module_compilation and not isinstance(statement, (VarDeclarationNode, FunctionDefinitionNode, UseNode)):
                continue

            code += self.generate_statement(statement)
        return code

    def generate_statement(self, node):
        if isinstance(node, NumberNode):
            return f"    ldi A {node.value}\n    call @push_A\n"
        
        elif isinstance(node, StringNode):
            label = self.add_string_literal(node.value)
            return f"    ldi A ${label}\n    call @push_A\n"
        
        elif isinstance(node, BacktickNode):
            return f"    call @{node.routine_name}\n"
        
        elif isinstance(node, LabelNode):
            self.labels[node.label_name] = len(self.code_section)
            return f":{node.label_name}\n"

        elif isinstance(node, GotoNode):
            if node.label_name in self.labels:
                # offset = self.labels[node.label_name] - len(self.code_section)
                return f"    jmp :{node.label_name}\n"
            else:
                raise Exception(f"Undefined label '{node.label_name}'.")

        elif isinstance(node, AsNode):
            var_name = node.var_name
            if var_name not in self.symbols:
                self.symbols.add(var_name)
                self.header_section += f". ${var_name} 1\n"
            
            if node.dereference:
                return f"    call @pop_B\n    ldm I ${var_name}\n    stx B $_start_memory_\n"
            else:
                return f"    call @pop_A\n    sto A ${var_name}\n"

        elif isinstance(node, AddressOfNode):
            return f"    ldi A ${node.var_name}\n    call @push_A\n"

        elif isinstance(node, DereferenceNode):
            return f"    ldm I ${node.var_name}\n    ldx A $_start_memory_\n    call @push_A\n"

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
                self.data_section += f"% ${var_name} {node.initial_value}\n"
                return ""

        elif isinstance(node, FunctionDefinitionNode):
            # Add the function name to the function symbol table so it can be called
            self.function_symbols.add(node.name)
            
            # Set context for unique label generation within the function
            previous_context = self.current_context
            self.current_context = node.name

            # Generate the assembly code for the function's body
            function_body_code = self.generate_program(node.body)
            
            # Restore previous context
            self.current_context = previous_context

            # Assemble the full function block with a label and a return instruction
            self.functions_section += f"@{node.name}\n"
            self.functions_section += function_body_code
            self.functions_section += "    ret\n\n"
            
            # A function definition does not produce inline code, so return an empty string
            return ""

        elif isinstance(node, WordNode):
            return self.generate_word(node)

        elif isinstance(node, IfNode):
            if_id = self.if_label_count
            self.if_label_count += 1
            
            true_code = self.generate_program(node.true_branch)
            
            if node.false_branch:
                false_code = self.generate_program(node.false_branch)
                else_label = f"{self.current_context}_if_else_{if_id}"
                end_label = f"{self.current_context}_if_end_{if_id}"
                
                return (
                    f"    call @pop_A\n"
                    f"    tst A 0\n"
                    f"    jmpt :{else_label}\n"  # Jump if false (zero)
                    f"{true_code}"
                    f"    jmp :{end_label}\n"
                    f":{else_label}\n"
                    f"{false_code}"
                    f":{end_label}\n"
                )
            else:
                end_label = f"{self.current_context}_if_end_{if_id}"
                return (
                    f"    call @pop_A\n"
                    f"    tst A 0\n"
                    f"    jmpt :{end_label}\n"  # Jump if false (zero)
                    f"{true_code}"
                    f":{end_label}\n"
                )

        elif isinstance(node, WhileNode):
            loop_id = self.while_loop_count
            self.while_loop_count += 1
            start_label = f"{self.current_context}_while_start_{loop_id}"
            end_label = f"{self.current_context}_while_end_{loop_id}"

            condition_code = self.generate_program(node.condition)
            body_code = self.generate_program(node.body)

            return (
                f":{start_label}\n"
                f"{condition_code}"
                f"    call @pop_A\n"
                f"    tst A 0\n"
                f"    jmpt :{end_label}\n"
                f"{body_code}"
                f"    jmp :{start_label}\n"
                f":{end_label}\n"
            )
        
        elif isinstance(node, IONode):
            command_upper = node.command.upper()
            if command_upper not in self.udc_commands:
                raise Exception(f"Unknown IO command '{node.command}'.")
            
            command_code = self.udc_commands[command_upper]
            channel = node.channel

            code = ""
            # For commands that don't take a value from the stack, we push a 0.
            # The runtime routine `&io` always expects 3 items: value, command, channel.
            if command_upper in ['ONLINE', 'OFFLINE', 'RESET', 'NEW', 'GET', 'FLIP', 'INIT']:
                code += (
                    f"    ldi A 0\n"              # Push dummy value 0
                    f"    call @push_A\n"
                )
            
            # This part is now generated for ALL IO commands.
            code += f"    ldi A {channel}\n    call @push_A\n    ldi A {command_code}\n    call @push_A\n    call @rt_udc_control\n"
            return code

        elif isinstance(node, UseNode):
            module_name = node.module_name
            # Assuming modules are in a 'lib' directory relative to the compiler's execution path
            # A more robust solution might search multiple paths.
            module_dir = "compiler/lib"
            sym_path = os.path.join(module_dir, f"{module_name}.sym")
            smod_path = os.path.join(module_dir, f"{module_name}.smod")

            # 1. Load symbols from .sym file
            try:
                with open(sym_path, 'r') as f:
                    symbols_data = json.load(f)
                
                # Add symbols to the current compilation context
                for func in symbols_data.get("functions", []):
                    self.function_symbols.add(func)
                for var in symbols_data.get("variables", []):
                    self.symbols.add(var)

            except FileNotFoundError:
                raise Exception(f"Symbol file not found for module '{module_name}': {sym_path}")
            except json.JSONDecodeError:
                raise Exception(f"Could not parse symbol file for module '{module_name}': {sym_path}")

            # 2. Load code from .smod file
            try:
                with open(smod_path, 'r') as f:
                    module_code = f.read()
                
                # A simple way to split sections. A more robust parser could be used.
                if "# .FUNCTIONS" in module_code:
                    self.functions_section += module_code.split("# .FUNCTIONS")[1].split("# .DATA")[0]
                if "# .DATA" in module_code:
                    self.data_section += module_code.split("# .DATA")[1]
            except FileNotFoundError:
                raise Exception(f"Module file not found for module '{module_name}': {smod_path}")

            return "" # The USE statement itself produces no inline code

        else:
            raise Exception(f"Unknown AST node type: {type(node)}")

    def generate_word(self, node):
        op = node.value if node.value is not None else node.token.type.value
        
        if op in self.function_symbols:
            return f"    call @{op}\n"

        if op in self.symbols:
            return f"    ldm A ${op}\n    call @push_A\n"

        op_map = {
            '+':    '@rt_add',
            '-':    '@rt_sub',
            '*':    '@rt_mul',
            '//':   '@rt_div',
            '%' :   '@rt_mod',
            '==':   '@rt_eq',
            '!=':   '@rt_neq',
            '>':    '@rt_gt',
            '<':    '@rt_lt',
            'DUP' : '@rt_dup',
            'SWAP': '@rt_swap',
            'DROP': '@rt_drop',
            'OVER': '@rt_over',
            'PRINT': '@rt_print_tos',
            'RND': '@rt_rnd',
        }

        if op.upper() in op_map:
            return f"    call {op_map[op.upper()]}\n"
        elif op in op_map: # for operators like '+'
            return f"    call {op_map[op]}\n"
        else:
            raise Exception(f"Undefined word '{op}'. It is not a built-in operator, a defined variable, or a function.")

    def add_string_literal(self, string_value):
        if string_value not in self.string_literals:
            label = f"str_{self.next_string_label}"
            self.next_string_label += 1
            self.string_literals[string_value] = label
            
            special_chars_map = {
                ' ' : '\space',
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

    # source = 'VALUE my_val 42 VALUE my_ptr 0 &my_val AS my_ptr 99 AS *my_ptr my_val PRINT'
    # source = 'WHILE 10 12 > DO 42 PRINT DONE'
    source = '10 12 > IF 42 PRINT ELSE 99 PRINT END 12 30 == IF 42 PRINT END'
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
    else:
        try:
            codegen = CodeGenerator()
            assembly = codegen.generate(ast)

            print(f"--- Source ---\n{source}\n")
            print(f"--- AST ---\n{ast}\n")
            print(f"--- Generated Assembly---\n{assembly}")
        except Exception as e:
            print(f"--- CODEGEN ERROR---\n{e}")
