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
. $_src_id 1
. $_local_port 1
. $_msg_type 1
. $_seq_num 1
. $_retries 1
. $_state 1
. $_current_state 1
. $_inbox 1
. $_can_send 1
. $_j 1
. $_payload_ptr 1
. $_rdp_packet_pool 1
. $_len 1
. $_data 1
. $_tx_buf 1
. $_tx_key 1
. $_pkt_seq 1
. $_pkt_buf 1
. $_last_sent 1
. $_resend_seq 1
. $_rdp_err_pool 36
. $_str_rdp_status 20
. $_str_active_conn 21
. $_str_conn 6
. $_str_colon 3
. $_str_state 7
. $_str_seq_out 9
. $_str_seq_in 8
. $_str_tx_buf 15
. $_str_rx_buf 13
. $_str_timer 10
. $_str_retries 10
. $_str_rdp_footer 20
. $_str_newline 2
. $_expected_seq 1
. $_rx_pkt 1
. $_rx_buf 1
. $_found_pkt 1
. $_min_key 1
. $_curr_key 1
. $_inbox_server 1
. $_inbox_client 1
. $_client_conn 1
. $_server_conn 1
. $_test_payload 1
. $_has_sent 1
. $_cnt 1
. $_idx 1
. $__ptr 1
. $_recv_buf 1
. $_recv_success 1
. $_recv_i 1
. $_recv_len 1
. $_stress_i 1
. $print_conn_state_str_0 18
. $print_server_rx_state_str_1 21
. $print_server_rx_state_str_2 2
. $main_str_3 28
. $main_str_4 22
. $main_str_5 22
. $main_str_6 26
. $main_str_7 25
. $main_str_8 25
. $main_str_9 43
. $main_str_10 30
. $_loop_count 1
. $main_str_11 6
. $main_str_12 2
. $main_str_13 31
. $main_str_14 37
. $main_str_15 3
. $_stress_count 1
. $main_str_16 50
. $_can_still_send 1
. $main_str_17 6
. $main_str_18 6
. $main_str_19 35
. $main_str_20 37

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
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $_rdp_packet_pool
    ld A Z
    sto A $_i
:RDP.init_while_start_0
    ldm A $_i
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.init_while_end_0
    ldi A 64
    stack A $DATASTACK_PTR
    call @NEW.array
    ldm A $_rdp_packet_pool
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :RDP.init_while_start_0
:RDP.init_while_end_0
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
@_rdp_prev_seq
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ret
@_rdp_get_buffer
    ldm A $_rdp_packet_pool
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_get_buffer_if_else_0
    stack Z $DATASTACK_PTR
    jmp :_rdp_get_buffer_if_end_0
:_rdp_get_buffer_if_else_0
    ldm A $_rdp_packet_pool
    stack A $DATASTACK_PTR
    call @DEQUE.pop
:_rdp_get_buffer_if_end_0
    ret
@_rdp_release_buffer
    call @rt_dup
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_release_buffer_if_else_1
    ldm A $_rdp_packet_pool
    stack A $DATASTACK_PTR
    call @DEQUE.append
    jmp :_rdp_release_buffer_if_end_1
:_rdp_release_buffer_if_else_1
    call @rt_drop
:_rdp_release_buffer_if_end_1
    ret
@_rdp_send_raw_ctrl_packet
    ustack A $DATASTACK_PTR
    sto A $_seq_num
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
@_rdp_send_control_packet
    ustack A $DATASTACK_PTR
    sto A $_msg_type
    ustack A $DATASTACK_PTR
    sto A $_conn
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_seq_num
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @_rdp_send_raw_ctrl_packet
    ret
@_rdp_send_response_packet
    ustack A $DATASTACK_PTR
    sto A $_msg_type
    ustack A $DATASTACK_PTR
    sto A $_conn
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    call @_rdp_prev_seq
    ustack A $DATASTACK_PTR
    sto A $_seq_num
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @_rdp_send_raw_ctrl_packet
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
    jmpt :_rdp_check_timeout_if_end_2
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_retries
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_check_timeout_if_else_3
    stack Z $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :_rdp_check_timeout_if_end_3
