# .HEADER
. $VVM0 1
. $VVM1 1
. $VVM0_host_deque 1
. $VVM1_host_deque 1
. $VVM0_kbd_deque 1
. $VVM1_kbd_deque 1
. $SIMPL_code 1
. $KERNEL_proces_list 1
. $KERNEL_number_of_processes 1
. $KERNEL_current_process 1
. $KERNEL_current_ptr 1
. $_binnengekomen_regel 1
. $_wachtende_vvm 1
. $_target_kbd_dq 1
. $_rpn_input_ptr 1
. $_tokens_geleverd 1
. $_main_str_0 52
. $kernel_input_buffer 80
. $kernel_buf_idx 1
. $_poll_loop_continue 1
. $_result_buffer_ptr 1
. $_ingedrukt_karakter 1
. $_term_ptr 1
. $_write_ptr 1
. $kernel_start_str_1 29
. $kernel_start_str_2 30
. $kernel_start_str_3 30
. $kernel_start_str_4 30
. $_sq_ 1
. $kernel_start_str_5 25
. $kernel_start_str_6 25
. $kernel_start_str_7 15
. $kernel_start_str_8 15
. $new_input_flag 1
. $kernel_start_str_9 3
. $kernel_start_str_10 49
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
@POLLline

        ldi I ~SYS_PRINT_CURSOR
        int $INT_VECTORS
    ld A Z
    sto A $_result_buffer_ptr
    ldi A 1
    sto A $_poll_loop_continue
:POLLline_while_start_1
    ldm A $_poll_loop_continue
    tst A 0
    jmpt :POLLline_while_end_1
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :POLLline_if_else_0
    ustack A $DATASTACK_PTR
    sto A $_ingedrukt_karakter
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :POLLline_if_else_1
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
    jmp :POLLline_if_end_1
:POLLline_if_else_1
    ldm A $_ingedrukt_karakter
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :POLLline_if_else_2
    ldm A $kernel_buf_idx
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :POLLline_if_end_3
    call @CURSORoff
    ldm A $_ingedrukt_karakter
    stack A $DATASTACK_PTR
    call @PRTchar
    ldm B $kernel_buf_idx
    ldi A 1
    sub B A
    ld A B
    sto A $kernel_buf_idx
:POLLline_if_end_3
    jmp :POLLline_if_end_2
:POLLline_if_else_2
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
:POLLline_if_end_2
:POLLline_if_end_1
    jmp :POLLline_if_end_0
:POLLline_if_else_0
    ld A Z
    sto A $_poll_loop_continue
:POLLline_if_end_0
    jmp :POLLline_while_start_1
:POLLline_while_end_1
    ldm A $_result_buffer_ptr
    stack A $DATASTACK_PTR
    ret
@kernel_start
    ldm A $HEAP_START
    sto A $HEAP_FREE
    ldi A 50
    stack A $DATASTACK_PTR
    call @DEQUE.init_pool
    ldi A $kernel_start_str_1
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
    sto A $VVM0_kbd_deque
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM1_kbd_deque
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $SIMPL_code
    call @VVM.init
    ldi A $kernel_start_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $kernel_start_str_3
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $VVM0
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $kernel_start_str_4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $VVM1
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A @host_gcd
    stack A $DATASTACK_PTR
    ldi A 101
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldm A $SIMPL_code
    sto A $_sq_
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
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193496300
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
    ldi A 210689093125
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
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 100
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
    ldi A 101
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
    ldi A $kernel_start_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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
    ldi A 500
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
    ldi A 16
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
    ldi A 15
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
    ldi A 15
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
    ldi A 25
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193463525
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
    ldi A 210711392910
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
    ldi A 18
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
    ldi A $VVM1_host_deque
    stack A $DATASTACK_PTR
    ldi A $VVM1_kbd_deque
    stack A $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $kernel_start_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.start
    ldi A $kernel_start_str_7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.start
    ldi A $kernel_start_str_8
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
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $VVM1
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
:kernel_start_while_start_2
    ldm A $KERNEL_number_of_processes
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_while_end_2
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_end_4
    ldm A $new_input_flag
    tst A 0
    jmpt :kernel_start_if_end_5
    ld A Z
    sto A $new_input_flag
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.tail
    call @PRTnum
    ldi A $kernel_start_str_9
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :kernel_start_if_end_5
    call @POLLline
    ustack A $DATASTACK_PTR
    sto A $_binnengekomen_regel
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_end_6
    ldm A $_binnengekomen_regel
    sto A $_rpn_input_ptr
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_7
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
:kernel_start_while_start_3
    ldm A $_rpn_input_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_while_end_3
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
    jmpt :kernel_start_if_else_8
    call @rt_drop
    jmp :kernel_start_if_end_8
