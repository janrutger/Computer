# compiler/lexer.py
from enum import Enum

class TokenType(Enum):
    # Literals
    NUMBER = "NUMBER"
    STRING = "STRING" # For literal values like "hello"
    
    # Identifiers
    IDENTIFIER = "IDENTIFIER"
    DEREF_VAR = "DEREF_VAR" # For *varname

    # Keywords
    DEF = "DEF"
    IF = "IF"
    ELSE = "ELSE"
    END = "END"
    WHILE = "WHILE"
    DO = "DO"
    DONE = "DONE"
    DUP = "DUP"
    SWAP = "SWAP"
    DROP = "DROP"
    OVER = "OVER"
    RND = "RND"
    IO = "IO"
    USE = "USE"
    INCLUDE = "INCLUDE"
    ASM = "ASM"
    PRINT = "PRINT"
    ASM_BLOCK = "ASM_BLOCK" # A special token for the raw assembly code
    AS = "AS"
    GOTO = "GOTO"


    # Declaration Keywords
    KEYWORD_VAR = "KEYWORD_VAR"
    KEYWORD_LIST = "KEYWORD_LIST"
    KEYWORD_STRING = "KEYWORD_STRING"
    KEYWORD_VALUE = "KEYWORD_VALUE"
    KEYWORD_CONST = "KEYWORD_CONST"

    # Operators
    PLUS = "+"
    MINUS = "-"
    MUL = "*"
    IDIV = "//"     # intger Divison
    MOD = "%"       # modulo

    EQ = "=="
    NEQ = "!="
    LT = "<"
    GT = ">"

    AMPERSAND = "&"
    COLON = ":"
    BACKTICK = "`"
    OPEN_BRACE = "{"
    CLOSE_BRACE = "}"
   
    # Special Tokens
    ILLEGAL = "ILLEGAL"
    EOF = "EOF"

# Map string keywords to their TokenType
KEYWORDS = {
    "DEF": TokenType.DEF,
    "IF": TokenType.IF,
    "ELSE": TokenType.ELSE,
    "END": TokenType.END,
    "WHILE": TokenType.WHILE,
    "DO": TokenType.DO,
    "DONE": TokenType.DONE,
    "DUP": TokenType.DUP,
    "SWAP": TokenType.SWAP,
    "DROP": TokenType.DROP,
    "OVER": TokenType.OVER,
    "RND": TokenType.RND,
    "IO": TokenType.IO,
    "USE": TokenType.USE,
    "INCLUDE": TokenType.INCLUDE,
    "ASM": TokenType.ASM,
    "PRINT": TokenType.PRINT,
    "AS": TokenType.AS,
    # Declaration Keywords
    "VAR": TokenType.KEYWORD_VAR,
    "LIST": TokenType.KEYWORD_LIST,
    "STRING": TokenType.KEYWORD_STRING,
    "VALUE": TokenType.KEYWORD_VALUE,
    "GOTO": TokenType.GOTO,
    "CONST": TokenType.KEYWORD_CONST,
    
}

class Token:
    def __init__(self, type, value=None, line=1, column=1):
        self.type = type
        self.value = value
        self.line = line
        self.column = column

    def __repr__(self):
        return f"Token({self.type}, {repr(self.value)})"

