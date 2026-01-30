# compiler/codegen.py
import os
import json

from parser import (
    ASTNode,
    ProgramNode,
    NumberNode,
    StringNode,
    StackStringNode,
    WordNode,
    IfNode,
    WhileNode,
    VarDeclarationNode,
    ConstDeclarationNode,
    FunctionDefinitionNode,
    BacktickNode,
    GotoNode,
    LabelNode,
    AsNode,
    AddressOfNode,
    DereferenceNode,
    IONode,
    UseNode,
    IncludeNode,
    AsmNode,
    ExecNode,
    # The following nodes will be used in upcoming steps
    # AssignmentNode,
    # VariableNode,
)
from lexer import Token, TokenType

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
        
        self.symbols = {}
        self.constants = {}
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



    def generate(self, ast, setModule=False, is_code_block=False):
        # Reset sections for each generation run
        self.header_section = ""
        self.code_section = ""
        self.data_section = ""
        self.functions_section = ""
        self.string_literals = {}
        self.next_string_label = 0
        self.while_loop_count = 0
        self.if_label_count = 0
        self.symbols = {}
        self.constants = {}
        self.function_symbols = set()
        self.current_context = "_main"
        self.labels = {}
        
        # Pre-scan for function definitions to allow forward references
        for statement in ast.statements:
            if isinstance(statement, FunctionDefinitionNode):
                self.function_symbols.add(statement.name)

        # Main code generation
        self.code_section = self.generate_program(ast, is_module_compilation=setModule)

        # Peephole optimization
        self.code_section      = self.peephole_optimize(self.code_section, "CODE")
        self.functions_section = self.peephole_optimize(self.functions_section, "FUNCTIONS")

        # Assemble the final code from sections
        final_assembly = ""

        if setModule:
            # For a module, we only care about functions and data.
            # The main code section is not even generated for modules.
            if self.header_section:
                final_assembly += "# .HEADER\n" + self.header_section
            if self.functions_section:
                final_assembly += "# .FUNCTIONS\n" + self.functions_section
            if self.data_section:
                final_assembly += "\n# .DATA\n" + self.data_section
        else:
            # For a runnable program, add the final 'ret' instruction.
            if not is_code_block:
                self.code_section += "    ret\n"
                # Add the required $_start_memory_ symbol for pointer operations.
                # For now, these are added to the os_loader.asm manualy 
                # i keep this lines for later refference (and use)
                # self.header_section += ". $_start_memory_ 1\n"
                # self.data_section += "% $_start_memory_ 0\n"
                # self.symbols["$_start_memory_"] = {'type': 'VAR', 'size': 1}


            # For a normal program, assemble all sections.
            if self.header_section:
                final_assembly += "# .HEADER\n" + self.header_section + "\n"
            
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
            if is_module_compilation and not isinstance(statement, (VarDeclarationNode, ConstDeclarationNode, FunctionDefinitionNode, UseNode, IncludeNode)):
                continue

            code += self.generate_statement(statement)
        return code

    def generate_statement(self, node):
        if isinstance(node, NumberNode):
            return f"    ldi A {node.value}\n    stack A $DATASTACK_PTR\n"
        
        elif isinstance(node, StringNode):
            label = self.add_string_literal(node.value)
            return f"    ldi A ${label}\n    stack A $DATASTACK_PTR\n"
        
        elif isinstance(node, StackStringNode):
            # Convert the string to integer values, handling basic escapes
            vals = []
            i = 0
            s = node.value
            while i < len(s):
                char = s[i]
                if char == '\\':
                    if i + 1 < len(s):
                        next_char = s[i+1]
                        if next_char == 'n':
                            vals.append(13) # \n
                            i += 2
                            continue
                        elif next_char == 't':
                            vals.append(9) # \t
                            i += 2
                            continue
                        else:
                            # Escaped char, e.g. \" or \\
                            vals.append(ord(next_char))
                            i += 2
                            continue
                vals.append(ord(char))
                i += 1
            
            # Calculate DJB2 Hash at Compile Time
            hash_val = 5381
            for val in vals:
                hash_val = ((hash_val * 33) + val)
            
            return f"    ldi A {hash_val}\n    stack A $DATASTACK_PTR\n"

        elif isinstance(node, BacktickNode):
            return f"    call @{node.routine_name}\n"
        
        elif isinstance(node, ExecNode):
            return f"    calls $DATASTACK_PTR\n"
        
        elif isinstance(node, LabelNode):
            self.labels[node.label_name] = len(self.code_section)
            return f":{node.label_name}\n"

        elif isinstance(node, GotoNode):
            # if node.label_name in self.labels:
            #     # offset = self.labels[node.label_name] - len(self.code_section)
            #     return f"    jmp :{node.label_name}\n"
            # else:
            #     raise Exception(f"Undefined label '{node.label_name}'.")
            return f"    jmp :{node.label_name}\n"
        elif isinstance(node, AsNode):
            var_name = node.var_name
            if var_name not in self.symbols:
                self.symbols[var_name] = {'type': 'VAR', 'size': 1}
                self.header_section += f". ${var_name} 1\n"
            
            if node.dereference:
                return f"    ustack B $DATASTACK_PTR\n    ldm I ${var_name}\n    stx B $_start_memory_\n"
            else:
                return f"    ustack A $DATASTACK_PTR\n    sto A ${var_name}\n"

        elif isinstance(node, AddressOfNode):
            prefix = "@" if node.var_name in self.function_symbols else "$"
            return f"    ldi A {prefix}{node.var_name}\n    stack A $DATASTACK_PTR\n"

        elif isinstance(node, DereferenceNode):
            return f"    ldm I ${node.var_name}\n    ldx A $_start_memory_\n    stack A $DATASTACK_PTR\n"

        elif isinstance(node, VarDeclarationNode):
            var_name = node.var_name
            if var_name in self.symbols:
                raise Exception(f"Duplicate variable declaration: '{var_name}' is already defined.")
            
            symbol_info = {'name': var_name, 'type': node.decl_type, 'size': 1}

            if node.decl_type == 'LIST':
                symbol_info['size'] = node.size
                self.header_section += f". ${var_name} {node.size}\n"
            
            elif node.decl_type == 'STRING':
                string_value = node.initial_value
                # Similar to add_string_literal, but with a named label
                special_chars_map = {
                    ' ': '\space',
                    '\n': '\Return',
                    '\t': '\tab',
                }
                asm_chars = []
                i = 0
                while i < len(string_value):
                    char = string_value[i]
                    if char == '\\':
                        if i + 1 < len(string_value):
                            next_char = string_value[i+1]
                            if next_char == 'n':
                                asm_chars.append(special_chars_map['\n'])
                                i += 2
                                continue
                            elif next_char == 't':
                                asm_chars.append(special_chars_map['\t'])
                                i += 2
                                continue
                            else:
                                # This would handle other escaped characters like \a or \\
                                asm_chars.append(f"\\{next_char}")
                                i += 2
                                continue
                    
                    if char in special_chars_map:
                        asm_chars.append(special_chars_map[char])
                    else:
                        asm_chars.append(f"\\{char}")
                    i += 1
                
                size = len(asm_chars) + 1
                char_list_str = " ".join(asm_chars)
                
                symbol_info['size'] = size
                self.header_section += f". ${var_name} {size}\n"
                self.data_section += f"% ${var_name} {char_list_str} \\null\n"

            elif node.decl_type == 'VAR':
                symbol_info['size'] = node.initial_value # Or 1, depending on MALLOC's meaning
                self.header_section += f"MALLOC ${node.var_name} {node.initial_value}\n"

            elif node.decl_type == 'VALUE':
                symbol_info['size'] = 1
                self.header_section += f". ${var_name} 1\n"
                self.data_section += f"% ${var_name} {node.initial_value}\n"

            self.symbols[var_name] = symbol_info
            return ""

        elif isinstance(node, ConstDeclarationNode):
            const_name = node.const_name
            if const_name in self.symbols or const_name in self.function_symbols or const_name in self.constants:
                raise Exception(f"Duplicate symbol declaration for '{const_name}'.")
            
            self.constants[const_name] = node.value_node
            return "" # No code is generated for a const declaration itself

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
            self.functions_section += "    ret\n"
            
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
                    f"    ustack A $DATASTACK_PTR\n"
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
                    f"    ustack A $DATASTACK_PTR\n"
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
                f"    ustack A $DATASTACK_PTR\n"
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
                    f"    stack A $DATASTACK_PTR\n"
                )
            
            # This part is now generated for ALL IO commands.
            code += f"    ldi A {channel}\n    stack A $DATASTACK_PTR\n    ldi A {command_code}\n    stack A $DATASTACK_PTR\n    call @rt_udc_control\n"
            return code

        elif isinstance(node, IncludeNode):
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
                
                # Add constants to the current compilation context
                for const_name, const_value in symbols_data.get("constants", {}).items():
                    # This is a simplified way to handle different node types
                    # For now, we assume constants are numbers.
                    if isinstance(const_value, int) or isinstance(const_value, float):
                        self.constants[const_name] = NumberNode(Token(TokenType.NUMBER, const_value))
                    elif isinstance(const_value, str):
                        self.constants[const_name] = StringNode(Token(TokenType.STRING, const_value))
                    # Add more types if needed

                # Add symbols to the current compilation context
                for func in symbols_data.get("functions", []):
                    self.function_symbols.add(func)
                
                lib_vars = symbols_data.get("variables", [])
                for var_info in lib_vars:
                    var_name = var_info.get("name")
                    var_type = var_info.get("type")
                    var_size = var_info.get("size", 1)
                    if var_name:
                        self.symbols[var_name] = {'name': var_name, 'type': 'LIB_VAR', 'size': var_size}
                        if var_type == 'VAR':       # MALLOC reservation
                            self.header_section += f"MALLOC ${var_name} {var_size}\n"
                        elif var_type == 'LIB_VAR': # No headerline here
                            continue
                        else:                       # default . (dot) directive
                            self.header_section += f". ${var_name} {var_size}\n"


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
                
                # Add constants to the current compilation context
                for const_name, const_value in symbols_data.get("constants", {}).items():
                    # This is a simplified way to handle different node types
                    # For now, we assume constants are numbers.
                    if isinstance(const_value, int) or isinstance(const_value, float):
                        self.constants[const_name] = NumberNode(Token(TokenType.NUMBER, const_value))
                    elif isinstance(const_value, str):
                        self.constants[const_name] = StringNode(Token(TokenType.STRING, const_value))
                    # Add more types if needed

                # Add symbols to the current compilation context
                for func in symbols_data.get("functions", []):
                    self.function_symbols.add(func)
                
                lib_vars = symbols_data.get("variables", [])
                for var_info in lib_vars:
                    var_name = var_info.get("name")
                    var_size = var_info.get("size", 1)
                    if var_name:
                        self.symbols[var_name] = {'name': var_name, 'type': 'LIB_VAR', 'size': var_size}

            except FileNotFoundError:
                raise Exception(f"Symbol file not found for module '{module_name}': {sym_path}")
            except json.JSONDecodeError:
                raise Exception(f"Could not parse symbol file for module '{module_name}': {sym_path}")
            
            return ""

        elif isinstance(node, AsmNode):
            # For an ASM block, just return the raw code it contains.
            return node.asm_code

        else:
            raise Exception(f"Unknown AST node type: {type(node)}")

    def generate_word(self, node):
        op = node.value if node.value is not None else node.token.type.value
        
        if op in self.constants:
            const_value_node = self.constants[op]

            # We can just re-use the statement generator for number and string literals
            return self.generate_statement(const_value_node)

        if op in self.function_symbols:
            return f"    call @{op}\n"

        if op in self.symbols:
            return f"    ldm A ${op}\n    stack A $DATASTACK_PTR\n"

        # Inline basic arithmetic based on RPN evaluation
        if op == '+':
            return "    ustack A $DATASTACK_PTR\n    ustack B $DATASTACK_PTR\n    add B A\n    stack B $DATASTACK_PTR\n"
        if op == '-':
            return "    ustack A $DATASTACK_PTR\n    ustack B $DATASTACK_PTR\n    sub B A\n    stack B $DATASTACK_PTR\n"
        if op == '*':
            return "    ustack A $DATASTACK_PTR\n    ustack B $DATASTACK_PTR\n    mul B A\n    stack B $DATASTACK_PTR\n"
        
        # Special handling for division and modulo based on dmod B A
        if op == '//': # Integer division
            return "    ustack A $DATASTACK_PTR\n    ustack B $DATASTACK_PTR\n    dmod B A\n    stack B $DATASTACK_PTR\n" # Quotient is in B
        if op == '%': # Modulo
            return "    ustack A $DATASTACK_PTR\n    ustack B $DATASTACK_PTR\n    dmod B A\n    stack A $DATASTACK_PTR\n" # Remainder is in A

        if op.upper() == 'NEGATE':
            return "    ustack A $DATASTACK_PTR\n    ldi B 0\n    sub B A\n    stack B $DATASTACK_PTR\n"

        if op.upper() == 'ABS':
            abs_id = self.if_label_count
            self.if_label_count += 1
            return (
                f"    ustack A $DATASTACK_PTR\n"
                f"    tstg A Z\n"
                f"    jmpt :{self.current_context}_abs_pos_{abs_id}\n"
                f"    ldi B 0\n    sub B A\n    ld A B\n"
                f":{self.current_context}_abs_pos_{abs_id}\n"
                f"    stack A $DATASTACK_PTR\n"
            )


        # Fallback to runtime calls for other operations
        rt_call_map = {
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

        if op.upper() in rt_call_map:
            return f"    call {rt_call_map[op.upper()]}\n"
        else:
            raise Exception(f"Undefined word '{op}'. It is not a built-in operator, a defined variable, or a function.")

    def add_string_literal(self, string_value):
        if string_value not in self.string_literals:
            label = f"{self.current_context}_str_{self.next_string_label}"
            # label = f"str_{self.next_string_label}"
            self.next_string_label += 1
            self.string_literals[string_value] = label
            
            special_chars_map = {
                ' ' : '\space',
                '\n': '\Return',
                '\t': '\tab', # A reasonable guess
            }

            asm_chars = []
            i = 0
            while i < len(string_value):
                char = string_value[i]
                if char == '\\':
                    if i + 1 < len(string_value):
                        next_char = string_value[i+1]
                        if next_char == 'n':
                            asm_chars.append(special_chars_map['\n'])
                            i += 2
                            continue
                        elif next_char == 't':
                            asm_chars.append(special_chars_map['\t'])
                            i += 2
                            continue
                        else:
                            # This would handle other escaped characters like \a or \\
                            asm_chars.append(f"\\{next_char}")
                            i += 2
                            continue
                
                if char in special_chars_map:
                    asm_chars.append(special_chars_map[char])
                else:
                    asm_chars.append(f"\\{char}")
                i += 1
            
            # The size is the number of characters + 1 for the null terminator
            size = len(asm_chars) + 1
            
            char_list_str = " ".join(asm_chars)
            
            # The declaration goes in the header, the data goes in the data section
            self.header_section += f". ${label} {size}\n"
            self.data_section += f"% ${label} {char_list_str} \\null\n"
        
        return self.string_literals[string_value]

    def peephole_optimize(self, assembly_code, section_name="Unknown"):
        lines_removed_count = 0
        optimized_code = assembly_code
        while True:
            original_code = optimized_code
            lines = original_code.split('\n')
            optimized_lines = []
            
            i = 0
            while i < len(lines):
                if i + 1 < len(lines):
                    line1 = lines[i].strip()
                    line2 = lines[i+1].strip()
                    parts1 = line1.split()
                    parts2 = line2.split()

                    # Pattern 1: stack/ustack
                    if len(parts1) > 1 and len(parts1) == len(parts2) and \
                       parts1[0] == 'stack' and parts2[0] == 'ustack' and \
                       parts1[1:] == parts2[1:]:
                        i += 2 # Skip both lines
                        lines_removed_count += 2
                        continue

                    # Pattern 2: sto/ldm
                    if len(parts1) == 3 and len(parts1) == len(parts2) and \
                       parts1[0] == 'sto' and parts2[0] == 'ldm' and \
                       parts1[1:] == parts2[1:]:
                        optimized_lines.append(lines[i]) # Keep the 'sto' line
                        i += 2 # Skip the 'ldm' line
                        lines_removed_count += 1
                        continue

                    # Pattern 3: Register move via stack (e.g. stack B ptr / ustack A ptr)
                    if parts1 and parts2 and parts1[0] == 'stack' and parts2[0] == 'ustack' and \
                       len(parts1) > 1 and len(parts1) == len(parts2) and \
                       parts1[2:] == parts2[2:] and parts1[1] != parts2[1]:
                        src_reg = parts1[1]
                        dest_reg = parts2[1]
                        optimized_lines.append(f"    ld {dest_reg.upper()} {src_reg.upper()}")
                        i += 2
                        lines_removed_count += 1
                        continue
                    
                    # Pattern 4: Interleaved Load/Stack optimization
                    # stack A $PTR -> ldm A $VAR -> ustack B $PTR
                    # Becomes: ld B A -> ldm A $VAR
                    if i + 2 < len(lines):
                        line3 = lines[i+2].strip()
                        parts3 = line3.split()
                        
                        if len(parts1) > 2 and len(parts3) > 2 and \
                           parts1[0] == 'stack' and parts3[0] == 'ustack' and \
                           parts1[2:] == parts3[2:] and parts1[1] != parts3[1]:
                            
                            src_reg = parts1[1]
                            dest_reg = parts3[1]
                            
                            if len(parts2) >= 2 and parts2[0] in ['ldm', 'ldi'] and parts2[1] == src_reg:
                                optimized_lines.append(f"    ld {dest_reg.upper()} {src_reg.upper()}")
                                optimized_lines.append(lines[i+1])
                                i += 3
                                lines_removed_count += 1
                                continue
                    
                    # Pattern 8: Redundant Save/Restore around independent instruction
                    # stack B $PTR -> ldm A $VAR -> ustack B $PTR
                    # Becomes: ldm A $VAR
                    # Condition: Middle instruction must not modify the saved register.
                    if i + 2 < len(lines):
                        line3 = lines[i+2].strip()
                        parts3 = line3.split()
                        
                        if len(parts1) > 2 and len(parts3) > 2 and \
                           parts1[0] == 'stack' and parts3[0] == 'ustack' and \
                           parts1[2:] == parts3[2:] and parts1[1] == parts3[1]:
                            
                            reg = parts1[1]
                            safe_ops = ['ldm', 'ldi', 'ld', 'add', 'sub', 'mul']
                            
                            if len(parts2) >= 2 and parts2[0] in safe_ops and parts2[1] != reg:
                                optimized_lines.append(lines[i+1])
                                i += 3
                                lines_removed_count += 2
                                continue

                    # Pattern 5: Load A then Move to B optimization
                    # ldm A $VAR -> ld B A
                    # Becomes: ldm B $VAR
                    # Only if A is overwritten in the next instruction
                    if i + 2 < len(lines):
                        line3 = lines[i+2].strip()
                        parts3 = line3.split()

                        overwrites_a = False
                        if len(parts3) >= 2 and parts3[1] == 'A':
                            if parts3[0] in ['ldi', 'ldm', 'ustack', 'ld']:
                                overwrites_a = True
                        
                        if len(parts1) == 3 and len(parts2) == 3 and \
                           parts1[0] == 'ldm' and parts1[1] == 'A' and \
                           parts2[0] == 'ld' and parts2[1] == 'B' and parts2[2] == 'A' and \
                           overwrites_a:
                            
                            optimized_lines.append(f"    ldm B {parts1[2]}")
                            i += 2
                            lines_removed_count += 1
                            continue

                    # Pattern 6: Commutative Op to Register Swap
                    # add B A -> ld A B  ==> add A B
                    # mul B A -> ld A B  ==> mul A B
                    if len(parts1) == 3 and len(parts2) == 3 and \
                       parts1[0] in ['add', 'mul'] and parts1[1] == 'B' and parts1[2] == 'A' and \
                       parts2[0] == 'ld' and parts2[1] == 'A' and parts2[2] == 'B':
                        
                        optimized_lines.append(f"    {parts1[0]} A B")
                        i += 2
                        lines_removed_count += 1
                        continue

                    # Pattern 7: Optimize pushing 0
                    # ldi A 0 -> stack A $DATASTACK_PTR
                    # Becomes: stack Z $DATASTACK_PTR
                    if len(parts1) == 3 and len(parts2) == 3 and \
                       parts1[0] == 'ldi' and parts1[1] == 'A' and parts1[2] == '0' and \
                       parts2[0] == 'stack' and parts2[1] == 'A' and parts2[2] == '$DATASTACK_PTR':
                        
                        optimized_lines.append(f"    stack Z {parts2[2]}")
                        i += 2
                        lines_removed_count += 1
                        continue

                optimized_lines.append(lines[i])
                i += 1

            optimized_code = '\n'.join(optimized_lines)

            if optimized_code == original_code:
                break
        
        if lines_removed_count > 0:
            print(f"Peephole optimization removed {lines_removed_count} lines from {section_name} section.")
            
        return optimized_code

# --- Main (for testing) ----------------------------------------------------
if __name__ == '__main__':
    from .lexer import Lexer
    from .parser import Parser

    # source = 'VALUE my_val 42 VALUE my_ptr 0 &my_val AS my_ptr 99 AS *my_ptr my_val PRINT'
    # source = 'WHILE 10 12 > DO 42 PRINT DONE'
    source = 'CONST my_const 42 CONST my_str "hello" my_const PRINT my_str PRINT'
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
