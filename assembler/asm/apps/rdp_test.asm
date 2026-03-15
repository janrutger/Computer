# .HEADER
. $_send_buffer 1
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
. $_src_port 1
. $_dest_port 1
. $_dest_id 1
. $_str_ptr 1
. $_char_ptr 1
. $_num 1
. $_p_ptr 1
. $_digit_count 1
. $_snd_list_ptr 1
. $_length 1
. $_ptr 1
. $_msg 1
. $_term_ptr 1
. $_res 1
. $_is_neg 1
. $_curr_ptr 1
. $_val 1
. $_rdp_conns 1
. $_rdp_ctrl_packet 1
. $_rdp_recv_buf 1
. $_conn 1
. $_conn_ptr 1
. $_new_conn 1
. $_key 1
. $_msg_type 1
. $_src_id 1
. $_local_port 1
. $_seq_num 1
. $_retries 1
. $_state 1
. $_current_state 1
. $_inbox 1
. $_payload_ptr 1
. $_inbox_server 1
. $_inbox_client 1
. $_client_conn 1
. $print_conn_state_str_0 18
. $main_str_1 28
. $main_str_2 22
. $main_str_3 22
. $main_str_4 26
. $main_str_5 25
. $main_str_6 25
. $main_str_7 43
. $main_str_8 30
. $_loop_count 1
. $main_str_9 6
. $main_str_10 3

# .CODE
    call @main
    ret

# .FUNCTIONS

@SOCKET.init

        ldi I ~SYS_NET_CONFIG ; syscall 65
        int $INT_VECTORS
        ldi A 256
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_send_buffer
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
    sto A $_src_port
    ustack A $DATASTACK_PTR
    sto A $_dest_port
    ustack A $DATASTACK_PTR
    sto A $_dest_id
    ustack A $DATASTACK_PTR
    sto A $_str_ptr
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
    ldm A $_send_buffer
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
    ldm A $_send_buffer
    stack A $DATASTACK_PTR

            ldi I ~SYS_NET_SEND
            int $INT_VECTORS
        :SOCKET.snd_text_if_end_2
    ret
@SOCKET.snd_num
    ustack A $DATASTACK_PTR
    sto A $_src_port
    ustack A $DATASTACK_PTR
    sto A $_dest_port
    ustack A $DATASTACK_PTR
    sto A $_dest_id
    ustack A $DATASTACK_PTR
    sto A $_num
    ld A Z
    sto A $_payload_len
    ldm B $_send_buffer
    ldi A 4
    add A B
    sto A $_p_ptr
    ldm A $_num
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.snd_num_if_end_3
    ldi A 45
    ld B A
    ldm I $_p_ptr
    stx B $_start_memory_
    ldm B $_p_ptr
    ldi A 1
    add A B
    sto A $_p_ptr
    ldm B $_payload_len
    ldi A 1
    add A B
    sto A $_payload_len
    ldm A $_num
    ldi B 0
    sub B A
    ld A B
    sto A $_num
:SOCKET.snd_num_if_end_3
    ldm A $_num
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.snd_num_if_else_4
    ldi A 48
    ld B A
    ldm I $_p_ptr
    stx B $_start_memory_
    ldm B $_payload_len
    ldi A 1
    add A B
    sto A $_payload_len
    jmp :SOCKET.snd_num_if_end_4
:SOCKET.snd_num_if_else_4
    ld A Z
    sto A $_digit_count
:SOCKET.snd_num_while_start_2
    ldm A $_num
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.snd_num_while_end_2
    ldm B $_num
    ldi A 10
    dmod B A
    ld B A
    ldi A 48
    add B A
    stack B $DATASTACK_PTR
    ldm B $_num
    ldi A 10
    dmod B A
    ld A B
    sto A $_num
    ldm B $_digit_count
    ldi A 1
    add A B
    sto A $_digit_count
    jmp :SOCKET.snd_num_while_start_2
