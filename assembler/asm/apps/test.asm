# .HEADER
. $VVM0 1
. $VVM1 1
. $host_comm_deque_ptr 1
. $SIMPL_code 1
. $main_str_0 29
. $host_comm_deque_ptr0 1
. $host_comm_deque_ptr1 1
. $main_str_1 30
. $main_str_2 30
. $main_str_3 30
. $_sq_ 1
. $main_str_4 24
. $main_str_5 24
. $main_str_6 15
. $main_str_7 15

# .CODE
    call @main
    ret

# .FUNCTIONS
@main
    ldm A $HEAP_START
    sto A $HEAP_FREE
    ldi A 50
    stack A $DATASTACK_PTR
    call @DEQUE.init_pool
    ldi A $main_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $host_comm_deque_ptr0
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $host_comm_deque_ptr1
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $SIMPL_code
    call @VVM.init
    ldi A $main_str_1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $main_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $VVM0
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $main_str_3
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
    ldi A 229487724944494
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
    ldi A 8246273204308186789
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
    ldi A 6383922049
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193492531
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
    ldi A 229487724944494
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 8246273204308186789
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
    ldi A 193492531
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
    stack Z $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5862552
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
    ldi A 6384520640
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384375937
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193463525
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
    ldi A 6383976602
    stack A $DATASTACK_PTR
    ldm A $_sq_
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193468656
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
    ldi A $host_comm_deque_ptr0
    stack A $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $main_str_4
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
    ldi A $host_comm_deque_ptr1
    stack A $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $main_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.start
    ldi A $main_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.start
    ldi A $main_str_7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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
:main_while_start_0
    stack Z $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    stack Z $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add A B
    tst A 0
    jmpt :main_while_end_0
    stack Z $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_0
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.run
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.check_syscalls
:main_if_end_0
    stack Z $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_1
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.run
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.check_syscalls
:main_if_end_1
    jmp :main_while_start_0
:main_while_end_0
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
% $host_comm_deque_ptr 0
% $SIMPL_code 0
% $main_str_0 \P \o \o \l \space \i \n \i \t \i \a \l \i \z \e \d \space \( \s \i \z \e \space \5 \0 \) \. \Return \null
% $main_str_1 \V \V \M \space \E \n \v \i \r \o \n \m \e \n \t \space \I \n \i \t \i \a \l \i \z \e \d \: \Return \null
% $main_str_2 \V \V \M \0 \space \b \a \s \e \space \a \d \d \r \e \s \s \space \space \space \space \space \space \space \space \space \space \: \space \null
% $main_str_3 \V \V \M \1 \space \b \a \s \e \space \a \d \d \r \e \s \s \space \space \space \space \space \space \space \space \space \space \: \space \null
% $main_str_4 \V \V \M \0 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \null
% $main_str_5 \V \V \M \1 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \null
% $main_str_6 \V \V \M \0 \space \s \t \a \r \t \e \d \space \Return \null
% $main_str_7 \V \V \M \1 \space \s \t \a \r \t \e \d \space \Return \null
