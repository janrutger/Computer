# compiler/parser.py

from lexer import Lexer, Token, TokenType

# --- AST Nodes -------------------------------------------------------------

class ASTNode:
    pass

class ProgramNode(ASTNode):
    def __init__(self):
        self.statements = []

    def __repr__(self):
        return f"ProgramNode({self.statements})"

class NumberNode(ASTNode):
    def __init__(self, token):
        self.token = token
        self.value = token.value

    def __repr__(self):
        return f"NumberNode({self.value})"

class StringNode(ASTNode):
    def __init__(self, token):
        self.token = token
        self.value = token.value

    def __repr__(self):
        return f"StringNode('{self.value}')"

class WordNode(ASTNode):
    """Represents identifiers, keywords, and operators."""
    def __init__(self, token):
        self.token = token
        self.value = token.value

    def __repr__(self):
        return f"WordNode('{self.value or self.token.type.value}')"

class AssignmentNode(ASTNode):
    def __init__(self, var_name, value_node):
        self.var_name = var_name
        self.value_node = value_node

    def __repr__(self):
        return f"AssignmentNode({self.var_name}, {self.value_node})"

class VariableNode(ASTNode):
    def __init__(self, token):
        self.token = token
        self.var_name = token.value

    def __repr__(self):
        return f"VariableNode('{self.var_name}')"

class AddressOfNode(ASTNode):
    def __init__(self, var_name_token):
        self.token = var_name_token
        self.var_name = var_name_token.value

    def __repr__(self):
        return f"AddressOfNode('{self.var_name}')"

class DereferenceNode(ASTNode):
    def __init__(self, var_name_token):
        self.token = var_name_token
        self.var_name = var_name_token.value

    def __repr__(self):
        return f"DereferenceNode('{self.var_name}')"

class AsNode(ASTNode):
    def __init__(self, var_name_token, dereference=False):
        self.var_name_token = var_name_token
        self.var_name = var_name_token.value
        self.dereference = dereference

    def __repr__(self):
        return f"AsNode(var='{self.var_name}', deref={self.dereference})"

class IfNode(ASTNode):
    def __init__(self, true_branch, false_branch=None):
        self.true_branch = true_branch
        self.false_branch = false_branch

    def __repr__(self):
        return f"IfNode(true={self.true_branch}, false={self.false_branch})"

class WhileNode(ASTNode):
    def __init__(self, condition, body):
        self.condition = condition
        self.body = body

    def __repr__(self):
        return f"WhileNode(condition={self.condition}, body={self.body})"

class VarDeclarationNode(ASTNode):
    def __init__(self, decl_type, var_name, size=None, initial_value=None):
        self.decl_type = decl_type
        self.var_name = var_name
        self.size = size
        self.initial_value = initial_value

    def __repr__(self):
        parts = [self.decl_type, f"'{self.var_name}'"]
        if self.size is not None:
            parts.append(f"size={self.size}")
        if self.initial_value is not None:
            parts.append(f"value='{self.initial_value}'")
        return f"VarDeclarationNode({', '.join(parts)})"

class FunctionDefinitionNode(ASTNode):
    def __init__(self, name, body):
        self.name = name
        self.body = body

    def __repr__(self):
        return f"FunctionDefinitionNode(name='{self.name}', body={self.body})"

class BacktickNode(ASTNode):
    def __init__(self, routine_name_token):
        self.token = routine_name_token
        self.routine_name = routine_name_token.value

    def __repr__(self):
        return f"BacktickNode('{self.routine_name}')"

class LabelNode(ASTNode):
    def __init__(self, label_name):
        self.label_name = label_name

    def __repr__(self):
        return f"LabelNode('{self.label_name}')"

class GotoNode(ASTNode):
    def __init__(self, label_name):
        self.label_name = label_name

    def __repr__(self):
        return f"GotoNode('{self.label_name}')"

