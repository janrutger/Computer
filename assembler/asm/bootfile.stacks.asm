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
. $_env_sp_read_ptr 1
. $_string_ptr 1
. $_argc 1
. $_argr 1
. $_nieuwe_sp 1
. $string_dict 1
. $_vvm_temp_list_ptr 1
. $kbd_req_queue 1
. $kbd_prompts 1
. $_FIT16_table 1
. $filename_tmp 1
. $index_file_name 8
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
. $msg_loading 26
. $msg_FITing 22
. $error_fit_file 22
. $error_invalid_syscall 34
. $_run_pc 1
. $_run_opcode 1
. $_run_handler 1
. $_start_argc 1
. $_start_idx 1
. $_syscall_id 1
. $_syscall_handler 1
. $_batch_size 1
. $_batch_idx 1
. $_continue_batch 1
. $_VVMpointer 1
. $_VVMkbdq 1
. $_VVMHOSTpointer 1
. $_VVMsize 1
. $_SIMPLcode 1
. $_in_string 1
. $_sub_op 1
. $_vvm_max_size 1
. $_vvm_needed_size 1
. $_vvm_code_start 1
. $_vvm_write_ptr 1
. $_char_val 1
. $_string_hash 1
. $_in_bake_string 1
. $_str_char_idx 1
. $_next_char 1
. $_final_string_ptr 1
. $_host_dq 1
. $_kbd_dq 1
. $_prompt_pointer 1
. $new_input_flag 1
. $_FIT_file_on_disk 1
. $_FIT_tempname 1
. $_FIT_table 1
. $_fit_char 1
. $_fit_hash 1
. $_fit_len 1
. $_fit_str_ptr 1
. $_search_hash 1
. $_found_file_ptr 1
. $msg_hash_not_found 48
. $_filename 1
. $_code_queue 1
. $_custom_id 1
. $_function_ptr 1

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
    # INCLUDE net_hal.stacks
    # INCLUDE net_core.stacks
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


@_read_disk_block

        ldi I ~SYS_F_READ_BLOCK
        int $INT_VECTORS
        # After read block 12 (or less) bytes from the file are loaded in $disk_io_buffer
        # \null terminated

        # reset Disk_io_buffer_prt
        sto Z $disk_io_buffer_ptr

        # Check for error
        ldm A $SYSCALL_RETURN_STATUS
        tste A Z
        ret
@_check_last_block

        ldm A $SYSCALL_RETURN_VALUE ; check if it was the last block
        tst A 1
        ret
@_read_next_block

        call @_check_last_block
        jmpt :close_and_end
        call @_read_disk_block
        jmpt :close_and_end

        ret
        ret
@load_bin_file

        # Pointer to File_name_string on the stack (kernel_stacks.asm)
        ustack A $DATASTACK_PTR     ; Pop filename pointer into A
        
        ##
        ldi I ~SYS_F_OPEN_READ      ; Open the file for read
        int $INT_VECTORS

        ldm A $SYSCALL_RETURN_STATUS
        tste A Z               ; Status is 1 at success
        jmpt :cmd_load_end     ; do nothing when file error, mesage is already printed

        . $mem_adres 1
        . $mem_val 1
        . $is_negative 1
        . $is_first_digit 1

        # read the first disk block
        call @_read_disk_block
        jmpt :close_and_end ; if error, close file and end

        :read_disk_loop
            # 1 find the adres from the input buffer
            #   an number seperated by an space (32)
            #   2 blocks can be needed

            # reset adres and value
            sto Z $mem_adres
            sto Z $mem_val

        :adres_lookup_loop
            inc I $disk_io_buffer_ptr
            ldx C $disk_io_buffer_base
            tst C \null
            jmpf :skip_next0                     ; End of input buffer
                call @_read_next_block
                inc I $disk_io_buffer_ptr
                ldx C $disk_io_buffer_base

            :skip_next0

            tst C \space                    ; check for adres delimiter
            jmpt :value_lookup_start         ; $mem_adres containts the adres

            ldm A $mem_adres
            muli A 10                       ; shift result by 10
            subi C 48                       ; Substract ascci offset
            add A C 
            sto A $mem_adres

            jmp :adres_lookup_loop
            
        # 2 Find the value of that adres from the input buffer
        #   an number seperated by Return (13)
        #   2 block van be needed
        :value_lookup_start
            sto Z $is_negative
            ldi B 1
            sto B $is_first_digit
            ;sto Z $is_first_digit

        :value_lookup_loop  
            inc I $disk_io_buffer_ptr
            ldx C $disk_io_buffer_base
            tst C \null                     ; End of input buffer
            jmpf :skip_next1 
                call @_read_next_block
                inc I $disk_io_buffer_ptr
                ldx C $disk_io_buffer_base

            :skip_next1

            tst C \Return                   ; check for value delimiter
            jmpt :apply_val_sign

            ldm A $is_first_digit
            tste A Z
            jmpt :not_first_digit_val

                ; It is the first char, so we check for sign and spaces
                sto Z $is_first_digit
                tst C \-
                jmpf :not_a_sign_val
                    ldi B 1
                    sto B $is_negative
                    jmp :value_lookup_loop ; read next char
                :not_a_sign_val

                # tst C ' '
                # jmpt :value_lookup_loop

            :not_first_digit_val
            ldm A $mem_val
            muli A 10                       ; shift result by 10
            subi C 48                       ; Substract ascci offset
            add A C 
            sto A $mem_val

            jmp :value_lookup_loop

        :apply_val_sign
            ldm A $is_negative
            tste A Z
            jmpf :negate_val
            jmp :store_adres_value_pair
        :negate_val
            # ldm A $mem_val
            # negi A
            # sto A $mem_val
            ldm B $mem_val
            ldi A 0
            sub A B 
            sto A $mem_val
            jmp :store_adres_value_pair

        # 3 Write found value on found adres
        :store_adres_value_pair
            ldm I $mem_adres
            ldm A $mem_val

            stx A $_start_memory_

        # 4 Repeat till last block found
        jmp :read_disk_loop


        :close_and_end
            ldi I ~SYS_F_CLOSE
            int $INT_VECTORS
            pop K               ; Drop return adres, due to jump outside the routine
            
        :cmd_load_end
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

        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer (direct in pointer-register I)
        ldx B $_start_memory_     ; 2. B = *I (haal basisadres op en parkeer direct in B)
        
        ustack I $DATASTACK_PTR   ; 3. I = index (overschrijf I met de index, want &VVM-pointer hebben we niet meer nodig)
        add I B                   ; 4. I = I + B (bereken doeladres direct IN register I!)
        
        ldx A $_start_memory_     ; 5. A = *I (haal de werkelijke waarde op uit het doeladres)
        stack A $DATASTACK_PTR    ; 6. Push het resultaat terug op de datastack
        ret
@VVMpoke

        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer (direct naar pointer-register I)
        ldx B $_start_memory_     ; 2. B = *I (basisadres ophalen in B)
        
        ustack I $DATASTACK_PTR   ; 3. I = index (overschrijf I met de index)
        add I B                   ; 4. I = I + B (bereken doeladres direct in I)
        
        ustack B $DATASTACK_PTR   ; 5. B = value (pop de waarde direct in B!)
        stx B $_start_memory_     ; 6. *I = B (schrijf B naar het doeladres)
        ret
