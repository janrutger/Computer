# Stacks Standard Library Manual

## 1. Introduction

The Stacks programming language comes with a rich set of standard libraries that provide essential functionality for application development. These libraries cover input/output, string manipulation, mathematical operations, data structures, and hardware interfacing.

To use a library in your Stacks program, use the `USE` directive:
```stacks
USE std_stern_io
USE math_lib
```

## 2. Standard I/O (`std_stern_io`)

This library provides functions for console input and output, interacting directly with the Stern-XT kernel via system calls.

### Initialization
*   **`io_lib_init`**: Initializes the library pointers. Must be called once at startup.
    *   Stack: `( &status_var &value_var -- )`

### Output
*   **`PRTchar`**: Prints a single character to the console.
    *   Stack: `( char_code -- )`
*   **`PRTstring`**: Prints a null-terminated string.
    *   Stack: `( string_ptr -- )`
*   **`PRTnum`**: Prints a number followed by a newline.
    *   Stack: `( number -- )`
*   **`PRTcls`**: Clears the console screen.
    *   Stack: `( -- )`
*   **`CURSORon`**: Shows the cursor.
    *   Stack: `( -- )`
*   **`CURSORoff`**: Hides the cursor.
    *   Stack: `( -- )`

### Input
*   **`KEYchar`**: Waits for a key press and returns its ASCII code (Blocking).
    *   Stack: `( -- char_code )`
*   **`KEYpressed`**: Checks if a key is pressed (Non-blocking).
    *   Stack: `( -- char_code 1 )` if pressed, or `( 0 )` if not.
*   **`READline`**: Reads a line of text from the user until Enter is pressed. Handles backspace.
    *   Stack: `( -- buffer_ptr )`

### Utilities
*   **`TOS.check`**: Returns the current depth of the data stack.
    *   Stack: `( -- depth )`
*   **`HALT`**: Prints a panic message and halts the CPU.
    *   Stack: `( -- )`

## 3. String Manipulation (`std_string`)

Provides functions for working with null-terminated strings.

*   **`STRcmp`**: Compares two strings for equality.
    *   Stack: `( str1_ptr str2_ptr -- result )`
    *   Returns: `1` if equal, `0` otherwise.
*   **`STRlen`**: Calculates the length of a string.
    *   Stack: `( str_ptr -- length )`
*   **`STRfind`**: Finds the first occurrence of a character in a string.
    *   Stack: `( str_ptr char -- index success )`
    *   Returns: `index 1` if found, `0 0` if not found.
*   **`STRcopy`**: Copies a string from source to destination.
    *   Stack: `( src_ptr dest_ptr -- )`
*   **`STRatoi`**: Converts a string of digits to an integer.
    *   Stack: `( str_ptr -- number success )`
    *   Returns: `number 1` on success, `original_ptr 0` on failure.

## 4. Mathematics (`math_lib`)

Basic mathematical functions beyond the core operators.

*   **`gcd`**: Calculates the Greatest Common Divisor of two numbers.
    *   Stack: `( a b -- gcd )`
*   **`power`**: Calculates integer power ($base^{exp}$).
    *   Stack: `( base exp -- result )`
*   **`factorial`**: Calculates the factorial of an integer ($n!$).
    *   Stack: `( n -- result )`

## 5. Fixed-Point Math (`fixed_point_lib`)

A library for handling fractional numbers using fixed-point arithmetic. The default scale factor is 1000 (3 decimal places).

### Configuration
*   **`FP.set_scale`**: Sets the global scaling factor.
    *   Stack: `( scale_factor -- )`

### Conversion
*   **`FP.from_int`**: Converts an integer to fixed-point format.
    *   Stack: `( int -- fp )`
*   **`FP.to_int`**: Converts fixed-point to integer (truncates).
    *   Stack: `( fp -- int )`
*   **`FP.from_string`**: Parses a string (e.g., "12.34") into a fixed-point number.
    *   Stack: `( str_ptr -- fp )`

### Arithmetic
*   **`FP.add`**: Adds two fixed-point numbers.
    *   Stack: `( a b -- result )`
*   **`FP.sub`**: Subtracts two fixed-point numbers.
    *   Stack: `( a b -- result )`
*   **`FP.mul`**: Multiplies two fixed-point numbers.
    *   Stack: `( a b -- result )`
