# .HEADER
. $VVM0 1
. $VVM1 1
. $VVM2 1
. $VVM3 1
. $VVM0_host_deque 1
. $VVM1_host_deque 1
. $VVM2_host_deque 1
. $VVM3_host_deque 1
. $VVM0_kbd_deque 1
. $VVM1_kbd_deque 1
. $VVM2_kbd_deque 1
. $VVM3_kbd_deque 1
. $SIMPL_code 1
. $KERNEL_slots 1
. $KERNEL_proces_list 1
. $KERNEL_number_of_processes 1
. $KERNEL_current_process 1
. $KERNEL_current_ptr 1
. $KERNEL_current_burst 1
. $KERNEL_disk_is_mounted 1
. $_binnengekomen_regel 1
. $_wachtende_vvm 1
. $_target_kbd_dq 1
. $_rpn_input_ptr 1
. $_tokens_geleverd 1
. $_active_count 1
. $_target_vvm 1
. $_main_str_0 52
. $host_proc_list_str_1 28
. $host_proc_list_str_2 29
. $_loop_idx 1
. $_slot_num 1
. $_vvm_ptr 1
. $_status 1
. $host_proc_list_str_3 2
. $host_proc_list_str_4 6
. $host_proc_list_str_5 8
. $host_proc_list_str_6 9
. $host_proc_list_str_7 10
. $host_proc_list_str_8 6
. $host_proc_list_str_9 7
. $host_proc_list_str_10 8
. $host_proc_list_str_11 9
. $host_proc_list_str_12 2
. $_target_slot 1
. $_current_status 1
. $_target_host_dq 1
. $_reg_idx 1
. $_vvm_size 1
. $_load_slot 1
. $_load_hash 1
. $_resolved_filename_ptr 1
. $kernel_input_buffer 80
. $kernel_buf_idx 1
. $_poll_loop_continue 1
. $_result_buffer_ptr 1
. $_ingedrukt_karakter 1
. $_term_ptr 1
. $_write_ptr 1
. $kernel_start_str_13 36
. $kernel_start_str_14 31
. $kernel_start_str_15 24
. $_sq_ 1
. $kernel_start_str_16 34
. $kernel_start_str_17 34
. $kernel_start_str_18 34
. $kernel_start_str_19 34
. $kernel_start_str_20 15
. $_waiting_VVM 1
. $kernel_start_str_21 3
. $kernel_start_str_22 49
. $_proc_status 1

# .CODE
    ldi A $_main_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @kernel_start
    ret

# .FUNCTIONS
@host_gcd
:host_gcd_while_start_0
    call @rt_dup
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_gcd_while_end_0
    call @rt_swap
    call @rt_over
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    jmp :host_gcd_while_start_0
:host_gcd_while_end_0
    call @rt_drop
    ret
@host_draw_fast
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    call @rt_rnd
    ldi A 15
    ustack B $DATASTACK_PTR
    mul B A
    ldi A 999
    dmod B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_draw_fast_if_end_0
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
:host_draw_fast_if_end_0
    ret
@host_proc_list
    ldi A $host_proc_list_str_1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $host_proc_list_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $_active_count
    ld A Z
    sto A $_loop_idx
:host_proc_list_while_start_1
    ldm A $_loop_idx
    stack A $DATASTACK_PTR
    ldm A $_active_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_list_while_end_1
    ldm A $_loop_idx
    stack A $DATASTACK_PTR
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $_slot_num
    ustack A $DATASTACK_PTR
    sto A $_vvm_ptr
    stack Z $DATASTACK_PTR
    ldi A $_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_status
    ldi A $host_proc_list_str_3
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_slot_num
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $host_proc_list_str_4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_vvm_ptr
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $host_proc_list_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_status
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_list_if_end_1
    ldi A $host_proc_list_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :host_proc_list_if_end_1
    ldm A $_status
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_list_if_end_2
    ldi A $host_proc_list_str_7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :host_proc_list_if_end_2
    ldm A $_status
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_list_if_end_3
    ldi A $host_proc_list_str_8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :host_proc_list_if_end_3
    ldm A $_status
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_list_if_end_4
    ldi A $host_proc_list_str_9
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :host_proc_list_if_end_4
    ldm A $_status
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_list_if_end_5
    ldi A $host_proc_list_str_10
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :host_proc_list_if_end_5
    ldm A $_status
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_list_if_end_6
    ldi A $host_proc_list_str_11
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :host_proc_list_if_end_6
    ldm B $_loop_idx
    ldi A 1
    add A B
    sto A $_loop_idx
    jmp :host_proc_list_while_start_1
