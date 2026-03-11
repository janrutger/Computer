# .HEADER
. $_send_buffer 256
. $_str_ptr 1
. $_src_port 1
. $_dest_port 1
. $_dest_id 1
. $_tmp_ptr 1
. $_char_ptr 1
. $_payload_len 1
. $my_inbox 1
. $main_str_0 41
. $main_str_1 66
. $main_str_2 40
. $main_str_3 54
. $testmessage 12
. $main_str_4 42
. $main_str_5 38
. $main_str_6 56

# .CODE
    call @main
:break
    ret

# .FUNCTIONS

@SOCKET.init

        ldi I ~SYS_NET_CONFIG ; syscall 65
        int $INT_VECTORS
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
    jmpt :SOCKET.snd_text_if_else_0
    stack Z $DATASTACK_PTR
    jmp :SOCKET.snd_text_if_end_0
:SOCKET.snd_text_if_else_0
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
:SOCKET.snd_text_while_start_0
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_payload_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.snd_text_while_end_0
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
    jmp :SOCKET.snd_text_while_start_0
:SOCKET.snd_text_while_end_0
    ldi A $_send_buffer
    stack A $DATASTACK_PTR

            ldi I ~SYS_NET_SEND
            int $INT_VECTORS
        :SOCKET.snd_text_if_end_0
    ret
@SOCKET.bind

        ldi I ~SYS_NET_BIND ; syscall 60
        int $INT_VECTORS
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
        ldi A 8246931439866572030
    stack A $DATASTACK_PTR
    ldi A 128
    stack A $DATASTACK_PTR
    call @SOCKET.init
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_0
    ldi A $main_str_1
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
    ldi A $main_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $main_str_3
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 8246931439866572030
    stack A $DATASTACK_PTR
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
    ldi A $main_str_4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        jmp :main_if_end_1
:main_if_else_1
    ldi A $main_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :main_if_end_1
    jmp :main_if_end_0
:main_if_else_0
    ldi A $main_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :main_if_end_0
    ret

# .DATA

% $_str_ptr 0
% $_src_port 0
% $_dest_port 0
% $_dest_id 0
% $_tmp_ptr 0
% $_char_ptr 0
% $_payload_len 0
% $my_inbox 0
% $main_str_0 \S \t \a \r \t \i \n \g \space \N \e \t \w \o \r \k \space \I \n \i \t \i \a \l \i \z \a \t \i \o \n \space \T \e \s \t \. \. \. \Return \null
% $main_str_1 \S \U \C \C \E \S \S \: \space \S \Y \S \_ \N \E \T \_ \C \O \N \F \I \G \space \r \e \t \u \r \n \e \d \space \1 \. \space \N \e \t \w \o \r \k \space \s \t \a \c \k \space \i \s \space \c \o \n \f \i \g \u \r \e \d \. \Return \null
% $main_str_2 \I \N \F \O \: \space \C \a \l \l \e \d \space \S \O \C \K \E \T \. \b \i \n \d \space \f \o \r \space \p \o \r \t \space \1 \0 \0 \. \Return \null
% $main_str_3 \I \N \F \O \: \space \U \s \e \space \d \e \b \u \g \g \e \r \space \t \o \space \i \n \s \p \e \c \t \space \_ \p \o \r \t \_ \m \a \p \space \i \n \space \n \e \t \_ \c \o \r \e \. \Return \null
% $testmessage \h \e \l \l \o \space \w \o \r \l \d \null
% $main_str_4 \I \N \F \O \: \space \M \e \s \s \a \g \e \space \i \s \space \s \e \n \d \space \b \y \space \h \o \s \t \space \s \u \c \c \e \s \f \u \l \l \Return \null
% $main_str_5 \I \N \F \O \: \space \M \e \s \s \a \g \e \space \i \s \space \s \e \n \d \space \b \y \space \h \o \s \t \space \f \a \i \l \e \d \Return \null
% $main_str_6 \F \A \I \L \U \R \E \: \space \S \Y \S \_ \N \E \T \_ \C \O \N \F \I \G \space \r \e \t \u \r \n \e \d \space \0 \. \space \C \h \e \c \k \space \k \e \r \n \e \l \space \l \o \g \s \. \Return \null
