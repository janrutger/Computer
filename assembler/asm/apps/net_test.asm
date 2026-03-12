# .HEADER
. $_send_buffer 256
. $_read_deque 1
. $_user_buf 1
. $_user_buf_len 1
. $_kern_pkt 1
. $_payload_len 1
. $_tmp_ptr 1
. $_total_len 1
. $_copy_len 1
. $_user_buf_data_ptr 1
. $_ri 1
. $_src 1
. $_dst 1
. $_user_buf_count_ptr 1
. $_str_ptr 1
. $_src_port 1
. $_dest_port 1
. $_dest_id 1
. $_char_ptr 1
. $my_inbox 1
. $message_ptr 1
. $print_message_str_0 26
. $data_ptr 1
. $tmp_ptr 1
. $print_message_str_1 17
. $print_message_str_2 17
. $print_message_str_3 17
. $print_message_str_4 17
. $message_len 1
. $print_message_str_5 17
. $mes_load_ptr 1
. $temp_ptr 1
. $print_message_str_6 27
. $main_str_7 41
. $main_str_8 66
. $main_str_9 40
. $testmessage 17
. $main_str_10 42
. $main_str_11 36
. $message 1
. $retry_count 1
. $read_success 1
. $main_str_12 40
. $main_str_13 46

# .CODE
    call @main
    ret

# .FUNCTIONS

@SOCKET.init

        ldi I ~SYS_NET_CONFIG ; syscall 65
        int $INT_VECTORS
        ret
@SOCKET.read
    ustack A $DATASTACK_PTR
    sto A $_read_deque
    ustack A $DATASTACK_PTR
    sto A $_user_buf
    ldm I $_user_buf
    ldx A $_start_memory_
    sto A $_user_buf_len

        ldi I ~SYS_NET_RECV
        int $INT_VECTORS
        ldm A $_read_deque
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.read_if_else_0
    stack Z $DATASTACK_PTR
    jmp :SOCKET.read_if_end_0
:SOCKET.read_if_else_0
    ldm A $_read_deque
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_kern_pkt
    ld B A
    ldi A 3
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    sto A $_payload_len
    ld B A
    ldi A 4
    add A B
    sto A $_total_len
    sto A $_copy_len
    stack A $DATASTACK_PTR
    ldm A $_user_buf_len
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.read_if_end_1
    ldm A $_user_buf_len
    sto A $_copy_len
:SOCKET.read_if_end_1
    ldm B $_user_buf
    ldi A 2
    add A B
    sto A $_user_buf_data_ptr
    ld A Z
    sto A $_ri
:SOCKET.read_while_start_0
    ldm A $_ri
    stack A $DATASTACK_PTR
    ldm A $_copy_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.read_while_end_0
    ldm B $_kern_pkt
    ldm A $_ri
    add A B
    sto A $_src
    ldm B $_user_buf_data_ptr
    ldm A $_ri
    add A B
    sto A $_dst
    ldm I $_src
    ldx A $_start_memory_
    ld B A
    ldm I $_dst
    stx B $_start_memory_
    ldm B $_ri
    ldi A 1
    add A B
    sto A $_ri
    jmp :SOCKET.read_while_start_0
:SOCKET.read_while_end_0
    ldm A $_kern_pkt
    stack A $DATASTACK_PTR
 
            ldi I ~SYS_NET_FREE 
            int $INT_VECTORS 
    ldm B $_user_buf
    ldi A 1
    add A B
    sto A $_user_buf_count_ptr
    ldm A $_copy_len
    ld B A
    ldm I $_user_buf_count_ptr
    stx B $_start_memory_
    ldi A 1
    stack A $DATASTACK_PTR
:SOCKET.read_if_end_0
    ret