:host_proc_list_while_end_1
    ldi A $host_proc_list_str_12
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    ret
@host_proc_start
    ustack A $DATASTACK_PTR
    sto A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ldm A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add A B
    tst A 0
    jmpt :host_proc_start_if_end_7
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :START_EXIT
:host_proc_start_if_end_7
    ldm A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_start_if_end_8
    ldm A $VVM1
    sto A $_target_vvm
:host_proc_start_if_end_8
    ldm A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_start_if_end_9
    ldm A $VVM2
    sto A $_target_vvm
:host_proc_start_if_end_9
    ldm A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_start_if_end_10
    ldm A $VVM3
    sto A $_target_vvm
:host_proc_start_if_end_10
    stack Z $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_current_status
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_start_if_end_11
    ldi A 3
    stack A $DATASTACK_PTR
    jmp :START_EXIT
:host_proc_start_if_end_11
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_target_host_dq
:host_proc_start_while_start_2
    ldm A $_target_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_start_while_end_2
    ldm A $_target_host_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_drop
    jmp :host_proc_start_while_start_2
:host_proc_start_while_end_2
    ldi A 48
    stack A $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_target_kbd_dq
:host_proc_start_while_start_3
    ldm A $_target_kbd_dq
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_start_while_end_3
    ldm A $_target_kbd_dq
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_drop
    jmp :host_proc_start_while_start_3
:host_proc_start_while_end_3
    ld A Z
    sto A $_reg_idx
:host_proc_start_while_start_4
    ldm A $_reg_idx
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_start_while_end_4
    stack Z $DATASTACK_PTR
    ldi A 22
    ld B A
    ldm A $_reg_idx
    add B A
    stack B $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm B $_reg_idx
    ldi A 1
    add A B
    sto A $_reg_idx
    jmp :host_proc_start_while_start_4
:host_proc_start_while_end_4
    ldm B $_target_vvm
    ldi A 50
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm B $_target_vvm
    ldi A 6
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_vvm_size
    ldm B $_target_vvm
    ldm A $_vvm_size
    add B A
    stack B $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpoke
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_target_slot
    stack A $DATASTACK_PTR
    ldm A $_target_vvm
    stack A $DATASTACK_PTR
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.put
    stack Z $DATASTACK_PTR
:START_EXIT
    ret
@host_proc_stop
    ustack A $DATASTACK_PTR
    sto A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ldm A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add A B
    tst A 0
    jmpt :host_proc_stop_if_end_12
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :STOP_EXIT
:host_proc_stop_if_end_12
    ldm A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_stop_if_end_13
    ldm A $VVM1
    sto A $_target_vvm
:host_proc_stop_if_end_13
    ldm A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_stop_if_end_14
    ldm A $VVM2
    sto A $_target_vvm
:host_proc_stop_if_end_14
    ldm A $_target_slot
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_proc_stop_if_end_15
    ldm A $VVM3
    sto A $_target_vvm
:host_proc_stop_if_end_15
    stack Z $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_status
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_neq
    ldm A $_status
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul A B
    tst A 0
    jmpt :host_proc_stop_if_else_16
    ldi A 4
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldi A $_target_vvm
    stack A $DATASTACK_PTR
    call @VVMpoke
    stack Z $DATASTACK_PTR
    jmp :host_proc_stop_if_end_16
:host_proc_stop_if_else_16
    ldi A 2
    stack A $DATASTACK_PTR
:host_proc_stop_if_end_16
:STOP_EXIT
    ret
@host_mount
    ldm A $KERNEL_disk_is_mounted
    tst A 0
    jmpt :host_mount_if_end_17
    jmp :MOUNT_EXIT