class Lexer:
    def __init__(self, source_code):
        self.source = source_code
        self.errors = []
        self.pos = 0
        self.current_char = self.source[self.pos] if self.pos < len(self.source) else None
        self.line = 1
        self.column = 1

    def advance(self):
        if self.current_char == '\n':
            self.line += 1
            self.column = 0
        self.pos += 1
        self.column += 1
        self.current_char = self.source[self.pos] if self.pos < len(self.source) else None

    def peek(self):
        peek_pos = self.pos + 1
        if peek_pos < len(self.source):
            return self.source[peek_pos]
        return None

    def skip_whitespace(self):
        while self.current_char is not None and self.current_char.isspace():
            self.advance()

    def skip_comment(self):
        while self.current_char is not None and self.current_char != '\n':
            self.advance()

    def get_number(self):
        result = ''
        start_column = self.column
        while self.current_char is not None and self.current_char.isdigit():
            result += self.current_char
            self.advance()

        if self.current_char is not None and self.current_char.isalpha():
            # This is a malformed number (e.g., "123a").
            # Consume the rest of the alphanumeric part.
            while self.current_char is not None and self.current_char.isalnum():
                result += self.current_char
                self.advance()
            
            error_msg = f"Lexer error: Invalid number format '{result}' at line {self.line}, column {start_column}"
            self.errors.append(error_msg)
            return Token(TokenType.ILLEGAL, result, self.line, start_column)
        
        return Token(TokenType.NUMBER, int(result), self.line, start_column)

    def get_string(self):
        result = ''
        start_line = self.line
        start_column = self.column
        self.advance()  # Consume the opening "

        while self.current_char is not None and self.current_char != '"':
            result += self.current_char
            self.advance()

        if self.current_char is None:
            # Unterminated string
            error_msg = f"Lexer error: Unterminated string literal at line {self.line}, column {self.column}"
            self.errors.append(error_msg)
            return Token(TokenType.ILLEGAL, result, start_line, start_column)

        # Found the closing quote
        self.advance()  # Consume the closing "
        return Token(TokenType.STRING, result, start_line, start_column)

    def get_identifier(self):
        result = ''
        start_column = self.column
        while self.current_char is not None and (self.current_char.isalnum() or self.current_char == '_') or self.current_char == '.':
            result += self.current_char
            self.advance()
        
        # check if it is an keyword, otherwise its an identifier
        token_type = KEYWORDS.get(result.upper(), TokenType.IDENTIFIER)
        return Token(token_type, result, self.line, start_column)

    def get_asm_block(self):
        """
        Consumes and returns the raw text inside an ASM { ... } block.
        This method is called after the 'ASM {' has been seen.
        """
        result = ''
        start_line = self.line
        start_column = self.column
        brace_level = 1

        while self.current_char is not None:
            if self.current_char == '{':
                brace_level += 1
            elif self.current_char == '}':
                brace_level -= 1
                if brace_level == 0:
                    self.advance() # Consume the final '}'
                    return Token(TokenType.ASM_BLOCK, result, start_line, start_column)
            
            result += self.current_char
            self.advance()
        
        self.errors.append(f"Lexer error: Unterminated ASM block starting at line {start_line}")
        return Token(TokenType.ILLEGAL, result, start_line, start_column)

    def get_next_token(self):
        while self.current_char is not None:
            if self.current_char.isspace():
                self.skip_whitespace()
                continue

            # Handle full-line comments
            if self.current_char == '#':
                self.skip_comment()
                continue
            # Handle inline/end-of-line comments
            if self.current_char == ';':
                self.skip_comment()
                continue

            if self.current_char == '"':
                return self.get_string()

            if self.current_char.isdigit():
                return self.get_number()

            if self.current_char.isalpha() or self.current_char == '_':
                identifier_token = self.get_identifier()
                # Check if the identifier is 'ASM' followed by '{'
                if identifier_token.type == TokenType.ASM:
                    self.skip_whitespace()
                    if self.current_char == '{':
                        self.advance() # Consume '{'
                        return self.get_asm_block()
                
                return identifier_token

            if self.current_char == '/' and self.peek() == '/':
                start_column = self.column
                self.advance()
                self.advance()
                return Token(TokenType.IDIV, '//', self.line, start_column)

            if self.current_char == '=' and self.peek() == '=':
                start_column = self.column
                self.advance()
                self.advance()
                return Token(TokenType.EQ, '==', self.line, start_column)

            if self.current_char == '!' and self.peek() == '=':
                start_column = self.column
                self.advance()
                self.advance()
                return Token(TokenType.NEQ, '!=', self.line, start_column)

            if self.current_char == '+' :
                token = Token(TokenType.PLUS, '+', self.line, self.column)
                self.advance()
                return token

            if self.current_char == '-' :
                token = Token(TokenType.MINUS, '-', self.line, self.column)
                self.advance()
                return token
            
            if self.current_char == '*' :
                peek_char = self.peek()
                if peek_char is not None and (peek_char.isalpha() or peek_char == '_'):
                    start_line = self.line
                    start_column = self.column
                    self.advance() # consume the '*'.
                    identifier_token = self.get_identifier()
                    return Token(TokenType.DEREF_VAR, identifier_token.value, start_line, start_column)
                else:
                    # This is multiplication
                    token = Token(TokenType.MUL, '*', self.line, self.column)
                    self.advance()
                    return token

            if self.current_char == '%' :
                token = Token(TokenType.MOD, '%', self.line, self.column)
                self.advance()
                return token
            
            if self.current_char == '>' :
                token = Token(TokenType.GT, '>', self.line, self.column)
                self.advance()
                return token

            if self.current_char == '<' :
                token = Token(TokenType.LT, '<', self.line, self.column)
                self.advance()
                return token
            
            if self.current_char == '{' :
                token = Token(TokenType.OPEN_BRACE, '{', self.line, self.column)
                self.advance()
                return token
            
            if self.current_char == '}' :
                token = Token(TokenType.CLOSE_BRACE, '}', self.line, self.column)
                self.advance()
                return token

            if self.current_char == ':' :
                token = Token(TokenType.COLON, ':', self.line, self.column)
                self.advance()
                return token

            if self.current_char == '`' :
                token = Token(TokenType.BACKTICK, '`', self.line, self.column)
                self.advance()
                return token

            if self.current_char == '&' :
                token = Token(TokenType.AMPERSAND, '&', self.line, self.column)
                self.advance()
                return token
            
            error_msg = f"Lexer error: Illegal character '{self.current_char}' at line {self.line}, column {self.column}"
            self.errors.append(error_msg)
            char = self.current_char
            token = Token(TokenType.ILLEGAL, char, self.line, self.column)
            self.advance()
            return token
        
        return Token(TokenType.EOF, None, self.line, self.column)

if __name__ == '__main__':
    source = 'VAR my_var 100 LIST my_list 20 STRING my_str "hello"'
    lexer = Lexer(source)

    print(f"Tokenizing source: \"{source}\"\n")

    tokens = []
    token = lexer.get_next_token()
    while token.type != TokenType.EOF:
        tokens.append(token)
        token = lexer.get_next_token()
    tokens.append(token)

    print("--- TOKENS ---")
    for t in tokens:
        print(t)
    
    if lexer.errors:
        print("\n--- ERRORS ---")
        for err in lexer.errors:
            print(err)