@VVMerror
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
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

        ; --- 1. Haal de parameters van de host-stack (JUISTE VOLGORDE) ---
        ustack I $DATASTACK_PTR   ; 1. EERST POPPEN: I = &VVM-pointer (_env_vvm_ptr)
        ld M I                    ; Save &VVM-pointer in M

        ustack Y $DATASTACK_PTR   ; 2. DAARNA POPPEN: Y = target address (_math_a)
        ldx B $_start_memory_     ; 3. B = basisadres van de VVM-struct (anker)
        
        ; --- 2. Haal de huidige PC op (Offset 2) ---
        ldi A 2
        add A B                   ; A = RAM-adres van VVM_PC
        ld I A
        ldx A $_start_memory_     ; A = huidige PC (Return Address)
        
        ; --- 3. Haal de huidige RSP op (Offset 5) EN bereken RSP_nieuw ---
        ldi C 5
        add C B                   ; C = RAM-adres van VVM_RSP
        ld I C
        ldx C $_start_memory_     ; C = huidige RSP-waarde (adres in sandbox)
        subi C 1                  ; C = RSP_nieuw (RSP - 1)
        
        ; --- 4. Collision Check: Is RSP_nieuw > PC? ---
        tstg C A                  ; Test of C (RSP_nieuw) > A (PC)
        jmpf :s_call_collision    ; Als False (dus RSP <= PC) -> CRASH!
        
        ; --- 5. VEILIG: Push Return Address (A) naar Sandbox Return Stack (*C) ---
        ld I C                    ; I = RSP_nieuw
        stx A $_start_memory_     ; Sla Return Address (A) op in sandbox-RAM
        
        ; --- 6. Update VVM_RSP in de struct met de nieuwe waarde (C) ---
        ld X C                    ; Bewaar de nieuwe RSP-waarde (C) even in X
        ldi C 5
        add C B                   ; C = RAM-adres van VVM_RSP
        ld I C
        stx X $_start_memory_     ; Sla de nieuwe RSP-waarde op in de struct!
        
        ; --- 7. Jump naar Target: Schrijf het doeladres (Y) naar VVM_PC (Offset 2) ---
        ldi C 2
        add C B                   ; C = RAM-adres van VVM_PC
        ld I C
        stx Y $_start_memory_     ; VVM_PC = target address!
        
        jmp :s_call_end           ; Sla de error-sectie over
        
    :s_call_collision
        ldi A $error_stack_collision
        stack A $DATASTACK_PTR
        ustack A $DATASTACK_PTR   ; Pop pointer van stack voor de syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS          ; Interrupt om de error te printen
        # call @HALT
        stack M $DATASTACK_PTR
        call @VVMerror
        
        
    :s_call_end
        ret
@s_ret

        ; --- 1. Haal de pointer op en vind de virtuele RSP ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct (anker)
        
        ldi A 5
        add A B                   ; A = RAM-adres van VVM_RSP
        ld I A
        ldx A $_start_memory_     ; 3. A = huidige RSP-waarde (adres in sandbox)
        
        ; --- 2. Pop het Return Address uit de Sandbox Return Stack ---
        ld I A                    ; I = huidige RSP
        ldx Y $_start_memory_     ; 4. Y = Het opgeslagen Return Address (PC)
        
        ; --- 3. Verhoog de RSP met 1 (Stack krimpt) ---
        addi A 1                  ; 5. A = nieuwe RSP-waarde (RSP + 1)
        
        ; --- 4. Update VVM_RSP in de struct (Offset 5) ---
        ld X A                    ; Parkeer de nieuwe RSP-waarde heel even in X
        ldi A 5
        add A B                   ; A = RAM-adres van VVM_RSP
        ld I A
        stx X $_start_memory_     ; 6. Update VVM_RSP in de struct!
        
        ; --- 5. Schrijf het Return Address (Y) naar VVM_PC (Offset 2) ---
        ldi A 2
        add A B                   ; A = RAM-adres van VVM_PC
        ld I A
        stx Y $_start_memory_     ; 7. VVM_PC = Return Address! Jump voltooid!
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

        ; --- 1. Haal de &VVM-pointer van de host-stack ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct
        
        ; --- 2. Bereken het RAM-adres van VVM_SP (basis + 3) ---
        ldi A 3                   ; 3. Offset voor VVM_SP
        add A B                   ; 4. A = RAM-adres van VVM_SP
        ld Y A                    ; 5. Parkeer het RAM-adres van VVM_SP in Y
        
        ; --- 3. Lees de huidige virtuele SP-waarde ---
        ld I A                    ; 6. I = RAM-adres van VVM_SP
        ldx A $_start_memory_     ; 7. A = huidige virtuele SP-waarde (adres in sandbox)
        
        ; --- 4. Lees de waarde op de Top van de Stack (SP - 1) ---
        ld I A                    ; 8. I = huidige virtuele SP
        subi I 1                  ; 9. I = huidige virtuele SP - 1 (TOS)
        ldx C $_start_memory_     ; 10. C = de waarde die we willen dupliceren ('b')
        
        ; --- 5. Schrijf 'b' naar de nieuwe top (de oude SP-locatie) ---
        ld I A                    ; 11. I = oorspronkelijke virtuele SP
        stx C $_start_memory_     ; 12. Schrijf 'b' direct vanuit C naar het sandbox-RAM!
        
        ; --- 6. Bereken de nieuwe SP-waarde (oude SP + 1) ---
        addi A 1                  ; 13. A = nieuwe virtuele SP-waarde
        
        ; --- 7. Sla de nieuwe SP op in de VVM-struct ---
        ld I Y                    ; 14. I = RAM-adres van VVM_SP
        ld B A                    ; 15. B = nieuwe virtuele SP-waarde (klaarzetten voor stx)
        stx B $_start_memory_     ; 16. Update VVM_SP in de struct!
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

        ; --- 1. Haal de huidige virtuele Stack Pointer op ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct
        ldi A 3                   ; 3. Offset voor VVM_SP
        add A B                   ; 4. A = RAM-adres van VVM_SP
        ld I A                    ; 5. I = RAM-adres van VVM_SP
        ldx A $_start_memory_     ; 6. A = huidige virtuele SP
        
        ; --- 2. Lees TOS (B) op locatie SP - 1 ---
        ld I A                    ; 7. I = virtuele SP
        subi I 1                  ; 8. I = virtuele SP - 1
        ldx B $_start_memory_     ; 9. B = waarde 'B'
        
        ; --- 3. Lees Next (A) op locatie SP - 2 EN schrijf 'B' direct terug ---
        ld I A                    ; 10. I = virtuele SP
        subi I 2                  ; 11. I = virtuele SP - 2
        ldx C $_start_memory_     ; 12. C = waarde 'A'
        stx B $_start_memory_     ; 13. Schrijf 'B' direct naar dit huidige adres (SP - 2)!
        
        ; --- 4. Schrijf waarde 'A' naar locatie SP - 1 ---
        ld I A                    ; 14. I = virtuele SP
        subi I 1                  ; 15. I = virtuele SP - 1
        stx C $_start_memory_     ; 16. Schrijf 'A' naar SP - 1
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

        ; --- 1. Haal de huidige virtuele Stack Pointer op ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct
        ldi A 3                   ; 3. Offset voor VVM_SP
        add A B                   ; 4. A = RAM-adres van VVM_SP
        ld Y A                    ; 5. Parkeer het RAM-adres van VVM_SP in Y voor de update straks
        
        ld I A                    ; 6. I = RAM-adres van VVM_SP
        ldx A $_start_memory_     ; 7. A = huidige virtuele SP
        
        ; --- 2. Lees TOS (B) op locatie SP - 1 ---
        ld I A                    ; 8. I = virtuele SP
        subi I 1                  ; 9. I = virtuele SP - 1 (TOS-adres)
        ldx B $_start_memory_     ; 10. B = waarde 'B'
        
        ; --- 3. Lees Next (A) op locatie SP - 2 EN voer de optelling uit ---
        ld I A                    ; 11. I = virtuele SP
        subi I 2                  ; 12. I = virtuele SP - 2 (Next-adres)
        ldx C $_start_memory_     ; 13. C = waarde 'A'
        
        add B C                   ; 14. B = B + C (oftewel: B = 'B' + 'A')
        stx B $_start_memory_     ; 15. Schrijf het resultaat direct naar het huidige adres (SP - 2)!
        
        ; --- 4. Update de nieuwe VVM_SP in de struct (oorspronkelijke SP - 1) ---
        ld B A                    ; 16. B = oorspronkelijke virtuele SP
        subi B 1                  ; 17. B = oorspronkelijke SP - 1 (dit is de nieuwe vrije plek pointer)
        
        ld I Y                    ; 18. I = RAM-adres van VVM_SP (uit register Y)
        stx B $_start_memory_     ; 19. Sla de nieuwe SP op in de VVM-struct!
        ret