:_rdp_check_timeout_if_else_3
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
    jmpt :_rdp_check_timeout_if_else_4
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 129
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
    jmp :_rdp_check_timeout_if_end_4
:_rdp_check_timeout_if_else_4
    ldm A $_state
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_check_timeout_if_else_5
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 135
    stack A $DATASTACK_PTR
    call @_rdp_send_response_packet
    call @rt_drop
    jmp :_rdp_check_timeout_if_end_5
:_rdp_check_timeout_if_else_5
    ldm A $_state
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_check_timeout_if_else_6
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 133
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
    jmp :_rdp_check_timeout_if_end_6
:_rdp_check_timeout_if_else_6
    ldm A $_state
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_rdp_check_timeout_if_end_7
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 133
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
:_rdp_check_timeout_if_end_7
:_rdp_check_timeout_if_end_6
:_rdp_check_timeout_if_end_5
:_rdp_check_timeout_if_end_4
:_rdp_check_timeout_if_end_3
:_rdp_check_timeout_if_end_2
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
    stack Z $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 6
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
    jmpt :RDP.connect_if_else_8
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :RDP.connect_if_end_8
:RDP.connect_if_else_8
    stack Z $DATASTACK_PTR
:RDP.connect_if_end_8
    ret
@RDP.update
    ustack A $DATASTACK_PTR
    sto A $_inbox
    ldm A $_rdp_recv_buf
    stack A $DATASTACK_PTR
    ldm A $_inbox
    stack A $DATASTACK_PTR
    call @SOCKET.read
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_9
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
    jmpt :RDP.update_if_else_10
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
    jmpt :RDP.update_if_else_11
    ldm A $_key
    stack A $DATASTACK_PTR
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_conn
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
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 129
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_12
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
    jmp :RDP.update_if_end_12
:RDP.update_if_else_12
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 136
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_13
    ldi A 4
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
    jmp :RDP.update_if_end_13
:RDP.update_if_else_13
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 137
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_14
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_payload_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    sto A $_seq_num
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_tx_buf
    ldi A 1
    sto A $_i
:RDP.update_while_start_1
    ldm A $_i
    stack A $DATASTACK_PTR
    ldi A 6
    ld B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_while_end_1
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_15
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_seq
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @rt_gt
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_16
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @_rdp_release_buffer
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.remove
:RDP.update_if_end_16
:RDP.update_if_end_15
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :RDP.update_while_start_1
:RDP.update_while_end_1
    ldm B $_seq_num
    ldi A 1
    add A B
    sto A $_resend_seq
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_len
:RDP.update_while_start_2
    ldm A $_resend_seq
    stack A $DATASTACK_PTR
    ldm A $_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_while_end_2
    ldm B $_resend_seq
    ldi A 6
    dmod B A
    ld B A
    ldi A 1
    add A B
    sto A $_key
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_17
    ldm A $_key
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
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
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    ldm A $_dest_id
    stack A $DATASTACK_PTR
    ldm A $_dest_port
    stack A $DATASTACK_PTR
    ldm A $_src_port
    stack A $DATASTACK_PTR
    call @SOCKET.snd_list
    call @rt_drop
:RDP.update_if_end_17
    ldm B $_resend_seq
    ldi A 1
    add A B
    sto A $_resend_seq
    jmp :RDP.update_while_start_2
:RDP.update_while_end_2
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 133
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
    jmp :RDP.update_if_end_14
:RDP.update_if_else_14
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 134
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_18
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
    jmpt :RDP.update_if_else_19
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
    jmp :RDP.update_if_end_19
:RDP.update_if_else_19
    ldm B $_payload_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    sto A $_seq_num
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_tx_buf
    ldi A 1
    sto A $_i
