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
. $_sh_ptr 1
. $_sh_acc 1
. $HEAP_START 1
. $HEAP_SIZE 1
. $HEAP_FREE 1
. $_ARR_TEMP_PTR 1
. $_MAT_TEMP_PTR 1
. $_MAT_X_DIM 1
. $_MAT_Y_DIM 1
. $_MAT_VALUE 1
. $_MAT_PTR 1
. $_MAT_LOOP_COUNTER 1
. $_MAT_OFFSET 1
. $error_mesg0 29
. $error_mesg1 29
. $error_mesg2 32
. $error_mesg3 32
. $error_mesg4 28
. $error_mesg5 30
. $error_mesg6 38
. $error_mesg7 29
. $error_mesg8 32
. $_list_size 1
. $_list_ptr 1
. $_LST_PTR 1
. $_LST_IDX 1
. $_LST_VAL 1
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
. $_dict_ptr 1
. $_dict_cap 1
. $_dict_cnt 1
. $_dict_key 1
. $_dict_val 1
. $_dict_idx 1
. $_dict_found 1
. $_dict_offset 1
. $_dict_last_off 1
. $_dict_last_key 1
. $_dict_last_val 1
. $_dict_err_full 30
. $_dict_err_key 25
. $_dict_err_bnd 32
. $_dict_err_inv_key 49
. $DEQUE_FREE_HEAD 1
. $DEQUE_POOL_PAGE_SIZE 1
. $_dq_i 1
. $_dq_ptr 1
. $_dq_next_ptr 1
. $_dq_node 1
. $_dq_val 1
. $_dq_list 1
. $_dq_head 1
. $_dq_tail 1
. $_dq_prev 1
. $_dq_next 1
. $_dq_err_empty 27
. $opcode_table 1
. $opcode_runtimes 1
. $label_addresses 1
. $syscall_table 1
. $_env_vvm_ptr 1
. $_env_sp_ptr_loc 1
. $_env_sp_addr 1
. $_env_val 1
. $_env_host_ptr_loc 1
. $_env_host_dq 1
. $_env_count 1
. $_env_ptr 1
. $_env_idx 1
. $_env_val_tmp 1
. $_math_a 1
. $_math_b 1
. $error_stack_collision 33
. $_temp_ptr 1
. $_temp_idx 1
. $_temp_val 1
. $_scan_ptr 1
. $_vvm_pc_offset 1
. $_opcode 1
. $_is_opcode 1
. $error_no_code 26
. $error_no_opcode 28
. $error_no_syscall 33
. $error_label_unknown 23
. $error_invalid_reg 30
. $error_div_zero 30
. $error_vvm_overflow 23
. $msg_labels_found 15
. $_run_pc 1
. $_run_opcode 1
. $_run_handler 1
. $_start_argc 1
. $_start_idx 1
. $_syscall_id 1
. $_syscall_handler 1
. $_VVMpointer 1
. $_VVMHOSTpointer 1
. $_VVMsize 1
. $_SIMPLcode 1
. $_vvm_max_size 1
. $_vvm_needed_size 1
. $_vvm_code_start 1
. $_vvm_write_ptr 1

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
    ldi A 24576
    stack A $DATASTACK_PTR
    ldi A 6144
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
@TIME.wait
    ldm I $p_currentime
    ldx A $_start_memory_
    ustack B $DATASTACK_PTR
    add A B
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

            nop
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
    stack Z $DATASTACK_PTR
:KEYpressed_if_end_1
    ret
@READline
:readline_loop

        ldi I ~SYS_PRINT_CURSOR
        int $INT_VECTORS
        call @KEYchar

        ldi I ~SYS_PRINT_CURSOR
        int $INT_VECTORS
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
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :READline_if_else_4
    call @CURSORoff
    call @PRTchar
    ldm B $input_buffer_index
    ldi A 1
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
    ld B A
    ldm A $input_buffer_index
    add A B
    sto A $p_input_buffer
    ustack B $DATASTACK_PTR
    ldm I $p_input_buffer
    stx B $_start_memory_
    ldm B $input_buffer_index
    ldi A 1
    add A B
    sto A $input_buffer_index
    jmp :readline_loop
:finish_readline
    ldi A $input_buffer
    ld B A
    ldm A $input_buffer_index
    add A B
    sto A $p_input_buffer
    ld B Z
    ldm I $p_input_buffer
    stx B $_start_memory_
    ld A Z
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
    stack Z $DATASTACK_PTR
    :checkstack_done
        ret
@HALT
    ldi A $info_mesg0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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
    stack Z $DATASTACK_PTR
    jmp :strcmp_end
:STRcmp_if_end_0
    ldm A $_strcmp_c1
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRcmp_if_end_1
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :strcmp_end
:STRcmp_if_end_1
    ldm B $_strcmp_p1
    ldi A 1
    add A B
    sto A $_strcmp_p1
    ldm B $_strcmp_p2
    ldi A 1
    add A B
    sto A $_strcmp_p2
    jmp :strcmp_loop
:strcmp_end
    ret
@STRatoi
    ustack A $DATASTACK_PTR
    sto A $_atoi_s_ptr
    ld A Z
    sto A $_atoi_result
    ldm A $_atoi_s_ptr
    sto A $_atoi_p
:atoi_loop
    ldm I $_atoi_p
    ldx A $_start_memory_
    sto A $_atoi_c
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    ldm B $_atoi_c
    ldi A 48
    sub B A
    stack B $DATASTACK_PTR
    ldm B $_atoi_result
    ldi A 10
    mul A B
    ustack B $DATASTACK_PTR
    add A B
    sto A $_atoi_result
    ldm B $_atoi_p
    ldi A 1
    add A B
    sto A $_atoi_p
    jmp :atoi_loop
:atoi_fail
    ldm A $_atoi_s_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    jmp :atoi_end
:atoi_end
    ret
@STRlen
    ustack A $DATASTACK_PTR
    sto A $_strlen_p
    ld A Z
    sto A $_strlen_len
:strlen_loop
    ldm I $_strlen_p
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRlen_if_end_5
    jmp :strlen_end