:host_mount_if_end_17
    ldm A $_FIT16_table
    stack A $DATASTACK_PTR
    ldm A $filename_tmp
    stack A $DATASTACK_PTR
    ldi A $index_file_name
    stack A $DATASTACK_PTR
    call @VVM.fit_init
    ldi A 1
    sto A $KERNEL_disk_is_mounted
:MOUNT_EXIT
    stack Z $DATASTACK_PTR
    ret
@host_umount
    ldm A $KERNEL_disk_is_mounted
    stack A $DATASTACK_PTR
    ld A Z
    sto A $KERNEL_disk_is_mounted
    stack Z $DATASTACK_PTR
    ret
@host_load
    ustack A $DATASTACK_PTR
    sto A $_load_slot
    ustack A $DATASTACK_PTR
    sto A $_load_hash
    ldm A $KERNEL_disk_is_mounted
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_load_if_end_18
    ldi A 5
    stack A $DATASTACK_PTR
    jmp :LOAD_EXIT
:host_load_if_end_18
    ldm A $_load_slot
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_lt
    ldm A $_load_slot
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add A B
    tst A 0
    jmpt :host_load_if_end_19
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :LOAD_EXIT
:host_load_if_end_19
    ldm A $_load_hash
    stack A $DATASTACK_PTR
    call @VVM.fit_lookup_by_hash
    ustack A $DATASTACK_PTR
    sto A $_resolved_filename_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_load_if_end_20
    ldi A 6
    stack A $DATASTACK_PTR
    jmp :LOAD_EXIT
:host_load_if_end_20
    ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    ldm A $_resolved_filename_ptr
    stack A $DATASTACK_PTR
    call @VVM.loadcode
    ldm A $_load_slot
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_load_if_end_21
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $VVM1_host_deque
    stack A $DATASTACK_PTR
    ldi A $VVM1_kbd_deque
    stack A $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.create
    jmp :LOAD_succes
:host_load_if_end_21
    ldm A $_load_slot
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_load_if_end_22
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $VVM2_host_deque
    stack A $DATASTACK_PTR
    ldi A $VVM2_kbd_deque
    stack A $DATASTACK_PTR
    ldi A $VVM2
    stack A $DATASTACK_PTR
    call @VVM.create
    jmp :LOAD_succes
:host_load_if_end_22
    ldm A $_load_slot
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :host_load_if_end_23
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $VVM3_host_deque
    stack A $DATASTACK_PTR
    ldi A $VVM3_kbd_deque
    stack A $DATASTACK_PTR
    ldi A $VVM3
    stack A $DATASTACK_PTR
    call @VVM.create
:host_load_if_end_23
:LOAD_succes
    stack Z $DATASTACK_PTR
:LOAD_EXIT
    ret
@POLLline

        ldi I ~SYS_PRINT_CURSOR
        int $INT_VECTORS
    ld A Z
    sto A $_result_buffer_ptr
    ldi A 1
    sto A $_poll_loop_continue
:POLLline_while_start_5
    ldm A $_poll_loop_continue
    tst A 0
    jmpt :POLLline_while_end_5
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :POLLline_if_else_24
    ustack A $DATASTACK_PTR
    sto A $_ingedrukt_karakter
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :POLLline_if_else_25
    call @CURSORoff
    ldm A $_ingedrukt_karakter
    stack A $DATASTACK_PTR
    call @PRTchar
    ldi A $kernel_input_buffer
    ld B A
    ldm A $kernel_buf_idx
    add A B
    sto A $_term_ptr
    ld B Z
    ldm I $_term_ptr
    stx B $_start_memory_
    ld A Z
    sto A $kernel_buf_idx
    ldi A $kernel_input_buffer
    sto A $_result_buffer_ptr
    ld A Z
    sto A $_poll_loop_continue
    jmp :POLLline_if_end_25
:POLLline_if_else_25
    ldm A $_ingedrukt_karakter
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :POLLline_if_else_26
    ldm A $kernel_buf_idx
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :POLLline_if_end_27
    call @CURSORoff
    ldm A $_ingedrukt_karakter
    stack A $DATASTACK_PTR
    call @PRTchar
    ldm B $kernel_buf_idx
    ldi A 1
    sub B A
    ld A B
    sto A $kernel_buf_idx