:RDP.update_while_start_3
    ldm A $_i
    stack A $DATASTACK_PTR
    ldi A 6
    ld B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_while_end_3
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_20
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_seq
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @rt_gt
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_21
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @_rdp_release_buffer
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.remove
:RDP.update_if_end_21
:RDP.update_if_end_20
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :RDP.update_while_start_3
:RDP.update_while_end_3
    ldm A $_current_state
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_22
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
:RDP.update_if_end_22
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_last_sent
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_23
    ldm B $_seq_num
    ldi A 1
    add A B
    sto A $_resend_seq
    ld B A
    ldi A 6
    dmod B A
    ld B A
    ldi A 1
    add A B
    sto A $_key
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_24
    ldm A $_key
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
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
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    ldm A $_dest_id
    stack A $DATASTACK_PTR
    ldm A $_dest_port
    stack A $DATASTACK_PTR
    ldm A $_src_port
    stack A $DATASTACK_PTR
    call @SOCKET.snd_list
    call @rt_drop
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 133
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
:RDP.update_if_end_24
:RDP.update_if_end_23
:RDP.update_if_end_19
    jmp :RDP.update_if_end_18
:RDP.update_if_else_18
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 133
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_25
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_26
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 136
    stack A $DATASTACK_PTR
    call @_rdp_send_response_packet
    call @rt_drop
    jmp :RDP.update_if_end_26
:RDP.update_if_else_26
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 134
    stack A $DATASTACK_PTR
    call @_rdp_send_response_packet
    call @rt_drop
:RDP.update_if_end_26
    jmp :RDP.update_if_end_25
:RDP.update_if_else_25
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 135
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_27
    ldm B $_payload_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    sto A $_seq_num
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_tx_buf
    ldi A 1
    sto A $_i
:RDP.update_while_start_4
    ldm A $_i
    stack A $DATASTACK_PTR
    ldi A 6
    ld B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_while_end_4
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_28
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_seq
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @rt_gt
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_29
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @_rdp_release_buffer
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.remove
:RDP.update_if_end_29
:RDP.update_if_end_28
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :RDP.update_while_start_4
:RDP.update_while_end_4
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_last_sent
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_30
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 131
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @_rdp_send_raw_ctrl_packet
    call @rt_drop
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :RDP.update_if_end_30
:RDP.update_if_else_30
    ldm B $_seq_num
    ldi A 1
    add A B
    sto A $_resend_seq
    ld B A
    ldi A 6
    dmod B A
    ld B A
    ldi A 1
    add A B
    sto A $_key
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_31
    ldm A $_key
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
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
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    ldm A $_dest_id
    stack A $DATASTACK_PTR
    ldm A $_dest_port
    stack A $DATASTACK_PTR
    ldm A $_src_port
    stack A $DATASTACK_PTR
    call @SOCKET.snd_list
    call @rt_drop
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 133
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
    jmp :RDP.update_if_end_31
:RDP.update_if_else_31
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 131
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @_rdp_send_raw_ctrl_packet
    call @rt_drop
:RDP.update_if_end_31
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
:RDP.update_if_end_30
    jmp :RDP.update_if_end_27
:RDP.update_if_else_27
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 131
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_32
    ldm B $_payload_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    sto A $_seq_num
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_tx_buf
    ldi A 1
    sto A $_i
:RDP.update_while_start_5
    ldm A $_i
    stack A $DATASTACK_PTR
    ldi A 6
    ld B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_while_end_5
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_33
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_seq
    stack A $DATASTACK_PTR
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    call @rt_gt
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_34
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @_rdp_release_buffer
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.remove
:RDP.update_if_end_34
:RDP.update_if_end_33
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :RDP.update_while_start_5
:RDP.update_while_end_5
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
    jmp :RDP.update_if_end_32
:RDP.update_if_else_32
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 132
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_35
    ldm B $_payload_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    ld B A
    ldi A 1
    add A B
    sto A $_seq_num
    ld B A
    ldi A 6
    dmod B A
    ld B A
    ldi A 1
    add A B
    sto A $_key
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_tx_buf
    ldm A $_key
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_36
    ldm A $_key
    stack A $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
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
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    ldm A $_dest_id
    stack A $DATASTACK_PTR
    ldm A $_dest_port
    stack A $DATASTACK_PTR
    ldm A $_src_port
    stack A $DATASTACK_PTR
    call @SOCKET.snd_list
    call @rt_drop
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 133
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
:RDP.update_if_end_36
    jmp :RDP.update_if_end_35