class IONode(ASTNode):
    def __init__(self, channel_token, command_token):
        self.channel_token = channel_token
        self.command_token = command_token
        self.channel = channel_token.value
        self.command = command_token.value

    def __repr__(self):
        return f"IONode(channel={self.channel}, command='{self.command}')"

class UseNode(ASTNode):
    def __init__(self, module_name_token):
        self.module_name_token = module_name_token
        self.module_name = module_name_token.value

    def __repr__(self):
        return f"UseNode(module='{self.module_name}')"

class AsmNode(ASTNode):
    def __init__(self, asm_code_token):
        self.asm_code_token = asm_code_token
        self.asm_code = asm_code_token.value

    def __repr__(self):
        return f"AsmNode(...)"




# --- Parser ----------------------------------------------------------------

class Parser:
    def __init__(self, lexer):
        self.lexer = lexer
        self.errors = []

        self.current_token = self.lexer.get_next_token()

    def advance(self):
        self.current_token = self.lexer.get_next_token()

    def parse(self):
        program = ProgramNode()
        while self.current_token.type != TokenType.EOF:
            statement = self.parse_statement()
            if statement:
                program.statements.append(statement)
            self.advance()
        return program

    def parse_statement(self):
        token = self.current_token
        if token.type == TokenType.NUMBER:
            return NumberNode(token)
        elif token.type == TokenType.STRING:
            return StringNode(token)
        elif token.type == TokenType.IF:
            return self.parse_if_statement()
        elif token.type == TokenType.WHILE:
            return self.parse_while_statement()
        elif token.type == TokenType.DEF:
            return self.parse_function_definition()
        elif token.type == TokenType.BACKTICK:
            return self.parse_backtick_call()
        elif token.type in (TokenType.KEYWORD_VAR, TokenType.KEYWORD_VALUE, TokenType.KEYWORD_LIST, TokenType.KEYWORD_STRING):
            return self.parse_declaration()
        elif token.type == TokenType.COLON:
            return self.parse_label()
        elif token.type == TokenType.GOTO:
            return self.parse_goto()
        elif token.type == TokenType.AS:
            return self.parse_as_statement()
        elif token.type == TokenType.AMPERSAND:
            return self.parse_address_of()
        elif token.type == TokenType.DEREF_VAR:
            return DereferenceNode(token)
        elif token.type == TokenType.IO:
            return self.parse_io_statement()
        
        # Handle the raw assembly block token
        elif token.type == TokenType.ASM_BLOCK:
            return AsmNode(token)
        
        # Fully implemented keywords and operators that are treated as "words"
        elif token.type in [
            TokenType.IDENTIFIER,
            TokenType.DUP, TokenType.SWAP, TokenType.DROP, TokenType.OVER,
            TokenType.PRINT,
            TokenType.PLUS, TokenType.MINUS, TokenType.MUL, TokenType.IDIV, TokenType.MOD,
            TokenType.EQ, TokenType.NEQ, TokenType.LT, TokenType.GT, TokenType.RND,
        ]:
            return WordNode(token)

        # Stubbed keywords for features in development (currently treated as words)
        elif token.type in [
            TokenType.ASM,
        ]:
            # Note: These will likely need their own specific parsing methods in the future.
            return WordNode(token)

        elif token.type == TokenType.ILLEGAL:
            self.errors.append(f"Parser error: Illegal token '{token.value}' found.")
            return None
        
        # Any other token at this level is unexpected. 
        # ELSE, END, OPEN_BRACE, CLOSE_BRACE should be handled by their parent structures.
        if token.type not in (TokenType.EOF, TokenType.ELSE, TokenType.END, TokenType.OPEN_BRACE, TokenType.CLOSE_BRACE, TokenType.DO, TokenType.DONE, TokenType.USE):
            # Special case for USE, which we now handle properly
            self.errors.append(f"Parser error: Unexpected token '{token.value}'.")
        elif token.type == TokenType.USE:
            return self.parse_use_statement()
        return None

    def parse_if_statement(self):
        self.advance() # Consume 'IF'
        
        true_branch = ProgramNode()
        while self.current_token.type not in (TokenType.ELSE, TokenType.END, TokenType.EOF):
            statement = self.parse_statement()
            if statement:
                true_branch.statements.append(statement)
            self.advance()

        false_branch = None
        if self.current_token.type == TokenType.ELSE:
            self.advance() # Consume 'ELSE'
            false_branch = ProgramNode()
            while self.current_token.type not in (TokenType.END, TokenType.EOF):
                statement = self.parse_statement()
                if statement:
                    false_branch.statements.append(statement)
                self.advance()

        if self.current_token.type != TokenType.END:
            self.errors.append("Parser error: Expected 'END' to close 'IF' block.")
        
        return IfNode(true_branch, false_branch)

    def parse_while_statement(self):
        self.advance() # Consume 'WHILE'
        
        condition = ProgramNode()
        while self.current_token.type not in (TokenType.DO, TokenType.EOF):
            statement = self.parse_statement()
            if statement:
                condition.statements.append(statement)
            self.advance()

        if self.current_token.type != TokenType.DO:
            self.errors.append("Parser error: Expected 'DO' to start 'WHILE' loop body.")
            return None
        
        self.advance() # Consume 'DO'
        
        body = ProgramNode()
        while self.current_token.type not in (TokenType.DONE, TokenType.EOF):
            statement = self.parse_statement()
            if statement:
                body.statements.append(statement)
            self.advance()

        if self.current_token.type != TokenType.DONE:
            self.errors.append("Parser error: Expected 'DONE' to close 'WHILE' loop.")
        
        return WhileNode(condition, body)

    def parse_function_definition(self):
        self.advance() # Consume 'DEF'

        if self.current_token.type != TokenType.IDENTIFIER:
            self.errors.append("Parser error: Expected function name after 'DEF'.")
            return None
        name = self.current_token.value
        self.advance() # Consume function name

        if self.current_token.type != TokenType.OPEN_BRACE:
            self.errors.append("Parser error: Expected '{' after function name.")
            return None
        self.advance() # Consume '{'

        body = ProgramNode()
        while self.current_token.type not in (TokenType.CLOSE_BRACE, TokenType.EOF):
            statement = self.parse_statement()
            if statement:
                body.statements.append(statement)
            self.advance()

        if self.current_token.type != TokenType.CLOSE_BRACE:
            self.errors.append("Parser error: Expected '}' to close function definition.")
            return None
        
        return FunctionDefinitionNode(name, body)

    def parse_backtick_call(self):
        self.advance() # Consume '`'

        if self.current_token.type != TokenType.IDENTIFIER:
            self.errors.append("Parser error: Expected identifier after '`'.")
            return None
        
        routine_name_token = self.current_token
        return BacktickNode(routine_name_token)

    def parse_label(self):
        self.advance() # consume ':'
        if self.current_token.type != TokenType.IDENTIFIER:
            self.errors.append(f"Parser error: Expected label name after ':'.")
            return None
        label_name = self.current_token.value
        return LabelNode(label_name)

    def parse_goto(self):
        self.advance() # consume 'GOTO'
        if self.current_token.type != TokenType.IDENTIFIER:
            self.errors.append(f"Parser error: Expected label name after 'GOTO'.")
            return None
        label_name = self.current_token.value
        return GotoNode(label_name)

    def parse_address_of(self):
        self.advance() # consume '&'
        if self.current_token.type != TokenType.IDENTIFIER:
            self.errors.append(f"Parser error: Expected identifier after '&'.")
            return None
        return AddressOfNode(self.current_token)

    def parse_as_statement(self):
        self.advance() # Consume 'AS'

        dereference = False
        
        if self.current_token.type == TokenType.DEREF_VAR:
            dereference = True
            var_name_token = self.current_token
        elif self.current_token.type == TokenType.IDENTIFIER:
            var_name_token = self.current_token
        else:
            self.errors.append("Parser error: Expected identifier or *identifier after 'AS'.")
            return None
        
        return AsNode(var_name_token, dereference)

    def parse_io_statement(self):
        self.advance() # Consume 'IO'

        if self.current_token.type != TokenType.NUMBER:
            self.errors.append(f"Parser error: Expected channel number after 'IO', but got {self.current_token.type}.")
            return None
        channel_token = self.current_token
        self.advance() # Consume channel number

        if self.current_token.type != TokenType.IDENTIFIER:
            self.errors.append(f"Parser error: Expected command identifier (e.g., SEND, GET) after channel, but got {self.current_token.type}.")
            return None
        command_token = self.current_token
        # The command token value will be validated in the code generator.

        return IONode(channel_token, command_token)

    def parse_use_statement(self):
        self.advance() # Consume 'USE'

        if self.current_token.type != TokenType.IDENTIFIER:
            self.errors.append(f"Parser error: Expected module name (identifier) after 'USE', but got {self.current_token.type}.")
            return None
        
        module_name_token = self.current_token
        return UseNode(module_name_token)


    def parse_declaration(self):
        decl_token = self.current_token
        self.advance() # consume keyword

        if self.current_token.type != TokenType.IDENTIFIER:
            self.errors.append(f"Expected identifier after {decl_token.value}, but got {self.current_token.type}")
            return None
        
        var_name_token = self.current_token
        self.advance() # consume identifier

        # Handle LIST name size
        if decl_token.type == TokenType.KEYWORD_LIST:
            if self.current_token.type != TokenType.NUMBER:
                self.errors.append(f"Expected size (number) for LIST, but got {self.current_token.type}")
                return None
            size_token = self.current_token
            return VarDeclarationNode(decl_type='LIST', var_name=var_name_token.value, size=size_token.value)

        # Handle STRING name "content"
        elif decl_token.type == TokenType.KEYWORD_STRING:
            if self.current_token.type != TokenType.STRING:
                self.errors.append(f"Expected string literal for STRING, but got {self.current_token.type}")
                return None
            string_token = self.current_token
            return VarDeclarationNode(decl_type='STRING', var_name=var_name_token.value, initial_value=string_token.value)

        # Handle VAR name address
        elif decl_token.type == TokenType.KEYWORD_VAR:
            if self.current_token.type != TokenType.NUMBER:
                self.errors.append(f"Expected address (number) for VAR, but got {self.current_token.type}")
                return None
            address_token = self.current_token
            # Using 'initial_value' to store the address for the node
            return VarDeclarationNode(decl_type='VAR', var_name=var_name_token.value, initial_value=address_token.value)

        # Handle VALUE name initial_value
        elif decl_token.type == TokenType.KEYWORD_VALUE:
            if self.current_token.type != TokenType.NUMBER:
                self.errors.append(f"Expected initial value (number) for VALUE, but got {self.current_token.type}")
                return None
            value_token = self.current_token
            return VarDeclarationNode(decl_type='VALUE', var_name=var_name_token.value, initial_value=value_token.value)
        
        return None # Should not be reached

# --- Main (for testing) ----------------------------------------------------

if __name__ == '__main__':
    source = ':start VAR my_ptr 1024 VALUE my_val 42 STRING my_greeting "hello" LIST my_buffer 100 goto start'
    lexer = Lexer(source)
    parser = Parser(lexer)
    ast = parser.parse()

    print(f"Parsing source: \"{source}\"\n")
    print("--- AST ---")
    print(ast)

    if parser.errors:
        print("\n--- ERRORS ---")
        for err in parser.errors:
            print(err)

    if lexer.errors:
        print("\n--- LEXER ERRORS ---")
        for err in lexer.errors:
            print(err)