:POLLline_if_end_27
    jmp :POLLline_if_end_26
:POLLline_if_else_26
    ldm A $_ingedrukt_karakter
    stack A $DATASTACK_PTR
    call @PRTchar
    ldi A $kernel_input_buffer
    ld B A
    ldm A $kernel_buf_idx
    add A B
    sto A $_write_ptr
    ldm A $_ingedrukt_karakter
    ld B A
    ldm I $_write_ptr
    stx B $_start_memory_
    ldm B $kernel_buf_idx
    ldi A 1
    add A B
    sto A $kernel_buf_idx
:POLLline_if_end_26
:POLLline_if_end_25
    jmp :POLLline_if_end_24
:POLLline_if_else_24
    ld A Z
    sto A $_poll_loop_continue
:POLLline_if_end_24
    jmp :POLLline_while_start_5
:POLLline_while_end_5
    ldm A $_result_buffer_ptr
    stack A $DATASTACK_PTR
    ret
@kernel_start
    ldm A $HEAP_START
    sto A $HEAP_FREE
    ldi A 50
    stack A $DATASTACK_PTR
    call @DEQUE.init_pool
    ldi A $kernel_start_str_13
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM0_host_deque
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM1_host_deque
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM2_host_deque
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM3_host_deque
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM0_kbd_deque
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM1_kbd_deque
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM2_kbd_deque
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM3_kbd_deque
    ldi A 4
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $KERNEL_slots
    ldm A $VVM0
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $KERNEL_slots
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $VVM1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $KERNEL_slots
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $VVM2
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $KERNEL_slots
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $VVM3
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $KERNEL_slots
    stack A $DATASTACK_PTR
    call @LIST.put
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $SIMPL_code
    call @VVM.init
    ldi A $kernel_start_str_14
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $kernel_start_str_15
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A @host_gcd
    stack A $DATASTACK_PTR
    ldi A 150
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @host_draw_fast
    stack A $DATASTACK_PTR
    ldi A 151
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @host_proc_list
    stack A $DATASTACK_PTR
    ldi A 100
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @host_proc_start
    stack A $DATASTACK_PTR
    ldi A 101
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @host_proc_stop
    stack A $DATASTACK_PTR
    ldi A 103
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @host_mount
    stack A $DATASTACK_PTR
    ldi A 105
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @host_umount
    stack A $DATASTACK_PTR
    ldi A 106
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @host_load
    stack A $DATASTACK_PTR
    ldi A 107
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldm A $SIMPL_code
    sto A $_sq_
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229487724944493
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246273204308186788
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 84
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 121
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 112
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 104
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 112
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 102
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 104
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 112
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 46
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 83
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 79
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 83
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 62
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5863720
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392913
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384018730
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953474141284
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8980323672842228326074
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392914
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953474141284
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383976602
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392914
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 249850556750932056
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392913
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210728208851
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392915
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 83
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 35
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 58
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384018730
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953474141286
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8980323672842228326074
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392916
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953474141286
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383976602
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392916
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 249850556750932056
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392915
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6385703755
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966012
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 83
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 35
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 58
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 103
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384018730
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229464646662223
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8980323672842228326074
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966013
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229464646662223
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383976602
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966013
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 249850556750932056
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966012
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210720935288
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966014
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384018730
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229464646662225
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8980323672842228326074
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966015
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229464646662225
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383976602
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966015
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 249850556750932056
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966014
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6954101367725
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966016
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 106
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384018730
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229464646662227
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8980323672842228326074
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966017
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229464646662227
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383976602
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966017
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 249850556750932056
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966016
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6385446277
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966018
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 70
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 58
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 83
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 35
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 58
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 107
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384018730
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229464646662229
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8980323672842228326074
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966019
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229464646662229
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383976602
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966019
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 249850556750932056
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966018
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6385292014
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966020
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 65
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 118
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 98
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 99
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 58
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 44
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 112
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 44
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 112
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 117
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 44
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 117
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 117
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 44
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 104
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 112
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 44
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 120
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 249850556750932056
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966020
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6385204799
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966021
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 249850556750932056
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953475966021
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 85
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 107
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 119
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 99
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 249850556750932056
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229487724944493
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246273204308186788
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 81
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 117
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 103
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 83
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 77
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 117
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 84
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 107
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 103
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384101742
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8980323672842228326074
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392907
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 73
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 118
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246287477255447998
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392907
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392908
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 67
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 104
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246287477255447998
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392908
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392909
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 67
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246287477255447998
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392909
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392910
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 67
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246287477255447998
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392910
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392911
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 77
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 117
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 102
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246287477255447998
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392911
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392912
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 70
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 102
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 117
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246287477255447998
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392912
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 84
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 104
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 112
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 98
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 58
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 69
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 82
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 82
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 79
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 82
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246287477255447998
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193468656
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $VVM0_host_deque
    stack A $DATASTACK_PTR
    ldi A $VVM0_kbd_deque
    stack A $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $kernel_start_str_16
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $VVM0
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldm A $SIMPL_code
    sto A $_sq_
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6385587236
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6385587236
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229487724944493
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 700
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862501
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246273204308186788
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 150
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384018730
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953474141277
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392907
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6953474141277
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453544
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392907
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6385587236
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229487724944493
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246273204308186788
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 70
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 121
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 107
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 46
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 46
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 46
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384101742
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6385587236
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 17
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193468656
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $VVM1_host_deque
    stack A $DATASTACK_PTR
    ldi A $VVM1_kbd_deque
    stack A $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $kernel_start_str_17
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $VVM1
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldm A $SIMPL_code
    sto A $_sq_
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 630
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 320
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 470
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6954011327813
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229487724944493
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2000
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862336
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246273204308186788
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193468937
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193463731
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 999
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453544
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392907
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392907
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392908
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392908
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862267
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392909
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392909
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453544
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453544
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193463525
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 151
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384018730
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229487724944493
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246273204308186788
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 296346319039047833156784
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 68
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 67
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 104
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 115
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 99
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 112
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 108
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 92
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952619929349
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384101742
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6954011327813
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 13
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 14
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193468656
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $VVM2_host_deque
    stack A $DATASTACK_PTR
    ldi A $VVM2_kbd_deque
    stack A $DATASTACK_PTR
    ldi A $VVM2
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $kernel_start_str_18
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $VVM2
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldm A $SIMPL_code
    sto A $_sq_
    ldi A 210689093125
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 69
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 116
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 97
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 110
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 117
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 109
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 98
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 114
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6952740020789
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193491638
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384101742
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193491638
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862501
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392907
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229465800356332
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210711392907
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470255
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193491638
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384520640
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193470255
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193491638
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 229465800356332
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193468656
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $VVM3_host_deque
    stack A $DATASTACK_PTR
    ldi A $VVM3_kbd_deque
    stack A $DATASTACK_PTR
    ldi A $VVM3
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $kernel_start_str_19
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $VVM3
    stack A $DATASTACK_PTR
    call @rt_print_tos
    stack Z $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.start
    ldi A $kernel_start_str_20
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 4
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $KERNEL_proces_list
    stack Z $DATASTACK_PTR
    ldm A $VVM0
    stack A $DATASTACK_PTR
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.put
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $KERNEL_number_of_processes
    ld A Z
    sto A $KERNEL_current_process
    ldi A 1
    ld B A
    ldm A $p_watch_list
    add A B
    sto A $current_watch
    ldm I $p_currentime
    ldx A $_start_memory_
    ld B A
    ldm I $current_watch
    stx B $_start_memory_