:SOCKET.snd_num_while_end_2
:SOCKET.snd_num_while_start_3
    ldm A $_digit_count
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.snd_num_while_end_3
    ustack B $DATASTACK_PTR
    ldm I $_p_ptr
    stx B $_start_memory_
    ldm B $_p_ptr
    ldi A 1
    add A B
    sto A $_p_ptr
    ldm B $_payload_len
    ldi A 1
    add A B
    sto A $_payload_len
    ldm B $_digit_count
    ldi A 1
    sub B A
    ld A B
    sto A $_digit_count
    jmp :SOCKET.snd_num_while_start_3
:SOCKET.snd_num_while_end_3
:SOCKET.snd_num_if_end_4
    ldm A $_send_buffer
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
    ldm A $_send_buffer
    stack A $DATASTACK_PTR

        ldi I ~SYS_NET_SEND
        int $INT_VECTORS
        ret
@SOCKET.snd_list
    ustack A $DATASTACK_PTR
    sto A $_src_port
    ustack A $DATASTACK_PTR
    sto A $_dest_port
    ustack A $DATASTACK_PTR
    sto A $_dest_id
    ustack A $DATASTACK_PTR
    sto A $_snd_list_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $_payload_len
    stack A $DATASTACK_PTR
    ldi A 240
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.snd_list_if_else_5
    stack Z $DATASTACK_PTR
    jmp :SOCKET.snd_list_if_end_5
:SOCKET.snd_list_if_else_5
    ldm A $_send_buffer
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
:SOCKET.snd_list_while_start_4
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_payload_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :SOCKET.snd_list_while_end_4
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_snd_list_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack B $DATASTACK_PTR
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
    jmp :SOCKET.snd_list_while_start_4
:SOCKET.snd_list_while_end_4
    ldm A $_send_buffer
    stack A $DATASTACK_PTR

            ldi I ~SYS_NET_SEND
            int $INT_VECTORS
        :SOCKET.snd_list_if_end_5
    ret
@SOCKET.bind

        ldi I ~SYS_NET_BIND ; syscall 60
        int $INT_VECTORS
        ret
@MESSAGE.src
    ldi A 2
    ustack B $DATASTACK_PTR
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@MESSAGE.dest_port
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@MESSAGE.src_port
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ldi A 2
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@MESSAGE.len
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ldi A 3
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@MESSAGE.payload_ptr
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ldi A 4
    add B A
    stack B $DATASTACK_PTR
    ret
@MESSAGE.as_string
    ustack A $DATASTACK_PTR
    sto A $_msg
    stack A $DATASTACK_PTR
    call @MESSAGE.len
    ustack A $DATASTACK_PTR
    sto A $_length
    ldm A $_msg
    stack A $DATASTACK_PTR
    call @MESSAGE.payload_ptr
    ustack A $DATASTACK_PTR
    sto A $_ptr
    ld B A
    ldm A $_length
    add A B
    sto A $_term_ptr
    ld B Z
    ldm I $_term_ptr
    stx B $_start_memory_
    ldm A $_ptr
    stack A $DATASTACK_PTR
    ret
@MESSAGE.as_num
    ustack A $DATASTACK_PTR
    sto A $_msg
    stack A $DATASTACK_PTR
    call @MESSAGE.len
    ustack A $DATASTACK_PTR
    sto A $_length
    ldm A $_msg
    stack A $DATASTACK_PTR
    call @MESSAGE.payload_ptr
    ustack A $DATASTACK_PTR
    sto A $_ptr
    ld A Z
    sto A $_res
    ld A Z
    sto A $_is_neg
    ld A Z
    sto A $_i
    ldm A $_length
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MESSAGE.as_num_if_end_6
    ldm I $_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 45
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MESSAGE.as_num_if_end_7
    ldi A 1
    sto A $_is_neg
    ldi A 1
    sto A $_i