*   **`FP.div`**: Divides two fixed-point numbers.
    *   Stack: `( a b -- result )`
*   **`FP.power`**: Calculates power for integer exponents.
    *   Stack: `( base_fp exp_int -- result_fp )`

### Output
*   **`FP.print`**: Prints a fixed-point number with 3 decimal places.
    *   Stack: `( fp -- )`
*   **`FP.fprint`**: Prints a fixed-point number with a specified number of decimal places.
    *   Stack: `( fp num_digits -- )`

## 6. Heap Data Structures (`std_heap`)

Manages dynamic memory allocation for lists, arrays, and matrices.

### Initialization
*   **`HEAP.init`**: Initializes the heap allocator.
    *   Stack: `( start_ptr size -- )`
*   **`HEAP.free`**: Resets the heap pointer (frees all memory).
    *   Stack: `( -- )`

### Lists & Arrays
*   **`NEW.list`**: Allocates a raw block of memory.
    *   Stack: `( size -- ptr )`
*   **`NEW.array`**: Creates a dynamic array with a header (capacity, count).
    *   Stack: `( capacity -- array_ptr )`
*   **`ARRAY.append`**: Adds an element to the end of an array.
    *   Stack: `( value array_ptr -- )`
*   **`ARRAY.put`**: Updates a value at a specific index.
    *   Stack: `( value index array_ptr -- )`
*   **`ARRAY.get`**: Reads a value at a specific index.
    *   Stack: `( index array_ptr -- value )`
*   **`ARRAY.len`**: Returns the current number of elements.
    *   Stack: `( array_ptr -- count )`
*   **`ARRAY.clear`**: Resets the array count to 0 (does not free memory).
    *   Stack: `( array_ptr -- )`

### Matrices
*   **`NEW.matrix`**: Allocates a matrix (rows x cols).
    *   Stack: `( rows cols -- matrix_ptr )`
*   **`MATRIX.put`**: Writes a value to the matrix.
    *   Stack: `( value row col matrix_ptr -- )`
*   **`MATRIX.get`**: Reads a value from the matrix.
    *   Stack: `( row col matrix_ptr -- value )`

## 7. Time (`std_time`)

Provides time-keeping functions using the system clock.

*   **`TIME.init`**: Initializes the time library pointers.
    *   Stack: `( -- )`
*   **`TIME.uptime`**: Returns the time elapsed since system start (in ms).
    *   Stack: `( -- ms )`
*   **`TIME.wait`**: Pauses execution for a duration (Busy wait).
    *   Stack: `( duration_ms -- )`
*   **`TIME.start`**: Starts a stopwatch timer at a specific memory slot.
    *   Stack: `( watch_id -- )`
*   **`TIME.read`**: Reads the elapsed time from a stopwatch.
    *   Stack: `( watch_id -- elapsed_ms )`
*   **`TIME.as_string`**: Prints a timestamp (ms) as `MMmSSsMS`.
    *   Stack: `( ms -- )`

## 8. Disk Utilities (`disk_utils`)

Helper functions for interacting with the Virtual Disk.

*   **`load_bin_file`**: Loads a binary file format (address/value pairs) from disk into memory.
    *   Stack: `( filename_ptr -- )`

## 9. Turtle Graphics (`turtle_lib`)

A library for controlling a "Turtle" graphics cursor on the UDC Screen device (Channel 2).

### Setup
*   **`TURTLE.start`**: Initializes the screen and turtle state.
    *   Stack: `( -- )`
*   **`TURTLE.mode`**: Sets the drawing mode (Pixel/Sprite, Single/Double Buffer).
    *   Stack: `( mode -- )`
*   **`TURTLE.color`**: Sets the drawing color.
    *   Stack: `( color_code -- )`
*   **`TURTLE.flip`**: Flips the screen buffer (if in double-buffer mode).
    *   Stack: `( -- )`

### Movement & Drawing
*   **`TURTLE.goto`**: Moves the turtle to absolute coordinates.
    *   Stack: `( x y -- )`
*   **`TURTLE.forward`**: Moves the turtle forward in its current direction.
    *   Stack: `( distance -- )`
*   **`TURTLE.right`**: Turns the turtle right by degrees.
    *   Stack: `( degrees -- )`