:kernel_start_while_start_6
    ldm A $KERNEL_number_of_processes
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_while_end_6
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_end_28
    ldm A $new_input_flag
    tst A 0
    jmpt :kernel_start_if_end_29
    ld A Z
    sto A $new_input_flag
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.tail
    call @DEQUE.value
    ustack A $DATASTACK_PTR
    sto A $_waiting_VVM
    stack A $DATASTACK_PTR
    ldm A $kbd_prompts
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_30
    ldm A $_waiting_VVM
    stack A $DATASTACK_PTR
    ldm A $kbd_prompts
    stack A $DATASTACK_PTR
    call @DICT.get

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        jmp :kernel_start_if_end_30
:kernel_start_if_else_30
    ldi A $kernel_start_str_21
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :kernel_start_if_end_30
:kernel_start_if_end_29
    call @POLLline
    ustack A $DATASTACK_PTR
    sto A $_binnengekomen_regel
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_end_31
    ldm A $_binnengekomen_regel
    sto A $_rpn_input_ptr
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_32
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_wachtende_vvm
    ldi A 1
    sto A $new_input_flag
    ldi A 48
    stack A $DATASTACK_PTR
    ldi A $_wachtende_vvm
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_target_kbd_dq
    ld A Z
    sto A $_tokens_geleverd