:MESSAGE.as_num_if_end_7
:MESSAGE.as_num_if_end_6
:MESSAGE.as_num_while_start_5
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_length
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MESSAGE.as_num_while_end_5
    ldm B $_ptr
    ldm A $_i
    add A B
    sto A $_curr_ptr
    ldm I $_curr_ptr
    ldx A $_start_memory_
    sto A $_val
    stack A $DATASTACK_PTR
    ldi A 47
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MESSAGE.as_num_if_end_8
    ldm A $_val
    stack A $DATASTACK_PTR
    ldi A 58
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :MESSAGE.as_num_if_end_9
    ldm B $_res
    ldi A 10
    mul B A
    stack B $DATASTACK_PTR
    ldm B $_val
    ldi A 48
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    add A B
    sto A $_res
:MESSAGE.as_num_if_end_9
:MESSAGE.as_num_if_end_8
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :MESSAGE.as_num_while_start_5
:MESSAGE.as_num_while_end_5
    ldm A $_is_neg
    tst A 0
    jmpt :MESSAGE.as_num_if_else_10
    stack Z $DATASTACK_PTR
    ldm A $_res
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    jmp :MESSAGE.as_num_if_end_10
:MESSAGE.as_num_if_else_10
    ldm A $_res
    stack A $DATASTACK_PTR
:MESSAGE.as_num_if_end_10
    ret


@RDP.init
    ldi A 8
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $_rdp_conns
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_rdp_ctrl_packet
    ldi A 256
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_rdp_recv_buf
    ret
@_rdp_make_key
    call @rt_swap
    ldi A 65536
    ustack B $DATASTACK_PTR
    mul A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ret
@_rdp_send_control_packet
    ustack A $DATASTACK_PTR
    sto A $_msg_type
    ustack A $DATASTACK_PTR
    sto A $_conn
    stack Z $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dest_id
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dest_port
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_src_port
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_seq_num
    ldm B $_rdp_ctrl_packet
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldm A $_rdp_ctrl_packet
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    ldm A $_rdp_ctrl_packet
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_rdp_ctrl_packet
    stack A $DATASTACK_PTR
    ldm A $_dest_id
    stack A $DATASTACK_PTR
    ldm A $_dest_port
    stack A $DATASTACK_PTR
    ldm A $_src_port
    stack A $DATASTACK_PTR
    call @SOCKET.snd_list
    ret
@_rdp_check_timeout
    ustack A $DATASTACK_PTR
    sto A $_conn
    call @TIME.uptime
    ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldi A 2000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_check_timeout_if_end_0
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_retries
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_check_timeout_if_else_1
    stack Z $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :_rdp_check_timeout_if_end_1
:_rdp_check_timeout_if_else_1
    ldm B $_retries
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    call @TIME.uptime
    ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_state
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_check_timeout_if_else_2
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 129
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
    jmp :_rdp_check_timeout_if_end_2
:_rdp_check_timeout_if_else_2
    ldm A $_state
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_check_timeout_if_end_3
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 133
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
:_rdp_check_timeout_if_end_3
:_rdp_check_timeout_if_end_2
:_rdp_check_timeout_if_end_1
:_rdp_check_timeout_if_end_0
    ret
@_rdp_alloc_conn
    ustack A $DATASTACK_PTR
    sto A $_local_port
    ustack A $DATASTACK_PTR
    sto A $_dest_port
    ustack A $DATASTACK_PTR
    sto A $_dest_id
    ldi A 16
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_conn
    ldm A $_dest_id
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dest_port
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_local_port
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    call @TIME.uptime
    ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 10
    stack A $DATASTACK_PTR
    call @DICT.new
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 10
    stack A $DATASTACK_PTR
    call @DICT.new
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldm A $_dest_port
    stack A $DATASTACK_PTR
    ldm A $_local_port
    stack A $DATASTACK_PTR
    call @_rdp_make_key
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.put
    ldm A $_conn
    stack A $DATASTACK_PTR
    ret
@RDP.connect
    call @_rdp_alloc_conn
    ustack A $DATASTACK_PTR
    sto A $_conn
    stack A $DATASTACK_PTR
    ldi A 129
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.connect_if_else_4
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :RDP.connect_if_end_4
:RDP.connect_if_else_4
    stack Z $DATASTACK_PTR