@s_sub

        ; --- 1. Haal de huidige virtuele Stack Pointer op ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct
        ldi A 3                   ; 3. Offset voor VVM_SP
        add A B                   ; 4. A = RAM-adres van VVM_SP
        ld Y A                    ; 5. Parkeer het RAM-adres van VVM_SP in Y
        
        ld I A                    ; 6. I = RAM-adres van VVM_SP
        ldx A $_start_memory_     ; 7. A = huidige virtuele SP
        
        ; --- 2. Lees TOS (B) op locatie SP - 1 ---
        ld I A                    ; 8. I = virtuele SP
        subi I 1                  ; 9. I = virtuele SP - 1 (TOS-adres)
        ldx B $_start_memory_     ; 10. B = waarde 'B' (TOS)
        
        ; --- 3. Lees Next (A) op locatie SP - 2 EN voer de aftrekking uit ---
        ld I A                    ; 11. I = virtuele SP
        subi I 2                  ; 12. I = virtuele SP - 2 (Next-adres)
        ldx C $_start_memory_     ; 13. C = waarde 'A' (NOS)
        
        sub C B                   ; 14. C = C - B (Oftewel: 'A' - 'B' -> exact de juiste volgorde!)
        stx C $_start_memory_     ; 15. Schrijf het resultaat vanuit C direct naar het huidige adres (SP - 2)!
        
        ; --- 4. Update de nieuwe VVM_SP in de struct (oorspronkelijke SP - 1) ---
        ld B A                    ; 16. B = oorspronkelijke virtuele SP
        subi B 1                  ; 17. B = oorspronkelijke SP - 1
        
        ld I Y                    ; 18. I = RAM-adres van VVM_SP
        stx B $_start_memory_     ; 19. Sla de nieuwe SP op in de VVM-struct!
        ret
@s_mul

        ; --- 1. Haal de huidige virtuele Stack Pointer op ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct
        ldi A 3                   ; 3. Offset voor VVM_SP
        add A B                   ; 4. A = RAM-adres van VVM_SP
        ld Y A                    ; 5. Parkeer het RAM-adres van VVM_SP in Y voor de update straks
        
        ld I A                    ; 6. I = RAM-adres van VVM_SP
        ldx A $_start_memory_     ; 7. A = huidige virtuele SP
        
        ; --- 2. Lees TOS (B) op locatie SP - 1 ---
        ld I A                    ; 8. I = virtuele SP
        subi I 1                  ; 9. I = virtuele SP - 1 (TOS-adres)
        ldx B $_start_memory_     ; 10. B = waarde 'B' (TOS)
        
        ; --- 3. Lees Next (A) op locatie SP - 2 EN voer de vermenigvuldiging uit ---
        ld I A                    ; 11. I = virtuele SP
        subi I 2                  ; 12. I = virtuele SP - 2 (Next-adres)
        ldx C $_start_memory_     ; 13. C = waarde 'A' (NOS)
        
        mul B C                   ; 14. B = B * C (Oftewel: TOS * NOS)
        stx B $_start_memory_     ; 15. Schrijf het resultaat direct naar het huidige adres (SP - 2)!
        
        ; --- 4. Update de nieuwe VVM_SP in de struct (oorspronkelijke SP - 1) ---
        ld B A                    ; 16. B = oorspronkelijke virtuele SP
        subi B 1                  ; 17. B = oorspronkelijke SP - 1 (nieuwe vrije plek pointer)
        
        ld I Y                    ; 18. I = RAM-adres van VVM_SP (uit register Y)
        stx B $_start_memory_     ; 19. Sla de nieuwe SP op in de VVM-struct!
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
    jmpt :s_div_if_end_0
    ldi A $error_div_zero
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:s_div_if_end_0
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
    jmpt :s_mod_if_end_1
    ldi A $error_div_zero
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:s_mod_if_end_1
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

        ; --- 1. Haal de pointer op en lees de virtuele SP ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct (anker)
        
        ldi A 3
        add A B                   ; A = RAM-adres van VVM_SP
        ld X A                    ; Parkeer het RAM-adres van VVM_SP in X voor de update straks
        
        ld I A
        ldx A $_start_memory_     ; 3. A = huidige virtuele SP
        
        ; --- 2. Lees de twee waarden van de virtuele stack ---
        ld I A
        subi I 1                  ; I = SP - 1 (TOS, math_b)
        ldx C $_start_memory_     ; 4. C = math_b
        
        subi I 1                  ; I = SP - 2 (NOS, math_a)
        ldx Y $_start_memory_     ; 5. Y = math_a
        
        ; --- 3. Voer de 'Is Equal' check uit ---
        tste Y C                  ; 6. Test of Y (math_a) == C (math_b)
        jmpt :s_eq_true           ; Als ze gelijk zijn -> spring naar True
        
        ; --- Case: False (Niet gelijk) ---
        ld C Z                    ; 7. C = 0 (via het veilige Zero register Z)
        jmp :s_eq_write
        
    :s_eq_true
        ldi C 1                   ; 8. C = 1 (True)
        
    :s_eq_write
        ; --- 4. Schrijf het resultaat terug naar de stack (Locatie SP - 2) ---
        ; Register I staat momenteel al op (SP - 2), dus daar maken we dankbaar gebruik van!
        stx C $_start_memory_     ; 9. Schrijf True/False naar de stack
        
        ; --- 5. Update de nieuwe VVM_SP in de struct (Nieuwe SP = Oude SP - 1) ---
        subi A 1                  ; 10. A = De nieuwe stack pointer stand
        ld I X                    ; 11. I = RAM-adres van VVM_SP (teruggehaald uit X)
        stx A $_start_memory_     ; 12. Sla de nieuwe SP op in de VVM-struct!
        ret