:kernel_start_while_start_7
    ldm A $_rpn_input_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_while_end_7
    ldm A $_rpn_input_ptr
    stack A $DATASTACK_PTR
    ldi A 32
    stack A $DATASTACK_PTR
    call @TOKENIZE
    ustack A $DATASTACK_PTR
    sto A $_rpn_input_ptr
    call @rt_dup
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_33
    call @rt_drop
    jmp :kernel_start_if_end_33
:kernel_start_if_else_33
    call @STRatoi
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_34
    ldm A $_target_kbd_dq
    stack A $DATASTACK_PTR
    call @DEQUE.push
    jmp :kernel_start_if_end_34
:kernel_start_if_else_34
    call @STRhash
    ldm A $_target_kbd_dq
    stack A $DATASTACK_PTR
    call @DEQUE.push
:kernel_start_if_end_34
    ldm B $_tokens_geleverd
    ldi A 1
    add A B
    sto A $_tokens_geleverd
:kernel_start_if_end_33
    jmp :kernel_start_while_start_7
:kernel_start_while_end_7
    ldm A $_tokens_geleverd
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_35
    ldi A 1
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldi A $_wachtende_vvm
    stack A $DATASTACK_PTR
    call @VVMpoke
    jmp :kernel_start_if_end_35
:kernel_start_if_else_35
    ldm A $_wachtende_vvm
    stack A $DATASTACK_PTR
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.push
:kernel_start_if_end_35
    jmp :kernel_start_if_end_32
:kernel_start_if_else_32
    ldi A $kernel_start_str_22
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :kernel_start_if_end_32
:kernel_start_if_end_31
:kernel_start_if_end_28
    ldm A $KERNEL_current_process
    stack A $DATASTACK_PTR
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.item
    call @rt_drop
    ustack A $DATASTACK_PTR
    sto A $KERNEL_current_ptr
    stack Z $DATASTACK_PTR
    ldi A $KERNEL_current_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_proc_status
    ldi A 300
    ld B A
    ldm A $KERNEL_number_of_processes
    dmod B A
    ld A B
    sto A $KERNEL_current_burst
    stack Z $DATASTACK_PTR
    ldi A $KERNEL_current_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_36
    ldm A $_proc_status
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_end_37
    ldm A $KERNEL_current_burst
    stack A $DATASTACK_PTR
    ldi A $KERNEL_current_ptr
    stack A $DATASTACK_PTR
    call @VVM.runbatch
    stack Z $DATASTACK_PTR
    ldi A $KERNEL_current_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_end_38
    ldi A $KERNEL_current_ptr
    stack A $DATASTACK_PTR
    call @VVM.check_syscalls
:kernel_start_if_end_38
:kernel_start_if_end_37
    ldm B $KERNEL_current_process
    ldi A 1
    add A B
    sto A $KERNEL_current_process
    stack A $DATASTACK_PTR
    ldm A $KERNEL_number_of_processes
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_end_39
    ld A Z
    sto A $KERNEL_current_process
:kernel_start_if_end_39
    jmp :kernel_start_if_end_36
:kernel_start_if_else_36
    ldm A $KERNEL_current_ptr
    stack A $DATASTACK_PTR
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.remove
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $KERNEL_number_of_processes
    ldm A $KERNEL_current_process
    stack A $DATASTACK_PTR
    ldm A $KERNEL_number_of_processes
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_end_40
    ld A Z
    sto A $KERNEL_current_process
:kernel_start_if_end_40
:kernel_start_if_end_36
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $KERNEL_number_of_processes
    jmp :kernel_start_while_start_6