:RDP.connect_if_end_4
    ret
@RDP.update
    ustack A $DATASTACK_PTR
    sto A $_inbox
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $_count
    ld A Z
    sto A $_i
:RDP.update_while_start_0
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_while_end_0
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $_conn_ptr
    ustack A $DATASTACK_PTR
    sto A $_key
    ldm A $_conn_ptr
    stack A $DATASTACK_PTR
    call @_rdp_check_timeout
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_5
    ldm A $_key
    stack A $DATASTACK_PTR
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.remove
    ldm B $_count
    ldi A 1
    sub B A
    ld A B
    sto A $_count
    jmp :RDP.update_if_end_5
:RDP.update_if_else_5
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
:RDP.update_if_end_5
    jmp :RDP.update_while_start_0
:RDP.update_while_end_0
    ldm A $_rdp_recv_buf
    stack A $DATASTACK_PTR
    ldm A $_inbox
    stack A $DATASTACK_PTR
    call @SOCKET.read
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_6
    ldm A $_rdp_recv_buf
    stack A $DATASTACK_PTR
    call @MESSAGE.payload_ptr
    ustack A $DATASTACK_PTR
    sto A $_payload_ptr
    ldm I $_payload_ptr
    ldx A $_start_memory_
    sto A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 128
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_7
    ldm A $_rdp_recv_buf
    stack A $DATASTACK_PTR
    call @MESSAGE.src
    ustack A $DATASTACK_PTR
    sto A $_src_id
    ldm A $_rdp_recv_buf
    stack A $DATASTACK_PTR
    call @MESSAGE.src_port
    ustack A $DATASTACK_PTR
    sto A $_src_port
    ldm A $_rdp_recv_buf
    stack A $DATASTACK_PTR
    call @MESSAGE.dest_port
    ustack A $DATASTACK_PTR
    sto A $_local_port
    ldm A $_src_port
    stack A $DATASTACK_PTR
    ldm A $_local_port
    stack A $DATASTACK_PTR
    call @_rdp_make_key
    ustack A $DATASTACK_PTR
    sto A $_key
    stack A $DATASTACK_PTR
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_8
    ldm A $_key
    stack A $DATASTACK_PTR
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_conn
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 129
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_9
    ldm B $_payload_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @rt_dup
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 134
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
    jmp :RDP.update_if_end_9
:RDP.update_if_else_9
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 134
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_10
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_current_state
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_11
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    call @TIME.uptime
    ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
:RDP.update_if_end_11
    jmp :RDP.update_if_end_10
:RDP.update_if_else_10
:RDP.update_if_end_10
:RDP.update_if_end_9
    jmp :RDP.update_if_end_8
:RDP.update_if_else_8
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 129
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_12
    ldm A $_src_id
    stack A $DATASTACK_PTR
    ldm A $_src_port
    stack A $DATASTACK_PTR
    ldm A $_local_port
    stack A $DATASTACK_PTR
    call @_rdp_alloc_conn
    ustack A $DATASTACK_PTR
    sto A $_new_conn
    ldm B $_payload_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @rt_dup
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_new_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_new_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_new_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_new_conn
    stack A $DATASTACK_PTR
    ldi A 134
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
:RDP.update_if_end_12
:RDP.update_if_end_8
    jmp :RDP.update_if_end_7
:RDP.update_if_else_7
:RDP.update_if_end_7
:RDP.update_if_end_6
    ret

@print_conn_state
    ustack A $DATASTACK_PTR
    sto A $_conn
    ldi A $print_conn_state_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    call @rt_print_tos
    ret
@main
    ldi A $main_str_1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $HEAP_START
    sto A $HEAP_FREE
    ldi A 32
    stack A $DATASTACK_PTR
    call @DEQUE.init_pool
    ldi A 8246931439866572030
    stack A $DATASTACK_PTR
    ldi A 128
    stack A $DATASTACK_PTR
    call @SOCKET.init
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_0
    ldi A $main_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        jmp :main_if_end_0
