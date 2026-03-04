# .HEADER
. $net_tx_buffer 1
. $nic_addr_ptr 1
. $_ns_len 1
. $_ns_payload 1
. $_ns_port 1
. $_ns_dest 1
. $_ns_total_len 1
. $_ns_src 1
. $_ns_i 1
. $my_inbox 1
. $my_payload 1
. $_loops 1
. $_pkt 1
. $_len 1
. $_i 1
. $_success 1
. $main_str_0 26
. $main_str_1 26
. $main_str_2 25
. $main_str_3 18
. $main_str_4 10
. $main_str_5 2
. $main_str_6 30

# .CODE
    call @main
    ret

# .FUNCTIONS

@NET_LIB.init
    ldi A 256
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $net_tx_buffer

        ldi I ~SYS_NET_GET_ADDR
        int $INT_VECTORS
        ldm A $SYSCALL_RETURN_VALUE
        sto A $nic_addr_ptr
        ret
@_net_write_word

        ustack C $DATASTACK_PTR ; Index
        ustack B $DATASTACK_PTR ; Buffer Ptr (Array Struct)
        ustack A $DATASTACK_PTR ; Value
        
        # Calculate Base Address: Ptr + 2 (Data Start) + Index
        addi B 2
        add B C 
        
        ld I B
        stx A $_start_memory_
        ret
@_net_write_32

        ustack C $DATASTACK_PTR ; Index
        ustack B $DATASTACK_PTR ; Buffer Ptr (Array Struct)
        ustack A $DATASTACK_PTR ; Value
        
        # Calculate Base Address: Ptr + 2 (Data Start) + Index
        addi B 2
        add B C 
        
        # Use repeated division by 256 to extract bytes (Big Endian)
        # K = Value, M = 256
        ld K A
        ldi M 256
        
        # Setup I to point to the last byte (Base + 3)
        ld I B
        addi I 3
        
        # Byte 3 (LSB): Value % 256
        ld A M          ; A = 256
        dmod K A        ; K = K / 256, A = K % 256
        stx A $_start_memory_
        subi I 1
        
        # Byte 2: (Value >> 8) % 256
        ld A M
        dmod K A
        stx A $_start_memory_
        subi I 1
        
        # Byte 1: (Value >> 16) % 256
        ld A M
        dmod K A
        stx A $_start_memory_
        subi I 1
        
        # Byte 0 (MSB): (Value >> 24)
        stx K $_start_memory_
        ret
@NET.bind_service

        ldi I ~SYS_NET_BIND
        int $INT_VECTORS
        ret
@NET.send_packet
    ustack A $DATASTACK_PTR
    sto A $_ns_len
    ustack A $DATASTACK_PTR
    sto A $_ns_payload
    ustack A $DATASTACK_PTR
    sto A $_ns_port
    ustack A $DATASTACK_PTR
    sto A $_ns_dest
    ldm A $_ns_len
    stack A $DATASTACK_PTR
    ldi A 239
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NET.send_packet_if_else_0
    stack Z $DATASTACK_PTR
    jmp :NET.send_packet_if_end_0
:NET.send_packet_if_else_0
    ldm B $_ns_len
    ldi A 16
    add A B
    sto A $_ns_total_len
    stack A $DATASTACK_PTR
    ldm A $net_tx_buffer
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @_net_write_word
    ldm A $_ns_dest
    stack A $DATASTACK_PTR
    ldm A $net_tx_buffer
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @_net_write_32
    ldm I $nic_addr_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm A $net_tx_buffer
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @_net_write_32
    ldm A $_ns_port
    stack A $DATASTACK_PTR
    ldm A $net_tx_buffer
    stack A $DATASTACK_PTR
    ldi A 9
    stack A $DATASTACK_PTR
    call @_net_write_32
    stack Z $DATASTACK_PTR
    ldm A $net_tx_buffer
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @_net_write_32
    ld A Z
    sto A $_ns_i
