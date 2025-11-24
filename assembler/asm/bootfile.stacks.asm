# .HEADER
. $p_epoc 1
. $p_currentime 1
. $p_watch_list 1
. $current_watch 1
. $wait_end_time 1
. $watch_list 8
. $p_syscall_status 1
. $p_syscall_value 1
. $input_buffer 80
. $p_input_buffer 1
. $input_buffer_index 1
. $info_mesg0 61
. $_strcmp_p1 1
. $_strcmp_p2 1
. $_strcmp_c1 1
. $_strcmp_c2 1
. $_atoi_s_ptr 1
. $_atoi_p 1
. $_atoi_c 1
. $_atoi_result 1
. $_strlen_p 1
. $_strlen_len 1
. $_strfind_p 1
. $_strfind_char 1
. $_strfind_idx 1

# .CODE

    ldi Z 0                 ; init Z register to 0
    call @init_interrupt_vector_table
    call @init_kernel_syscalls
    call @init_udc
    call @init_vdisk
    call @KBD_INIT

    ei
    call @INIT_RTC
    call @TIME.init
    ldi A $SYSCALL_RETURN_STATUS
    stack A $DATASTACK_PTR
    ldi A $SYSCALL_RETURN_VALUE
    stack A $DATASTACK_PTR
    call @io_lib_init
    call @start_kernel

    :HALT    ; Breakpointg before halt
    halt

    INCLUDE hardware_config.stacks
    INCLUDE keyboard_routines.stacks
    INCLUDE rtc_routines.stacks
    INCLUDE screen_routines.stacks
    INCLUDE udc_routines.stacks
    INCLUDE syscalls.stacks
    INCLUDE stern_kernel.stacks
    INCLUDE vdisk_routines.stacks
    ret

# .FUNCTIONS

@TIME.init
    ldi A $SYSTEM_TIME
    sto A $p_currentime
    ldi A $SYSTEM_EPOC
    sto A $p_epoc
    ldi A $watch_list
    sto A $p_watch_list
    ret
@TIME.uptime
    ldm I $p_currentime
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm I $p_epoc
    ldx A $_start_memory_
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ret
@TIME.start
    ldm A $p_watch_list
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_watch
    ldm I $p_currentime
    ldx A $_start_memory_
    ld B A
    ldm I $current_watch
    stx B $_start_memory_
    ret
@TIME.read
    ldm A $p_watch_list
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_watch
    ldm I $p_currentime
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm I $current_watch
    ldx A $_start_memory_
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ret
@TIME.wait
    ldm I $p_currentime
    ldx A $_start_memory_
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $wait_end_time
:wait_loop
    ldm A $wait_end_time
    stack A $DATASTACK_PTR
    ldm I $p_currentime
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TIME.wait_if_end_0
    jmp :wait_loop
:TIME.wait_if_end_0
    ret
@TIME.as_string

        # --- Part 1: Split total_ms into total_seconds and milliseconds ---
        ldi A 1000
        ustack B $DATASTACK_PTR     ; Pop total_ms into B
        dmod B A                    ; B becomes total_seconds, A becomes milliseconds

        # Save milliseconds on the stack so we can reuse register A
        stack A $DATASTACK_PTR      ; Stack now contains: [milliseconds]

        # --- Part 2: Split total_seconds into minutes and seconds ---
        # B still holds total_seconds from the first operation
        ldi A 60
        dmod B A                    ; B becomes minutes, A becomes seconds

        # --- Part 3: Print all parts ---

        # Print Minutes (from B)
        ld C B
        ldi I ~SYS_PRINT_NUMBER
        int $INT_VECTORS

        # Print separator
        ldi C \m
        ldi I ~SYS_PRINT_CHAR
        int $INT_VECTORS

        # Print Seconds (from A)
        ld C A
        ldi I ~SYS_PRINT_NUMBER
        int $INT_VECTORS

        # Print separator
        ldi C \s
        ldi I ~SYS_PRINT_CHAR
        int $INT_VECTORS

        # Print Milliseconds (from the stack)
        ustack C $DATASTACK_PTR     ; Pop milliseconds from stack into C
        ldi I ~SYS_PRINT_NUMBER
        int $INT_VECTORS

        # # Print trailing space and newline
        # ldi C \space
        # ldi I ~SYS_PRINT_CHAR
        # int $INT_VECTORS
        ret


@io_lib_init
    ustack A $DATASTACK_PTR
    sto A $p_syscall_value
    ustack A $DATASTACK_PTR
    sto A $p_syscall_status
    ret
