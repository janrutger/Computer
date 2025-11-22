# Stacks Language Library Reference

This document provides an overview of the methods available in the standard Stacks language libraries.

### `disk_utils.stacks`

*   `_read_disk_block`: Reads a block from the disk.
*   `_check_last_block`: Checks if the last read block was the final one.
*   `_read_next_block`: Reads the next block from the disk.
*   `load_bin_file`: Loads a binary file from disk into memory.

### `fixed_point_lib.stacks`

*   `FP.set_scale`: Sets the scale factor for fixed-point numbers.
*   `FP.from_int`: Converts an integer to a fixed-point number.
*   `FP.to_int`: Converts a fixed-point number to an integer (truncates).
*   `FP.add`: Adds two fixed-point numbers.
*   `FP.sub`: Subtracts two fixed-point numbers.
*   `FP.mul`: Multiplies two fixed-point numbers.
*   `FP.div`: Divides two fixed-point numbers.
*   `FP.power`: Calculates `fp_base ^ int_exponent`.
*   `FP.print`: Prints a fixed-point number.
*   `FP.fprint`: Prints a fixed-point number with a specified number of decimal places.
*   `FP.from_string`: Converts a string (e.g., "12.34") to a fixed-point number.

### `heaper_lib.stacks` (Array and Heap Management)

*   `HEAP.init`: Initializes the heap allocator. `( heap_start_ptr heap_size -- )`
*   `NEW.array`: Creates a new array on the heap. `( requested_capacity -- new_array_pointer )`
*   `ARRAY.append`: Appends an element to an array. `( value array_ptr -- )`
*   `ARRAY.put`: Updates a value at a specific index in an array. `( value index array_ptr -- )`
*   `ARRAY.get`: Reads a value from a specific index in an array. `( index array_ptr -- value )`
*   `ARRAY.size`: Returns the total capacity of an array. `( array_ptr -- capacity )`
*   `ARRAY.len`: Returns the current number of elements in an array. `( array_ptr -- count )`

### `math_lib.stacks`

*   `gcd`: Calculates the greatest common divisor of two numbers.
*   `power`: Calculates integer power (`base^exp`).
*   `factorial`: Calculates the factorial of a number.
*   `negate`: Negates the top of the stack.
*   `abs`: Computes the absolute value of the top of the stack.

### `parser_tools.stacks`

*   `TOKENIZE`: Splits a string by a delimiter.
*   `WRITE_TO_BYTECODE`: Writes an opcode and optional value to the bytecode buffer.
*   `EXECUTE_BYTECODE`: Executes bytecode from a buffer.

### `std_stacks_rt.stacks` (Stacks Runtime)

*   `rt_eq`: Checks for equality (`==`).
*   `rt_neq`: Checks for inequality (`!=`).
*   `rt_gt`: Checks for greater than (`>`).
*   `rt_lt`: Checks for less than (`<`).
*   `rt_dup`: Duplicates the top of the stack.
*   `rt_swap`: Swaps the top two items on the stack.
*   `rt_drop`: Removes the top item from the stack.
*   `rt_over`: Copies the second item from the top of the stack to the top.
*   `rt_print_tos`: Prints the top of the stack as a number.
*   `rt_udc_control`: Sends a control command to a Universal Device Controller.
*   `rt_rnd`: Generates a pseudo-random number.

### `std_stern_io.stacks` (Standard I/O)

*   `io_lib_init`: Initializes the I/O library.
*   `PRTchar`: Prints a single character from the top of the stack.
*   `PRTstring`: Prints a null-terminated string.
*   `PRTnum`: Prints a number from the top of the stack.
*   `PRTcls`: Clears the screen.
*   `CURSORon`: Shows the cursor.
*   `CURSORoff`: Hides the cursor.
*   `KEYchar`: Waits for and reads a character from the keyboard (blocking).
*   `KEYpressed`: Checks if a key has been pressed (non-blocking).
*   `READline`: Reads a line of text from the user.
*   `TOS.check`: Returns the depth of the stack.
*   `HALT`: Halts program execution with an error message.

### `std_string.stacks`

*   `STRcmp`: Compares two strings for equality.
*   `STRatoi`: Converts an ASCII string to an integer.
*   `STRlen`: Calculates the length of a string.
*   `STRfind`: Finds the first occurrence of a character in a string.
*   `STRcopy`: Copies one string to another.

### `std_time.stacks`

*   `TIME.init`: Initializes the time library.
*   `TIME.uptime`: Gets the system uptime in milliseconds.
*   `TIME.start`: Starts a stopwatch.
*   `TIME.read`: Reads the elapsed time from a stopwatch.
*   `TIME.wait`: Pauses execution for a given number of milliseconds.
*   `TIME.as_string`: Converts a millisecond timestamp to a formatted string (e.g., "5m3s123").

### `turtle_lib.stacks` (Turtle Graphics)

*   `TURTLE.mode`: Sets the turtle graphics mode (pixel, sprite, etc.).
*   `TURTLE.flip`: Flips the display buffer (for double-buffered modes).
*   `TURTLE.right`: Turns the turtle right.
*   `TURTLE.left`: Turns the turtle left.
*   `TURTLE.color`: Sets the drawing color.
*   `TURTLE.goto`: Moves the turtle to an absolute X,Y position.
*   `TURTLE.forward`: Moves the turtle forward by a given distance.
*   `TURTLE.start`: Initializes the turtle graphics system.
*   `TURTLE.line`: Draws a line between two points.
*   `TURTLE.circle`: Draws a circle.
