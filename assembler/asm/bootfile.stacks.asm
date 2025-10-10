# .HEADER
. $p_syscall_status 1
. $p_syscall_value 1
. $input_buffer 16
. $p_input_buffer 1
. $input_buffer_index 1
. $_strcmp_p1 1
. $_strcmp_p2 1
. $_strcmp_c1 1
. $_strcmp_c2 1
. $str_0 15
. $str_1 4
. $str_2 4
. $str_3 6
. $str_4 5

# .CODE

    ldi Z 0                 ; init Z register to 0
    call @init_interrupt_vector_table
    call @init_kernel_syscalls
    call @KBD_INIT

    ei
    ldi A $SYSCALL_RETURN_STATUS
    call @push_A
    ldi A $SYSCALL_RETURN_VALUE
    call @push_A
    call @io_lib_init
    ldi A 12
    call @push_A
    ldi A 30
    call @push_A
    call @rt_add
    call @rt_print_tos
    ldi A $str_0
    call @push_A
    call @PRTstring
    call @KEYchar
    call @PRTchar
    call @READline
    call @PRTstring
    ldi A $str_1
    call @push_A
    ldi A $str_1
    call @push_A
    call @STRcmp
    call @rt_print_tos
    ldi A $str_2
    call @push_A
    ldi A $str_3
    call @push_A
    call @STRcmp
    call @rt_print_tos
    call @READline
    ldi A $str_4
    call @push_A
    call @STRcmp
    call @rt_print_tos

    :HALT    ; Breakpointg before halt
    halt

    INCLUDE hardware_config.stacks
    INCLUDE keyboard_routines.stacks
    INCLUDE screen_routines.stacks
    INCLUDE syscalls.stacks
    ret

# .FUNCTIONS

@io_lib_init
    call @pop_A
    sto A $p_syscall_value
    call @pop_A
    sto A $p_syscall_status
    ret
@PRTchar

        call @pop_A            ; Pop character from stack into C register for the syscall
        ld C A
        ldi I ~SYS_PRINT_CHAR
        int $INT_VECTORS       ; Interrupt to trigger the syscall
        ret
@PRTstring

        call @pop_A              ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ret
@PRTcls

        ldi I ~SYS_CLEAR_SCREEN
        int $INT_VECTORS
        ret
@KEYchar
:key_loop

            ldi I ~SYS_GET_CHAR
            int $INT_VECTORS
            ldm I $p_syscall_status
    ldx A $_start_memory_
    call @push_A
    call @pop_A
    tst A 0
    jmpt :KEYchar_if_end_0
    ldm I $p_syscall_value
    ldx A $_start_memory_
    call @push_A
    jmp :key_end_loop
:KEYchar_if_end_0
    jmp :key_loop
:key_end_loop
    ret
@READline
:readline_loop
    call @KEYchar
    call @rt_dup
    ldi A 13
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :READline_if_end_1
    call @PRTchar
    jmp :finish_readline
:READline_if_end_1
    call @rt_dup
    ldi A 8
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :READline_if_end_2
    ldm A $input_buffer_index
    call @push_A
    ldi A 0
    call @push_A
    call @rt_neq
    call @pop_A
    tst A 0
    jmpt :READline_if_else_3
    call @PRTchar
    ldm A $input_buffer_index
    call @push_A
    ldi A 1
    call @push_A
    call @rt_sub
    call @pop_A
    sto A $input_buffer_index
    jmp :readline_loop
    jmp :READline_if_end_3
:READline_if_else_3
    call @rt_drop
    jmp :readline_loop
:READline_if_end_3
:READline_if_end_2
    call @rt_dup
    call @PRTchar
    ldi A $input_buffer
    call @push_A
    ldm A $input_buffer_index
    call @push_A
    call @rt_add
    call @pop_A
    sto A $p_input_buffer
    call @pop_B
    ldm I $p_input_buffer
    stx B $_start_memory_
    ldm A $input_buffer_index
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $input_buffer_index
    jmp :readline_loop
:finish_readline
    ldi A $input_buffer
    call @push_A
    ldm A $input_buffer_index
    call @push_A
    call @rt_add
    call @pop_A
    sto A $p_input_buffer
    ldi A 0
    call @push_A
    call @pop_B
    ldm I $p_input_buffer
    stx B $_start_memory_
    ldi A 0
    call @push_A
    call @pop_A
    sto A $input_buffer_index
    ldi A $input_buffer
    call @push_A
    ret


@STRcmp
    call @pop_A
    sto A $_strcmp_p2
    call @pop_A
    sto A $_strcmp_p1
:strcmp_loop
    ldm I $_strcmp_p1
    ldx A $_start_memory_
    call @push_A
    call @pop_A
    sto A $_strcmp_c1
    ldm I $_strcmp_p2
    ldx A $_start_memory_
    call @push_A
    call @pop_A
    sto A $_strcmp_c2
    ldm A $_strcmp_c1
    call @push_A
    ldm A $_strcmp_c2
    call @push_A
    call @rt_neq
    call @pop_A
    tst A 0
    jmpt :STRcmp_if_end_0
    ldi A 0
    call @push_A
    jmp :strcmp_end
:STRcmp_if_end_0
    ldm A $_strcmp_c1
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :STRcmp_if_end_1
    ldi A 1
    call @push_A
    jmp :strcmp_end
:STRcmp_if_end_1
    ldm A $_strcmp_p1
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $_strcmp_p1
    ldm A $_strcmp_p2
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $_strcmp_p2
    jmp :strcmp_loop
:strcmp_end
    ret


# .DATA

% $p_syscall_status 0
% $p_syscall_value 0
% $p_input_buffer 0
% $input_buffer_index 0

% $_strcmp_p1 0
% $_strcmp_p2 0
% $_strcmp_c1 0
% $_strcmp_c2 0
% $str_0 \H \e \l \l \o \space \W \o \r \l \d \! \space \Return \null
% $str_1 \t \s \t \null
% $str_2 \a \a \p \null
% $str_3 \a \a \a \a \p \null
% $str_4 \n \o \o \t \null
