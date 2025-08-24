; Kernel Runtime Routines

@push_A
    inc I $DATASTACK_INDEX  ; Load current stack pointer into I 
    stx A $DATASTACK_PTR    ; Store value from A at index I
    ret

@pop_A
    dec I $DATASTACK_INDEX  ; Load current stack pointer into I
    ldx A $DATASTACK_PTR    ; Load value from index I into A
    ret