:RDP.update_if_else_35
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 130
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_37
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_38
    ldm B $_payload_ptr
    ldi A 1
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    sto A $_seq_num
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_expected_seq
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    ldm A $_expected_seq
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_39
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    call @DICT.count
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_lt
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    tst A 0
    jmpt :RDP.update_if_else_40
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_41
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 136
    stack A $DATASTACK_PTR
    call @_rdp_send_response_packet
    call @rt_drop
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
:RDP.update_if_end_41
    jmp :RDP.update_if_end_40
:RDP.update_if_else_40
    call @_rdp_get_buffer
    ustack A $DATASTACK_PTR
    sto A $_rx_pkt
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_42
    ldm B $_rx_pkt
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldi A 130
    stack A $DATASTACK_PTR
    ldm A $_rx_pkt
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    ldm A $_rx_pkt
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_rdp_recv_buf
    stack A $DATASTACK_PTR
    call @MESSAGE.len
    ldi A 2
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_len
    ld A Z
    sto A $_i
:RDP.update_while_start_6
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_while_end_6
    ldm B $_payload_ptr
    ldi A 2
    add B A
    ldm A $_i
    add A B
    sto A $_tmp_ptr
    ldm I $_tmp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm A $_rx_pkt
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :RDP.update_while_start_6
:RDP.update_while_end_6
    ldm A $_rx_pkt
    stack A $DATASTACK_PTR
    ldm B $_seq_num
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    call @DICT.put
    jmp :RDP.update_if_end_42
:RDP.update_if_else_42
    ldi A $_rdp_err_pool
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:RDP.update_if_end_42
    ldm B $_seq_num
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 5
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
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    ldm A $_expected_seq
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_else_43
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 132
    stack A $DATASTACK_PTR
    call @_rdp_send_response_packet
    call @rt_drop
    jmp :RDP.update_if_end_43
:RDP.update_if_else_43
:RDP.update_if_end_43
:RDP.update_if_end_40
:RDP.update_if_end_39
:RDP.update_if_end_38
:RDP.update_if_end_37
:RDP.update_if_end_35
:RDP.update_if_end_32
:RDP.update_if_end_27
:RDP.update_if_end_25
:RDP.update_if_end_18
:RDP.update_if_end_14
:RDP.update_if_end_13
:RDP.update_if_end_12
    jmp :RDP.update_if_end_11
:RDP.update_if_else_11
    ldm A $_msg_type
    stack A $DATASTACK_PTR
    ldi A 129
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_if_end_44
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
:RDP.update_if_end_44
:RDP.update_if_end_11
    jmp :RDP.update_if_end_10
:RDP.update_if_else_10
:RDP.update_if_end_10
:RDP.update_if_end_9
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $_count
    ld A Z
    sto A $_i
:RDP.update_while_start_7
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.update_while_end_7
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
    jmpt :RDP.update_if_else_45
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
    jmp :RDP.update_if_end_45
:RDP.update_if_else_45
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
:RDP.update_if_end_45
    jmp :RDP.update_while_start_7
:RDP.update_while_end_7
    ret
@RDP.send
    ustack A $DATASTACK_PTR
    sto A $_len
    ustack A $DATASTACK_PTR
    sto A $_data
    ustack A $DATASTACK_PTR
    sto A $_conn
    ldi A 1
    sto A $_can_send
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.send_if_end_46
    ld A Z
    sto A $_can_send
:RDP.send_if_end_46
    ldm A $_len
    stack A $DATASTACK_PTR
    ldi A 64
    ld B A
    ldi A 2
    sub B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.send_if_end_47
    ld A Z
    sto A $_can_send
