# .CODE

# .FUNCTIONS

@push_A

        inc I $DATASTACK_INDEX  ; Load current stack pointer into I 
        stx A $DATASTACK_PTR    ; Store value from A at index I
        ret
