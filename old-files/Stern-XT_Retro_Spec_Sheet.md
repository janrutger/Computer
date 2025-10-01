```
==============================================================

       THE OFFICIAL STERN-XT PERSONAL COMPUTER

               TECHNICAL SPECIFICATIONS

                     (2025 Edition)

==============================================================

Congratulations on your interest in the STERN-XT, the personal
computer of the future! This document contains all the technical
information you need to begin your journey into the exciting
world of 16-bit computing.


1. GETTING TO KNOW YOUR STERN-XT
=================================

The Stern-XT is a complete, state-of-the-art computer system.
At its heart is a powerful, custom-designed Central Processing
Unit (CPU) waiting for your commands!


2. UNDER THE HOOD: THE HARDWARE
=================================

Take a look at the revolutionary technology at your fingertips!

*** THE STERN-XT CPU ***

A marvel of modern engineering! The Stern-XT CPU is a fully
customisable, microcode-driven processor.

  - ARCHITECTURE    : Classic Fetch-Decode-Execute cycle.
  - INSTRUCTION SET : FULLY PROGRAMMABLE! Define up to 90 of
    your own instructions using the MICROCODE ASSEMBLER.
  - REGISTERS       : 10 General-Purpose Registers (R0-R9), plus
    special registers for the Program Counter (PC) and
    Stack Pointer (SP).
  - INTERRUPTS      : Full hardware interrupt support for 
    advanced peripheral communication.


*** SYSTEM MEMORY ***

The Stern-XT comes equipped with a massive 16KB of RAM, laid
out for maximum efficiency.

  - TOTAL SIZE: 16384 Bytes!

  - MEMORY MAP:
    --------------------------------------------------
    | 0     - 1023  | LOADER PROGRAM AREA            |
    | 1024  - 3071  | KERNEL & STACKS LANGUAGE ROM   |
    | 3072  - 4095  | INTERRUPT VECTOR TABLE         |
    | 4096  - 12287 | USER PROGRAM AREA              |
    | 12288 - 14335 | I/O & STACK AREA               |
    | 14336 - 16255 | VIDEO MATRIX (80x24 DISPLAY)   |
    --------------------------------------------------


3. UNLEASHING THE POWER: SOFTWARE & PROGRAMMING
=================================================
 
The Stern-XT is more than just powerful hardware. It comes with
a complete suite of software to get you started FAST!

*** THE 'STACKS' PROGRAMMING LANGUAGE ***

Built directly into the KERNEL is STACKS, a modern, Forth-like
language that gives you direct control over the hardware.

  - INTERACTIVE: Use the immediate mode REPL (Read-Eval-Print
    Loop) to execute commands instantly! Perfect for learning
    and quick calculations.

  - POWERFUL: Write full programs with functions, loops, and
    `IF/ELSE`, `WHILE/DO/DONE' logic. The system compiles your 
    code to super-fast bytecode for execution!

  - COMMANDS at your disposal include:
    - STACK : DUP, SWAP, DROP, OVER
    - MATH  : +, -, *, /, MOD
    - LOGIC : ==, !=, <, >
    - I/O   : PRINT, &IO (for hardware!)


*** THE DEVELOPMENT TOOLCHAIN ***

For the serious programmer, the Stern-XT includes a professional
development system.

  - MICROCODE ASSEMBLER: Design your OWN instruction set for the
    CPU! A truly revolutionary feature.

  - ISA ASSEMBLER: Write programs in a powerful assembly language
    that YOU have designed. The assembler dynamically adapts to
    your custom instruction set!


4. EXPAND YOUR HORIZONS: PERIPHERALS
=======================================

Expand your Stern-XT with a range of exciting peripherals using
the Universal Device Controller (UDC) port!

  - VIRTUAL DISK DRIVE: Load and SAVE your programs and data!
    The disk system allows you to manage files on a virtual disk
    with simple commands.

  - Y-PLOTTER: Turn data into graphics! Send values to the
    plotter and watch it draw charts and graphs in real-time.

  - VIRTUAL LCD SCREEN: A high-resolution 640x480 pixel display!
    Draw individual pixels or use the built-in character set and
    8x8 sprites. Supports a palette of 16 VIBRANT COLOURS and
    flicker-free animation with double buffering!


5. DEBUGGING AND ANALYSIS
===========================

For the advanced user, a machine-code monitor and debugger is
built into the system.

  - Activate by running with the '-debug' switch.
  - Step through code instruction-by-instruction (`STEP`) or even
    clock-cycle-by-clock-cycle (`MICROSTEP`)!
  - Set breakpoints to pause execution at critical points.
  - Inspect memory and CPU registers to see EXACTLY what your
    program is doing.


==============================================================

       HAVE FUN PROGRAMMING YOUR STERN-XT!

==============================================================
```