:RDP.send_if_end_47
    ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.count
    ldi A 6
    stack A $DATASTACK_PTR
    call @rt_lt
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    tst A 0
    jmpt :RDP.send_if_end_48
    ld A Z
    sto A $_can_send
:RDP.send_if_end_48
    ldm A $_can_send
    tst A 0
    jmpt :RDP.send_if_else_49
    call @_rdp_get_buffer
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.send_if_else_50
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_seq_num
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
    ldm B $_pkt_buf
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldi A 130
    stack A $DATASTACK_PTR
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_seq_num
    stack A $DATASTACK_PTR
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ld A Z
    sto A $_i
:RDP.send_while_start_8
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.send_while_end_8
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_data
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :RDP.send_while_start_8
:RDP.send_while_end_8
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    ldm A $_dest_id
    stack A $DATASTACK_PTR
    ldm A $_dest_port
    stack A $DATASTACK_PTR
    ldm A $_src_port
    stack A $DATASTACK_PTR
    call @SOCKET.snd_list
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.send_if_else_51
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    ldm B $_seq_num
    ldi A 6
    dmod B A
    ld B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.put
    ldm B $_seq_num
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 4
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
    ldm A $_tx_buf
    stack A $DATASTACK_PTR
    call @DICT.count
    ldi A 6
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.send_if_end_52
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 133
    stack A $DATASTACK_PTR
    call @_rdp_send_control_packet
    call @rt_drop
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
:RDP.send_if_end_52
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :RDP.send_if_end_51
:RDP.send_if_else_51
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @_rdp_release_buffer
    stack Z $DATASTACK_PTR
:RDP.send_if_end_51
    jmp :RDP.send_if_end_50
:RDP.send_if_else_50
    stack Z $DATASTACK_PTR
:RDP.send_if_end_50
    jmp :RDP.send_if_end_49
:RDP.send_if_else_49
    stack Z $DATASTACK_PTR
:RDP.send_if_end_49
    ret
@RDP.recv
    ustack A $DATASTACK_PTR
    sto A $_data
    ustack A $DATASTACK_PTR
    sto A $_conn
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_rx_buf
    ld A Z
    sto A $_found_pkt
    ldm A $_rx_buf
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $_count
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.recv_if_end_53
    stack Z $DATASTACK_PTR
    ldm A $_rx_buf
    stack A $DATASTACK_PTR
    call @DICT.item
    call @rt_drop
    ustack A $DATASTACK_PTR
    sto A $_min_key
    ldi A 1
    sto A $_i
:RDP.recv_while_start_9
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.recv_while_end_9
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_rx_buf
    stack A $DATASTACK_PTR
    call @DICT.item
    call @rt_drop
    ustack A $DATASTACK_PTR
    sto A $_curr_key
    stack A $DATASTACK_PTR
    ldm A $_min_key
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.recv_if_end_54
    ldm A $_curr_key
    sto A $_min_key
:RDP.recv_if_end_54
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :RDP.recv_while_start_9
:RDP.recv_while_end_9
    ldm A $_min_key
    stack A $DATASTACK_PTR
    ldm A $_rx_buf
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_pkt_buf
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ldi A 2
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_len
    ld A Z
    sto A $_j
:RDP.recv_while_start_10
    ldm A $_j
    stack A $DATASTACK_PTR
    ldm A $_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.recv_while_end_10
    ldm B $_j
    ldi A 2
    add B A
    stack B $DATASTACK_PTR
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldm A $_data
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm B $_j
    ldi A 1
    add A B
    sto A $_j
    jmp :RDP.recv_while_start_10
:RDP.recv_while_end_10
    ldm A $_pkt_buf
    stack A $DATASTACK_PTR
    call @_rdp_release_buffer
    ldm A $_min_key
    stack A $DATASTACK_PTR
    ldm A $_rx_buf
    stack A $DATASTACK_PTR
    call @DICT.remove
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.recv_if_end_55
    ldm A $_rx_buf
    stack A $DATASTACK_PTR
    call @DICT.count
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.recv_if_end_56
    stack Z $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_conn
    stack A $DATASTACK_PTR
    ldi A 137
    stack A $DATASTACK_PTR
    call @_rdp_send_response_packet
    call @rt_drop
