# .HEADER
. $_main_str_0 13

# .CODE
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A @my_func
    stack A $DATASTACK_PTR
    calls $DATASTACK_PTR
    call @rt_print_tos
    ldi A $_main_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ret

# .FUNCTIONS
@my_func
    call @rt_dup
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ret

# .DATA
% $_main_str_0 \H \e \l \l \o \space \w \o \r \l \d \Return \null