@s_ne

        ; --- 1. Haal de pointer op en lees de virtuele SP ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct (anker)
        
        ldi A 3
        add A B                   ; A = RAM-adres van VVM_SP
        ld X A                    ; Parkeer het RAM-adres van VVM_SP in X voor de update straks
        
        ld I A
        ldx A $_start_memory_     ; 3. A = huidige virtuele SP
        
        ; --- 2. Lees de twee waarden van de virtuele stack ---
        ld I A
        subi I 1                  ; I = SP - 1 (TOS, math_b)
        ldx C $_start_memory_     ; 4. C = math_b
        
        subi I 1                  ; I = SP - 2 (NOS, math_a)
        ldx Y $_start_memory_     ; 5. Y = math_a
        
        ; --- 3. Voer de 'Not Equal' check uit via 'Test Equal' ---
        tste Y C                  ; 6. Test of Y (math_a) == C (math_b)
        jmpt :s_ne_false_          ; Als ze WEL gelijk zijn -> spring naar False!
        
        ; --- Case: True (Ze zijn ongelijk) ---
        ldi C 1                   ; 7. C = 1 (True)
        jmp :s_eq_write_
        
    :s_ne_false_
        ; --- Case: False (Ze zijn gelijk) ---
        ld C Z                    ; 8. C = 0 (via het veilige Zero register Z)
        
    :s_eq_write_
        ; --- 4. Schrijf het resultaat terug naar de stack (Locatie SP - 2) ---
        ; Register I staat nog steeds op (SP - 2), daar schrijven we direct naartoe!
        stx C $_start_memory_     ; 9. Schrijf True/False naar de stack
        
        ; --- 5. Update de nieuwe VVM_SP in de struct (Nieuwe SP = Oude SP - 1) ---
        subi A 1                  ; 10. A = De nieuwe stack pointer stand
        ld I X                    ; 11. I = RAM-adres van VVM_SP (teruggehaald uit X)
        stx A $_start_memory_     ; 12. Sla de nieuwe SP op in de VVM-struct!
        ret
@s_lt

        ; --- 1. Haal de pointer op en lees de virtuele SP ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct (anker)
        
        ldi A 3
        add A B                   ; A = RAM-adres van VVM_SP
        ld X A                    ; Parkeer het RAM-adres van VVM_SP in X voor de update straks
        
        ld I A
        ldx A $_start_memory_     ; 3. A = huidige virtuele SP
        
        ; --- 2. Lees de twee waarden van de virtuele stack ---
        ld I A
        subi I 1                  ; I = SP - 1 (TOS, math_b)
        ldx C $_start_memory_     ; 4. C = math_b (TOS)
        
        subi I 1                  ; I = SP - 2 (NOS, math_a)
        ldx Y $_start_memory_     ; 5. Y = math_a (NOS)
        
        ; --- 3. Voer de 'Less Than' check uit via 'Greater Than' (Is B > A?) ---
        tstg C Y                  ; 6. Test of C (math_b) > Y (math_a)
        jmpt :s_lt_true_          ; Als TOS > NOS, dan is NOS < TOS -> spring naar True
        
        ; --- Case: False (NOS >= TOS) ---
        ld C Z                    ; 7. C = 0 (via het veilige Zero register Z)
        jmp :s_lt_write_
        
    :s_lt_true_
        ldi C 1                   ; 8. C = 1 (True)
        
    :s_lt_write_
        ; --- 4. Schrijf het resultaat terug naar de stack (Locatie SP - 2) ---
        ; Register I staat nu exact op (SP - 2), daar schrijven we direct naartoe
        stx C $_start_memory_     ; 9. Schrijf True/False naar de stack
        
        ; --- 5. Update de nieuwe VVM_SP in de struct (Nieuwe SP = Oude SP - 1) ---
        subi A 1                  ; 10. A = De nieuwe stack pointer stand
        ld I X                    ; 11. I = RAM-adres van VVM_SP (teruggehaald uit X)
        stx A $_start_memory_     ; 12. Sla de nieuwe SP op in de VVM-struct!
    
        ret
@s_gt

        ; --- 1. Haal de pointer op en lees de virtuele SP ---
        ustack I $DATASTACK_PTR   ; 1. I = &VVM-pointer
        ldx B $_start_memory_     ; 2. B = basisadres van de VVM-struct (anker)
        
        ldi A 3
        add A B                   ; A = RAM-adres van VVM_SP
        ld X A                    ; Parkeer het RAM-adres van VVM_SP in X voor de update straks
        
        ld I A
        ldx A $_start_memory_     ; 3. A = huidige virtuele SP
        
        ; --- 2. Lees de twee waarden van de virtuele stack ---
        ld I A
        subi I 1                  ; I = SP - 1 (TOS, math_b)
        ldx C $_start_memory_     ; 4. C = math_b (TOS)
        
        subi I 1                  ; I = SP - 2 (NOS, math_a)
        ldx Y $_start_memory_     ; 5. Y = math_a (NOS)
        
        ; --- 3. Voer de 'Greater Than' check uit (Is NOS > TOS?) ---
        tstg Y C                  ; 6. Test of Y (math_a) > C (math_b)
        jmpt :s_gt_true_          ; Als NOS > TOS -> spring naar True
        
        ; --- Case: False (NOS <= TOS) ---
        ld C Z                    ; 7. C = 0 (via het veilige Zero register Z)
        jmp :s_gt_write_
        
    :s_gt_true_
        ldi C 1                   ; 8. C = 1 (True)
        
    :s_gt_write_
        ; --- 4. Schrijf het resultaat terug naar de stack (Locatie SP - 2) ---
        ; Register I staat nog steeds op (SP - 2), daar schrijven we direct naartoe
        stx C $_start_memory_     ; 9. Schrijf True/False naar de stack
        
        ; --- 5. Update de nieuwe VVM_SP in de struct (Nieuwe SP = Oude SP - 1) ---
        subi A 1                  ; 10. A = De nieuwe stack pointer stand
        ld I X                    ; 11. I = RAM-adres van VVM_SP (teruggehaald uit X)
        stx A $_start_memory_     ; 12. Sla de nieuwe SP op in de VVM-struct!
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
    jmpt :s_abs_if_end_2
    stack Z $DATASTACK_PTR
    ldm A $_math_a
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_math_a
:s_abs_if_end_2
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
@s_prints
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
    sto A $_env_sp_read_ptr
    ldm I $_env_sp_read_ptr
    ldx A $_start_memory_
    sto A $_string_ptr
    ldm A $_env_sp_read_ptr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_string_ptr
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ret
@s_push

        ; --- 1. Haal de parameters van de host-stack (Juiste Volgorde) ---
        ustack I $DATASTACK_PTR   ; 1. EERST POPPEN: I = &VVM-pointer (_env_vvm_ptr)
        ustack Y $DATASTACK_PTR   ; 2. DAARNA POPPEN: Y = de te pushen waarde (_env_val)
        ldx B $_start_memory_     ; 3. B = basisadres van de VVM-struct (anker)
        
        ; --- 2. Haal de huidige virtuele Stack Pointer op (Offset 3) ---
        ldi A 3
        add A B                   ; A = RAM-adres van VVM_SP
        ld X A                    ; Parkeer het RAM-adres van VVM_SP in X voor de update straks
        
        ld I A
        ldx A $_start_memory_     ; 4. A = huidige virtuele SP (het schrijfadres)
        
        ; --- 3. Schrijf de waarde (Y) naar de Sandbox Stack (*A) ---
        ld I A                    ; I = huidige virtuele SP
        stx Y $_start_memory_     ; 5. Schrijf waarde uit Y direct naar het sandbox-RAM
        
        ; --- 4. Verhoog de virtuele SP met 1 ---
        addi A 1                  ; 6. A = nieuwe virtuele SP (SP + 1)
        
        ; --- 5. Update VVM_SP in de struct met de nieuwe waarde ---
        ld I X                    ; I = RAM-adres van VVM_SP (teruggehaald uit X)
        stx A $_start_memory_     ; 7. Sla de verhoogde SP op in de VVM-struct!
        ret