:RDP.recv_if_end_56
:RDP.recv_if_end_55
    ldi A 1
    sto A $_found_pkt
:RDP.recv_if_end_53
    ldm A $_found_pkt
    stack A $DATASTACK_PTR
    ret
@RDP.print_status
    ldi A $_str_rdp_status
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $_count
    ldi A $_str_active_conn
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_count
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $_str_newline
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ld A Z
    sto A $_i
:RDP.print_status_while_start_11
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :RDP.print_status_while_end_11
    ldm A $_i
    stack A $DATASTACK_PTR
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $_conn_ptr
    call @rt_drop
    ldi A $_str_conn
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_i
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $_str_colon
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $_str_state
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_conn_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    call @PRTnum
    ldi A $_str_seq_out
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_conn_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    call @PRTnum
    ldi A $_str_seq_in
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_conn_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    call @PRTnum
    ldi A $_str_newline
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $_str_tx_buf
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 7
    stack A $DATASTACK_PTR
    ldm A $_conn_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    call @DICT.count
    call @PRTnum
    ldi A $_str_rx_buf
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 8
    stack A $DATASTACK_PTR
    ldm A $_conn_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    call @DICT.count
    call @PRTnum
    ldi A $_str_newline
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $_str_timer
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 9
    stack A $DATASTACK_PTR
    ldm A $_conn_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    call @PRTnum
    ldi A $_str_retries
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 10
    stack A $DATASTACK_PTR
    ldm A $_conn_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    call @PRTnum
    ldi A $_str_newline
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :RDP.print_status_while_start_11
:RDP.print_status_while_end_11
    ldi A $_str_rdp_footer
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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
@print_server_rx_state
    ustack A $DATASTACK_PTR
    sto A $_conn
    ldi A $print_server_rx_state_str_1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    call @PRTnum
    ldi A $print_server_rx_state_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ret
@main
    ldi A $main_str_3
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
    ldi A $main_str_4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        jmp :main_if_end_0
:main_if_else_0
    ldi A $main_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:main_if_end_0
    call @RDP.init
    ldi A $main_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 64
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_recv_buf
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $_inbox_server
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $_inbox_server
    stack A $DATASTACK_PTR
    call @SOCKET.bind
    ldi A $main_str_7
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
    ldi A $main_str_8
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
    ldi A $main_str_9
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
    ldi A $main_str_10
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:main_if_end_1
    ldi A 10
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_test_payload
    ldi A 42
    stack A $DATASTACK_PTR
    ldm A $_test_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 43
    stack A $DATASTACK_PTR
    ldm A $_test_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 44
    stack A $DATASTACK_PTR
    ldm A $_test_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 45
    stack A $DATASTACK_PTR
    ldm A $_test_payload
    stack A $DATASTACK_PTR
    call @ARRAY.append
:main_while_start_0
    ldm A $_loop_count
    stack A $DATASTACK_PTR
    ldi A 80
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_while_end_0
    ldi A $main_str_11
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_loop_count
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $main_str_12
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
    ldm A $_server_conn
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_2
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $_cnt
    ld A Z
    sto A $_idx
:main_while_start_1
    ldm A $_idx
    stack A $DATASTACK_PTR
    ldm A $_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_while_end_1
    ldm A $_idx
    stack A $DATASTACK_PTR
    ldm A $_rdp_conns
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $__ptr
    call @rt_drop
    ldm A $__ptr
    stack A $DATASTACK_PTR
    ldm A $_client_conn
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_3
    ldm A $__ptr
    sto A $_server_conn
    ldi A $main_str_13
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_cnt
    sto A $_idx
    jmp :main_if_end_3
:main_if_else_3
    ldm B $_idx
    ldi A 1
    add A B
    sto A $_idx
:main_if_end_3
    jmp :main_while_start_1
:main_while_end_1
    jmp :main_if_end_2
