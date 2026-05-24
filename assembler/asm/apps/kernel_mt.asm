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
. $_main_str_0 52
. $kernel_start_str_1 29
. $kernel_start_str_2 30
. $kernel_start_str_3 30
. $kernel_start_str_4 30
. $_sq_ 1
. $kernel_start_str_5 25
. $kernel_start_str_6 25
. $kernel_start_str_7 15
. $kernel_start_str_8 15
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
    ldi A 42
    stack A $DATASTACK_PTR
    ldm A $VVM0_kbd_deque
    stack A $DATASTACK_PTR
    call @DEQUE.push
    ldi A 43
    stack A $DATASTACK_PTR
    ldm A $VVM1_kbd_deque
    stack A $DATASTACK_PTR
    call @DEQUE.push
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
    ldi A 1500
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
:kernel_start_while_start_1
    ldm A $KERNEL_number_of_processes
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :kernel_start_while_end_1
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
    jmpt :kernel_start_if_else_0
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
    jmpt :kernel_start_if_end_1
    ldi A $KERNEL_current_ptr
    stack A $DATASTACK_PTR
    call @VVM.check_syscalls
:kernel_start_if_end_1
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
    jmpt :kernel_start_if_end_2
    ld A Z
    sto A $KERNEL_current_process
:kernel_start_if_end_2
    jmp :kernel_start_if_end_0
:kernel_start_if_else_0
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
    jmpt :kernel_start_if_end_3
    ld A Z
    sto A $KERNEL_current_process
:kernel_start_if_end_3
:kernel_start_if_end_0
    ldm A $KERNEL_proces_list
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $KERNEL_number_of_processes
    jmp :kernel_start_while_start_1
:kernel_start_while_end_1
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
% $_main_str_0 \Return \W \e \l \k \o \m \space \b \i \j \space \S \t \e \r \n \- \A \T \X \space \m \u \l \t \i \t \a \s \k \i \n \g \space \k \e \r \n \e \l \space \p \r \o \j \e \c \t \Return \Return \null
% $kernel_start_str_1 \P \o \o \l \space \i \n \i \t \i \a \l \i \z \e \d \space \( \s \i \z \e \space \5 \0 \) \. \Return \null
% $kernel_start_str_2 \V \V \M \space \E \n \v \i \r \o \n \m \e \n \t \space \I \n \i \t \i \a \l \i \z \e \d \: \Return \null
% $kernel_start_str_3 \V \V \M \0 \space \b \a \s \e \space \a \d \d \r \e \s \s \space \space \space \space \space \space \space \space \space \space \: \space \null
% $kernel_start_str_4 \V \V \M \1 \space \b \a \s \e \space \a \d \d \r \e \s \s \space \space \space \space \space \space \space \space \space \space \: \space \null
% $kernel_start_str_5 \V \V \M \0 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \Return \null
% $kernel_start_str_6 \V \V \M \1 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \Return \null
% $kernel_start_str_7 \V \V \M \0 \space \s \t \a \r \t \e \d \space \Return \null
% $kernel_start_str_8 \V \V \M \1 \space \s \t \a \r \t \e \d \space \Return \null