:STRlen_if_end_5
    ldm B $_strlen_p
    ldi A 1
    add A B
    sto A $_strlen_p
    ldm B $_strlen_len
    ldi A 1
    add A B
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
    ld A Z
    sto A $_strfind_idx
:strfind_loop
    ldm I $_strfind_p
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @rt_dup
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRfind_if_end_6
    call @rt_drop
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    ldm B $_strfind_p
    ldi A 1
    add A B
    sto A $_strfind_p
    ldm B $_strfind_idx
    ldi A 1
    add A B
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
@STRhash

        # 1. Get String Pointer
        ustack A $DATASTACK_PTR ; Pop string pointer into A
        sto A $_sh_ptr          ; Store it so LDX can use it as base

        # 2. Init Hash (DJB2 starts with 5381)
        ldi A 5381
        sto A $_sh_acc
        
        # 3. Init Index
        ldi I 0

        :hash_loop1
            ldx A $_sh_ptr   ; Load char at (_sh_ptr + I)
            tst A 0          ; Check for null terminator
            jmpt :hash_end   ; If 0, we are done

            ldm B $_sh_acc    ; Load current hash
            muli B 33        ; Hash * 33
            add B A          ; + Char
            sto B $_sh_acc   ; Update hash

            addi I 1         ; Increment index
            jmp :hash_loop1

        :hash_end
            ldm A $_sh_acc          ; Load result
            stack A $DATASTACK_PTR ; Push to stack
        ret


@HEAP.init
    ustack A $DATASTACK_PTR
    sto A $HEAP_SIZE
    ustack A $DATASTACK_PTR
    sto A $HEAP_START
    sto A $HEAP_FREE
    ret
@NEW.list
    ustack A $DATASTACK_PTR
    sto A $_list_size
    ldm B $HEAP_FREE
    ldm A $_list_size
    add B A
    stack B $DATASTACK_PTR
    ldm B $HEAP_START
    ldm A $HEAP_SIZE
    add B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.list_if_end_0
    ldi A $error_mesg4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:NEW.list_if_end_0
    ldm A $HEAP_FREE
    sto A $_list_ptr
    ldm B $HEAP_FREE
    ldm A $_list_size
    add A B
    sto A $HEAP_FREE
    ldm A $_list_ptr
    stack A $DATASTACK_PTR
    ret
@LIST.put
    ustack A $DATASTACK_PTR
    sto A $_LST_PTR
    ustack A $DATASTACK_PTR
    sto A $_LST_IDX
    ustack A $DATASTACK_PTR
    sto A $_LST_VAL

        ldm A $_LST_VAL
        ldm B $_LST_PTR
        ldm I $_LST_IDX
        add I B
        stx A $_start_memory_
        ret
@LIST.get
    ustack A $DATASTACK_PTR
    sto A $_LST_PTR
    ustack A $DATASTACK_PTR
    sto A $_LST_IDX

        ldm B $_LST_PTR
        ldm I $_LST_IDX
        add I B
        ldx A $_start_memory_
        stack A $DATASTACK_PTR
        ret
@NEW.array
    ustack A $DATASTACK_PTR
    sto A $requested_capacity
    ld B A
    ldi A 2
    add A B
    sto A $total_size
    ldm B $HEAP_FREE
    ldm A $total_size
    add B A
    stack B $DATASTACK_PTR
    ldm B $HEAP_START
    ldm A $HEAP_SIZE
    add B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.array_if_end_1
    ldi A $error_mesg0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:NEW.array_if_end_1
    ldm A $HEAP_FREE
    sto A $new_array_pointer
    ldm B $HEAP_FREE
    ldm A $total_size
    add A B
    sto A $HEAP_FREE
    ldm A $new_array_pointer
    sto A $_ARR_TEMP_PTR
    ldm A $requested_capacity
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm B $new_array_pointer
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
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
    ldm B $array_ptr
    ldi A 1
    add A B
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

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:ARRAY.append_if_end_3
    ldm B $array_ptr
    ldi A 2
    add B A
    ldm A $_count
    add A B
    sto A $dest_addr
    sto A $_ARR_TEMP_PTR
    ldm A $_value
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm B $array_ptr
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ldm B $_count
    ldi A 1
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
    ldm B $array_ptr
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_count
    ldm A $_index
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.put_if_end_4
    ldi A $error_mesg2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:ARRAY.put_if_end_6
    ldm B $array_ptr
    ldi A 2
    add B A
    ldm A $_index
    add A B
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
    ldm B $array_ptr
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_count
    ldm A $_index
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.get_if_end_7
    ldi A $error_mesg3
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:ARRAY.get_if_end_9
    ldm B $array_ptr
    ldi A 2
    add B A
    ldm A $_index
    add A B
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
    ld B A
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_MAT_X_DIM
    ustack A $DATASTACK_PTR
    sto A $_MAT_Y_DIM
    ldm A $_MAT_X_DIM
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_if_end_10
    ldi A $error_mesg8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:NEW.matrix_if_end_10
    ldm A $_MAT_Y_DIM
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_if_end_11
    ldi A $error_mesg8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:NEW.matrix_if_end_11
    ldm B $_MAT_X_DIM
    ldm A $_MAT_Y_DIM
    mul A B
    sto A $_total_data_elements
    ld B A
    ldi A 2
    add A B
    sto A $_total_matrix_size
    ldm B $HEAP_FREE
    ldm A $_total_matrix_size
    add B A
    stack B $DATASTACK_PTR
    ldm B $HEAP_START
    ldm A $HEAP_SIZE
    add B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_if_end_12
    ldi A $error_mesg5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:NEW.matrix_if_end_12
    ldm A $HEAP_FREE
    sto A $_MAT_PTR
    ldm B $HEAP_FREE
    ldm A $_total_matrix_size
    add A B
    sto A $HEAP_FREE
    ldm A $_MAT_PTR
    sto A $_MAT_TEMP_PTR
    ldm A $_MAT_Y_DIM
    ld B A
    ldm I $_MAT_TEMP_PTR
    stx B $_start_memory_
    ldm B $_MAT_PTR
    ldi A 1
    add A B
    sto A $_MAT_TEMP_PTR
    ldm A $_MAT_X_DIM
    ld B A
    ldm I $_MAT_TEMP_PTR
    stx B $_start_memory_
    ldm A $_MAT_PTR
    stack A $DATASTACK_PTR
    ret