:main_if_else_2
    ldm A $_server_conn
    stack A $DATASTACK_PTR
    call @print_server_rx_state
:main_if_end_2
    ldm A $_server_conn
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_4
    ldm A $_loop_count
    stack A $DATASTACK_PTR
    ldi A 30
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_5
    ldm B $_recv_buf
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $_server_conn
    stack A $DATASTACK_PTR
    ldm A $_recv_buf
    stack A $DATASTACK_PTR
    call @RDP.recv
    ustack A $DATASTACK_PTR
    sto A $_recv_success
    tst A 0
    jmpt :main_if_end_6
    ldi A $main_str_14
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_recv_buf
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $_recv_len
    ld A Z
    sto A $_recv_i
:main_while_start_2
    ldm A $_recv_i
    stack A $DATASTACK_PTR
    ldm A $_recv_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_while_end_2
    ldm A $_recv_i
    stack A $DATASTACK_PTR
    ldm A $_recv_buf
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @PRTnum
    ldi A $main_str_15
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ldm B $_recv_i
    ldi A 1
    add A B
    sto A $_recv_i
    jmp :main_while_start_2
:main_while_end_2
    ldi A $print_server_rx_state_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :main_if_end_6
:main_if_end_5
:main_if_end_4
    ldm A $_client_conn
    stack A $DATASTACK_PTR
    call @print_conn_state
    ldm A $_stress_i
    stack A $DATASTACK_PTR
    ldm A $_stress_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_7
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_client_conn
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_8
    ldm A $_stress_i
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_9
    ldi A $main_str_16
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :main_if_end_9
    ldi A 1
    sto A $_can_still_send
:main_while_start_3
    ldm A $_stress_i
    stack A $DATASTACK_PTR
    ldm A $_stress_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ldm A $_can_still_send
    ustack B $DATASTACK_PTR
    mul A B
    tst A 0
    jmpt :main_while_end_3
    ldm A $_client_conn
    stack A $DATASTACK_PTR
    ldm A $_test_payload
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @RDP.send
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_10
    ldi A $main_str_17
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $_stress_i
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $main_str_18
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ldm B $_stress_i
    ldi A 1
    add A B
    sto A $_stress_i
    jmp :main_if_end_10
:main_if_else_10
    ldi A $main_str_19
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ld A Z
    sto A $_can_still_send
:main_if_end_10
    jmp :main_while_start_3
:main_while_end_3
    ldm A $_stress_i
    stack A $DATASTACK_PTR
    ldm A $_stress_count
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_11
    ldi A $main_str_20
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :main_if_end_11
:main_if_end_8
:main_if_end_7
    ldm B $_loop_count
    ldi A 1
    add A B
    sto A $_loop_count
    jmp :main_while_start_0