@PRTchar

        ustack A $DATASTACK_PTR ; Pop character from stack into C register for the syscall
        ld C A
        ldi I ~SYS_PRINT_CHAR
        int $INT_VECTORS        ; Interrupt to trigger the syscall
        ret
@PRTstring

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ret
@PRTnum

        ustack A $DATASTACK_PTR
        ld C A

        ldi I ~SYS_PRINT_NUMBER
        int $INT_VECTORS
        
        ret
@PRTcls

        ldi I ~SYS_CLEAR_SCREEN
        int $INT_VECTORS
        ret
@CURSORon

        ldi I ~SYS_PRINT_CURSOR
        int $INT_VECTORS
        ret
@CURSORoff

        ldi I ~SYS_DEL_CURSOR
        int $INT_VECTORS
        ret
@KEYchar
:key_loop

            ldi I ~SYS_GET_CHAR
            int $INT_VECTORS
            ldm I $p_syscall_status
    ldx A $_start_memory_
    tst A 0
    jmpt :KEYchar_if_end_0
    ldm I $p_syscall_value
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    jmp :key_end_loop
:KEYchar_if_end_0
    jmp :key_loop
:key_end_loop
    ret
@KEYpressed

        ldi I ~SYS_GET_CHAR
        int $INT_VECTORS
        ldm I $p_syscall_status
    ldx A $_start_memory_
    tst A 0
    jmpt :KEYpressed_if_else_1
    ldm I $p_syscall_value
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :KEYpressed_if_end_1
:KEYpressed_if_else_1
    ldi A 0
    stack A $DATASTACK_PTR
:KEYpressed_if_end_1
    ret
@READline
:readline_loop
    call @CURSORon
    call @KEYchar
    call @CURSORon
    call @rt_dup
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :READline_if_end_2
    call @CURSORoff
    call @PRTchar
    jmp :finish_readline
:READline_if_end_2
    call @rt_dup
    ldi A 8
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :READline_if_end_3
    ldm A $input_buffer_index
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :READline_if_else_4
    call @CURSORoff
    call @PRTchar
    ldm A $input_buffer_index
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $input_buffer_index
    jmp :readline_loop
    jmp :READline_if_end_4
:READline_if_else_4
    call @rt_drop
    jmp :readline_loop
:READline_if_end_4
:READline_if_end_3
    call @rt_dup
    call @PRTchar
    ldi A $input_buffer
    stack A $DATASTACK_PTR
    ldm A $input_buffer_index
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $p_input_buffer
    ustack B $DATASTACK_PTR
    ldm I $p_input_buffer
    stx B $_start_memory_
    ldm A $input_buffer_index
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $input_buffer_index
    jmp :readline_loop
:finish_readline
    ldi A $input_buffer
    stack A $DATASTACK_PTR
    ldm A $input_buffer_index
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $p_input_buffer
    ldi A 0
    ld B A
    ldm I $p_input_buffer
    stx B $_start_memory_
    ldi A 0
    sto A $input_buffer_index
    ldi A $input_buffer
    stack A $DATASTACK_PTR
    ret
@TOS.check

        ldi K $DATASTACK        ; start adres of buffer in K
        ldm M $DATASTACK_PTR    ; Current stackpointer in M

        tste K M                ; 0 when stack emty
        jmpt :stack_empty
        # ldi A 1
        # stack A $DATASTACK_PTR
        sub M K                 ; Calculate stack use
        stack M $DATASTACK_PTR  ; place numner of stack items at TOS
        jmp :checkstack_done
    :stack_empty                ; Stack is empty
        ldi A 0
        stack A $DATASTACK_PTR
    :checkstack_done
        ret
@HALT
    ldi A $info_mesg0
    stack A $DATASTACK_PTR
    call @PRTstring
:HALT_while_start_0
    ldi A 1
    tst A 0
    jmpt :HALT_while_end_0
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :HALT_if_end_5
    ldi A 27
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :HALT_if_end_6

                    halt
                :HALT_if_end_6
:HALT_if_end_5
    jmp :HALT_while_start_0
:HALT_while_end_0
    ret


@STRcmp
    ustack A $DATASTACK_PTR
    sto A $_strcmp_p2
    ustack A $DATASTACK_PTR
    sto A $_strcmp_p1