@MATRIX.put
    ustack A $DATASTACK_PTR
    sto A $_MAT_PTR
    ustack A $DATASTACK_PTR
    sto A $_MAT_X_DIM
    ustack A $DATASTACK_PTR
    sto A $_MAT_Y_DIM
    ustack A $DATASTACK_PTR
    sto A $_MAT_VALUE
    ldm A $_MAT_Y_DIM
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MATRIX.put_if_end_13
    ldi A $error_mesg7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:MATRIX.put_if_end_13
    ldm A $_MAT_PTR
    sto A $_MAT_TEMP_PTR
    ldm I $_MAT_TEMP_PTR
    ldx A $_start_memory_
    sto A $_MAT_OFFSET
    ldm A $_MAT_Y_DIM
    stack A $DATASTACK_PTR
    ldm A $_MAT_OFFSET
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MATRIX.put_if_end_14
    ldi A $error_mesg7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:MATRIX.put_if_end_14
    ldm A $_MAT_X_DIM
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MATRIX.put_if_end_15
    ldi A $error_mesg7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:MATRIX.put_if_end_15
    ldm B $_MAT_PTR
    ldi A 1
    add A B
    sto A $_MAT_TEMP_PTR
    ldm I $_MAT_TEMP_PTR
    ldx A $_start_memory_
    sto A $_MAT_OFFSET
    ldm A $_MAT_X_DIM
    stack A $DATASTACK_PTR
    ldm A $_MAT_OFFSET
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MATRIX.put_if_end_16
    ldi A $error_mesg7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:MATRIX.put_if_end_16
    ldm B $_MAT_X_DIM
    ldi A 1
    sub B A
    ld A B
    sto A $_MAT_X_DIM
    ldm B $_MAT_Y_DIM
    ldi A 1
    sub B A
    ld A B
    sto A $_MAT_Y_DIM
    ld B A
    ldm A $_MAT_OFFSET
    mul B A
    ldm A $_MAT_X_DIM
    add B A
    ldi A 2
    add A B
    sto A $_MAT_OFFSET
    ldm B $_MAT_PTR
    ldm A $_MAT_OFFSET
    add A B
    sto A $_MAT_TEMP_PTR
    ldm A $_MAT_VALUE
    ld B A
    ldm I $_MAT_TEMP_PTR
    stx B $_start_memory_
    ret
@MATRIX.get
    ustack A $DATASTACK_PTR
    sto A $_MAT_PTR
    ustack A $DATASTACK_PTR
    sto A $_MAT_X_DIM
    ustack A $DATASTACK_PTR
    sto A $_MAT_Y_DIM
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MATRIX.get_if_end_17
    ldi A $error_mesg7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:MATRIX.get_if_end_17
    ldm A $_MAT_PTR
    sto A $_MAT_TEMP_PTR
    ldm I $_MAT_TEMP_PTR
    ldx A $_start_memory_
    sto A $_MAT_OFFSET
    ldm A $_MAT_Y_DIM
    stack A $DATASTACK_PTR
    ldm A $_MAT_OFFSET
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MATRIX.get_if_end_18
    ldi A $error_mesg7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:MATRIX.get_if_end_18
    ldm A $_MAT_X_DIM
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MATRIX.get_if_end_19
    ldi A $error_mesg7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:MATRIX.get_if_end_19
    ldm B $_MAT_PTR
    ldi A 1
    add A B
    sto A $_MAT_TEMP_PTR
    ldm I $_MAT_TEMP_PTR
    ldx A $_start_memory_
    sto A $_MAT_OFFSET
    ldm A $_MAT_X_DIM
    stack A $DATASTACK_PTR
    ldm A $_MAT_OFFSET
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MATRIX.get_if_end_20
    ldi A $error_mesg7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:MATRIX.get_if_end_20
    ldm B $_MAT_X_DIM
    ldi A 1
    sub B A
    ld A B
    sto A $_MAT_X_DIM
    ldm B $_MAT_Y_DIM
    ldi A 1
    sub B A
    ld A B
    sto A $_MAT_Y_DIM
    ld B A
    ldm A $_MAT_OFFSET
    mul B A
    ldm A $_MAT_X_DIM
    add B A
    ldi A 2
    add A B
    sto A $_MAT_OFFSET
    ldm B $_MAT_PTR
    ldm A $_MAT_OFFSET
    add A B
    sto A $_MAT_TEMP_PTR
    ldm I $_MAT_TEMP_PTR
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@NEW.matrix_populate
    ustack A $DATASTACK_PTR
    sto A $_MAT_X_DIM
    ustack A $DATASTACK_PTR
    sto A $_MAT_Y_DIM
    ldm A $_MAT_X_DIM
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_populate_if_end_21
    ldi A $error_mesg8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:NEW.matrix_populate_if_end_21
    ldm A $_MAT_Y_DIM
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_populate_if_end_22
    ldi A $error_mesg8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:NEW.matrix_populate_if_end_22
    ldm B $_MAT_X_DIM
    ldm A $_MAT_Y_DIM
    mul A B
    sto A $_total_data_elements
    ld B A
    ldi A 2
    add A B
    sto A $_total_matrix_size
    ldm B $HEAP_FREE
    ldm A $_total_matrix_size
    add B A
    stack B $DATASTACK_PTR
    ldm B $HEAP_START
    ldm A $HEAP_SIZE
    add B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_populate_if_end_23
    ldi A $error_mesg5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:NEW.matrix_populate_if_end_23
    ldm A $HEAP_FREE
    sto A $_MAT_PTR
    ldm B $HEAP_FREE
    ldm A $_total_matrix_size
    add A B
    sto A $HEAP_FREE
    ldm A $_MAT_PTR
    sto A $_MAT_TEMP_PTR
    ldm A $_MAT_Y_DIM
    ld B A
    ldm I $_MAT_TEMP_PTR
    stx B $_start_memory_
    ldm B $_MAT_PTR
    ldi A 1
    add A B
    sto A $_MAT_TEMP_PTR
    ldm A $_MAT_X_DIM
    ld B A
    ldm I $_MAT_TEMP_PTR
    stx B $_start_memory_
    ldm B $_MAT_PTR
    ldi A 2
    add A B
    sto A $_MAT_TEMP_PTR
    ld A Z
    sto A $_MAT_LOOP_COUNTER
