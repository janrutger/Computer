
# INTRODUCING THE STERN-XT

## A REVOLUTION IN PERSONAL COMPUTING

---

In an age of fixed, uninspired computer designs, one machine dares to be different. The Stern-XT is not just another personal computer. It is a complete, reconfigurable computing engine designed for the serious programmer, the digital pioneer, and the electronic artist.

For the first time, the power to define the very architecture of your computer is in your hands. Don't just write software—program the processor itself.

---

### THE STERN WRITABLE CONTROL STORE (WCS) ARCHITECTURE

At the core of the Stern-XT lies its greatest innovation: a processor with a Writable Control Store. Unlike other computers with a fixed, hard-wired instruction set, the Stern-XT's processor logic is defined by a loadable microcode program.

**WHAT THIS MEANS FOR YOU:**

*   **CREATE YOUR OWN INSTRUCTIONS:** Need to accelerate a graphics routine? Building an AI? Design and implement your own custom machine instructions that execute at the full speed of the processor.
*   **OPTIMIZE YOUR WORKLOAD:** Redefine the existing instruction set to create a CPU tailored specifically to your application.
*   **A TRUE PROGRAMMER'S MACHINE:** The Stern-XT provides the ultimate level of control, previously only available on expensive mainframe systems and research workstations.

---

### TECHNICAL SPECIFICATIONS

```
****************************************
*** STERN-XT: SYSTEM SPECIFICATIONS ****
****************************************

**CPU: Stern µCore-1 with WCS**

*   Architecture.... Microprogrammable Control Unit
*   Control Store..... User-Writable, RAM-based
*   GPRs.............. 10 (R0-R9)
*   Index Register.... R0
*   System Registers.. PC, SP, MIR
*   Flags............. Zero, Negative, Equal, Status

**MEMORY SUBSYSTEM**

*   Total RAM......... 16 Kilowords
*   OS Space.......... 4K Protected (Loader, Kernel, Vectors)
*   User Space........ 12K (Program, Data, Stack, Video)

**INTEGRATED I/O**

*   Video............. Memory-Mapped Display
*   Input............. Interrupt-Driven Keyboard Interface
*   Control........... Full Hardware Interrupt Controller
*   Expansion......... Serial I/O Port (SIO)

**SOFTWARE SUITE**

*   Primary OS........ Stern-XT Kernel & Monitor
*   Assemblers........ 1) Microcode Assembler
                       2) ISA Macro Assembler
*   High-Level Lang... STACKS (Compiled, Stack-Based Language)

**DEVELOPMENT ENVIRONMENT**

*   Debugger.......... Integrated Monitor with full memory
                       and execution control (breakpoints,
                       single-stepping, inspection).

```

---

### UNLEASH YOUR CREATIVITY

The Stern-XT comes with a complete software suite to harness its awesome power.

*   **STERN ASSEMBLY - A SUPERIOR INSTRUCTION SET:** Get close to the metal with a powerful and complete instruction set. The default Stern-1 ISA is a professional-grade CISC architecture designed for serious programming, yet remains fully customizable thanks to the WCS.

    **Novelties of the Stern-1 ISA:**
    *   **True Indexed Addressing (`LDX`, `STX`):** Go beyond simple offsets. The Stern-1 ISA provides true `base + index` addressing. An instruction like `LDX R1, 1000` calculates its target address on the fly by adding the base (`1000`) to the value in the dedicated `R0` index register. This is the ideal tool for high-speed array manipulation and complex data structures, all handled automatically by the microcode.

    *   **Direct-to-Memory Operations (`INC`, `DEC`):** Why waste registers? The Stern-1 ISA features powerful `INC` and `DEC` instructions that can operate *directly on any memory location*. A single `INC 1234` instruction triggers a complete read-modify-write sequence in the microcode, streamlining your code and freeing up general-purpose registers for other tasks. This is the power of a true CISC machine!

    *   **Advanced Conditional Branching:** Go beyond simple `JUMP-IF-ZERO`. The Stern ISA features a powerful Test engine (`TST`, `TSTE`, `TSTG`) that works with high-level conditional jumps (`JMPT`, `JMPF`) to make complex decision-making fast and efficient.

    *   **System-Level Control:** The ISA is built to host a real operating system, with dedicated instructions for software interrupts (`INT`) and context switching (`CXTSW`).

    **The Stern-1 Reference Instruction Set:**
    ```
| | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | NOP | HALT | RET | EI | DI | RTI | | | | |
| 2 | JMPF | JMPT | JMP | JMPX | CALL | CALLX | INT | CXTSW | | |
| 3 | LD | LDI | LDM | LDX | | | | | | |
| 4 | STO | STX | | | | | | | | |
| 5 | ADD | ADDI | SUB | SUBI | SUBR | | | | | |
| 6 | MUL | MULI | DIV | DIVI | DIVR | DMOD | | | | |
| 7 | TST | TSTE | TSTG | | | | | | | |
| 8 | INC | DEC | ANDI | XORX | | | | | | |
| 9 | PUSH | POP | | | | | | | | |
    ```


*   **STACKS - THE ON-BOARD PROFESSIONAL LANGUAGE:** While other systems are stuck with slow, line-numbered BASIC, the Stern-XT unleashes the power of STACKS. It’s a modern, structured language that is fully compiled to machine-native bytecode for maximum performance. Its logic is clean, efficient, and easy to learn.

    **The STACKS Philosophy: RPN Power**
    Think like the masters of computing! STACKS uses Reverse Polish Notation, the same logic that powered early HP calculators. You place your data on the stack first, then perform the operation. A calculation like `(5 + 3) * 2` becomes the elegant and unambiguous `5 3 + 2 *`. This direct approach eliminates parentheses and makes your code incredibly efficient.

    **A Rich Suite of Features:**
    *   **Blazing Speed:** Your STACKS programs are translated by a three-phase compiler into dense, machine-native bytecode that executes at the full speed of the µCore-1 processor.
    *   **Structured Programming:** Build professional-grade applications with `IF/ELSE/END` logic, powerful `WHILE/DO/DONE` loops, and create your own libraries of reusable commands with the `DEF` keyword.
    *   **Interactive Development:** The best of both worlds! Prototype algorithms and perform quick calculations in the Immediate Mode, then compile your finished program for release.

    **An Example of Power: Recursive Factorial**
    See the elegance of STACKS in action. This program defines a new word, `factorial`, that calls itself to compute a result.
    ```
# Computes factorial of the number on the stack

DEF factorial {
  DUP 1 > IF     
    DUP 1 -      
    factorial     
    *             
  ELSE
  END
}

5 factorial PRINT 
    ```

*   **PROFESSIONAL DEVELOPMENT SYSTEM:** The Stern-XT includes a two-stage assembler suite for total system control and a machine-level debugger for flawless code execution.

**The Stern-XT is not a toy. It is a tool for the imagination. Are you ready to redefine computing?**
