# .HEADER
. $random_seed 1
. $INT_VECTORS 1
. $VIDEO_MEM 1

# .CODE

    . $_start_memory_ 1
    % $_start_memory_ 0     ; Init _start_memory_ to 0 used by the Stacks compiler

    EQU ~SCREEN_WIDTH 80
    EQU ~SCREEN_HEIGHT 24
    EQU ~SCREEN_POINTER_END 1920
    EQU ~SCREEN_LAST_ADRES 24448    ; ~VIDEO_MEM + ~SCREEN_POINTER_END


    ; Define memory constants
    EQU ~KERNEL_START 1024
    EQU ~INT_VECTORS 8192
    EQU ~PROG_START 9216
    EQU ~VAR_START 18432
    EQU ~VIDEO_MEM 22528
    EQU ~STACK_TOP 22527

    . $DATASTACK 32             ; Create the datastack
    . $DATASTACK_PTR 1
    # . $DATASTACK_INDEX 1
    # % $DATASTACK_INDEX 0
    % $DATASTACK_PTR $DATASTACK


# .FUNCTIONS

@rt_eq

        ustack A $DATASTACK_PTR
        ustack B $DATASTACK_PTR
        tste A B
        jmpt :eq_true
        ldi A 0
        jmp :eq_end
    :eq_true
        ldi A 1
    :eq_end
        stack A $DATASTACK_PTR
        ret
@rt_neq

        ustack A $DATASTACK_PTR
        ustack B $DATASTACK_PTR
        tste A B
        jmpf :neq_true
        ldi A 0
        jmp :neq_end
    :neq_true
        ldi A 1
    :neq_end
        stack A $DATASTACK_PTR
        ret
@rt_gt

        ustack A $DATASTACK_PTR
        ustack B $DATASTACK_PTR
        tstg B A
        jmpt :gt_true
        ldi A 0
        jmp :gt_end
    :gt_true
        ldi A 1
    :gt_end
        stack A $DATASTACK_PTR
        ret
@rt_lt

        ustack A $DATASTACK_PTR
        ustack B $DATASTACK_PTR
        tstg A B
        jmpt :lt_true
        ldi A 0
        jmp :lt_end
    :lt_true
        ldi A 1
    :lt_end
        stack A $DATASTACK_PTR
        ret
@rt_dup

        ustack A $DATASTACK_PTR
        stack A $DATASTACK_PTR
        stack A $DATASTACK_PTR
        ret
@rt_swap

        ustack A $DATASTACK_PTR
        ustack B $DATASTACK_PTR
        stack A $DATASTACK_PTR
        stack B $DATASTACK_PTR
        ret
@rt_drop

        ustack A $DATASTACK_PTR
        ret
@rt_over

        ustack A $DATASTACK_PTR
        ustack B $DATASTACK_PTR
        stack B $DATASTACK_PTR
        stack A $DATASTACK_PTR
        stack B $DATASTACK_PTR
        ret
@rt_print_tos

        ustack A $DATASTACK_PTR
        ld C A

        ldi I ~SYS_PRINT_NUMBER
        int $INT_VECTORS

        ldi C \Return
        ldi I ~SYS_PRINT_CHAR
        int $INT_VECTORS
        ret
@rt_udc_control

        ustack B $DATASTACK_PTR     ; Pop command code into B
        ustack A $DATASTACK_PTR     
        ld M A          ; Save the Channel number
        ustack A $DATASTACK_PTR
        ld C A          ; load data/arugumnet in C
        ld A M          ; load channel number in A

        ldi I ~SYS_UDC_CONTROL      ; Load the syscall number
        int $INT_VECTORS            ; call the kernel

        ; Check status and push return value for GET commands
        ldm A $SYSCALL_RETURN_STATUS
        tste A Z
        jmpf :rt_udc_ok
        ; Error handeling here, for now, just continue

    :rt_udc_ok  
        ; if command was GET, push the return value
        tst B ~UDC_DEVICE_GET
        jmpf :rt_udc_end        ; goto end if no return value

        ldm A $SYSCALL_RETURN_VALUE
        stack A $DATASTACK_PTR            ; Push the return value on the datastack

    :rt_udc_end 
        ret
@rt_rnd
    ldm B $random_seed
    ldi A 134775813
    mul B A
    ldi A 1
    add B A
    ldi A 65536
    dmod B A
    sto A $random_seed
    ld B A
    ldi A 1000
    dmod B A
    stack A $DATASTACK_PTR
    ret

@init_interrupt_vector_table

        ldi I 0             ; Interrupt vector (0 is keyboard)
        ldi M @KBD_ISR      ; ISR start adres
        stx M $INT_VECTORS  ; Store ISR adres as pointer

        ldi I 1             ; Interrupt vector for RTC
        ldi M @RTC_ISR      ; RTC ISR start adres
        stx M $INT_VECTORS  ; Store ISR pointer in table

        # Next interrupt vector
        ret

# .DATA

% $random_seed 54321
% $INT_VECTORS 8192
% $VIDEO_MEM 22528