:matrix_populate_loop
    ldm A $_MAT_LOOP_COUNTER
    stack A $DATASTACK_PTR
    ldm A $_total_data_elements
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_populate_if_end_24
    call @TOS.check
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.matrix_populate_if_end_25
    ldi A $error_mesg6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:NEW.matrix_populate_if_end_25
    ustack A $DATASTACK_PTR
    sto A $_MAT_VALUE
    ld B A
    ldm I $_MAT_TEMP_PTR
    stx B $_start_memory_
    ldm B $_MAT_TEMP_PTR
    ldi A 1
    add A B
    sto A $_MAT_TEMP_PTR
    ldm B $_MAT_LOOP_COUNTER
    ldi A 1
    add A B
    sto A $_MAT_LOOP_COUNTER
    jmp :matrix_populate_loop
:NEW.matrix_populate_if_end_24
    ldm A $_MAT_PTR
    stack A $DATASTACK_PTR
    ret


@DICT.new
    ustack A $DATASTACK_PTR
    sto A $_dict_cap
    ld B A
    ldi A 2
    mul B A
    ldi A 2
    add B A
    stack B $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ldm A $_dict_cap
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    ret
@DICT.count
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DICT.put
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ustack A $DATASTACK_PTR
    sto A $_dict_val
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_end_0
    ldi A $_dict_err_inv_key
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DICT.put_if_end_0
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_found
    ld A Z
    sto A $_dict_idx
:DICT.put_while_start_0
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_while_end_0
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_else_1
    ldm A $_dict_val
    stack A $DATASTACK_PTR
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 1
    sto A $_dict_found
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.put_if_end_1
:DICT.put_if_else_1
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.put_if_end_1
    jmp :DICT.put_while_start_0
:DICT.put_while_end_0
    ldm A $_dict_found
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_end_2
    stack Z $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cap
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    ldm A $_dict_cap
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_end_3
    ldi A $_dict_err_full
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DICT.put_if_end_3
    ldm B $_dict_cnt
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    ldm A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_val
    stack A $DATASTACK_PTR
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_dict_cnt
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
:DICT.put_if_end_2
    ret
@DICT.get
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_found
    ld A Z
    sto A $_dict_idx
:DICT.get_while_start_1
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.get_while_end_1
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.get_if_else_4
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 1
    sto A $_dict_found
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.get_if_end_4
:DICT.get_if_else_4
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.get_if_end_4
    jmp :DICT.get_while_start_1
:DICT.get_while_end_1
    ldm A $_dict_found
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.get_if_end_5
    ldi A $_dict_err_key
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DICT.get_if_end_5
    ret
@DICT.has_key
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_found
    ld A Z
    sto A $_dict_idx
:DICT.has_key_while_start_2
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.has_key_while_end_2
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.has_key_if_else_6
    ldi A 1
    sto A $_dict_found
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.has_key_if_end_6
:DICT.has_key_if_else_6
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.has_key_if_end_6
    jmp :DICT.has_key_while_start_2
:DICT.has_key_while_end_2
    ldm A $_dict_found
    stack A $DATASTACK_PTR
    ret
@DICT.remove
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_idx
:DICT.remove_while_start_3
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.remove_while_end_3
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.remove_if_else_7
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm B $_dict_cnt
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.remove_if_end_8
    ldm B $_dict_cnt
    ldi A 1
    sub B A
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_last_off
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_last_key
    ldm B $_dict_last_off
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_last_val
    ldm A $_dict_last_key
    stack A $DATASTACK_PTR
    ldm A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_last_val
    stack A $DATASTACK_PTR
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
:DICT.remove_if_end_8
    ldm B $_dict_cnt
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.remove_if_end_7
:DICT.remove_if_else_7
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.remove_if_end_7
    jmp :DICT.remove_while_start_3
:DICT.remove_while_end_3
    ret
@DICT.clear
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@DICT.item
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_idx
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.item_if_else_9
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    jmp :DICT.item_if_end_9
:DICT.item_if_else_9
    ldi A $_dict_err_bnd
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DICT.item_if_end_9
    ret


@_DEQUE.grow_pool
    ldm B $DEQUE_POOL_PAGE_SIZE
    ldi A 3
    mul B A
    stack B $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_dq_ptr
    ld A Z
    sto A $_dq_i
:_DEQUE.grow_pool_while_start_0
    ldm A $_dq_i
    stack A $DATASTACK_PTR
    ldm B $DEQUE_POOL_PAGE_SIZE
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_DEQUE.grow_pool_while_end_0
    ldm A $_dq_ptr
    stack A $DATASTACK_PTR
    ldm B $_dq_i
    ldi A 3
    mul A B
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dq_node
    ldm A $_dq_ptr
    stack A $DATASTACK_PTR
    ldm B $_dq_i
    ldi A 1
    add B A
    ldi A 3
    mul A B
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dq_next_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_dq_i
    ldi A 1
    add A B
    sto A $_dq_i
    jmp :_DEQUE.grow_pool_while_start_0
:_DEQUE.grow_pool_while_end_0
    ldm A $_dq_ptr
    stack A $DATASTACK_PTR
    ldm B $_dq_i
    ldi A 3
    mul A B
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dq_node
    ldm A $DEQUE_FREE_HEAD
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_ptr
    sto A $DEQUE_FREE_HEAD
    ret
@DEQUE.init_pool
    ustack A $DATASTACK_PTR
    sto A $DEQUE_POOL_PAGE_SIZE
    ld A Z
    sto A $DEQUE_FREE_HEAD
    call @_DEQUE.grow_pool
    ret
