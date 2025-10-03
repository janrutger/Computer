# The Stacks Programming Language Manual

## Introduction

Welcome to Stacks, a stack-oriented programming language designed for simplicity and low-level control. It compiles directly into an assembly-like language for a custom virtual machine. Its syntax is minimal, and its operations are based on manipulating a central data stack.

This manual provides a comprehensive guide to the language's features, based on its implementation in the compiler.

## Core Concepts

### Stack-Based Operations

Stacks is a stack-based language. This means that most operations work by taking their inputs from the top of a data stack and pushing their results back onto it.

For example, to add two numbers, you first push both numbers onto the stack and then call the addition operator (`+`). The operator will pop the top two numbers, add them, and push the sum back onto the stack.

**Example:**
`5 10 +`
1.  `5` is pushed onto the stack. Stack: `[5]`
2.  `10` is pushed onto the stack. Stack: `[5, 10]`
3.  `+` pops 10 and 5, calculates `5 + 10`, and pushes `15`. Stack: `[15]`

### Data Types

The language has two primary literal data types:

*   **Numbers:** Integers (e.g., `42`, `-100`).
*   **Strings:** Sequences of characters enclosed in double quotes (e.g., `"hello world"`). When a string literal is used in code, a pointer to its location in memory is pushed onto the stack.

## Language Reference

### 1. Literals

*   **Numbers:** Any sequence of digits is treated as a number and its value is pushed onto the stack.
    ```
    123
    ```
*   **Strings:** Text enclosed in double quotes. This creates a string in the program's data section, and a pointer to it is pushed onto the stack.
    ```
    "This is a string"
    ```

### 2. Stack Manipulation

*   `DUP`: Duplicates the top item on the stack.
*   `SWAP`: Swaps the top two items on the stack.
*   `DROP`: Removes the top item from the stack.
*   `OVER`: Copies the second item from the top of the stack and pushes it to the top.

### 3. Arithmetic and Comparison

These operators pop the required operands from the stack and push the result.

*   `+`: Addition
*   `-`: Subtraction
*   `*`: Multiplication
*   `//`: Integer Division
*   `%`: Modulo

*   `==`: Equality check. Pushes `1` for true, `0` for false.
*   `!=`: Inequality check.
*   `>`: Greater than.
*   `<`: Less than.

### 4. Variable and Data Declaration

Variables and data structures are declared at the top level.

*   `VALUE <name> <initial_value>`: Declares a single-value variable initialized with `<initial_value>`.
    ```
    VALUE my_var 42
    ```
*   `VAR <name> <address>`: Declares a variable that acts as a pointer to a memory address.
    ```
    VAR my_pointer 1024
    ```
*   `LIST <name> <size>`: Allocates a block of memory of `<size>` words and assigns its starting address to `<name>`.
    ```
    LIST my_buffer 100
    ```
*   `STRING <name> "<content>"`: Declares a null-terminated string in the data section and assigns its address to `<name>`.
    ```
    STRING greeting "Hello!"
    ```
To use a declared variable, simply use its name. This will push its value (or address for `VAR` and `LIST`) onto the stack.

### 5. Control Flow

*   **Labels:** Define a location in the code.
    ```
    :my_label
    ```
*   `GOTO <label>`: Unconditionally jumps to the specified label.
    ```
    GOTO my_label
    ```
*   **Conditional Blocks:** The `IF`/`ELSE`/`END` structure allows for conditional execution. The `IF` statement pops a value from the stack; if it's non-zero (true), the `true` branch is executed.
    ```
    1           # Push a "true" value
    IF
        "It was true!" PRINT
    ELSE
        "It was false!" PRINT
    END
    ```
    *(Note: The code generator implementation for `IF` is currently a placeholder and will be fully implemented in a future version.)*

### 6. Functions

*   **Definition:** Functions are defined using `DEF`, a name, and a body enclosed in curly braces `{}`.
    ```
    DEF my_function {
        # Function body
        DUP *   # Squares the number on top of the stack
    }
    ```
*   **Calling:** To call a function, simply use its name.
    ```
    5 my_function PRINT  # Pushes 5, calls the function, prints the result (25)
    ```

### 7. System Routines

The language provides a way to call low-level system routines using the backtick (`` ` ``) syntax.

*   `` `routine_name ``: Calls the specified system routine.
    ```
    `read_keyboard  # Example system call
    ```

### 8. Output

*   `PRINT`: Pops the top value from the stack and prints it to the standard output.

## Code Examples

### Example 1: Simple Arithmetic

```
# Calculate (5 + 10) * 2 and print it
5 10 + 2 * PRINT
```

### Example 2: Variables and Functions

```
# Declare a value and a function
VALUE start_value 3

DEF double_it {
    DUP +
}

# Use the variable and function
start_value double_it PRINT # Prints 6
```

### Example 3: Control Flow with GOTO

```
    VALUE counter 5

:loop
    counter PRINT
    counter 1 -
    DUP           # Duplicate the new value
    VALUE counter # Re-assign counter
    
    # If counter is not zero, loop again
    IF
        GOTO loop
    END
```