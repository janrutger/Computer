@init_kernel_syscalls
    # syscall vectors start from 20

    EQU ~SYS_EXIT 20
    ldi I ~SYS_EXIT     ; syscall 20 @sys_exit
    ldi M @sys_exit     ; Start of the ISR
    stx M $INT_VECTORS  ; Store ISR

    EQU ~SYS_PRINT_CHAR 21
    ldi I ~SYS_PRINT_CHAR ; syscall 21 @sys_print_char
    ldi M @sys_print_char ; Start of the ISR
    stx M $INT_VECTORS    ; Store ISR

    EQU ~SYS_CLEAR_SCREEN 22
    ldi I ~SYS_CLEAR_SCREEN ; syscall 22 @sys_clear_screen
    ldi M @sys_clear_screen ; Start of the ISR
    stx M $INT_VECTORS      ; Store ISR

    EQU ~SYS_GET_CHAR 23
    ldi I ~SYS_GET_CHAR     ; syscall 23 @sys_get_char
    ldi M @sys_get_char     ; Start of the ISR
    stx M $INT_VECTORS      ; Store ISR

    EQU ~SYS_PRINT_STRING 24
    ldi I ~SYS_PRINT_STRING ; syscall 24 @sys_print_string
    ldi M @sys_print_string ; Start of the ISR
    stx M $INT_VECTORS      ; Store ISR

    EQU ~SYS_PRINT_CURSOR 25
    ldi I ~SYS_PRINT_CURSOR ; syscall 25 @sys_print_cursor
    ldi M @sys_print_cursor ; Start of the ISR
    stx M $INT_VECTORS      ; Store ISR

    EQU ~SYS_DEL_CURSOR 26
    ldi I ~SYS_DEL_CURSOR   ; syscall 26 @sys_del_cursor
    ldi M @sys_del_cursor   ; Start of the ISR
    stx M $INT_VECTORS      ; Store ISR


ret

# setup syscalls routines

@sys_exit               ; Syscall 20
    halt
    rti

@sys_print_char         ; Syscall 21
    call @print_char
    rti

@sys_clear_screen       ; Syscall 22
    call @clear_screen
    rti

@sys_get_char           ; Syscall 23
    call @KBD_GET_CHAR
    jmpt :set_status_true
    sto Z $SYSCALL_RETURN_STATUS
    rti
:set_status_true
    ldi A 1
    sto A $SYSCALL_RETURN_STATUS    ; Set status to true
    sto C $SYSCALL_RETURN_VALUE     ; Set C to value
    rti


@sys_print_string       ; Syscall 24
    ; A holds the address of the string
    :loop
        ld I A              ; Load address from A into I (R0)
        ldx C $start_memory ; Load character from memory[start_memory + I] into C
        tst C \null         ; Check for null terminator
        jmpt :end_loop      ; If null, end loop

        call @print_char    ; Directly call print_char routine

        addi A 1            ; Increment string address
        jmp :loop           ; Continue loop
    :end_loop
    rti

@sys_print_cursor       ; Syscall 25
    call @print_cursor
    rti

@sys_del_cursor         ; Syscall 26
    call @del_cursor
    rti