@_DEQUE.alloc_node
    ldm A $DEQUE_FREE_HEAD
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_DEQUE.alloc_node_if_end_0
    call @_DEQUE.grow_pool
:_DEQUE.alloc_node_if_end_0
    ldm A $DEQUE_FREE_HEAD
    sto A $_dq_node
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $DEQUE_FREE_HEAD
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ret
@_DEQUE.free_node
    ustack A $DATASTACK_PTR
    sto A $_dq_node
    ldm A $DEQUE_FREE_HEAD
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_node
    sto A $DEQUE_FREE_HEAD
    ret
@DEQUE.new
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    ret
@DEQUE.is_empty
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    stack Z $DATASTACK_PTR
    call @rt_eq
    ret
@DEQUE.push
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    ustack A $DATASTACK_PTR
    sto A $_dq_val
    call @_DEQUE.alloc_node
    ustack A $DATASTACK_PTR
    sto A $_dq_node
    ldm A $_dq_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_head
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.push_if_else_1
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :DEQUE.push_if_end_1
:DEQUE.push_if_else_1
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
:DEQUE.push_if_end_1
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@DEQUE.append
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    ustack A $DATASTACK_PTR
    sto A $_dq_val
    call @_DEQUE.alloc_node
    ustack A $DATASTACK_PTR
    sto A $_dq_node
    ldm A $_dq_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_tail
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.append_if_else_2
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :DEQUE.append_if_end_2
:DEQUE.append_if_else_2
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
:DEQUE.append_if_end_2
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_head
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.pop_if_end_3
    ldi A $_dq_err_empty
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DEQUE.pop_if_end_3
    stack Z $DATASTACK_PTR
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_val
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_next
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_next
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.pop_if_else_4
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_next
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :DEQUE.pop_if_end_4
:DEQUE.pop_if_else_4
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
:DEQUE.pop_if_end_4
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    call @_DEQUE.free_node
    ldm A $_dq_val
    stack A $DATASTACK_PTR
    ret
@DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_tail
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.pop_tail_if_end_5
    ldi A $_dq_err_empty
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DEQUE.pop_tail_if_end_5
    stack Z $DATASTACK_PTR
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_val
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_prev
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_prev
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.pop_tail_if_else_6
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_prev
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :DEQUE.pop_tail_if_end_6
:DEQUE.pop_tail_if_else_6
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
:DEQUE.pop_tail_if_end_6
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    call @_DEQUE.free_node
    ldm A $_dq_val
    stack A $DATASTACK_PTR
    ret
@DEQUE.head
    stack Z $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DEQUE.tail
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DEQUE.is_last
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    stack Z $DATASTACK_PTR
    call @rt_eq
    ret
@DEQUE.is_first
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    stack Z $DATASTACK_PTR
    call @rt_eq
    ret
@DEQUE.next
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DEQUE.prev
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DEQUE.value
    stack Z $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret


@VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_ptr
    ustack A $DATASTACK_PTR
    sto A $_env_idx
    ldm I $_env_ptr
    ldx A $_start_memory_
    sto A $_env_ptr
    ld B A
    ldm A $_env_idx
    add A B
    sto A $_env_ptr
    ldm I $_env_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@VVMpoke
    ustack A $DATASTACK_PTR
    sto A $_env_ptr
    ustack A $DATASTACK_PTR
    sto A $_env_idx
    ustack A $DATASTACK_PTR
    sto A $_env_val_tmp
    ldm I $_env_ptr
    ldx A $_start_memory_
    sto A $_env_ptr
    ld B A
    ldm A $_env_idx
    add A B
    sto A $_env_ptr
    ldm A $_env_val_tmp
    ld B A
    ldm I $_env_ptr
    stx B $_start_memory_
    ret
@s_halt
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 4
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_call
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_math_a
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_val
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm A $_env_val
    stack A $DATASTACK_PTR
    ldm A $_env_sp_addr
    stack A $DATASTACK_PTR
    call @rt_lt
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_call_if_end_0
    ldi A $error_stack_collision
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:s_call_if_end_0
    ldm A $_env_val
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm A $_env_sp_addr
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_math_a
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_ret
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_env_val
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_env_val
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_nop
    call @rt_drop
    ret
@s_sys
    ret
@s_out
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_env_val
    ldm A $_env_sp_addr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_host_dq
    ldm A $_env_val
    stack A $DATASTACK_PTR
    ldm A $_env_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ret
@s_fetch
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_env_val
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ldm A $_env_val
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_dup
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    add A B
    sto A $_env_sp_addr
    ldm A $_math_b
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_drop
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_swap
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    ldm A $_math_b
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add A B
    sto A $_env_sp_addr
    ldm A $_math_a
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ret
@s_over
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 2
    sub B A
    ld A B
    sto A $_env_ptr
    ldm I $_env_ptr
    ldx A $_start_memory_
    sto A $_math_a
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_add
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    ld B A
    ldm A $_math_b
    add B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_sub
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    ld B A
    ldm A $_math_b
    sub B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_mul
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    ld B A
    ldm A $_math_b
    mul B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_div
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_div_if_end_1
    ldi A $error_div_zero
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:s_div_if_end_1
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    ld B A
    ldm A $_math_b
    dmod B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_mod
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_mod_if_end_2
    ldi A $error_div_zero
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:s_mod_if_end_2
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    ld B A
    ldm A $_math_b
    dmod B A
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_neg
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_env_sp_addr
    stack Z $DATASTACK_PTR
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    ustack B $DATASTACK_PTR
    sub B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ret
