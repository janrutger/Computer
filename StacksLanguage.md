# The Stacks Programming Language Manual

## 1. Introduction

Welcome to Stacks, a stack-oriented programming language designed for simplicity and low-level control for the Stern-XT computer. It compiles directly into Stern-XT assembly. Its syntax is minimal, and its operations are based on manipulating a central data stack using Reverse Polish Notation (RPN).

This manual provides a comprehensive guide to the language's features as implemented in the Stacks compiler.
---
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
The language supports two primary literal data types:

*   **Numbers:** Positive integers (e.g., `42`, `100`).
*   **Strings:** Sequences of characters enclosed in double quotes (e.g., `"hello world"`). When a string literal is used, a pointer to its memory location is pushed onto the stack.

---
## 2. Language Reference

### 2.1. Literals

*   **Numbers:** Any sequence of digits is treated as a number and its value is pushed onto the stack.
    ```
    123
    ```
*   **Strings:** Text enclosed in double quotes. This creates a string in the program's data section, and a pointer to it is pushed onto the stack.
    ```
    "This is a string"
    ```

### 2.2. Stack Manipulation

*   `DUP`: Duplicates the top item on the stack.
*   `SWAP`: Swaps the top two items on the stack.
*   `DROP`: Removes the top item from the stack.
*   `OVER`: Copies the second item from the top of the stack and pushes it to the top.

### 2.3. Arithmetic and Comparison

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

### 2.4. Variables and Data

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

#### Using Variables

*   **Reading a Value:** To push a variable's value onto the stack, simply use its name.
    ```
    my_var  # Pushes the value of my_var onto the stack
    ```
*   **Assigning a Value:** Use the `AS` keyword to pop a value from the stack and store it in a variable.
    ```
    100 AS my_var  # Sets my_var to 100
    ```

### 2.5. Pointers and Memory

*   **Getting an Address (`&`):** The `&` operator gets the memory address of a variable and pushes it onto the stack.
    ```
    &my_var  # Pushes the address of my_var
    ```
*   **Dereferencing (Reading):** The `*` operator before a variable name reads the value from the memory address *contained within* that variable.
    ```
    *my_pointer  # Reads from the address stored in my_pointer
    ```
*   **Dereferencing (Writing):** The `*` operator can also be used with `AS` to write to a memory address.
    ```
    42 AS *my_pointer # Writes 42 to the address stored in my_pointer
    ```

### 2.6. Control Flow

*   **Labels:** Define a location in the code.
    ```
    :my_label
    ```
*   `GOTO <label>`: Unconditionally jumps to the specified label.
    ```
    GOTO my_label
    ```
*   **Conditional Blocks (`IF`/`ELSE`/`END`):** The `IF` statement pops a value from the stack. If it's non-zero (true), the code block until `ELSE` or `END` is executed.
    ```
    1           # Push a "true" value
    IF
        "It was true!" PRINT
    ELSE
        "It was false!" PRINT
    END
    ```
*   **Loops (`WHILE`/`DO`/`DONE`):** The `WHILE` loop executes a block of code as long as a condition is true. The condition is evaluated at the start of each iteration.
    ```
    WHILE counter 0 > DO
        # Loop body
    DONE
    ```

### 2.7. Functions

*   **Definition:** Functions are defined using `DEF`, a name, and a body enclosed in curly braces `{}`. The function name becomes a new word in the language.
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

### 2.8. Hardware and System Interaction

*   **System Routines (Backtick):** Call low-level assembly routines directly using the backtick (`` ` ``).
    ```
    `rt_add  # Directly calls the runtime's addition routine
    ```
*   **Device I/O (`IO`):** Communicate with hardware devices through the Universal Device Controller (UDC).
    *   **Syntax:** `[value] IO <channel> <command>`
    *   The `IO` instruction interacts with the runtime, which expects `Value`, `Command`, and `Channel` on the stack. The compiler handles the stack setup.
    *   For commands that require a value from the stack (e.g., `SEND`), the value must be pushed first.
    *   For commands that do not require a value (e.g., `ONLINE`, `GET`), the compiler automatically pushes a dummy `0`.
    
    **Examples:**
    ```
    # Send the value 150 to the plotter on channel 1
    150 IO 1 SEND

    # Bring the plotter on channel 1 online
    IO 1 ONLINE

    # Get a value from a sensor on channel 0
    IO 0 GET
    ```

### 2.9. Miscellaneous

*   `PRINT`: Pops the top value from the stack and prints it to the console.
*   `RND`: Pushes a pseudo-random number onto the stack.

---
## 3. Code Examples

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