:main_if_else_0
    ldi A $main_str_3
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:main_if_end_0
    call @RDP.init
    ldi A $main_str_4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $_inbox_server
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_inbox_server
    stack A $DATASTACK_PTR
    call @SOCKET.bind
    ldi A $main_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $_inbox_client
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $_inbox_client
    stack A $DATASTACK_PTR
    call @SOCKET.bind
    ldi A $main_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 8246931439866572030
    stack A $DATASTACK_PTR
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A 101
    stack A $DATASTACK_PTR
    call @RDP.connect
    call @rt_swap
    ustack A $DATASTACK_PTR
    sto A $_client_conn
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_1
    ldi A $main_str_7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_client_conn
    stack A $DATASTACK_PTR
    call @print_conn_state
    jmp :main_if_end_1
:main_if_else_1
    call @rt_drop
    ldi A $main_str_8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:main_if_end_1
:main_while_start_0
    ldm A $_loop_count
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_while_end_0
    ldi A $main_str_9
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_loop_count
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $main_str_10
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    
            nop
            ldm A $_inbox_server
    stack A $DATASTACK_PTR
    call @RDP.update

            nop
            ldm A $_inbox_client
    stack A $DATASTACK_PTR
    call @RDP.update
    ldm A $_client_conn
    stack A $DATASTACK_PTR
    call @print_conn_state
    ldm B $_loop_count
    ldi A 1
    add A B
    sto A $_loop_count
    jmp :main_while_start_0
:main_while_end_0
    ret

# .DATA

% $_send_buffer 0
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
% $_src_port 0
% $_dest_port 0
% $_dest_id 0
% $_str_ptr 0
% $_char_ptr 0
% $_num 0
% $_p_ptr 0
% $_digit_count 0
% $_snd_list_ptr 0
% $_length 0
% $_ptr 0
% $_msg 0
% $_term_ptr 0
% $_res 0
% $_is_neg 0
% $_curr_ptr 0
% $_val 0

% $_rdp_conns 0
% $_rdp_ctrl_packet 0
% $_rdp_recv_buf 0
% $_conn 0
% $_conn_ptr 0
% $_new_conn 0
% $_key 0
% $_msg_type 0
% $_src_id 0
% $_local_port 0
% $_seq_num 0
% $_retries 0
% $_state 0
% $_current_state 0
% $_inbox 0
% $_payload_ptr 0
% $_inbox_server 0
% $_inbox_client 0
% $_client_conn 0
% $print_conn_state_str_0 \( \2 \= \I \N \I \T \, \space \3 \= \O \P \E \N \) \space \null
% $main_str_1 \- \- \- \space \R \D \P \space \H \a \n \d \s \h \a \k \e \space \T \e \s \t \space \- \- \- \Return \null
% $main_str_2 \N \e \t \w \o \r \k \space \I \n \i \t \i \a \l \i \z \e \d \. \Return \null
% $main_str_3 \N \e \t \w \o \r \k \space \I \n \i \t \space \F \a \i \l \e \d \. \Return \null
% $main_str_4 \R \D \P \space \L \i \b \r \a \r \y \space \I \n \i \t \i \a \l \i \z \e \d \. \Return \null
% $main_str_5 \B \o \u \n \d \space \P \o \r \t \space \1 \0 \0 \space \( \S \e \r \v \e \r \) \Return \null
% $main_str_6 \B \o \u \n \d \space \P \o \r \t \space \1 \0 \1 \space \( \C \l \i \e \n \t \) \Return \null
% $main_str_7 \C \l \i \e \n \t \: \space \C \o \n \n \e \c \t \space \c \a \l \l \space \s \u \c \c \e \s \s \. \space \S \e \n \t \space \H \E \L \L \O \. \Return \null
% $main_str_8 \C \l \i \e \n \t \: \space \C \o \n \n \e \c \t \space \c \a \l \l \space \f \a \i \l \e \d \. \Return \null
% $_loop_count 0
% $main_str_9 \T \i \c \k \space \null
% $main_str_10 \space \space \null