:kernel_start_if_else_8
    call @STRatoi
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_9
    ldm A $_target_kbd_dq
    stack A $DATASTACK_PTR
    call @DEQUE.push
    jmp :kernel_start_if_end_9
:kernel_start_if_else_9
    call @STRhash
    ldm A $_target_kbd_dq
    stack A $DATASTACK_PTR
    call @DEQUE.push
:kernel_start_if_end_9
    ldm B $_tokens_geleverd
    ldi A 1
    add A B
    sto A $_tokens_geleverd
:kernel_start_if_end_8
    jmp :kernel_start_while_start_3
:kernel_start_while_end_3
    ldm A $_tokens_geleverd
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_10
    ldi A 1
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldi A $_wachtende_vvm
    stack A $DATASTACK_PTR
    call @VVMpoke
    jmp :kernel_start_if_end_10
:kernel_start_if_else_10
    ldm A $_wachtende_vvm
    stack A $DATASTACK_PTR
    ldm A $kbd_req_queue
    stack A $DATASTACK_PTR
    call @DEQUE.push
:kernel_start_if_end_10
    jmp :kernel_start_if_end_7
:kernel_start_if_else_7
    ldi A $kernel_start_str_10
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :kernel_start_if_end_7
:kernel_start_if_end_6
:kernel_start_if_end_4
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
    stack Z $DATASTACK_PTR
    ldi A $KERNEL_current_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_else_11
    ldm A $_proc_status
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_if_end_12
    ldi A 10
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
    jmpt :kernel_start_if_end_13
    ldi A $KERNEL_current_ptr
    stack A $DATASTACK_PTR
    call @VVM.check_syscalls
:kernel_start_if_end_13
:kernel_start_if_end_12
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
    jmpt :kernel_start_if_end_14
    ld A Z
    sto A $KERNEL_current_process
:kernel_start_if_end_14
    jmp :kernel_start_if_end_11
:kernel_start_if_else_11
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
    jmpt :kernel_start_if_end_15
    ld A Z
    sto A $KERNEL_current_process
:kernel_start_if_end_15
:kernel_start_if_end_11
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $KERNEL_number_of_processes
    jmp :kernel_start_while_start_2
:kernel_start_while_end_2
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
% $VVM0_host_deque 0
% $VVM1_host_deque 0
% $VVM0_kbd_deque 0
% $VVM1_kbd_deque 0
% $SIMPL_code 0
% $KERNEL_proces_list 0
% $KERNEL_number_of_processes 0
% $KERNEL_current_process 0
% $KERNEL_current_ptr 0
% $_binnengekomen_regel 0
% $_wachtende_vvm 0
% $_target_kbd_dq 0
% $_rpn_input_ptr 0
% $_tokens_geleverd 0
% $_main_str_0 \Return \W \e \l \k \o \m \space \b \i \j \space \S \t \e \r \n \- \A \T \X \space \m \u \l \t \i \t \a \s \k \i \n \g \space \k \e \r \n \e \l \space \p \r \o \j \e \c \t \Return \Return \null
% $kernel_buf_idx 0
% $_poll_loop_continue 0
% $kernel_start_str_1 \P \o \o \l \space \i \n \i \t \i \a \l \i \z \e \d \space \( \s \i \z \e \space \5 \0 \) \. \Return \null
% $kernel_start_str_2 \V \V \M \space \E \n \v \i \r \o \n \m \e \n \t \space \I \n \i \t \i \a \l \i \z \e \d \: \Return \null
% $kernel_start_str_3 \V \V \M \0 \space \b \a \s \e \space \a \d \d \r \e \s \s \space \space \space \space \space \space \space \space \space \space \: \space \null
% $kernel_start_str_4 \V \V \M \1 \space \b \a \s \e \space \a \d \d \r \e \s \s \space \space \space \space \space \space \space \space \space \space \: \space \null
% $kernel_start_str_5 \V \V \M \0 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \Return \null
% $kernel_start_str_6 \V \V \M \1 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \Return \null
% $kernel_start_str_7 \V \V \M \0 \space \s \t \a \r \t \e \d \space \Return \null
% $kernel_start_str_8 \V \V \M \1 \space \s \t \a \r \t \e \d \space \Return \null
% $new_input_flag 1
% $kernel_start_str_9 \> \space \null
% $kernel_start_str_10 \K \e \r \n \e \l \: \space \I \n \v \o \e \r \space \g \e \n \e \g \e \e \r \d \, \space \g \e \e \n \space \w \a \c \h \t \e \n \d \space \p \r \o \c \e \s \. \Return \null
