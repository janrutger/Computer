# Stacks Programming Language Manual

## 1. Introduction

**Stacks** is a high-level, stack-oriented programming language designed for the Stern-ATX computer system. It combines the simplicity and power of Reverse Polish Notation (RPN) with structured programming constructs like loops, conditionals, and functions. Stacks compiles directly to Stern-ATX assembly language, providing efficient execution on the virtual hardware.

## 2. Core Concepts

### 2.1 The Data Stack
Stacks operates primarily on a Last-In, First-Out (LIFO) data stack. Most operations consume arguments from the top of the stack and push their results back onto it.

*   **Pushing Data**: Writing a number or variable name pushes its value onto the stack.
*   **Popping Data**: Operations like `+` or `PRINT` remove items from the stack.

### 2.2 Reverse Polish Notation (RPN)
In Stacks, the operator follows its operands.
*   Infix: `3 + 4`
*   Stacks: `3 4 +`

This eliminates the need for parentheses and operator precedence rules.

## 3. Syntax and Structure

### 3.1 Comments
Comments start with `#` or `;` and continue to the end of the line.

```stacks
# This is a comment
10 20 + ; This is also a comment
```

### 3.2 Literals
*   **Numbers**: Integers (e.g., `42`, `-10`).
*   **Strings**: Text enclosed in double quotes (e.g., `"Hello World"`). Pushing a string literal pushes the *address* of the string onto the stack.

## 4. Variables and Constants

### 4.1 Declarations
Variables must be declared before use.

*   **`VALUE name initial_value`**: Declares a single-word variable initialized to a value.
    ```stacks
    VALUE score 0
    ```
*   **`VAR name address`**: Declares a variable that points to a specific, fixed memory address (useful for memory-mapped I/O).
    ```stacks
    VAR keyboard_data 18424
    ```
*   **`LIST name size`**: Allocates a block of memory of the specified size. `name` becomes a pointer to the start of the block.
    ```stacks
    LIST buffer 100
    ```
*   **`STRING name "content"`**: Allocates memory for a string and initializes it. `name` is a pointer to the string.
    ```stacks
    STRING greeting "Welcome!"
    ```
*   **`CONST name value`**: Defines a compile-time constant. The value is substituted wherever the name appears.
    ```stacks
    CONST MAX_LIVES 3
    ```

### 4.2 Assignment and Access

*   **Reading**: Simply using the variable name pushes its value (or address for LIST/STRING) onto the stack.
    ```stacks
    score       # Pushes the value of 'score'
    ```
*   **Writing (`AS`)**: The `AS` keyword pops a value from the stack and stores it in a variable.
    ```stacks
    100 AS score
    ```
*   **Pointers (`&` and `*`)**:
    *   `&var`: Pushes the *address* of the variable `var`.
    *   `*var`: Dereferences the pointer stored in `var` (reads the value at that address).
    *   `AS *var`: Stores the value into the address pointed to by `var`.

## 5. Stack Manipulation

Standard stack operators are available to manage data flow.

| Keyword | Stack Effect (Before -- After) | Description |
| :--- | :--- | :--- |
| `DUP` | `( a -- a a )` | Duplicates the top item. |
| `SWAP` | `( a b -- b a )` | Swaps the top two items. |
| `DROP` | `( a -- )` | Discards the top item. |
| `OVER` | `( a b -- a b a )` | Copies the second item to the top. |

## 6. Arithmetic and Logic

| Operator | Description |
| :--- | :--- |
| `+` | Addition |
| `-` | Subtraction |
| `*` | Multiplication |
| `//` | Integer Division |
| `%` | Modulo |
| `NEGATE` | Negates the top value (`x` -> `-x`) |
| `ABS` | Absolute value |
| `RND` | Pushes a random integer |

### Comparisons
Comparison operators consume two values and push `1` (True) or `0` (False).

*   `==` (Equal)
*   `!=` (Not Equal)
*   `<` (Less Than)
*   `>` (Greater Than)

## 7. Control Flow

### 7.1 Conditionals (`IF` ... `ELSE` ... `END`)
Executes code based on the value on top of the stack. If the value is non-zero (True), the `IF` block runs.

```stacks
score 100 > IF
    "High Score!" PRINT
ELSE
    "Keep trying" PRINT
END
```

### 7.2 Loops (`WHILE` ... `DO` ... `DONE`)
Repeats the block as long as the condition is true.

```stacks
0 AS i
WHILE i 10 < DO
    i PRINT
    i 1 + AS i
DONE
```

### 7.3 Labels and Goto
*   **`:label`**: Defines a jump target.
*   **`GOTO :label`**: Unconditionally jumps to the label.

```stacks
:loop_start
    # ... code ...
    GOTO :loop_start
```

## 8. Functions

Functions are defined using `DEF` and called by their name.

```stacks
DEF square {
    DUP *
}

5 square PRINT  # Output: 25
```

## 9. Input / Output (IO)

The `IO` keyword interfaces with the Universal Device Controller (UDC).

**Syntax**: `[value] channel IO command`

*   **`channel`**: The UDC channel number (0-7).
*   **`command`**: The command to execute (e.g., `SEND`, `GET`, `DRAW`).
*   **`[value]`**: An optional argument required by some commands.

**Examples:**
```stacks
# Initialize device on channel 1
1 IO INIT

# Send value 50 to plotter on channel 1
50 1 IO SEND

# Read value from sensor on channel 0
0 IO GET
```

## 10. Modules and Libraries

Stacks supports modular programming.

*   **`USE module_name`**: Links a compiled library module (`.smod`). This makes the module's functions and variables available to your program.
*   **`INCLUDE module_name`**: Includes the source of another module directly.

## 11. Low-Level Access

For low-level control, Stacks provides mechanisms to interact directly with the underlying assembly environment.

### 11.1 Inline Assembly
You can embed raw Stern-ATX assembly code using the `ASM` block.

```stacks
ASM {
    ldi A 10
    move_reg B A
}
```

## 12. Example Program

```stacks
# Calculate Factorial

VALUE n 5
VALUE result 1

DEF factorial {
    # Stack: ( n -- n! )
    1 AS result
    
    WHILE DUP 1 > DO
        DUP result * AS result
        1 -
    DONE
    DROP # Drop the counter (which is now 1)
    result
}

n factorial PRINT
```