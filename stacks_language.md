# The Stacks Programming Language

## Introduction

Stacks is a custom, Forth-like programming language designed for the Stern-XT computer simulation. It is a stack-based language that uses Reverse Polish Notation (RPN) for all of its operations. The language is processed by a sophisticated three-phase interpreter that supports both direct "immediate mode" execution and the compilation and execution of multi-line programs.

Key features include variables, conditional logic, loops, labels with `GOTO`, and user-defined functions.

## Core Concepts

### The Data Stack

All operations in Stacks work on a central data stack. Numbers are pushed onto the stack, and operators or commands consume (pop) values from the stack, perform an operation, and push the result back onto the stack.

For example, to calculate `(5 + 3) * 2`, you would write:
`5 3 + 2 *`

1.  `5` is pushed. Stack: `[5]`
2.  `3` is pushed. Stack: `[5, 3]`
3.  `+` pops 3 and 5, adds them, and pushes 8. Stack: `[8]`
4.  `2` is pushed. Stack: `[8, 2]`
5.  `*` pops 2 and 8, multiplies them, and pushes 16. Stack: `[16]`

### Immediate Mode vs. Program Mode

The Stacks interpreter can be used in two ways:

*   **Immediate Mode:** You can type commands directly at the prompt, and they execute instantly. This is useful for quick calculations or inspecting the stack. Complex control flow like `IF` or `GOTO` is not supported in this mode.
*   **Program Mode:** You can load a script from the virtual disk (e.g., `load my_program.txt`) and then execute the entire program at once with the `run` command. This is the standard way to run complex applications.

## Language Reference

### Stack Manipulation

*   `DUP`: Duplicates the top item on the stack.
*   `SWAP`: Swaps the top two items on the stack.
*   `DROP`: Removes the top item from the stack.
*   `OVER`: Copies the second item from the top and pushes it onto the stack.

### Arithmetic

*   `+`, `-`, `*`, `/`, `%`: Standard arithmetic operators. They each pop two values and push the result.

### Variables

Stacks supports 26 single-letter variables (A-Z).

*   `<value> A !`: Stores the `<value>` from the top of the stack into variable A.
*   `A @`: Retrieves the value from variable A and pushes it onto the stack.

### Output

*   `PRINT`: Pops the top value from the stack and prints it to the screen.

### Comparisons

These operators pop two values, compare them, and push a result (`1` for true, `0` for false).

*   `==`: Equal
*   `!=`: Not Equal
*   `>`: Greater Than
*   `<`: Less Than

### Conditional Logic

The `IF/ELSE/END` construct allows for conditional execution.

**Syntax:** `condition IF ... ELSE ... END`

*   The `condition` should evaluate to a non-zero value (true) or zero (false).
*   The `ELSE` block is optional.

**Example:**
```forth
10 5 > IF
    1 PRINT # Will execute
ELSE
    0 PRINT
END
```

### Loops

The `WHILE/DO/DONE` construct creates a loop that runs as long as a condition is true.

**Syntax:** `condition WHILE ... DO ... DONE`

*   The loop first evaluates the `WHILE` part. If the result is true (non-zero), the `DO` block is executed.
*   The `DONE` keyword marks the end of the loop body.

**Example:**
```forth
0 A ! # Initialize A to 0
WHILE A @ 5 < DO
    A @ PRINT
    A @ 1 + A !
DONE
# Output: 0 1 2 3 4
```

### Labels and GOTO

The interpreter supports unconditional jumps to labels within the code.

*   `:my_label`: Defines a label named `my_label`.
*   `GOTO my_label`: Immediately jumps execution to that label.

### Functions

This is the most powerful feature of the Stacks language. It allows you to define reusable blocks of code as named functions.

**Syntax:** `DEF function_name { ... body ... }`

*   `DEF`: The keyword to start a function definition.
*   `function_name`: The name you will use to call the function.
*   `{ ... }`: The body of the function, containing any valid Stacks code.

Functions can call other functions, and all standard operations work inside them.

**Example:**
```forth
# Define a function to square a number
DEF square {
    DUP *
}

# Call the function
5 square PRINT # Pushes 5, calls square, prints the result (25)
```

---

## The Stacks Interpreter: How It Works

The interpreter is a sophisticated system that processes Stacks code in three distinct phases.

### Phase 1: The Scan Phase

Before any code is compiled, the interpreter performs a quick first pass over the entire program. The sole purpose of this phase is to find all `:label` definitions. It records the name of each label and its future memory address in a lookup table. This allows the `GOTO` command to know the correct address to jump to during execution. This phase is smart enough to ignore all code inside `DEF { ... }` blocks, as labels are not allowed inside functions.

### Phase 2: The Compile Phase

This is where the human-readable source code is translated into a compact, numeric, and efficient format called bytecode. The compiler reads each token (a number, a variable, or a command) and writes a corresponding numeric instruction to the `$CODE_BUFFER`.

*   **Control Flow:** For complex structures like `IF/ELSE/END` and `WHILE/DO/DONE`, the compiler writes placeholder jump addresses into the bytecode. It uses an internal "placeholder stack" to remember the location of these placeholders. When it finds the corresponding `END` or `DONE`, it goes back and "patches" the placeholder with the correct destination address.
*   **Function Compilation:** When the compiler sees the `DEF` keyword, it performs a special action. It temporarily switches its output from the main `$CODE_BUFFER` to a separate `$FUNCTION_BUFFER`. It then compiles the entire body of the function into this separate memory area. When it sees the closing `}`, it writes a special `~ret` (return) instruction, updates its pointers, and switches back to compiling the main program.

### Phase 3: The Execution Phase

This is the final and fastest phase. The executor runs a simple loop that reads the bytecode instructions one by one from the `$CODE_BUFFER` and performs the required action.

*   **Function Calls:** The execution of functions is handled via a clever runtime mechanism. When the executor encounters an unknown word (an `~ident` token), it does not immediately throw an error. Instead, it searches the `$FUNCTION_HASH_TABLE` for a matching function name. 
    *   If a match is found, it performs a "call":
        1.  It saves its current state (the return address and the current base pointer) to the `$CALL_STACK`.
        2.  It "hijacks" its own pointers, setting its base pointer to the `$FUNCTION_BUFFER` and its instruction pointer to the start of the function code.
        3.  It continues its execution loop, now running the function's code.
    *   When it encounters the special `~ret` instruction at the end of a function, it pops the saved state from the `$CALL_STACK`, restoring its original pointers and seamlessly continuing execution of the main program.
    *   If no match is found in the function table, it then throws an "unknown word" error.

---

## Complete Example Program

This program demonstrates functions, nested calls, loops, and conditional logic all working together.

```forth
DEF square {
    DUP *
}

DEF square_if_large {
    DUP 5 >
    IF
        square
    ELSE
    END
}

0 A !

WHILE A @ 10 < DO
    A @ PRINT
    A @ square_if_large
    PRINT
    A @ 1 + A !
DONE
```

**Expected Output:**
```
0 0 1 1 2 2 3 3 4 4 5 5 6 36 7 49 8 64 9 81
```