@s_eq
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    stack A $DATASTACK_PTR
    ldm A $_math_b
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack B $DATASTACK_PTR
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_ne
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    stack A $DATASTACK_PTR
    ldm A $_math_b
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack B $DATASTACK_PTR
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_lt
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    stack A $DATASTACK_PTR
    ldm A $_math_b
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack B $DATASTACK_PTR
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_gt
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    stack A $DATASTACK_PTR
    ldm A $_math_b
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack B $DATASTACK_PTR
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_abs
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_abs_if_end_3
    stack Z $DATASTACK_PTR
    ldm A $_math_a
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_math_a
:s_abs_if_end_3
    ldm A $_math_a
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ret
@s_rnd
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    call @rt_rnd
    ustack A $DATASTACK_PTR
    sto A $_env_val
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ldm A $_env_val
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_push
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_env_val
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ldm A $_env_val
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_get
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_math_a
    ldm I $_env_vvm_ptr
    ldx A $_start_memory_
    ld B A
    ldi A 22
    add B A
    ldm A $_math_a
    add A B
    sto A $_env_ptr
    ldm I $_env_ptr
    ldx A $_start_memory_
    sto A $_env_val
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ldm A $_env_val
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_set
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_math_a
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_env_val
    ldm A $_env_sp_addr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm I $_env_vvm_ptr
    ldx A $_start_memory_
    ld B A
    ldi A 22
    add B A
    ldm A $_math_a
    add A B
    sto A $_env_ptr
    ldm A $_env_val
    ld B A
    ldm I $_env_ptr
    stx B $_start_memory_
    ret
@s_bra
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_math_a
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_brz
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_math_a
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_env_val
    ldm A $_env_sp_addr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_env_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_brz_if_end_4
    ldm A $_math_a
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
:s_brz_if_end_4
    ret
@s_bnz
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_math_a
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_env_val
    ldm A $_env_sp_addr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_env_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_bnz_if_end_5
    ldm A $_math_a
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
:s_bnz_if_end_5
    ret
@s_brp
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_math_a
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_env_val
    ldm A $_env_sp_addr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_env_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_lt
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_brp_if_end_6
    ldm A $_math_a
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
:s_brp_if_end_6
    ret
@s_brn
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_math_a
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_env_val
    ldm A $_env_sp_addr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_env_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_brn_if_end_7
    ldm A $_math_a
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
:s_brn_if_end_7
    ret
@s_print_num
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_env_val
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ret
@s_UDC_IO
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_math_a
    ldm A $_env_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_math_b
    ldm A $_env_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_env_val
    stack A $DATASTACK_PTR
    ldm A $_math_b
    stack A $DATASTACK_PTR
    ldm A $_math_a
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_math_a
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ldm A $_math_a
    stack A $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add A B
    tst A 0
    jmpt :s_UDC_IO_if_end_8
    ustack A $DATASTACK_PTR
    sto A $_env_val
    stack A $DATASTACK_PTR
    ldm A $_env_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.append
:s_UDC_IO_if_end_8
    ret
@VVM.init
    ldi A 100
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $opcode_table
    ldi A 100
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $opcode_runtimes
    ldi A 100
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $label_addresses
    ldi A 50
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $syscall_table
    stack Z $DATASTACK_PTR
    ldi A 6384101742
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_halt
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 193464626
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_nop
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_sys
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_out
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 210673137615
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_fetch
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 193468656
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_ret
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_dup
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 11
    stack A $DATASTACK_PTR
    ldi A 6383976602
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_drop
    stack A $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 12
    stack A $DATASTACK_PTR
    ldi A 6384520640
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_swap
    stack A $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 13
    stack A $DATASTACK_PTR
    ldi A 6384375937
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_over
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_add
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 193470255
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_sub
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 193463731
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_mul
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 23
    stack A $DATASTACK_PTR
    ldi A 193453544
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_div
    stack A $DATASTACK_PTR
    ldi A 23
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 24
    stack A $DATASTACK_PTR
    ldi A 193463525
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_mod
    stack A $DATASTACK_PTR
    ldi A 24
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 25
    stack A $DATASTACK_PTR
    ldi A 193464287
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_neg
    stack A $DATASTACK_PTR
    ldi A 25
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_eq
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 27
    stack A $DATASTACK_PTR
    ldi A 5862552
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_ne
    stack A $DATASTACK_PTR
    ldi A 27
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 28
    stack A $DATASTACK_PTR
    ldi A 5862501
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_lt
    stack A $DATASTACK_PTR
    ldi A 28
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 29
    stack A $DATASTACK_PTR
    ldi A 5862336
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_gt
    stack A $DATASTACK_PTR
    ldi A 29
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 30
    stack A $DATASTACK_PTR
    ldi A 193450043
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_abs
    stack A $DATASTACK_PTR
    ldi A 30
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 31
    stack A $DATASTACK_PTR
    ldi A 193468937
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_rnd
    stack A $DATASTACK_PTR
    ldi A 31
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 50
    stack A $DATASTACK_PTR
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_push
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 51
    stack A $DATASTACK_PTR
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_get
    stack A $DATASTACK_PTR
    ldi A 51
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 52
    stack A $DATASTACK_PTR
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_set
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 60
    stack A $DATASTACK_PTR
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A 61
    stack A $DATASTACK_PTR
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_bra
    stack A $DATASTACK_PTR
    ldi A 61
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 62
    stack A $DATASTACK_PTR
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_brz
    stack A $DATASTACK_PTR
    ldi A 62
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 63
    stack A $DATASTACK_PTR
    ldi A 193451535
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_bnz
    stack A $DATASTACK_PTR
    ldi A 63
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 64
    stack A $DATASTACK_PTR
    ldi A 193451657
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_brp
    stack A $DATASTACK_PTR
    ldi A 64
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 65
    stack A $DATASTACK_PTR
    ldi A 193451655
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_brn
    stack A $DATASTACK_PTR
    ldi A 65
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 66
    stack A $DATASTACK_PTR
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_call
    stack A $DATASTACK_PTR
    ldi A 66
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A @s_print_num
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $syscall_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_UDC_IO
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $syscall_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ret


