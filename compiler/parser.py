# compiler/parser.py

from .lexer import Lexer, Token, TokenType

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

class IfNode(ASTNode):
    def __init__(self, true_branch, false_branch=None):
        self.true_branch = true_branch
        self.false_branch = false_branch

    def __repr__(self):
        return f"IfNode(true={self.true_branch}, false={self.false_branch})"

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
        elif token.type in (TokenType.KEYWORD_VAR, TokenType.KEYWORD_VALUE, TokenType.KEYWORD_LIST, TokenType.KEYWORD_STRING):
            return self.parse_declaration()
        # For now, treat all keywords, identifiers, and operators as "words"
        elif token.type in [
            TokenType.IDENTIFIER,
            # Keywords
            TokenType.DEF,
            TokenType.WHILE, TokenType.DO, TokenType.DONE,
            TokenType.DUP, TokenType.SWAP, TokenType.DROP, TokenType.OVER,
            TokenType.RND, TokenType.IO, TokenType.USE, TokenType.ASM,
            TokenType.PRINT, TokenType.AS,
            # Operators
            TokenType.PLUS, TokenType.MINUS, TokenType.MUL, TokenType.IDIV, TokenType.MOD,
            TokenType.EQ, TokenType.NEQ, TokenType.LT, TokenType.GT,
            TokenType.BACKTICK, TokenType.OPEN_BRACE, TokenType.CLOSE_BRACE,
        ]:
            # We don't want to parse ELSE and END as standalone words here
            if token.type in (TokenType.ELSE, TokenType.END):
                self.errors.append(f"Parser error: Unexpected token '{token.value}'.")
                return None
            return WordNode(token)
        elif token.type == TokenType.ILLEGAL:
            self.errors.append(f"Parser error: Illegal token '{token.value}' found.")
            return None
        
        return None # Should not be reached if all tokens are handled

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
    source = 'VAR my_ptr 1024 VALUE my_val 42 STRING my_greeting "hello" LIST my_buffer 100'
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