@s_get

        ; --- 1. Haal de parameters van de host-stack (Juiste Volgorde) ---
        ustack I $DATASTACK_PTR   ; 1. EERST POPPEN: I = &VVM-pointer (_env_vvm_ptr)
        ustack Y $DATASTACK_PTR   ; 2. DAARNA POPPEN: Y = register-index (_math_a)
        ldx B $_start_memory_     ; 3. B = basisadres van de VVM-struct (anker)
        
        ; --- 2. Lees de waarde uit het virtuele register (Offset 22) ---
        ld X B                    ; Kopieer basisadres naar X voor de berekening
        addi X 22                 ; X = basisadres + 22 (VVM_regs start)
        add X Y                   ; X = basisadres + 22 + register_index
        ld I X
        ldx Y $_start_memory_     ; 4. Y = De gezochte waarde uit het virtuele register
        
        ; --- 3. Haal de huidige virtuele Stack Pointer op (Offset 3) ---
        ldi A 3
        add A B                   ; A = RAM-adres van VVM_SP
        ld X A                    ; Parkeer het RAM-adres van VVM_SP in X voor de update straks
        
        ld I A
        ldx A $_start_memory_     ; 5. A = huidige virtuele SP (het schrijfadres)
        
        ; --- 4. Schrijf de registerwaarde (Y) naar de Sandbox Stack (*A) ---
        ld I A                    ; I = huidige virtuele SP
        stx Y $_start_memory_     ; 6. Schrijf de waarde direct naar de stack
        
        ; --- 5. Verhoog de virtuele SP met 1 ---
        addi A 1                  ; 7. A = nieuwe virtuele SP (SP + 1)
        
        ; --- 6. Update VVM_SP in de struct met de nieuwe waarde ---
        ld I X                    ; I = RAM-adres van VVM_SP (teruggehaald uit X)
        stx A $_start_memory_     ; 8. Sla de verhoogde SP op in de VVM-struct!
        ret
@s_set

        ; --- 1. Haal de parameters van de host-stack (Juiste Volgorde) ---
        ustack I $DATASTACK_PTR   ; 1. EERST POPPEN: I = &VVM-pointer (_env_vvm_ptr)
        ustack Y $DATASTACK_PTR   ; 2. DAARNA POPPEN: Y = register-index (_math_a)
        ldx B $_start_memory_     ; 3. B = basisadres van de VVM-struct (anker)
        
        ; --- 2. Haal de huidige VVM_SP op (Offset 3) EN bereken TOS (SP - 1) ---
        ldi A 3
        add A B                   ; A = RAM-adres van VVM_SP
        ld X A                    ; Parkeer het RAM-adres van VVM_SP in X voor de update straks
        
        ld I A
        ldx A $_start_memory_     ; 4. A = huidige virtuele SP
        subi A 1                  ; 5. A = nieuwe virtuele SP (TOS-adres: SP - 1)
        
        ; --- 3. Pop de waarde van de Sandbox Stack (*A) ---
        ld I A                    ; I = TOS-adres
        ldx C $_start_memory_     ; 6. C = De waarde van de stack (_env_val)
        
        ; --- 4. Update VVM_SP in de struct met de verlaagde waarde ---
        ld I X                    ; I = RAM-adres van VVM_SP (teruggehaald uit X)
        stx A $_start_memory_     ; 7. Sla de verlaagde SP op in de VVM-struct
        
        ; --- 5. Schrijf de waarde (C) naar het virtuele register (Offset 22) ---
        ld X B                    ; Kopieer basisadres naar X voor de berekening
        addi X 22                 ; X = basisadres + 22 (VVM_regs start)
        add X Y                   ; X = basisadres + 22 + register_index
        ld I X
        stx C $_start_memory_     ; 8. Schrijf de waarde vanuit C direct in het virtuele register!
        ret
@s_bra

        ; --- 1. Haal de parameters van de host-stack (Juiste Volgorde) ---
        ustack I $DATASTACK_PTR   ; 1. EERST POPPEN: I = &VVM-pointer (_env_vvm_ptr)
        ustack Y $DATASTACK_PTR   ; 2. DAARNA POPPEN: Y = doeladres (_math_a)
        ldx B $_start_memory_     ; 3. B = basisadres van de VVM-struct (anker)
        
        ; --- 2. Bereken het RAM-adres van VVM_PC (Offset 2) ---
        ldi A 2
        add A B                   ; A = RAM-adres van VVM_PC
        
        ; --- 3. Schrijf het nieuwe adres direct in de struct ---
        ld I A                    ; Instellen als adres register
        stx Y $_start_memory_     ; 4. Sla het doeladres op in VVM_PC!
        ret
@s_brz

        ; --- 1. Haal de parameters van de host-stack (Juiste Volgorde) ---
        ustack I $DATASTACK_PTR   ; 1. EERST POPPEN: I = &VVM-pointer (_env_vvm_ptr)
        ustack Y $DATASTACK_PTR   ; 2. DAARNA POPPEN: Y = doeladres (_math_a)
        ldx B $_start_memory_     ; 3. B = basisadres van de VVM-struct (anker)
        
        ; --- 2. Haal de huidige VVM_SP op (Offset 3) EN krimp de stack (SP - 1) ---
        ldi A 3
        add A B                   ; A = RAM-adres van VVM_SP
        ld X A                    ; Parkeer het RAM-adres van VVM_SP in X voor de update straks
        
        ld I A
        ldx A $_start_memory_     ; 4. A = huidige virtuele SP
        subi A 1                  ; 5. A = nieuwe virtuele SP (het adres van de TOS-waarde)
        
        ; --- 3. Pop de waarde van de Sandbox Stack (*A) ---
        ld I A                    ; I = TOS-adres
        ldx C $_start_memory_     ; 6. C = De waarde van de stack waarmee we gaan testen
        
        ; --- 4. Update VVM_SP direct in de struct met de verlaagde waarde ---
        ld I X                    ; I = RAM-adres van VVM_SP (teruggehaald uit X)
        stx A $_start_memory_     ; 7. Sla de verlaagde SP op in de VVM-struct
        
        ; --- 5. Controleer of de waarde 0 is (C == Z) ---
        tste C Z                  ; 8. Test of de stackwaarde (C) gelijk is aan 0 (Z)
        jmpf :s_brz_end_          ; 9. Als NIET nul (False) -> skip de branch en beëindig de functie!
        
        ; --- 6. Case True: Schrijf het doeladres (Y) naar VVM_PC (Offset 2) ---
        ldi A 2
        add A B                   ; A = RAM-adres van VVM_PC
        ld I A
        stx Y $_start_memory_     ; 10. Sla het doeladres op in VVM_PC!
        
    :s_brz_end_
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
    jmpt :s_bnz_if_end_3
    ldm A $_math_a
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
:s_bnz_if_end_3
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
    jmpt :s_brp_if_end_4
    ldm A $_math_a
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
:s_brp_if_end_4
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
    jmpt :s_brn_if_end_5
    ldm A $_math_a
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
:s_brn_if_end_5
    ret