*   **`TURTLE.left`**: Turns the turtle left by degrees.
    *   Stack: `( degrees -- )`
*   **`TURTLE.line`**: Draws a line between two points.
    *   Stack: `( x1 y1 x2 y2 -- )`
*   **`TURTLE.circle`**: Draws a circle.
    *   Stack: `( xc yc radius -- )`

## 10. Game Engine (`game_lib`)

A sprite-based game engine for the UDC Screen. It manages a list of "Tiles" (sprites with position and behavior).

### Initialization
*   **`GAME.init_game_lib`**: Sets up the screen and internal data structures.
    *   Stack: `( -- )`

### Tile Management
*   **`GAME.init_tile`**: Creates/Resets a tile object.
    *   Stack: `( tile_id start_x start_y data_ptr color reaction -- )`
*   **`GAME.delete_tile`**: Removes a tile (moves it off-screen).
    *   Stack: `( tile_id -- )`
*   **`GAME.tile_move`**: Instantly moves a tile.
    *   Stack: `( tile_id new_x new_y -- )`
*   **`GAME.update_tile_props`**: Changes a tile's appearance or behavior.
    *   Stack: `( tile_id data_ptr color reaction -- )`
*   **`GAME.get_xy`**: Gets a tile's position.
    *   Stack: `( tile_id -- x y )`

### Game Loop
*   **`GAME.handle_input`**: Reads keyboard input and moves the player tile (ID 0). Handles collisions.
    *   Stack: `( -- )`
*   **`GAME.process_events`**: Processes collision events generated by `handle_input`.
    *   Stack: `( -- event_type target_id )`
*   **`GAME.redraw_all_moved_tiles`**: Efficiently redraws only tiles that have moved.
    *   Stack: `( -- )`
*   **`GAME.refresh`**: Flips the screen buffer.
    *   Stack: `( -- )`

## 11. Neural Network (`nn_lib` & `mlnn_gpu3_optimized_lib`)

Libraries for creating and training neural networks. `nn_lib` is a basic CPU implementation, while `mlnn_gpu3_optimized_lib` leverages the GPU-R3 hardware.

### `nn_lib` (CPU Perceptron)
*   **`NN.new_perceptron`**: Creates a single perceptron.
    *   Stack: `( num_inputs -- perceptron_ptr )`
*   **`NN.predict`**: Makes a prediction.
    *   Stack: `( input_ptr perceptron_ptr -- result )`
*   **`NN.train_step`**: Performs one training step (adjusts weights).
    *   Stack: `( perceptron_ptr input_ptr error learning_rate -- )`

### `mlnn_gpu3_optimized_lib` (GPU Deep Learning)
*   **`NN.set_scale`**: Sets the fixed-point scale for the network.
    *   Stack: `( scale -- )`
*   **`NN.new_network`**: Creates a 3-layer network (Input -> Hidden -> Output).
    *   Stack: `( input_size hidden_size output_size -- network_ptr )`
*   **`NN.train`**: Trains the network on a single example using backpropagation.
    *   Stack: `( network_ptr input_ptr target_ptr learning_rate -- )`
*   **`NN.predict`**: Runs a forward pass to get predictions.
    *   Stack: `( network_ptr input_ptr -- output_activations_ptr )`

## 12. GPU R3 (`gpu3_lib`)

Low-level interface to the GPU-R3 co-processor.

*   **`GPU.tdl`**: Populates a Task Descriptor List (TDL) entry in memory.
    *   Stack: `( ptr_a ptr_b ptr_res scale opcode next_tdl_ptr tdl_ptr -- )`
*   **`GPU.exec`**: Executes a TDL chain on the GPU.
    *   Stack: `( tdl_ptr -- status )`

### GPU Opcodes
*   `MAT.ADD` (0): Matrix Addition
*   `MAT.SUB` (1): Matrix Subtraction
*   `MAT.MUL` (2): Element-wise Multiplication
*   `MAT.DOT` (3): Dot Product (Matrix Multiplication)
*   `MAT.RELU` (4): ReLU Activation
*   `MAT.TRANS` (5): Matrix Transpose
*   `MAT.RELU_DERIV` (6): ReLU Derivative
*   `MAT.FREE` (12): Free VRAM handle