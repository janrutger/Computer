# Stacks Struct Library Manual

## Introduction

The `std_struct` library introduces a dynamic type system to the Stacks programming language. It allows developers to define data structures with named fields, create instances, and access fields using efficient integer hashing.

To use this library, include it in your program:
```stacks
USE std_struct
```

## Core Concepts

### 1. Dynamic Types
Unlike static structs in C, Stacks structs are resolved at runtime. A "Type" is a blueprint stored on the heap that maps field hashes to memory offsets.

### 2. Contiguous Memory
Struct instances are allocated as a single contiguous block of memory on the heap. This ensures cache efficiency and simplifies memory management.

### 3. Compile-Time Hashing
To avoid the performance penalty of string comparisons, field names are hashed into integers at compile time using the `\"string"` syntax.
*   `"name"` pushes a pointer to the string "name".
*   `\"name"` pushes the DJB2 hash of "name" (an integer).

## API Reference

### `STRUCT.new_type`
Creates a new Struct Type (blueprint).

*   **Stack:** `( hash_1 ... hash_N N -- type_ptr )`
*   **Description:** Allocates a Type structure on the heap containing the field hashes.
*   **Example:**
    ```stacks
    \"name" \"age" 2 STRUCT.new_type AS t_person
    ```

### `STRUCT.new`
Creates a new instance of a Struct Type.

*   **Stack:** `( type_ptr -- instance_ptr )`
*   **Description:** Allocates memory for the instance and zero-initializes all fields.
*   **Example:**
    ```stacks
    t_person STRUCT.new AS person1
    ```

### `STRUCT.put`
Writes a value to a specific field.

*   **Stack:** `( value field_hash instance_ptr -- )`
*   **Description:** Sets the field identified by `field_hash` to `value`. Halts with an error if the field does not exist.
*   **Example:**
    ```stacks
    "Jan" \"name" person1 STRUCT.put
    ```

### `STRUCT.get`
Reads a value from a specific field.

*   **Stack:** `( field_hash instance_ptr -- value )`
*   **Description:** Returns the value of the field identified by `field_hash`. Halts with an error if the field does not exist.
*   **Example:**
    ```stacks
    \"age" person1 STRUCT.get PRINT
    ```

## Design Patterns

### The Method Pattern (OOP)
Stacks supports Object-Oriented Programming patterns using global variables and naming conventions.

**1. Setup Context:**
Define a global variable `self` to hold the current instance context.
```stacks
VALUE self 0
```

**2. Define Methods:**
Use the naming convention `Type.method`. The method should pop the instance pointer into `self` immediately.
```stacks
DEF Person.greet {
    AS self
    "Hello, I am " PRTstring
    \"name" self STRUCT.get PRTstring
}
```

**3. Call Methods:**
Push the instance pointer onto the stack and call the method.
```stacks
person1 Person.greet
```


### The C-Style Pattern (Performance) 
For performance-critical applications (like games), you can bypass the dynamic hash lookup by using static integer offsets. This mimics C structs and offers significantly faster access times at the cost of flexibility. 

**1. Define Offsets:** 
Use CONST to define field offsets manually. 

```stacks 
CONST P_X 0 
CONST P_Y 1 
CONST P_SIZE 2 
```
**2. Allocation:** 
Use NEW.list from std_heap directly to allocate the memory block. 
```stacks
P_SIZE NEW.list AS point_ptr
```
**3. Access:** 
Use LIST.get and LIST.put with the constants to access fields directly. 
 ```stacks 
 # Set X
 10 P_X point_ptr LIST.put 
 # Get X
 P_X point_ptr LIST.get
 ```