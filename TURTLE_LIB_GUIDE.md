# Turtle Graphics Library (turtle_lib) Developer Guide

This guide explains how to use the `turtle_lib.stacks` library to create turtle graphics in the Stacks language.

The library provides a simple interface for drawing lines and shapes on the screen. It supports two main operating modes: a low-resolution **sprite mode** (80x60) and a high-resolution **pixel mode** (640x480).

## 1. Setup and Initialization

To use the library, you must first include it in your program and call the `TURTLE_start` function.

```stacks
INCLUDE turtle_lib
USE std_stern_io # Often needed for printing text

# Initialize the turtle system and screen
TURTLE_start
```

## 2. Screen Mode

The library can operate in four different modes. You can set the mode with the `TURTLE_mode` function. It's recommended to set the mode right after `TURTLE_start`.

The available modes are:
*   `sprite`: 80x60 character grid, single buffered.
*   `db_sprite`: 80x60 character grid, double buffered. **(Default)**
*   `pixel`: 640x480 pixel grid, single buffered.
*   `db_pixel`: 640x480 pixel grid, double buffered.

**Usage:**
```stacks
# Set the screen to high-resolution pixel mode with double buffering
db_pixel TURTLE_mode
```

When using a double-buffered mode (`db_pixel` or `db_sprite`), drawing commands write to a hidden buffer. To make your drawing visible, you must call `TURTLE_flip`.

## 3. Core Turtle Commands

These are the basic commands for controlling the turtle.

### Movement

*   **`distance TURTLE_forward`**: Moves the turtle forward by a given `distance`. In sprite mode, the unit is characters (8 pixels). In pixel mode, the unit is pixels.
*   **`x y TURTLE_goto`**: Moves the turtle to a specific coordinate and draws a single point/character.
*   **`degrees TURTLE_right`**: Turns the turtle right by a given number of degrees.
*   **`degrees TURTLE_left`**: Turns the turtle left by a given number of degrees.

### Color

*   **`color_constant TURTLE_color`**: Sets the drawing color for the turtle. The library provides 16 color constants (e.g., `red`, `green`, `blue`, `white`).

**Example:**
```stacks
green TURTLE_color  # Set the turtle color to green
100 TURTLE_forward  # Move forward 100 units
90 TURTLE_right     # Turn right 90 degrees
```

## 4. Screen Control

*   **`TURTLE_flip`**: If you are in a double-buffered mode (`db_pixel` or `db_sprite`), this command will copy the hidden drawing buffer to the visible screen. It does nothing in single-buffered modes.
*   **`IO 2 NEW`**: This is a direct UDC command that clears the screen.

## 5. Advanced Drawing

The library also includes functions for drawing complete shapes. These functions use the current turtle color and respect the active mode (pixel or sprite).

*   **`x1 y1 x2 y2 TURTLE_line`**: Draws a line from (x1, y1) to (x2, y2).
*   **`xc yc radius TURTLE_circle`**: Draws a circle with a center at (xc, yc) and a given radius.

## Full Example

Here is a complete example of a program that draws a red square in high-resolution pixel mode.

```stacks
INCLUDE turtle_lib
USE std_stern_io

# 1. Initialize the system
TURTLE_start

# 2. Set high-resolution mode
db_pixel TURTLE_mode

# 3. Clear the screen and set the color
IO 2 NEW
red TURTLE_color

# 4. Move to starting position
100 100 TURTLE_goto

# 5. Draw a square
200 TURTLE_forward
90 TURTLE_right
200 TURTLE_forward
90 TURTLE_right
200 TURTLE_forward
90 TURTLE_right
200 TURTLE_forward

# 6. Flip the buffer to show the final drawing
TURTLE_flip
```
