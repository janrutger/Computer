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
. $HEAP_START 1
. $HEAP_SIZE 1
. $HEAP_FREE 1
. $_ARR_TEMP_PTR 1
. $_ARR_VALUE_PTR 1
. $_MAT_TEMP_PTR 1
. $_MAT_X_DIM 1
. $_MAT_Y_DIM 1
. $_MAT_VALUE 1
. $_MAT_PTR 1
. $_MAT_LOOP_COUNTER 1
. $error_mesg0 29
. $error_mesg1 29
. $error_mesg2 32
. $error_mesg3 32
. $error_mesg4 28
. $error_mesg5 30
. $error_mesg6 38
. $_list_size 1
. $_list_ptr 1
. $requested_capacity 1
. $total_size 1
. $new_array_pointer 1
. $array_ptr 1
. $_value 1
. $_capacity 1
. $_count 1
. $dest_addr 1
. $_index 1
. $read_addr 1
. $_total_data_elements 1
. $_total_matrix_size 1

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
    ldi A 10240
    stack A $DATASTACK_PTR
    ldi A 2048
    stack A $DATASTACK_PTR
    call @HEAP.init
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


@HEAP.init
    ustack A $DATASTACK_PTR
    sto A $HEAP_SIZE
    ustack A $DATASTACK_PTR
    sto A $HEAP_START
    sto A $HEAP_FREE
    ret
@HEAP.free
    ldm A $HEAP_START
    sto A $HEAP_FREE
    ret
@NEW.list
    ustack A $DATASTACK_PTR
    sto A $_list_size
    ldm A $HEAP_FREE
    stack A $DATASTACK_PTR
    ldm A $_list_size
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $HEAP_START
    stack A $DATASTACK_PTR
    ldm A $HEAP_SIZE
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.list_if_end_0
    ldi A $error_mesg4
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:NEW.list_if_end_0
    ldm A $HEAP_FREE
    sto A $_list_ptr
    ldm A $HEAP_FREE
    stack A $DATASTACK_PTR
    ldm A $_list_size
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $HEAP_FREE
    ldm A $_list_ptr
    stack A $DATASTACK_PTR
    ret
@NEW.array
    ustack A $DATASTACK_PTR
    sto A $requested_capacity
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $total_size
    ldm A $HEAP_FREE
    stack A $DATASTACK_PTR
    ldm A $total_size
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $HEAP_START
    stack A $DATASTACK_PTR
    ldm A $HEAP_SIZE
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.array_if_end_1
    ldi A $error_mesg0
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:NEW.array_if_end_1
    ldm A $HEAP_FREE
    sto A $new_array_pointer
    ldm A $HEAP_FREE
    stack A $DATASTACK_PTR
    ldm A $total_size
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $HEAP_FREE
    ldm A $new_array_pointer
    sto A $_ARR_TEMP_PTR
    ldm A $requested_capacity
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $new_array_pointer
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldi A 0
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $new_array_pointer
    stack A $DATASTACK_PTR
    ret
@ARRAY.append
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    ustack A $DATASTACK_PTR
    sto A $_value
    ldm A $array_ptr
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_capacity
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_count
    stack A $DATASTACK_PTR
    ldm A $_capacity
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.append_if_end_2
    ldi A $error_mesg1
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.append_if_end_2
    ldm A $_count
    stack A $DATASTACK_PTR
    ldm A $_capacity
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.append_if_end_3
    ldi A $error_mesg1
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.append_if_end_3
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_count
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $dest_addr
    sto A $_ARR_TEMP_PTR
    ldm A $_value
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ret
@ARRAY.put
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    ustack A $DATASTACK_PTR
    sto A $_index
    ustack A $DATASTACK_PTR
    sto A $_value
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_count
    ldm A $_index
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.put_if_end_4
    ldi A $error_mesg2
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.put_if_end_4
    ldm A $_index
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.put_if_end_5
    ldi A $error_mesg2
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.put_if_end_5
    ldm A $_index
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.put_if_end_6
    ldi A $error_mesg2
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.put_if_end_6
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_index
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $dest_addr
    sto A $_ARR_TEMP_PTR
    ldm A $_value
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ret
@ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    ustack A $DATASTACK_PTR
    sto A $_index
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_count
    ldm A $_index
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.get_if_end_7
    ldi A $error_mesg3
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.get_if_end_7
    ldm A $_index
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.get_if_end_8
    ldi A $error_mesg3
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.get_if_end_8
    ldm A $_index
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.get_if_end_9
    ldi A $error_mesg3
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.get_if_end_9
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_index
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $read_addr
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@ARRAY.size
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@ARRAY.clear
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $array_ptr
    ldi A 0
    ld B A
    ldm I $array_ptr
    stx B $_start_memory_
    ret
@NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_MAT_X_DIM
    ustack A $DATASTACK_PTR
    sto A $_MAT_Y_DIM
    ldm A $_MAT_X_DIM
    stack A $DATASTACK_PTR
    ldm A $_MAT_Y_DIM
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $_total_data_elements
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_total_matrix_size
    ldm A $HEAP_FREE
    stack A $DATASTACK_PTR
    ldm A $_total_matrix_size
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $HEAP_START
    stack A $DATASTACK_PTR
    ldm A $HEAP_SIZE
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_if_end_10
    ldi A $error_mesg5
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:NEW.matrix_if_end_10
    ldm A $HEAP_FREE
    sto A $_MAT_PTR
    ldm A $HEAP_FREE
    stack A $DATASTACK_PTR
    ldm A $_total_matrix_size
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $HEAP_FREE
    ldm A $_MAT_PTR
    sto A $_MAT_TEMP_PTR
    ldm A $_MAT_X_DIM
    ld B A
    ldm I $_MAT_TEMP_PTR
    stx B $_start_memory_
    ldm A $_MAT_PTR
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_MAT_TEMP_PTR
    ldm A $_MAT_Y_DIM
    ld B A
    ldm I $_MAT_TEMP_PTR
    stx B $_start_memory_
    ldm A $_MAT_PTR
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_MAT_TEMP_PTR
    ldi A 0
    sto A $_MAT_LOOP_COUNTER
:matrix_populate_loop
    ldm A $_MAT_LOOP_COUNTER
    stack A $DATASTACK_PTR
    ldm A $_total_data_elements
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_if_end_11
    call @TOS.check
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_if_end_12
    ldi A $error_mesg6
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:NEW.matrix_if_end_12
    ustack A $DATASTACK_PTR
    sto A $_MAT_VALUE
    ld B A
    ldm I $_MAT_TEMP_PTR
    stx B $_start_memory_
    ldm A $_MAT_TEMP_PTR
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_MAT_TEMP_PTR
    ldm A $_MAT_LOOP_COUNTER
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_MAT_LOOP_COUNTER
    jmp :matrix_populate_loop
:NEW.matrix_if_end_11
    ldm A $_MAT_PTR
    stack A $DATASTACK_PTR
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

% $HEAP_START 0
% $HEAP_SIZE 0
% $HEAP_FREE 0
% $_ARR_TEMP_PTR 0
% $_ARR_VALUE_PTR 0
% $_MAT_TEMP_PTR 0
% $_MAT_X_DIM 0
% $_MAT_Y_DIM 0
% $_MAT_VALUE 0
% $_MAT_PTR 0
% $_MAT_LOOP_COUNTER 0
% $error_mesg0 \N \E \W \. \a \r \r \a \y \: \space \N \o \space \s \p \a \c \e \space \o \n \space \h \e \a \p \Return \null
% $error_mesg1 \A \R \R \A \Y \. \a \p \p \e \n \d \: \space \A \r \r \a \y \space \i \s \space \f \u \l \l \Return \null
% $error_mesg2 \A \R \R \A \Y \. \p \u \t \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $error_mesg3 \A \R \R \A \Y \. \g \e \t \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $error_mesg4 \N \E \W \. \l \i \s \t \: \space \N \o \space \s \p \a \c \e \space \o \n \space \h \e \a \p \Return \null
% $error_mesg5 \N \E \W \. \m \a \t \r \i \x \: \space \N \o \space \s \p \a \c \e \space \o \n \space \h \e \a \p \Return \null
% $error_mesg6 \N \E \W \. \m \a \t \r \i \x \: \space \N \o \t \space \e \n \o \u \g \h \space \d \a \t \a \space \o \n \space \s \t \a \c \k \Return \null
% $_list_size 0
% $_list_ptr 0
% $requested_capacity 0
% $total_size 0
% $new_array_pointer 0
% $array_ptr 0
% $_value 0
% $_capacity 0
% $_count 0
% $dest_addr 0
% $_index 0
% $read_addr 0
% $_total_data_elements 0
% $_total_matrix_size 0