:kernel_start_while_end_6
    ldi A 1
    ld B A
    ldm A $p_watch_list
    add A B
    sto A $current_watch
    ldm I $p_currentime
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm I $current_watch
    ldx A $_start_memory_
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @TIME.as_string
    ret

# .DATA
% $VVM0 30720
% $VVM1 31744
% $VVM2 32768
% $VVM3 33792
% $VVM0_host_deque 0
% $VVM1_host_deque 0
% $VVM2_host_deque 0
% $VVM3_host_deque 0
% $VVM0_kbd_deque 0
% $VVM1_kbd_deque 0
% $VVM2_kbd_deque 0
% $VVM3_kbd_deque 0
% $SIMPL_code 0
% $KERNEL_slots 4
% $KERNEL_proces_list 0
% $KERNEL_number_of_processes 0
% $KERNEL_current_process 0
% $KERNEL_current_ptr 0
% $KERNEL_current_burst 50
% $KERNEL_disk_is_mounted 0
% $_binnengekomen_regel 0
% $_wachtende_vvm 0
% $_target_kbd_dq 0
% $_rpn_input_ptr 0
% $_tokens_geleverd 0
% $_active_count 0
% $_target_vvm 0
% $_main_str_0 \Return \W \e \l \k \o \m \space \b \i \j \space \S \t \e \r \n \- \A \T \X \space \m \u \l \t \i \t \a \s \k \i \n \g \space \k \e \r \n \e \l \space \p \r \o \j \e \c \t \Return \Return \null
% $host_proc_list_str_1 \Return \S \l \o \t \space \space \space \V \V \M \- \A \d \r \e \s \space \space \space \S \t \a \t \u \s \Return \null
% $host_proc_list_str_2 \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \Return \null
% $host_proc_list_str_3 \space \null
% $host_proc_list_str_4 \space \space \space \space \space \null
% $host_proc_list_str_5 \space \space \space \space \space \space \space \null
% $host_proc_list_str_6 \R \U \N \N \I \N \G \Return \null
% $host_proc_list_str_7 \S \Y \S \_ \C \A \L \L \Return \null
% $host_proc_list_str_8 \I \D \L \E \Return \null
% $host_proc_list_str_9 \E \R \R \O \R \Return \null
% $host_proc_list_str_10 \H \A \L \T \E \D \Return \null
% $host_proc_list_str_11 \W \A \I \T \_ \I \O \Return \null
% $host_proc_list_str_12 \Return \null
% $_reg_idx 0
% $_load_slot 0
% $_load_hash 0
% $_resolved_filename_ptr 0
% $kernel_buf_idx 0
% $_poll_loop_continue 0
% $kernel_start_str_13 \D \e \q \u \e \space \P \o \o \l \space \i \n \i \t \i \a \l \i \z \e \d \space \( \s \i \z \e \space \5 \0 \) \. \Return \Return \null
% $kernel_start_str_14 \V \V \M \space \E \n \v \i \r \o \n \m \e \n \t \space \I \n \i \t \i \a \l \i \z \e \d \! \! \Return \null
% $kernel_start_str_15 \V \V \M \space \L \o \a \d \i \n \g \space \s \l \o \t \s \. \. \. \. \Return \Return \null
% $kernel_start_str_16 \S \L \O \T \space \0 \: \space \c \l \i \space \space \space \space \I \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \@ \null
% $kernel_start_str_17 \S \L \O \T \space \1 \: \space \f \l \y \space \space \space \space \I \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \@ \null
% $kernel_start_str_18 \S \L \O \T \space \2 \: \space \c \h \a \o \s \3 \space \I \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \@ \null
% $kernel_start_str_19 \S \L \O \T \space \3 \: \space \f \i \b \space \space \space \space \I \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \@ \null
% $kernel_start_str_20 \Return \C \L \I \space \s \t \a \r \t \e \d \space \Return \null
% $kernel_start_str_21 \> \space \null
% $kernel_start_str_22 \K \e \r \n \e \l \: \space \I \n \v \o \e \r \space \g \e \n \e \g \e \e \r \d \, \space \g \e \e \n \space \w \a \c \h \t \e \n \d \space \p \r \o \c \e \s \. \Return \null
