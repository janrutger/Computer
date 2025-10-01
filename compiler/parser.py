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
        # For now, treat all keywords, identifiers, and operators as "words"
        elif token.type in [
            TokenType.IDENTIFIER,
            # Keywords
            TokenType.DEF, TokenType.IF, TokenType.ELSE, TokenType.END,
            TokenType.WHILE, TokenType.DO, TokenType.DONE,
            TokenType.DUP, TokenType.SWAP, TokenType.DROP, TokenType.OVER,
            TokenType.RND, TokenType.IO, TokenType.USE, TokenType.ASM,
            TokenType.PRINT, TokenType.AS,
            # Operators
            TokenType.PLUS, TokenType.MINUS, TokenType.MUL, TokenType.IDIV, TokenType.MOD,
            TokenType.EQ, TokenType.NEQ, TokenType.LT, TokenType.GT,
            TokenType.BACKTICK, TokenType.OPEN_BRACE, TokenType.CLOSE_BRACE,
        ]:
            return WordNode(token)
        elif token.type == TokenType.ILLEGAL:
            self.errors.append(f"Parser error: Illegal token '{token.value}' found.")
            return None
        
        return None # Should not be reached if all tokens are handled

# --- Main (for testing) ----------------------------------------------------

if __name__ == '__main__':
    source = '10 20 + DUP "hello" SWAP IF 20 ELSE 30 END'
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