@VVM.create
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    ustack A $DATASTACK_PTR
    sto A $_VVMHOSTpointer
    ustack A $DATASTACK_PTR
    sto A $_VVMsize
    ustack A $DATASTACK_PTR
    sto A $_SIMPLcode
    ldi A 4
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_VVMsize
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm I $_VVMpointer
    ldx A $_start_memory_
    ld B A
    ldi A 50
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm I $_VVMpointer
    ldx A $_start_memory_
    ld B A
    ldi A 6
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm I $_VVMHOSTpointer
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm I $_VVMpointer
    ldx A $_start_memory_
    ld B A
    ldm A $_VVMsize
    add B A
    stack B $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.clear
    ld A Z
    sto A $_vvm_pc_offset
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_0
    ldi A $error_no_code
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
    jmp :VVM.create_if_end_0
:VVM.create_if_else_0
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.head
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
:VVM.create_while_start_0
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_while_end_0
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.value
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_1
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_opcode
    stack A $DATASTACK_PTR
    ldi A 60
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_2
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_3
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.value
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    ldm A $_vvm_pc_offset
    stack A $DATASTACK_PTR
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.put
:VVM.create_if_end_3
    jmp :VVM.create_if_end_2
:VVM.create_if_else_2
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_4
    ldm B $_vvm_pc_offset
    ldi A 1
    add A B
    sto A $_vvm_pc_offset
    jmp :VVM.create_if_end_4
:VVM.create_if_else_4
    ldm B $_vvm_pc_offset
    ldi A 2
    add A B
    sto A $_vvm_pc_offset
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
:VVM.create_if_end_4
:VVM.create_if_end_2
    jmp :VVM.create_if_end_1
:VVM.create_if_else_1
    ldi A $error_no_opcode
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_1
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_5
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
:VVM.create_if_end_5
    jmp :VVM.create_while_start_0
:VVM.create_while_end_0
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.count
    call @PRTnum
    ldi A $msg_labels_found
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :VVM.create_if_end_0
    ldm A $_VVMsize
    sto A $_vvm_max_size
    ldi A 50
    ld B A
    ldm A $_vvm_pc_offset
    add A B
    sto A $_vvm_needed_size
    stack A $DATASTACK_PTR
    ldm A $_vvm_max_size
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_6
    ldi A $error_vvm_overflow
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_6
    ldm I $_VVMpointer
    ldx A $_start_memory_
    sto A $_temp_ptr
    ld B A
    ldi A 50
    add A B
    sto A $_vvm_code_start
    sto A $_vvm_write_ptr
:VVM.create_while_start_1
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_while_end_1
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_opcode
    stack A $DATASTACK_PTR
    ldi A 60
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_7
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_drop
    jmp :VVM.create_if_end_7
:VVM.create_if_else_7
    ldm A $_opcode
    ld B A
    ldm I $_vvm_write_ptr
    stx B $_start_memory_
    ldm B $_vvm_write_ptr
    ldi A 1
    add A B
    sto A $_vvm_write_ptr
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 49
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_8
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 60
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_9
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_10
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.get
    ldm A $_vvm_code_start
    ustack B $DATASTACK_PTR
    add A B
    sto A $_temp_val
    jmp :VVM.create_if_end_10
:VVM.create_if_else_10
    ldi A $error_label_unknown
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_10
    jmp :VVM.create_if_end_9
:VVM.create_if_else_9
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 51
    stack A $DATASTACK_PTR
    call @rt_eq
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add A B
    tst A 0
    jmpt :VVM.create_if_end_11
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_lt
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldi A 25
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add A B
    tst A 0
    jmpt :VVM.create_if_end_12
    ldi A $error_invalid_reg
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_12
:VVM.create_if_end_11
:VVM.create_if_end_9
    ldm A $_temp_val
    ld B A
    ldm I $_vvm_write_ptr
    stx B $_start_memory_
    ldm B $_vvm_write_ptr
    ldi A 1
    add A B
    sto A $_vvm_write_ptr
:VVM.create_if_end_8
:VVM.create_if_end_7
    jmp :VVM.create_while_start_1
:VVM.create_while_end_1
    ret
@VVM.start
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    ustack A $DATASTACK_PTR
    sto A $_start_argc
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_start_argc
    sto A $_start_idx
:VVM.start_while_start_2
    ldm A $_start_idx
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.start_while_end_2
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    stack A $DATASTACK_PTR
    ldi A 22
    ld B A
    ldm A $_start_idx
    add B A
    stack B $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm B $_start_idx
    ldi A 1
    sub B A
    ld A B
    sto A $_start_idx
    jmp :VVM.start_while_start_2
:VVM.start_while_end_2
    ldm I $_VVMpointer
    ldx A $_start_memory_
    ld B A
    ldi A 50
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@VVM.run
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.run_if_else_13
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_run_pc
    ldm I $_run_pc
    ldx A $_start_memory_
    sto A $_run_opcode
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.run_if_else_14
    ldi A 1
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    jmp :VVM.run_if_end_14
:VVM.run_if_else_14
    ldm B $_run_pc
    ldi A 1
    add A B
    sto A $_run_pc
    ldm A $_run_opcode
    stack A $DATASTACK_PTR
    ldi A 49
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.run_if_end_15
    ldm I $_run_pc
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm B $_run_pc
    ldi A 1
    add A B
    sto A $_run_pc
:VVM.run_if_end_15
    ldm A $_run_pc
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_run_opcode
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_run_handler
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    ldm A $_run_handler
    stack A $DATASTACK_PTR
    calls $DATASTACK_PTR
:VVM.run_if_end_14
    jmp :VVM.run_if_end_13
:VVM.run_if_else_13
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.run_if_end_16
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
:VVM.run_if_end_16
:VVM.run_if_end_13
    ret
@VVM.check_syscalls
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.check_syscalls_if_end_17
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_syscall_id
    stack A $DATASTACK_PTR
    ldm A $syscall_table
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.check_syscalls_if_else_18
    ldm A $_syscall_id
    stack A $DATASTACK_PTR
    ldm A $syscall_table
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_syscall_handler
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    ldm A $_syscall_handler
    stack A $DATASTACK_PTR
    calls $DATASTACK_PTR
    jmp :VVM.check_syscalls_if_end_18
:VVM.check_syscalls_if_else_18
    ldi A $error_no_syscall
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.check_syscalls_if_end_18
    ldi A 2
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
:VVM.check_syscalls_if_end_17
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
% $_sh_ptr 0
% $_sh_acc 0