@SOCKET.snd_text
    ustack A $DATASTACK_PTR
    sto A $_str_ptr
    ustack A $DATASTACK_PTR
    sto A $_src_port
    ustack A $DATASTACK_PTR
    sto A $_dest_port
    ustack A $DATASTACK_PTR
    sto A $_dest_id
    ldm A $_str_ptr
    stack A $DATASTACK_PTR
    call @STRlen
    ustack A $DATASTACK_PTR
    sto A $_payload_len
    stack A $DATASTACK_PTR
    ldi A 240
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.snd_text_if_else_2
    stack Z $DATASTACK_PTR
    jmp :SOCKET.snd_text_if_end_2
:SOCKET.snd_text_if_else_2
    ldi A $_send_buffer
    sto A $_tmp_ptr
    ldm A $_dest_id
    ld B A
    ldm I $_tmp_ptr
    stx B $_start_memory_
    ldm B $_tmp_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm A $_dest_port
    ld B A
    ldm I $_tmp_ptr
    stx B $_start_memory_
    ldm B $_tmp_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm A $_src_port
    ld B A
    ldm I $_tmp_ptr
    stx B $_start_memory_
    ldm B $_tmp_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm A $_payload_len
    ld B A
    ldm I $_tmp_ptr
    stx B $_start_memory_
    ldm B $_tmp_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ld A Z
    sto A $_i
:SOCKET.snd_text_while_start_1
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_payload_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.snd_text_while_end_1
    ldm B $_str_ptr
    ldm A $_i
    add A B
    sto A $_char_ptr
    ldm I $_char_ptr
    ldx A $_start_memory_
    ld B A
    ldm I $_tmp_ptr
    stx B $_start_memory_
    ldm B $_tmp_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :SOCKET.snd_text_while_start_1
:SOCKET.snd_text_while_end_1
    ldi A $_send_buffer
    stack A $DATASTACK_PTR

            ldi I ~SYS_NET_SEND
            int $INT_VECTORS
        :SOCKET.snd_text_if_end_2
    ret
@SOCKET.bind

        ldi I ~SYS_NET_BIND ; syscall 60
        int $INT_VECTORS
        ret

@print_message
    ustack A $DATASTACK_PTR
    sto A $message_ptr
    ldi A $print_message_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ldm B $message_ptr
    ldi A 2
    add A B
    sto A $data_ptr
    ldi A $print_message_str_1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm I $data_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $print_message_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ldm B $data_ptr
    ldi A 1
    add A B
    sto A $tmp_ptr
    ldm I $tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $print_message_str_3
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ldm B $data_ptr
    ldi A 2
    add A B
    sto A $tmp_ptr
    ldm I $tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $print_message_str_4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ldm B $data_ptr
    ldi A 3
    add A B
    sto A $tmp_ptr
    ldm I $tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @rt_dup
    ustack A $DATASTACK_PTR
    sto A $message_len
    call @rt_print_tos
    ldi A $print_message_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ldm B $data_ptr
    ldi A 4
    add A B
    sto A $mes_load_ptr
    ld B A
    ldm A $message_len
    add A B
    sto A $temp_ptr
    ld B Z
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $mes_load_ptr
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $print_message_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ret
@main
    ldm A $HEAP_START
    sto A $HEAP_FREE
    ldi A 32
    stack A $DATASTACK_PTR
    call @DEQUE.init_pool
    ldi A $main_str_7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 8246931439866572030
    stack A $DATASTACK_PTR
    ldi A 128
    stack A $DATASTACK_PTR
    call @SOCKET.init
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_0
    ldi A $main_str_8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $my_inbox
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $my_inbox
    stack A $DATASTACK_PTR
    call @SOCKET.bind
    ldi A $main_str_9
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 1
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A $testmessage
    stack A $DATASTACK_PTR
    call @SOCKET.snd_text
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_1
    ldi A $main_str_10
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        jmp :main_if_end_1
:main_if_else_1
    ldi A $main_str_11
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :main_if_end_1
    ldi A 64
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $message
:main_while_start_0
    ldm A $retry_count
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_while_end_0
    ldm A $message
    stack A $DATASTACK_PTR
    ldm A $my_inbox
    stack A $DATASTACK_PTR
    call @SOCKET.read
    ustack A $DATASTACK_PTR
    sto A $read_success
    tst A 0
    jmpt :main_if_else_2
    ld A Z
    sto A $retry_count
    jmp :main_if_end_2
