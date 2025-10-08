# .HEADER
. $str_0 19
. $str_1 21
. $str_2 16
. $str_3 14
. $str_4 18
. $str_5 18
. $str_6 23
. $str_7 28
. $str_8 27
. $str_9 16
. $str_10 18
. $str_11 16
. $str_12 20

# .CODE

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
@rt_print_tos

        call @pop_A
        ld C A

        ldi I ~SYS_PRINT_NUMBER
        int $INT_VECTORS

        ldi C \Return
        ldi I ~SYS_PRINT_CHAR
        int $INT_VECTORS
        ret
@rt_udc_control

        call @pop_B     ; Pop command code into B
        call @pop_A     
        ld M A          ; Save the Channel number
        call @pop_A
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
        call @push_A            ; Push the return value on the datastack

    :rt_udc_end 
        ret
@print_error

        call @pop_A          ; load adres from datastack
        :loop
        ld I A              ; Load address from A into I (R0)
        ldx C $start_memory ; Load character from memory[start_memory + I] into C
        tst C \null         ; Check for null terminator
        jmpt :end_loop      ; If null, end loop

        call @print_char    ; Directly call print_char routine

        addi A 1            ; Increment string address
        jmp :loop           ; Continue loop
    :end_loop
        ret
@fatal

    :end_less
        nop
    jmp :end_less
        ret
@error_invalid_cmd
    ldi A $str_0
    call @push_A
    call @print_error
    ret
@error_invalid_goto_label
    ldi A $str_1
    call @push_A
    call @print_error
    ret
@error_unkown_library
    ldi A $str_2
    call @push_A
    call @print_error
    ret
@errors_unkown_token
    ldi A $str_3
    call @push_A
    call @print_error
    ret
@errors_invalid_def_name
    ldi A $str_4
    call @push_A
    call @print_error
    ret
@errors_invalid_def_body
    ldi A $str_5
    call @push_A
    call @print_error
    ret
@errors_unterminated_def
    ldi A $str_6
    call @push_A
    call @print_error
    ret
@errors_fatal_invalid_syntax
    ldi A $str_7
    call @push_A
    call @print_error
    call @fatal
    ret
@fatal_Invalid_instruction_error
    ldi A $str_8
    call @push_A
    call @print_error
    call @fatal
    ret
@error_wrong_filename
    ldi A $str_9
    call @push_A
    call @print_error
    ret
@error_fatal_disk_error
    ldi A $str_10
    call @push_A
    call @print_error
    call @fatal
    ret
@error_udc_send_error
    ldi A $str_11
    call @push_A
    call @print_error
    call @fatal
    ret
@error_wrong_device_error
    ldi A $str_12
    call @push_A
    call @print_error
    call @fatal
    ret

# .DATA
% $str_0 \I \n \v \a \l \l \i \d \space \C \O \M \M \A \N \D \space \Return \null
% $str_1 \I \n \v \a \l \i \d \space \G \O \T \O \space \l \a \b \e \l \space \Return \null
% $str_2 \U \n \k \o \w \n \space \l \i \b \r \a \r \y \Return \null
% $str_3 \U \n \k \o \w \n \space \t \o \k \e \n \Return \null
% $str_4 \I \n \v \a \l \i \d \space \D \E \F \space \n \a \m \e \Return \null
% $str_5 \I \n \v \a \l \i \d \space \D \E \F \space \b \o \d \y \Return \null
% $str_6 \U \n \t \e \r \m \i \n \a \t \e \d \space \f \u \n \c \t \i \o \n \Return \null
% $str_7 \F \a \t \a \l \space \i \n \v \a \l \i \d \space \s \y \n \t \a \x \space \e \r \r \o \r \Return \null
% $str_8 \I \n \v \a \l \i \d \space \i \n \s \t \r \u \c \t \i \o \n \space \e \r \r \o \r \Return \null
% $str_9 \W \r \o \n \g \space \f \i \l \e \n \a \m \e \Return \null
% $str_10 \F \A \T \A \L \space \d \i \s \k \space \e \r \r \o \r \Return \null
% $str_11 \U \D \C \space \S \e \n \d \space \e \r \r \o \r \Return \null
% $str_12 \W \r \o \n \g \space \d \e \v \i \c \e \space \e \r \r \o \r \Return \null