@s_exec
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
    sto A $_syscall_id
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_argr
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_argc
    ldm A $_env_sp_addr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_argc
    sto A $_env_idx
:s_exec_while_start_0
    ldm A $_env_idx
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_exec_while_end_0
    ldm B $_env_sp_addr
    ldm A $_env_idx
    sub B A
    ld A B
    sto A $_env_ptr
    ldm I $_env_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm B $_env_idx
    ldi A 1
    sub B A
    ld A B
    sto A $_env_idx
    jmp :s_exec_while_start_0
:s_exec_while_end_0
    ldm B $_env_sp_addr
    ldm A $_argc
    sub B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_syscall_id
    stack A $DATASTACK_PTR
    ldm A $syscall_table
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_exec_if_else_6
    ldm A $_syscall_id
    stack A $DATASTACK_PTR
    ldm A $syscall_table
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_syscall_handler
    stack A $DATASTACK_PTR
    calls $DATASTACK_PTR
    jmp :s_exec_if_end_6
:s_exec_if_else_6
    ldi A $error_no_syscall
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:s_exec_if_end_6
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld A Z
    sto A $_env_idx
:s_exec_while_start_1
    ldm A $_env_idx
    stack A $DATASTACK_PTR
    ldm A $_argr
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :s_exec_while_end_1
    ustack A $DATASTACK_PTR
    sto A $_env_val
    ldm B $_env_sp_addr
    ldm A $_argr
    add B A
    ldi A 1
    sub B A
    ldm A $_env_idx
    sub B A
    ld A B
    sto A $_env_ptr
    ldm A $_env_val
    ld B A
    ldm I $_env_ptr
    stx B $_start_memory_
    ldm B $_env_idx
    ldi A 1
    add A B
    sto A $_env_idx
    jmp :s_exec_while_start_1
:s_exec_while_end_1
    ldm B $_env_sp_addr
    ldm A $_argr
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
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
    jmpt :s_UDC_IO_if_end_7
    ustack A $DATASTACK_PTR
    sto A $_env_val
    stack A $DATASTACK_PTR
    ldm A $_env_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.append
:s_UDC_IO_if_end_7
    ret
@s_READ
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 48
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_kbd_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_math_a
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ldm A $_math_a
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add A B
    sto A $_nieuwe_sp
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
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
    ldi A 100
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $string_dict
    ldi A 4
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $kbd_prompts
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $kbd_req_queue
    ldi A 16
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $_FIT16_table
    ldi A 26
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $filename_tmp
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
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_prints
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 6384018730
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_exec
    stack A $DATASTACK_PTR
    ldi A 7
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
    ldi A 90
    stack A $DATASTACK_PTR
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A 91
    stack A $DATASTACK_PTR
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
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
    ldi A @s_READ
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $syscall_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ret


@VVM.create
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    ustack A $DATASTACK_PTR
    sto A $_VVMkbdq
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
    ldm I $_VVMkbdq
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 48
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
    ldi A 90
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_4
    ldi A 1
    sto A $_in_string
:VVM.create_while_start_1
    ldm A $_in_string
    tst A 0
    jmpt :VVM.create_while_end_1
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_5
    ldi A $error_no_opcode
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_5
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
    jmpt :VVM.create_if_end_6
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_sub_op
    stack A $DATASTACK_PTR
    ldi A 91
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_7
    ld A Z
    sto A $_in_string
:VVM.create_if_end_7
:VVM.create_if_end_6
    jmp :VVM.create_while_start_1
:VVM.create_while_end_1
    ldm B $_vvm_pc_offset
    ldi A 2
    add A B
    sto A $_vvm_pc_offset
    jmp :VVM.create_if_end_4
:VVM.create_if_else_4
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_8
    ldm B $_vvm_pc_offset
    ldi A 1
    add A B
    sto A $_vvm_pc_offset
    jmp :VVM.create_if_end_8
:VVM.create_if_else_8
    ldm B $_vvm_pc_offset
    ldi A 2
    add A B
    sto A $_vvm_pc_offset
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
:VVM.create_if_end_8
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
    jmpt :VVM.create_if_end_9
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
:VVM.create_if_end_9
    jmp :VVM.create_while_start_0
:VVM.create_while_end_0
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
    jmpt :VVM.create_if_end_10
    ldi A $error_vvm_overflow
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_10
    ldm I $_VVMpointer
    ldx A $_start_memory_
    sto A $_temp_ptr
    ld B A
    ldi A 50
    add A B
    sto A $_vvm_code_start
    sto A $_vvm_write_ptr
:VVM.create_while_start_2
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_while_end_2
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
    jmpt :VVM.create_if_else_11
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_drop
    jmp :VVM.create_if_end_11
:VVM.create_if_else_11
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 90
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_12
    ldi A 64
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_vvm_temp_list_ptr
    ldi A 1
    sto A $_in_bake_string
    ld A Z
    sto A $_str_char_idx
:VVM.create_while_start_3
    ldm A $_in_bake_string
    tst A 0
    jmpt :VVM.create_while_end_3
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_13
    ldi A $error_no_opcode
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_13
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_char_val
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_14
    ldm A $_char_val
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_sub_op
    stack A $DATASTACK_PTR
    ldi A 91
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_15
    ld A Z
    sto A $_in_bake_string
:VVM.create_if_end_15
    jmp :VVM.create_if_end_14
:VVM.create_if_else_14
    ldm A $_char_val
    stack A $DATASTACK_PTR
    ldi A 92
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_16
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_17
    ldi A $error_no_opcode
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_17
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_next_char
    stack A $DATASTACK_PTR
    ldi A 110
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_18
    ldi A 13
    sto A $_char_val
    jmp :VVM.create_if_end_18
:VVM.create_if_else_18
    ldm A $_next_char
    sto A $_char_val
:VVM.create_if_end_18
:VVM.create_if_end_16
    ldm B $_str_char_idx
    ldi A 1
    add A B
    sto A $_temp_idx
    ldm A $_char_val
    stack A $DATASTACK_PTR
    ldm A $_temp_idx
    stack A $DATASTACK_PTR
    ldm A $_vvm_temp_list_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_str_char_idx
    ldi A 1
    add A B
    sto A $_str_char_idx
:VVM.create_if_end_14
    jmp :VVM.create_while_start_3
:VVM.create_while_end_3
    ldm B $_str_char_idx
    ldi A 1
    add A B
    sto A $_temp_idx
    stack Z $DATASTACK_PTR
    ldm A $_temp_idx
    stack A $DATASTACK_PTR
    ldm A $_vvm_temp_list_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_str_char_idx
    ldi A 1
    add A B
    sto A $_str_char_idx
    ldm B $_vvm_temp_list_ptr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @STRhash
    ustack A $DATASTACK_PTR
    sto A $_string_hash
    stack A $DATASTACK_PTR
    ldm A $string_dict
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_19
    ldm A $_string_hash
    stack A $DATASTACK_PTR
    ldm A $string_dict
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_final_string_ptr
    jmp :VVM.create_if_end_19
:VVM.create_if_else_19
    ldm B $_vvm_temp_list_ptr
    ldi A 1
    add A B
    sto A $_final_string_ptr
    stack A $DATASTACK_PTR
    ldm A $_string_hash
    stack A $DATASTACK_PTR
    ldm A $string_dict
    stack A $DATASTACK_PTR
    call @DICT.put