:strcmp_loop
    ldm I $_strcmp_p1
    ldx A $_start_memory_
    sto A $_strcmp_c1
    ldm I $_strcmp_p2
    ldx A $_start_memory_
    sto A $_strcmp_c2
    ldm A $_strcmp_c1
    stack A $DATASTACK_PTR
    ldm A $_strcmp_c2
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRcmp_if_end_0
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :strcmp_end
:STRcmp_if_end_0
    ldm A $_strcmp_c1
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRcmp_if_end_1
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :strcmp_end
:STRcmp_if_end_1
    ldm A $_strcmp_p1
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_strcmp_p1
    ldm A $_strcmp_p2
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_strcmp_p2
    jmp :strcmp_loop
:strcmp_end
    ret
@STRatoi
    ustack A $DATASTACK_PTR
    sto A $_atoi_s_ptr
    ldi A 0
    sto A $_atoi_result
    ldm A $_atoi_s_ptr
    sto A $_atoi_p
:atoi_loop
    ldm I $_atoi_p
    ldx A $_start_memory_
    sto A $_atoi_c
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRatoi_if_end_2
    ldm A $_atoi_result
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :atoi_end
:STRatoi_if_end_2
    ldm A $_atoi_c
    stack A $DATASTACK_PTR
    ldi A 48
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRatoi_if_end_3
    jmp :atoi_fail
:STRatoi_if_end_3
    ldm A $_atoi_c
    stack A $DATASTACK_PTR
    ldi A 57
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRatoi_if_end_4
    jmp :atoi_fail
:STRatoi_if_end_4
    ldm A $_atoi_c
    stack A $DATASTACK_PTR
    ldi A 48
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $_atoi_result
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_atoi_result
    ldm A $_atoi_p
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_atoi_p
    jmp :atoi_loop
:atoi_fail
    ldm A $_atoi_s_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :atoi_end
:atoi_end
    ret
@STRlen
    ustack A $DATASTACK_PTR
    sto A $_strlen_p
    ldi A 0
    sto A $_strlen_len
:strlen_loop
    ldm I $_strlen_p
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRlen_if_end_5
    jmp :strlen_end
:STRlen_if_end_5
    ldm A $_strlen_p
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_strlen_p
    ldm A $_strlen_len
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_strlen_len
    jmp :strlen_loop
:strlen_end
    ldm A $_strlen_len
    stack A $DATASTACK_PTR
    ret
@STRfind
    ustack A $DATASTACK_PTR
    sto A $_strfind_char
    ustack A $DATASTACK_PTR
    sto A $_strfind_p
    ldi A 0
    sto A $_strfind_idx
:strfind_loop
    ldm I $_strfind_p
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRfind_if_end_6
    call @rt_drop
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :strfind_end
:STRfind_if_end_6
    ldm A $_strfind_char
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRfind_if_end_7
    ldm A $_strfind_idx
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :strfind_end
:STRfind_if_end_7
    ldm A $_strfind_p
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_strfind_p
    ldm A $_strfind_idx
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_strfind_idx
    jmp :strfind_loop
:strfind_end
    ret
@STRcopy

        push A 
        push B
        push C

        ustack B $DATASTACK_PTR     ; pointer to to_string in B
        ustack A $DATASTACK_PTR     ; pointer to from_string in A

        :string_copy_loop
            ld I A 
            ldx C $_start_memory_    ; read char from source

            ld I B 
            stx C $_start_memory_    ; write char to dest

            tst C \null
            jmpt :string_copy_end   ; end of string to copy

            addi A 1
            addi B 1
            jmp :string_copy_loop

        :string_copy_end            ; copy is done

        pop C 
        pop B 
        pop A

        ret


# .DATA

% $p_epoc 0
% $p_currentime 0
% $p_watch_list 0
% $current_watch 0
% $wait_end_time 0

% $p_syscall_status 0
% $p_syscall_value 0
% $p_input_buffer 0
% $input_buffer_index 0
% $info_mesg0 \P \A \N \I \C \: \space \H \a \l \t \e \d \space \a \f \t \e \r \space \a \n \space \n \o \n \- \r \e \c \o \v \e \r \a \b \l \e \space \e \r \r \o \r \. \space \( \p \r \e \s \s \space \< \e \s \c \> \) \Return \null

% $_strcmp_p1 0
% $_strcmp_p2 0
% $_strcmp_c1 0
% $_strcmp_c2 0
% $_atoi_s_ptr 0
% $_atoi_p 0
% $_atoi_c 0
% $_atoi_result 0
% $_strlen_p 0
% $_strlen_len 0
% $_strfind_p 0
% $_strfind_char 0
% $_strfind_idx 0
