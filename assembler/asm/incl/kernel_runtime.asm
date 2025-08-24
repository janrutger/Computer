; Kernel Runtime Routines

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

@rt_print_tos
    call @pop_A
    ld C A
    :debug
    ldi I ~SYS_PRINT_NUMBER
    int $INT_VECTORS

    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS
ret


