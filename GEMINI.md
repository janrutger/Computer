# Stern-XT Project: Compiler & CPU Optimization Plan

This document summarizes the three main optimization strategies discussed for improving the performance of the Stacks language on the Stern-XT computer.

### 1. Inline Arithmetic (Compiler-only change)

*   **Goal:** Speed up math operations (`+`, `-`, `*`, etc.).
*   **Action:** Modify the compiler to directly output the assembly sequence for arithmetic (e.g., `call @pop_B`, `call @pop_A`, `add A, B`, `call @push_A`) instead of calling runtime functions like `@rt_add`.
*   **Benefit:** High performance gain for low implementation effort. This is a great first step.

### 2. Peephole Optimization for Comparisons (Compiler + Runtime change)

*   **Goal:** Speed up `IF` and `WHILE` statements.
*   **Action:**
    1.  Create new runtime functions (e.g., `@rt_eq_A`) that perform a comparison but leave the `0` or `1` result in the `A` register instead of pushing it to the data stack.
    2.  Add a "peephole" optimization pass to the compiler to find and replace sequences like (`call @rt_eq` followed by `call @pop_A`) with a single call to the new, more efficient `@rt_eq_A`.
*   **Benefit:** Reduces redundant stack operations, making all conditional logic faster.

### 3. Hardware-Accelerated Data Stack (CPU + Compiler change)

*   **Goal:** Make all data stack operations dramatically faster. This is the most advanced and most effective optimization.
*   **Action:**
    1.  **CPU Hardware:** Add a dedicated "Data Stack Pointer" register (`DSP`) to the CPU. Create new native instructions that use this register, such as `DPUSH <reg>` and `DPOP <reg>`.
    2.  **Compiler:** Modify the compiler to emit these new, fast hardware instructions instead of calling the slow `@push_A`/`@pop_A` subroutines.
*   **Benefit:** Provides a massive, transformative performance increase across the entire system by accelerating the most fundamental operations of the Stacks language. This is a true hardware/software co-design improvement.
