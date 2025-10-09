# .HEADER
. $p_syscall_value 1
. $p_syscall_status 1
. $str_0 13

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
@KEYpressed

        ldi I ~SYS_GET_CHAR
        int $INT_VECTORS
        ldm I $p_syscall_value
    ldx A $_start_memory_
    call @push_A
    ldm I $p_syscall_status
    ldx A $_start_memory_
    call @push_A
    ret

# .DATA
% $str_0 \H \e \l \l \o \space \W \o \r \l \d \! \null
