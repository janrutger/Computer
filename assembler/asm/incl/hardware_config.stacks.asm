# .HEADER
. $INT_VECTORS 1

# .CODE

    . $_start_memory_ 1
    % $_start_memory_ 0     ; Init _start_memory_ to 0 used by the Stacks compiler

    . $DATASTACK 32
    . $DATASTACK_PTR 1
    . $DATASTACK_INDEX 1
    % $DATASTACK_INDEX 0
    % $DATASTACK_PTR $DATASTACK

# .FUNCTIONS

@push_A

        inc I $DATASTACK_INDEX  ; Load current stack pointer into I 
        stx A $DATASTACK_PTR    ; Store value from A at index I
        ret
@pop_A

        dec I $DATASTACK_INDEX  ; Load current stack pointer into I
        ldx A $DATASTACK_PTR    ; Load value from index I into A
        ret
@push_B

        inc I $DATASTACK_INDEX  ; Load current stack pointer into I 
        stx B $DATASTACK_PTR    ; Store value from B at index I
        ret
@pop_B

        dec I $DATASTACK_INDEX  ; Load current stack pointer into I
        ldx B $DATASTACK_PTR    ; Load value from index I into B
        ret
@rt_add

        call @pop_A
        call @pop_B
        add A B
        call @push_A
        ret
@rt_sub

        call @pop_A
        call @pop_B
        sub B A
        call @push_B
        ret
@rt_mul

        call @pop_A
        call @pop_B
        mul A B
        call @push_A
        ret
@rt_div

        call @pop_A
        call @pop_B
        dmod B A
        call @push_B
        ret
@rt_mod

        call @pop_A
        call @pop_B
        dmod B A
        call @push_A
        ret
@rt_eq

        call @pop_A
        call @pop_B
        tste A B
        jmpt :eq_true
        ldi A 0
        jmp :eq_end
    :eq_true
        ldi A 1
    :eq_end
        call @push_A
        ret
@rt_neq

        call @pop_A
        call @pop_B
        tste A B
        jmpf :neq_true
        ldi A 0
        jmp :neq_end
    :neq_true
        ldi A 1
    :neq_end
        call @push_A
        ret
@rt_gt

        call @pop_A
        call @pop_B
        tstg B A
        jmpt :gt_true
        ldi A 0
        jmp :gt_end
    :gt_true
        ldi A 1
    :gt_end
        call @push_A
        ret
@rt_lt

        call @pop_A
        call @pop_B
        tstg A B
        jmpt :lt_true
        ldi A 0
        jmp :lt_end
    :lt_true
        ldi A 1
    :lt_end
        call @push_A
        ret
@rt_dup

        call @pop_A
        call @push_A
        call @push_A
        ret
@rt_swap

        call @pop_A
        call @pop_B
        call @push_A
        call @push_B
        ret
@rt_drop

        call @pop_A
        ret
@rt_over

        call @pop_A
        call @pop_B
        call @push_B
        call @push_A
        call @push_B
        ret
@init_interrupt_vector_table

        ldi I 0             ; Interrupt vector (0 is keyboard)
        ldi M @KBD_ISR      ; ISR start adres
        stx M $INT_VECTORS  ; Store ISR adres as pointer

        # Next interrupt vector
        ret

# .DATA
% $INT_VECTORS 3072