:NET.send_packet_while_start_0
    ldm A $_ns_i
    stack A $DATASTACK_PTR
    ldm A $_ns_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NET.send_packet_while_end_0
    ldm A $_ns_i
    stack A $DATASTACK_PTR
    ldm A $_ns_payload
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldm A $net_tx_buffer
    stack A $DATASTACK_PTR
    ldm B $_ns_i
    ldi A 17
    add B A
    stack B $DATASTACK_PTR
    call @_net_write_word
    ldm B $_ns_i
    ldi A 1
    add A B
    sto A $_ns_i
    jmp :NET.send_packet_while_start_0
:NET.send_packet_while_end_0
    ldm B $net_tx_buffer
    ldi A 2
    add B A
    stack B $DATASTACK_PTR

            ldi I ~SYS_NET_SEND
            int $INT_VECTORS
        :NET.send_packet_if_end_0
    ret
@NET.poll

        ldi I ~SYS_NET_RECV
        int $INT_VECTORS
        ldm A $SYSCALL_RETURN_VALUE
        stack A $DATASTACK_PTR
        ret

@_NET.free_buffer
    call @NET.free_buffer
    ret
@main
    ldm A $HEAP_START
    sto A $HEAP_FREE
    ldi A 32
    stack A $DATASTACK_PTR
    call @DEQUE.init_pool
    ldi A $main_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @NET_LIB.init
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $my_inbox
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $my_inbox
    stack A $DATASTACK_PTR
    call @NET.bind_service
    ldi A $main_str_1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 10
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $my_payload
    ldi A 72
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 69
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 76
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 76
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 79
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 32
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 78
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 105
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 99
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 107
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 1
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $my_payload
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @NET.send_packet
    call @rt_drop
    ldi A $main_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ld A Z
    sto A $_loops
:main_while_start_0
    ldm A $_loops
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_while_end_0
    call @NET.poll
    call @rt_drop
    ldm A $my_inbox
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_0
    ldi A $main_str_3
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $my_inbox
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_pkt
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $_len
    ldi A $main_str_4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ld A Z
    sto A $_i
:main_while_start_1
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm B $_len
    ldi A 16
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_while_end_1
    ldm B $_i
    ldi A 16
    add B A
    stack B $DATASTACK_PTR
    ldm A $_pkt
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @PRTchar
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :main_while_start_1
:main_while_end_1
    ldi A $main_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_pkt
    stack A $DATASTACK_PTR
    call @_NET.free_buffer
    ldi A 1
    sto A $_success
    ldi A 150
    sto A $_loops
:main_if_end_0
    ldm B $_loops
    ldi A 1
    add A B
    sto A $_loops
    jmp :main_while_start_0
:main_while_end_0
    ldm A $_success
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_1
    ldi A $main_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :main_if_end_1
    ret

# .DATA

% $net_tx_buffer 0
% $nic_addr_ptr 0
% $_ns_len 0
% $_ns_payload 0
% $_ns_port 0
% $_ns_dest 0
% $_ns_total_len 0
% $_ns_src 0
% $_ns_i 0
% $my_inbox 0
% $my_payload 0
% $_loops 0
% $_pkt 0
% $_len 0
% $_i 0
% $_success 0
% $main_str_0 \S \t \a \r \t \i \n \g \space \N \e \t \w \o \r \k \space \T \e \s \t \. \. \. \Return \null
% $main_str_1 \B \o \u \n \d \space \P \o \r \t \space \1 \0 \0 \space \t \o \space \I \n \b \o \x \. \Return \null
% $main_str_2 \P \a \c \k \e \t \space \S \e \n \t \. \space \P \o \l \l \i \n \g \. \. \. \Return \null
% $main_str_3 \P \a \c \k \e \t \space \R \e \c \e \i \v \e \d \! \Return \null
% $main_str_4 \P \a \y \l \o \a \d \: \space \null
% $main_str_5 \Return \null
% $main_str_6 \T \i \m \e \o \u \t \: \space \N \o \space \p \a \c \k \e \t \space \r \e \c \e \i \v \e \d \. \Return \null
