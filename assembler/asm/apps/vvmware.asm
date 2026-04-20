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
. $main_str_4 8
. $main_str_5 25
. $main_str_6 11
. $main_str_7 25
. $main_str_8 15
. $main_str_9 15

# .CODE
    call @main
    ret

# .FUNCTIONS
@host_function
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ret
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
    ldi A @host_function
    stack A $DATASTACK_PTR
    ldi A 100
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @host_gcd
    stack A $DATASTACK_PTR
    ldi A 101
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A $main_str_4
    stack A $DATASTACK_PTR
    call @VVM.loadcode
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $host_comm_deque_ptr0
    stack A $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $main_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A $main_str_6
    stack A $DATASTACK_PTR
    call @VVM.loadcode
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $host_comm_deque_ptr1
    stack A $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $main_str_7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.start
    ldi A $main_str_8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.start
    ldi A $main_str_9
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
:main_while_start_1
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
    jmpt :main_while_end_1
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
    call @VVM.run
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
    call @VVM.run
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.run
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.check_syscalls
:main_if_end_1
    jmp :main_while_start_1
:main_while_end_1
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
% $main_str_4 \s \b \c \_ \f \l \y \null
% $main_str_5 \V \V \M \0 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \Return \null
% $main_str_6 \s \b \c \_ \c \h \a \o \s \3 \null
% $main_str_7 \V \V \M \1 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \Return \null
% $main_str_8 \V \V \M \0 \space \s \t \a \r \t \e \d \space \Return \null
% $main_str_9 \V \V \M \1 \space \s \t \a \r \t \e \d \space \Return \null
