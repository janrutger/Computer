# Stacks Language Cheatsheet

## 1. Comments
- `#`: Full line or trailing comment.
- `;`: Inline comment.

## 2. Data Types & Literals
- **Integer**: `123`, `-45`
- **String Literal**: `"Hello"` (Pushes the memory address of the string).
- **Stack String**: `\"Hello"` (Pushes the DJB2 hash of the string, used for file handles).

## 3. Stack Manipulation
| Command | Description |
| :--- | :--- |
| `DUP` | Duplicate Top Of Stack (TOS). |
| `SWAP` | Swap top two elements. |
| `DROP` | Discard TOS. |
| `OVER` | Copy second element to top. |

## 4. Arithmetic & Logic
| Operator | Description |
| :--- | :--- |
| `+` | Addition |
| `-` | Subtraction |
| `*` | Multiplication |
| `//` | Integer Division |
| `%` | Modulo |
| `NEGATE` | Negate (x -> -x) |
| `ABS` | Absolute value |
| `RND` | Push random number |

## 5. Comparisons
| Operator | Description |
| :--- | :--- |
| `==` | Equal |
| `!=` | Not Equal |
| `<` | Less Than |
| `>` | Greater Than |

## 6. Variables & Memory
### Declarations
| Syntax | Description |
| :--- | :--- |
| `CONST name value` | Define compile-time constant (Number or String). |
| `VALUE name val` | Define global variable initialized to `val` (1 word). |
| `VAR name address` | Define a named pointer to a specific memory address. |
| `LIST name size` | Allocate `size` words in data section. |
| `STRING name "txt"` | Allocate string buffer initialized to `"txt"`. |

### Access & Assignment
| Syntax | Description |
| :--- | :--- |
| `name` | Push value of variable `name`. |
| `&name` | Push address of variable `name`. |
| `*name` | Dereference: Push value at address stored in `name`. |
| `val AS name` | Store `val` into variable `name`. |
| `val AS *name` | Store `val` into address stored in `name`. |

## 7. Control Flow
### Conditionals
```stacks
condition IF
    # Code executed if true
ELSE
    # Code executed if false
END
```

### Loops
```stacks
WHILE condition DO
    # Loop body
DONE
```

### Jumps
- `:label`: Define a label.
- `GOTO label`: Unconditional jump to label.

## 8. Functions & Macros
| Syntax | Description |
| :--- | :--- |
| `DEF name { ... }` | Define a function. |
| `MACRO name { ... }` | Define an inlined macro (No GOTO allowed). |
| `name` | Call function or expand macro. |
| `&name` | Push address of function. |
| `EXEC` | Execute function at address on TOS. |
| `` `name `` | Call internal runtime routine (e.g., `` `print_char ``). |

## 9. Input / Output
- **Syntax**: `IO channel command`
- **Channels**: Integer (e.g., 1 for Plotter, 2 for LCD-screen).
- **Commands**: `INIT`, `RESET`, `SEND`, `GET`, `COLOR`, `X`, `Y`, `DRAW`, `FLIP`, `MODE`, `ONLINE`, `OFFLINE`.

## 10. Modules
- `INCLUDE module_name`: Import symbols AND code (Static linking).
- `USE module_name`: Import symbols only (Headers/Forward declarations).

## 11. Inline Assembly
Allows injecting raw assembly instructions directly into the code.
```stacks
ASM {
    ldi A 0
    int 1
}
```

## 12. Debugging
- `PRINT`: Print value on TOS.

## 13. Example Program
```stacks
:start VAR ptr 1024 VALUE val 42 STRING msg "hello" LIST buf 100 goto start
```