:main_if_else_2
    ldm B $retry_count
    ldi A 1
    sub B A
    ld A B
    sto A $retry_count

                    nop
                :main_if_end_2
    jmp :main_while_start_0
:main_while_end_0
    ldm A $read_success
    tst A 0
    jmpt :main_if_else_3
    ldi A $main_str_12
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $message
    stack A $DATASTACK_PTR
    call @print_message
    jmp :main_if_end_3
:main_if_else_3
    ldi A $main_str_13
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :main_if_end_3
:main_if_end_0
    ret

# .DATA

% $_read_deque 0
% $_user_buf 0
% $_user_buf_len 0
% $_kern_pkt 0
% $_payload_len 0
% $_tmp_ptr 0
% $_total_len 0
% $_copy_len 0
% $_user_buf_data_ptr 0
% $_ri 0
% $_src 0
% $_dst 0
% $_user_buf_count_ptr 0
% $_str_ptr 0
% $_src_port 0
% $_dest_port 0
% $_dest_id 0
% $_char_ptr 0
% $my_inbox 0
% $print_message_str_0 \- \- \- \space \R \e \c \e \i \v \e \d \space \M \e \s \s \a \g \e \space \- \- \- \Return \null
% $data_ptr 0
% $tmp_ptr 0
% $print_message_str_1 \space \space \S \o \u \r \c \e \space \I \D \space \space \space \: \space \null
% $print_message_str_2 \space \space \D \e \s \t \space \P \o \r \t \space \space \space \: \space \null
% $print_message_str_3 \space \space \S \o \u \r \c \e \space \P \o \r \t \space \: \space \null
% $print_message_str_4 \space \space \P \a \y \l \o \a \d \space \L \e \n \space \: \space \null
% $message_len 0
% $print_message_str_5 \space \space \P \a \y \l \o \a \d \space \space \space \space \space \: \space \null
% $mes_load_ptr 0
% $print_message_str_6 \Return \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \Return \null
% $main_str_7 \S \t \a \r \t \i \n \g \space \N \e \t \w \o \r \k \space \I \n \i \t \i \a \l \i \z \a \t \i \o \n \space \T \e \s \t \. \. \. \Return \null
% $main_str_8 \S \U \C \C \E \S \S \: \space \S \Y \S \_ \N \E \T \_ \C \O \N \F \I \G \space \r \e \t \u \r \n \e \d \space \1 \. \space \N \e \t \w \o \r \k \space \s \t \a \c \k \space \i \s \space \c \o \n \f \i \g \u \r \e \d \. \Return \null
% $main_str_9 \I \N \F \O \: \space \C \a \l \l \e \d \space \S \O \C \K \E \T \. \b \i \n \d \space \f \o \r \space \p \o \r \t \space \1 \0 \0 \. \Return \null
% $testmessage \H \e \l \l \o \space \W \o \r \l \d \! \! \space \4 \2 \null
% $main_str_10 \I \N \F \O \: \space \M \e \s \s \a \g \e \space \s \e \n \t \space \b \y \space \h \o \s \t \space \s \u \c \c \e \s \s \f \u \l \l \y \. \Return \null
% $main_str_11 \I \N \F \O \: \space \M \e \s \s \a \g \e \space \s \e \n \d \space \b \y \space \h \o \s \t \space \f \a \i \l \e \d \. \Return \null
% $retry_count 50
% $read_success 0
% $main_str_12 \I \N \F \O \: \space \M \e \s \s \a \g \e \space \r \e \a \d \space \b \y \space \h \o \s \t \space \s \u \c \c \e \s \s \f \u \l \. \Return \null
% $main_str_13 \I \N \F \O \: \space \M \e \s \s \a \g \e \space \r \e \a \d \space \b \y \space \h \o \s \t \space \f \a \i \l \e \d \space \( \t \i \m \e \o \u \t \) \. \Return \null