:VVM.create_if_end_19
    ldi A 50
    ld B A
    ldm I $_vvm_write_ptr
    stx B $_start_memory_
    ldm B $_vvm_write_ptr
    ldi A 1
    add A B
    sto A $_vvm_write_ptr
    ldm A $_final_string_ptr
    ld B A
    ldm I $_vvm_write_ptr
    stx B $_start_memory_
    ldm B $_vvm_write_ptr
    ldi A 1
    add A B
    sto A $_vvm_write_ptr
    jmp :VVM.create_if_end_12
:VVM.create_if_else_12
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
    jmpt :VVM.create_if_end_20
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
    jmpt :VVM.create_if_else_21
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_22
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.get
    ldm A $_vvm_code_start
    ustack B $DATASTACK_PTR
    add A B
    sto A $_temp_val
    jmp :VVM.create_if_end_22
:VVM.create_if_else_22
    ldi A $error_label_unknown
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_22
    jmp :VVM.create_if_end_21
:VVM.create_if_else_21
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
    jmpt :VVM.create_if_end_23
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
    jmpt :VVM.create_if_end_24
    ldi A $error_invalid_reg
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_24
:VVM.create_if_end_23
:VVM.create_if_end_21
    ldm A $_temp_val
    ld B A
    ldm I $_vvm_write_ptr
    stx B $_start_memory_
    ldm B $_vvm_write_ptr
    ldi A 1
    add A B
    sto A $_vvm_write_ptr
:VVM.create_if_end_20
:VVM.create_if_end_12
:VVM.create_if_end_11
    jmp :VVM.create_while_start_2
:VVM.create_while_end_2
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
:VVM.start_while_start_4
    ldm A $_start_idx
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.start_while_end_4
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
    jmp :VVM.start_while_start_4
:VVM.start_while_end_4
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
    jmpt :VVM.run_if_else_25
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
    jmpt :VVM.run_if_else_26
    ldi A 1
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    jmp :VVM.run_if_end_26
:VVM.run_if_else_26
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
    jmpt :VVM.run_if_end_27
    ldm I $_run_pc
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm B $_run_pc
    ldi A 1
    add A B
    sto A $_run_pc
:VVM.run_if_end_27
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
:VVM.run_if_end_26
    jmp :VVM.run_if_end_25
:VVM.run_if_else_25
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.run_if_end_28
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
:VVM.run_if_end_28
:VVM.run_if_end_25
    ret
@VVM.runbatch
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    ustack A $DATASTACK_PTR
    sto A $_batch_size
    ld A Z
    sto A $_batch_idx
    ldi A 1
    sto A $_continue_batch
:VVM.runbatch_while_start_5
    ldm A $_batch_idx
    stack A $DATASTACK_PTR
    ldm A $_batch_size
    stack A $DATASTACK_PTR
    call @rt_lt
    ldm A $_continue_batch
    ustack B $DATASTACK_PTR
    mul A B
    tst A 0
    jmpt :VVM.runbatch_while_end_5
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVM.run
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.runbatch_if_end_29
    ld A Z
    sto A $_continue_batch
:VVM.runbatch_if_end_29
    ldm B $_batch_idx
    ldi A 1
    add A B
    sto A $_batch_idx
    jmp :VVM.runbatch_while_start_5
:VVM.runbatch_while_end_5
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
    jmpt :VVM.check_syscalls_if_end_30
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.tail
    call @DEQUE.value
    ustack A $DATASTACK_PTR
    sto A $_syscall_id
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.check_syscalls_if_else_31
    ldm A $_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    call @rt_drop
    ldm A $_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.tail
    call @DEQUE.value
    ustack A $DATASTACK_PTR
    sto A $_prompt_pointer
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 48
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_kbd_dq
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.check_syscalls_if_else_32
    ldm A $_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    call @rt_drop
    ldm A $_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    call @rt_drop
    ldi A 20
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
    ldi A 2
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    jmp :VVM.check_syscalls_if_end_32
:VVM.check_syscalls_if_else_32
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.check_syscalls_if_end_33
    ldi A 5
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm I $_VVMpointer
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldm A $_prompt_pointer
    stack A $DATASTACK_PTR
    ldm I $_VVMpointer
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm A $kbd_prompts
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A 1
    sto A $new_input_flag
:VVM.check_syscalls_if_end_33
:VVM.check_syscalls_if_end_32
    jmp :VVM.check_syscalls_if_end_31
:VVM.check_syscalls_if_else_31
    ldm A $_host_dq
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
    jmpt :VVM.check_syscalls_if_else_34
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
    jmp :VVM.check_syscalls_if_end_34
:VVM.check_syscalls_if_else_34
    ldi A $error_no_syscall
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.check_syscalls_if_end_34
    ldi A 2
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
:VVM.check_syscalls_if_end_31
:VVM.check_syscalls_if_end_30
    ret
@VVM.fit_init
    ustack A $DATASTACK_PTR
    sto A $_FIT_file_on_disk
    ustack A $DATASTACK_PTR
    sto A $_FIT_tempname
    ustack A $DATASTACK_PTR
    sto A $_FIT_table
    ldi A $msg_FITing
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    
        # Open _FIT16_ file expected the disk
        # Retuns 1 on success, 0 on failure
        ldm A $_FIT_file_on_disk
        ldi I ~SYS_F_OPEN_READ
        int $INT_VECTORS
        
        ldm A $SYSCALL_RETURN_STATUS
        tste A Z
        stack A $DATASTACK_PTR      ; return value on the Stack
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.fit_init_if_else_35
    ldm A $_FIT_file_on_disk
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $error_fit_file
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
    jmp :VVM.fit_init_if_end_35
:VVM.fit_init_if_else_35

            call @_read_disk_block
            # Mocht dit block om vage redenen falen, spring naar close
            jmpt :fit_init_close_early
    ldm B $_FIT_tempname
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
:fit_init_loop

            :get_char_loop
                inc I $disk_io_buffer_ptr
                ldx C $disk_io_buffer_base
                tst C \null
                jmpf :FIT_process_char
                    # End of block, read next
                    call @_check_last_block
                    jmpt :FIT_last_block
                    call @_read_disk_block
                    jmpt :FIT_close_and_end

                    # Reset ptr and reload C
                    # The _read_disk_block resets the internal pointer variable to 0.
                    # The top of the loop increments before reading, which would skip the
                    # first character of the new block.
                    # We must manually load the first character here and jump past the loop's load.
                    inc I $disk_io_buffer_ptr
                    ldx C $disk_io_buffer_base
                    jmp :FIT_process_char

                :FIT_process_char                  
                    stack C $DATASTACK_PTR
                    jmp :FIT_get_char_exit

                :FIT_last_block                 # no data left
                    stack Z $DATASTACK_PTR
                    jmp :FIT_get_char_exit

            :FIT_get_char_exit    
            ustack A $DATASTACK_PTR
    sto A $_fit_char
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.fit_init_if_end_36
    jmp :FIT_close_and_end