% $HEAP_START 0
% $HEAP_SIZE 0
% $HEAP_FREE 0
% $_ARR_TEMP_PTR 0
% $_MAT_TEMP_PTR 0
% $_MAT_X_DIM 0
% $_MAT_Y_DIM 0
% $_MAT_VALUE 0
% $_MAT_PTR 0
% $_MAT_LOOP_COUNTER 0
% $_MAT_OFFSET 0
% $error_mesg0 \N \E \W \. \a \r \r \a \y \: \space \N \o \space \s \p \a \c \e \space \o \n \space \h \e \a \p \Return \null
% $error_mesg1 \A \R \R \A \Y \. \a \p \p \e \n \d \: \space \A \r \r \a \y \space \i \s \space \f \u \l \l \Return \null
% $error_mesg2 \A \R \R \A \Y \. \p \u \t \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $error_mesg3 \A \R \R \A \Y \. \g \e \t \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $error_mesg4 \N \E \W \. \l \i \s \t \: \space \N \o \space \s \p \a \c \e \space \o \n \space \h \e \a \p \Return \null
% $error_mesg5 \N \E \W \. \m \a \t \r \i \x \: \space \N \o \space \s \p \a \c \e \space \o \n \space \h \e \a \p \Return \null
% $error_mesg6 \N \E \W \. \m \a \t \r \i \x \: \space \N \o \t \space \e \n \o \u \g \h \space \d \a \t \a \space \o \n \space \s \t \a \c \k \Return \null
% $error_mesg7 \M \A \T \R \I \X \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $error_mesg8 \N \E \W \. \m \a \t \r \i \x \: \space \I \n \v \a \l \i \d \space \d \i \m \e \n \s \i \o \n \s \Return \null
% $_list_size 0
% $_list_ptr 0
% $_LST_PTR 0
% $_LST_IDX 0
% $_LST_VAL 0
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

% $_dict_ptr 0
% $_dict_cap 0
% $_dict_cnt 0
% $_dict_key 0
% $_dict_val 0
% $_dict_idx 0
% $_dict_found 0
% $_dict_offset 0
% $_dict_last_off 0
% $_dict_last_key 0
% $_dict_last_val 0
% $_dict_err_full \D \I \C \T \. \p \u \t \: \space \D \i \c \t \i \o \n \a \r \y \space \i \s \space \f \u \l \l \Return \null
% $_dict_err_key \D \I \C \T \. \g \e \t \: \space \K \e \y \space \n \o \t \space \f \o \u \n \d \Return \null
% $_dict_err_bnd \D \I \C \T \. \i \t \e \m \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $_dict_err_inv_key \D \I \C \T \. \p \u \t \: \space \K \e \y \space \0 \space \i \s \space \r \e \s \e \r \v \e \d \space \a \n \d \space \c \a \n \n \o \t \space \b \e \space \u \s \e \d \. \Return \null

% $DEQUE_FREE_HEAD 0
% $DEQUE_POOL_PAGE_SIZE 0
% $_dq_i 0
% $_dq_ptr 0
% $_dq_next_ptr 0
% $_dq_node 0
% $_dq_val 0
% $_dq_list 0
% $_dq_head 0
% $_dq_tail 0
% $_dq_prev 0
% $_dq_next 0
% $_dq_err_empty \D \E \Q \U \E \. \p \o \p \: \space \D \e \q \u \e \space \i \s \space \e \m \p \t \y \Return \null

% $opcode_table 0
% $opcode_runtimes 0
% $label_addresses 0
% $syscall_table 0
% $_env_vvm_ptr 0
% $_env_sp_ptr_loc 0
% $_env_sp_addr 0
% $_env_val 0
% $_env_host_ptr_loc 0
% $_env_host_dq 0
% $_env_count 0
% $_env_ptr 0
% $_env_idx 0
% $_env_val_tmp 0
% $_math_a 0
% $_math_b 0
% $error_stack_collision \V \V \M \space \S \t \a \c \k \space \C \o \l \l \i \s \i \o \n \space \( \P \C \> \= \R \S \P \) \. \space \Return \null

% $_temp_ptr 0
% $_temp_idx 0
% $_temp_val 0
% $_scan_ptr 0
% $_vvm_pc_offset 0
% $_opcode 0
% $_is_opcode 0
% $error_no_code \N \o \space \S \I \M \P \L \space \c \o \d \e \space \p \r \o \v \i \d \e \d \. \space \Return \null
% $error_no_opcode \V \V \M \space \i \n \v \a \l \i \d \space \O \P \C \O \D \E \space \f \o \u \n \d \. \space \Return \null
% $error_no_syscall \V \V \M \space \i \n \v \a \l \i \d \space \S \Y \S \C \A \L \L \space \i \s \space \c \a \l \l \e \d \. \space \Return \null
% $error_label_unknown \V \V \M \space \l \a \b \e \l \space \n \o \t \space \f \o \u \n \d \. \space \Return \null
% $error_invalid_reg \V \V \M \space \i \n \v \a \l \i \d \space \r \e \g \i \s \t \e \r \space \i \n \d \e \x \. \space \Return \null
% $error_div_zero \V \V \M \space \d \i \v \i \s \i \o \n \space \b \y \space \z \e \r \o \space \e \r \r \o \r \. \space \Return \null
% $error_vvm_overflow \V \V \M \space \m \e \m \o \r \y \space \o \v \e \r \f \l \o \w \. \space \Return \null
% $msg_labels_found \space \l \a \b \e \l \s \space \f \o \u \n \d \Return \null
% $_run_pc 0
% $_run_opcode 0
% $_run_handler 0
% $_start_argc 0
% $_start_idx 0
% $_syscall_id 0
% $_syscall_handler 0
% $_VVMpointer 0
% $_VVMHOSTpointer 0
% $_VVMsize 0
% $_SIMPLcode 0
% $_vvm_max_size 0
% $_vvm_needed_size 0
% $_vvm_code_start 0
% $_vvm_write_ptr 0
