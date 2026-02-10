import os
from codegen import BaseGenerator
from parser import (
    ProgramNode, NumberNode, StringNode, StackStringNode, WordNode,
    IfNode, WhileNode, VarDeclarationNode, ConstDeclarationNode,
    FunctionDefinitionNode, BacktickNode, GotoNode, LabelNode,
    AsNode, AddressOfNode, DereferenceNode, IONode, UseNode,
    IncludeNode, AsmNode, ExecNode
)

class SimplGenerator(BaseGenerator):
    def __init__(self):
        super().__init__()
        self.deque_name = "_sq_"
        self.simpl_code = ""
        self.function_code = ""
        self.register_count = 0
        self.max_registers = 26
        
        # Map Stacks operators to SIMPL opcodes
        self.op_map = {
            '+': 'ADD', '-': 'SUB', '*': 'MUL', '/': 'DIV', '%': 'MOD',
            'DUP': 'DUP', 'DROP': 'DROP', 'SWAP': 'SWAP', 'OVER': 'OVER',
            'NEGATE': 'NEG',
            'ABS': 'ABS',
            '==': 'EQ', '!=': 'NE', '<': 'LT', '>': 'GT',
        }

    def generate(self, ast, macro_name="load_simpl_program"):
        self.reset_state()
        self.simpl_code = ""
        self.function_code = ""
        self.register_count = 0
        
        # Pre-scan for function definitions
        for statement in ast.statements:
            if isinstance(statement, FunctionDefinitionNode):
                self.function_symbols.add(statement.name)

        self.visit(ast)
        
        self.emit("HALT")
        self.simpl_code += self.function_code
        
        return f"USE std_deque\n\nMACRO {macro_name} {{\n    AS {self.deque_name}\n\n{self.simpl_code}}}\n"

    def emit(self, val):
        if isinstance(val, str):
            # Escape quotes for Stacks string literal
            val_str = f'\\"{val}"'
        else:
            val_str = str(val)
        
        self.simpl_code += f'    {val_str:<14} {self.deque_name} DEQUE.append\n'

    def visit_ProgramNode(self, node):
        for stmt in node.statements:
            self.visit(stmt)

    def visit_NumberNode(self, node):
        self.emit("PUSH")
        self.emit(node.value)

    def visit_StringNode(self, node):
        raise Exception("SIMPL Target Error: String literals are not supported in Scalar Stacks.")

    def visit_StackStringNode(self, node):
        raise Exception("SIMPL Target Error: Stack Strings are not supported in Scalar Stacks.")

    def visit_VarDeclarationNode(self, node):
        if node.decl_type not in ['VALUE', 'VAR']:
             raise Exception(f"SIMPL Target Error: Unsupported variable type '{node.decl_type}'. Only VALUE and VAR are allowed for the SIMPL target.")
        
        if self.register_count >= self.max_registers:
            raise Exception(f"SIMPL Target Error: Register overflow. Max {self.max_registers} variables allowed.")
            
        reg_index = self.register_count
        self.register_count += 1

        self.symbols[node.var_name] = {'type': 'REG', 'index': reg_index}

        if node.decl_type == 'VAR':
            # For the SIMPL target, VAR is for uninitialized arguments. It must not have a value.
            if node.initial_value is not None:
                raise Exception(f"SIMPL Target Error: VAR '{node.var_name}' cannot be initialized.")
        elif node.decl_type == 'VALUE':
            # VALUE must be initialized.
            if node.initial_value is None:
                raise Exception(f"SIMPL Target Error: VALUE '{node.var_name}' must be initialized.")
            self.emit("PUSH")
            self.emit(node.initial_value)
            self.emit("SET")
            self.emit(reg_index)

    def visit_AsNode(self, node):
        # Assignment: expression AS var
        if node.var_name not in self.symbols:
             raise Exception(f"Undefined variable '{node.var_name}'")
        
        sym = self.symbols[node.var_name]
        if sym['type'] != 'REG':
             raise Exception(f"Cannot assign to non-register symbol '{node.var_name}'")
             
        self.emit("SET")
        self.emit(sym['index'])

    def visit_WordNode(self, node):
        word = node.value
        
        # 0. Constant Substitution
        if word in self.constants:
            const_value = self.constants[word]
            # We only support integer constants in this target for now
            if not isinstance(const_value, int):
                raise Exception(f"SIMPL Target Error: Unsupported constant type for '{word}'. Only integers allowed.")
            self.emit("PUSH")
            self.emit(const_value)
            return

        # 1. Variable Access
        if word in self.symbols:
            sym = self.symbols[word]
            if sym['type'] == 'REG':
                self.emit("GET")
                self.emit(sym['index'])
                return
        
        # 2. Function Call
        if word in self.function_symbols:
            self.emit("CALL")
            self.emit(word)
            return

        # 3. Opcode Mapping
        if word in self.op_map:
            self.emit(self.op_map[word])
            return
            
        # 4. VVM Specifics
        if word.upper() in ['OUT', 'SYS', 'HALT', 'FETCH', 'RET', 'RND']:
            self.emit(word.upper())
            return

        # 5. High-level commands
        if word.upper() == 'PRINT':
            self.emit('OUT')   # Send to host
            self.emit('PUSH')
            self.emit(10)      # PRINT_NUM syscall ID
            self.emit('OUT')   # Send ID to host
            self.emit('SYS')   # Trigger syscall
            return

        raise Exception(f"SIMPL Target Error: Unknown word '{word}'")

    def visit_IfNode(self, node):
        if_id = self.if_label_count
        self.if_label_count += 1
        else_label = f"else_{if_id}"
        end_label = f"end_{if_id}"
        
        self.emit("BRZ")
        self.emit(else_label if node.false_branch else end_label)
        
        self.visit(node.true_branch)
        
        if node.false_branch:
            self.emit("BRA")
            self.emit(end_label)
            self.emit("LABEL")
            self.emit(else_label)
            self.visit(node.false_branch)
            
        self.emit("LABEL")
        self.emit(end_label)

    def visit_WhileNode(self, node):
        loop_id = self.while_loop_count
        self.while_loop_count += 1
        start_label = f"while_{loop_id}"
        end_label = f"endwhile_{loop_id}"
        
        self.emit("LABEL")
        self.emit(start_label)
        self.visit(node.condition)
        self.emit("BRZ")
        self.emit(end_label)
        self.visit(node.body)
        self.emit("BRA")
        self.emit(start_label)
        self.emit("LABEL")
        self.emit(end_label)

    def visit_FunctionDefinitionNode(self, node):
        # Redirect output to function_code buffer
        current_simpl_code = self.simpl_code
        self.simpl_code = ""

        self.emit("LABEL")
        self.emit(node.name)
        self.visit(node.body)
        self.emit("RET")

        self.function_code += self.simpl_code
        self.simpl_code = current_simpl_code

    def visit_AsmNode(self, node):
        raise Exception("SIMPL Target Error: ASM blocks are not supported.")
    
    def visit_IncludeNode(self, node):
        raise Exception("SIMPL Target Error: INCLUDE is not supported in Scalar Stacks.")
    def visit_UseNode(self, node):
        raise Exception("SIMPL Target Error: USE is not supported in Scalar Stacks.")
    def visit_ConstDeclarationNode(self, node):
        # Extract the value from the value_node (NumberNode)
        if isinstance(node.value_node, NumberNode):
            val = node.value_node.value
        else:
             raise Exception(f"SIMPL Target Error: Constant '{node.const_name}' must be a number.")

        # Store in the BaseGenerator's constants table
        self.constants[node.const_name] = val

    def visit_GotoNode(self, node):
        self.emit("BRA")
        self.emit(node.label_name)
        

    def visit_LabelNode(self, node):
        self.emit("LABEL")
        self.emit(node.label_name)

    def visit_AddressOfNode(self, node):
        raise Exception("SIMPL Target Error: Address-of operator '&' is not supported in Scalar Stacks.")

    def visit_DereferenceNode(self, node):
        raise Exception("SIMPL Target Error: Dereference operator '*' is not supported in Scalar Stacks.")

    def visit_BacktickNode(self, node):
        raise Exception("SIMPL Target Error: Backtick/assembly calls '`' are not supported.")

    def visit_ExecNode(self, node):
        raise Exception("SIMPL Target Error: EXEC is not supported in Scalar Stacks.")