:VVM.fit_init_if_end_36
    ldm A $_fit_char
    stack A $DATASTACK_PTR
    call @PRTchar
    ldm A $_fit_char
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.fit_init_if_end_37
    stack Z $DATASTACK_PTR
    ldm A $_FIT_tempname
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_FIT_tempname
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.fit_init_if_end_38
    ldm B $_FIT_tempname
    ldi A 2
    add B A
    stack B $DATASTACK_PTR
    call @STRhash
    ustack A $DATASTACK_PTR
    sto A $_fit_hash
    ldm A $_FIT_tempname
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $_fit_len
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_fit_str_ptr
    ldm B $_FIT_tempname
    ldi A 2
    add B A
    stack B $DATASTACK_PTR
    ldm A $_fit_str_ptr
    stack A $DATASTACK_PTR
    call @STRcopy
    ldm A $_fit_str_ptr
    stack A $DATASTACK_PTR
    ldm A $_fit_hash
    stack A $DATASTACK_PTR
    ldm A $_FIT_table
    stack A $DATASTACK_PTR
    call @DICT.put
:VVM.fit_init_if_end_38
    ldm B $_FIT_tempname
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    jmp :fit_init_loop
:VVM.fit_init_if_end_37
    ldm A $_fit_char
    stack A $DATASTACK_PTR
    ldm A $_FIT_tempname
    stack A $DATASTACK_PTR
    call @ARRAY.append
    jmp :fit_init_loop

                :fit_init_close_early
            :VVM.fit_init_if_end_35
:FIT_close_and_end

        # Close _FIT16_ file
        ldi I ~SYS_F_CLOSE
        int $INT_VECTORS
        ret
@VVM.fit_lookup_by_hash
    ustack A $DATASTACK_PTR
    sto A $_search_hash
    stack A $DATASTACK_PTR
    ldm A $_FIT_table
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.fit_lookup_by_hash_if_else_39
    ldm A $_search_hash
    stack A $DATASTACK_PTR
    ldm A $_FIT_table
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_found_file_ptr
    stack A $DATASTACK_PTR
    jmp :VVM.fit_lookup_by_hash_if_end_39
:VVM.fit_lookup_by_hash_if_else_39
    ldi A $msg_hash_not_found
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_search_hash
    stack A $DATASTACK_PTR
    call @rt_print_tos
    stack Z $DATASTACK_PTR
:VVM.fit_lookup_by_hash_if_end_39
    ret
@VVM.loadcode
    ustack A $DATASTACK_PTR
    sto A $_filename
    ustack A $DATASTACK_PTR
    sto A $_code_queue
    ldi A $msg_loading
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    
        # Open file
        ldm A $_filename
        ldi I ~SYS_F_OPEN_READ
        int $INT_VECTORS
        
        ldm A $SYSCALL_RETURN_STATUS
        tste A Z
        jmpt :vvm_load_end_error

        # Variables
        . $vvm_val 1
        . $vvm_digit_seen 1

        # Read first block
        call @_read_disk_block
        jmpt :vvm_close_and_end

        :vvm_read_loop
            sto Z $vvm_val
            sto Z $vvm_digit_seen

        :vvm_parse_loop
            inc I $disk_io_buffer_ptr
            ldx C $disk_io_buffer_base
            tst C \null
            jmpf :vvm_process_char
                # End of block, read next
                call @_check_last_block
                jmpt :vvm_close_and_end
                call @_read_disk_block
                jmpt :vvm_close_and_end

                # Reset ptr and reload C
                # The _read_disk_block resets the internal pointer variable to 0.
                # The top of the loop increments before reading, which would skip the
                # first character of the new block.
                # We must manually load the first character here and jump past the loop's load.
                inc I $disk_io_buffer_ptr
                ldx C $disk_io_buffer_base
                jmp :vvm_process_char

            :vvm_process_char
            tst C \Return
            jmpt :vvm_check_push
            # tst C \Newline
            # jmpt :vvm_check_push
            # tst C \space
            # jmpt :vvm_check_push
            

            :vvm_check_digit
            ldi A 1
            sto A $vvm_digit_seen
            ldm A $vvm_val
            muli A 10
            subi C 48
            add A C
            sto A $vvm_val
            jmp :vvm_parse_loop

            :vvm_check_push
            ldm A $vvm_digit_seen
            tste A Z
            jmpt :vvm_parse_loop
            
            :vvm_push
            ldm A $vvm_val
            stack A $DATASTACK_PTR
            ldm A $_code_queue
            stack A $DATASTACK_PTR
            call @DEQUE.append
            jmp :vvm_read_loop

        :vvm_close_and_end
            ldi I ~SYS_F_CLOSE
            int $INT_VECTORS
            
        :vvm_load_end_error
        ret
@VVM.bind
    ustack A $DATASTACK_PTR
    sto A $_custom_id
    ustack A $DATASTACK_PTR
    sto A $_function_ptr
    ldm A $_custom_id
    stack A $DATASTACK_PTR
    ldi A 100
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.bind_if_else_40
    ldi A $error_invalid_syscall
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
    jmp :VVM.bind_if_end_40
:VVM.bind_if_else_40
    ldm A $_function_ptr
    stack A $DATASTACK_PTR
    ldm A $_custom_id
    stack A $DATASTACK_PTR
    ldm A $syscall_table
    stack A $DATASTACK_PTR
    call @DICT.put
:VVM.bind_if_end_40
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
% $_env_sp_read_ptr 0
% $_string_ptr 0
% $_argc 0
% $_argr 0
% $_nieuwe_sp 0
% $string_dict 0
% $_vvm_temp_list_ptr 0
% $kbd_req_queue 0
% $kbd_prompts 0
% $_FIT16_table 0
% $filename_tmp 0
% $index_file_name \_ \F \I \T \1 \6 \_ \null

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
% $msg_loading \L \o \a \d \i \n \g \space \I \m \a \g \e \space \f \r \o \m \space \d \i \s \k \space \Return \null
% $msg_FITing \C \r \e \a \t \t \i \n \g \space \F \I \T \space \t \a \b \l \e \space \Return \null
% $error_fit_file \space \n \o \t \space \f \o \u \n \d \space \o \n \space \d \i \s \k \. \space \Return \null
% $error_invalid_syscall \V \V \M \space \I \l \l \i \g \a \l \space \S \Y \S \C \A \L \L \space \I \D \space \i \s \space \u \s \e \d \. \space \Return \null
% $_run_pc 0
% $_run_opcode 0
% $_run_handler 0
% $_start_argc 0
% $_start_idx 0
% $_syscall_id 0
% $_syscall_handler 0
% $_batch_size 0
% $_batch_idx 0
% $_continue_batch 0
% $_VVMpointer 0
% $_VVMkbdq 0
% $_VVMHOSTpointer 0
% $_VVMsize 0
% $_SIMPLcode 0
% $_in_string 1
% $_sub_op 0
% $_vvm_max_size 0
% $_vvm_needed_size 0
% $_vvm_code_start 0
% $_vvm_write_ptr 0
% $_char_val 0
% $_string_hash 0
% $_in_bake_string 1
% $_str_char_idx 0
% $_next_char 0
% $_final_string_ptr 0
% $_host_dq 0
% $_kbd_dq 0
% $_prompt_pointer 0
% $new_input_flag 1
% $_FIT_file_on_disk 0
% $_FIT_tempname 0
% $_FIT_table 0
% $_fit_char 0
% $_fit_hash 0
% $_fit_len 0
% $_fit_str_ptr 0
% $_search_hash 0
% $_found_file_ptr 0
% $msg_hash_not_found \V \V \M \space \K \e \r \n \e \l \space \E \r \r \o \r \: \space \E \x \e \c \u \t \a \b \l \e \space \h \a \s \h \space \n \o \t \space \f \o \u \n \d \space \- \> \space \null
% $_filename 0
% $_code_queue 0
% $_custom_id 0
% $_function_ptr 0