:main_while_end_0
    call @RDP.print_status
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
% $_src_id 0
% $_local_port 0
% $_msg_type 0
% $_seq_num 0
% $_retries 0
% $_state 0
% $_current_state 0
% $_inbox 0
% $_can_send 0
% $_j 0
% $_payload_ptr 0
% $_rdp_packet_pool 0
% $_len 0
% $_data 0
% $_tx_buf 0
% $_tx_key 0
% $_pkt_seq 0
% $_pkt_buf 0
% $_last_sent 0
% $_resend_seq 0
% $_rdp_err_pool \R \D \P \. \u \p \d \a \t \e \: \space \P \a \c \k \e \t \space \P \o \o \l \space \E \x \h \a \u \s \t \e \d \! \Return \null
% $_str_rdp_status \- \- \- \space \R \D \P \space \S \t \a \t \u \s \space \- \- \- \Return \null
% $_str_active_conn \A \c \t \i \v \e \space \C \o \n \n \e \c \t \i \o \n \s \: \space \null
% $_str_conn \C \o \n \n \space \null
% $_str_colon \: \space \null
% $_str_state \S \t \a \t \e \= \null
% $_str_seq_out \space \S \e \q \O \U \T \= \null
% $_str_seq_in \space \S \e \q \I \N \= \null
% $_str_tx_buf \space \space \space \T \x \B \u \f \space \S \i \z \e \= \null
% $_str_rx_buf \space \R \x \B \u \f \space \S \i \z \e \= \null
% $_str_timer \space \space \space \T \i \m \e \r \= \null
% $_str_retries \space \R \e \t \r \i \e \s \= \null
% $_str_rdp_footer \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \- \Return \null
% $_str_newline \Return \null
% $_expected_seq 0
% $_rx_pkt 0
% $_rx_buf 0
% $_found_pkt 0
% $_min_key 0
% $_curr_key 0
% $_inbox_server 0
% $_inbox_client 0
% $_client_conn 0
% $_server_conn 0
% $_test_payload 0
% $_has_sent 0
% $_cnt 0
% $_idx 0
% $__ptr 0
% $_recv_buf 0
% $_recv_success 0
% $_recv_i 0
% $_recv_len 0
% $_stress_i 0
% $print_conn_state_str_0 \( \2 \= \I \N \I \T \, \space \3 \= \O \P \E \N \) \space \null
% $print_server_rx_state_str_1 \S \e \r \v \e \r \space \R \X \space \N \e \x \t \space \S \e \q \: \space \null
% $print_server_rx_state_str_2 \Return \null
% $main_str_3 \- \- \- \space \R \D \P \space \H \a \n \d \s \h \a \k \e \space \T \e \s \t \space \- \- \- \Return \null
% $main_str_4 \N \e \t \w \o \r \k \space \I \n \i \t \i \a \l \i \z \e \d \. \Return \null
% $main_str_5 \N \e \t \w \o \r \k \space \I \n \i \t \space \F \a \i \l \e \d \. \Return \null
% $main_str_6 \R \D \P \space \L \i \b \r \a \r \y \space \I \n \i \t \i \a \l \i \z \e \d \. \Return \null
% $main_str_7 \B \o \u \n \d \space \P \o \r \t \space \1 \0 \0 \space \( \S \e \r \v \e \r \) \Return \null
% $main_str_8 \B \o \u \n \d \space \P \o \r \t \space \1 \0 \1 \space \( \C \l \i \e \n \t \) \Return \null
% $main_str_9 \C \l \i \e \n \t \: \space \C \o \n \n \e \c \t \space \c \a \l \l \space \s \u \c \c \e \s \s \. \space \S \e \n \t \space \H \E \L \L \O \. \Return \null
% $main_str_10 \C \l \i \e \n \t \: \space \C \o \n \n \e \c \t \space \c \a \l \l \space \f \a \i \l \e \d \. \Return \null
% $_loop_count 0
% $main_str_11 \T \i \c \k \space \null
% $main_str_12 \space \null
% $main_str_13 \S \e \r \v \e \r \space \C \o \n \n \e \c \t \i \o \n \space \i \d \e \n \t \i \f \i \e \d \. \Return \null
% $main_str_14 \S \e \r \v \e \r \space \A \p \p \: \space \R \e \c \e \i \v \e \d \space \D \a \t \a \! \space \P \a \y \l \o \a \d \: \space \null
% $main_str_15 \, \space \null
% $_stress_count 23
% $main_str_16 \S \t \a \t \e \space \O \P \E \N \. \space \S \t \a \r \t \i \n \g \space \S \t \r \e \s \s \space \T \e \s \t \space \( \S \c \e \n \a \r \i \o \space \A \) \. \. \. \Return \null
% $main_str_17 \S \e \n \d \space \null
% $main_str_18 \space \O \K \. \space \null
% $main_str_19 \S \e \n \d \space \B \l \o \c \k \e \d \. \space \W \a \i \t \i \n \g \space \f \o \r \space \s \y \n \c \. \. \. \Return \null
% $main_str_20 \S \t \r \e \s \s \space \T \e \s \t \space \C \o \m \p \l \e \t \e \d \space \S \u \c \c \e \s \s \f \u \l \l \y \. \Return \null
