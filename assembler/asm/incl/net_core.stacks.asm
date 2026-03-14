# .HEADER
. $_tx_scratchpad 1
. $_net_is_configured 1
. $_port_map 1
. $_packet_pool 1
. $_local_host_id 1
. $_rx_buffer_size 1
. $_i 1
. $w16_off 1
. $w16_val 1
. $w16_base 1
. $w32_off 1
. $w32_val 1
. $w32_base 1
. $usr_pkt_ptr 1
. $usr_tmp_ptr 1
. $payload_len 1
. $dest_id 1
. $dest_port 1
. $src_port 1
. $payload_ptr 1
. $__index 1
. $r16_addr 1
. $_r16_val 1
. $r32_addr 1
. $_r32_val 1
. $rx_buf_ptr 1
. $raw_len 1
. $pkt_dest_id 1
. $pkt_src_id 1
. $pkt_dest_port 1
. $pkt_src_port 1
. $_poll_payload_len 1
. $dest_deque_ptr 1
. $_poll_i 1
. $byte_val 1
. $_poll_tmp_ptr 1

# .CODE

# .FUNCTIONS
@sys_net_config
    ldm A $_net_is_configured
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sys_net_config_if_else_0
    call @rt_drop
    call @rt_drop
    stack Z $DATASTACK_PTR
    jmp :sys_net_config_if_end_0
:sys_net_config_if_else_0
    call @HAL.init
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sys_net_config_if_else_1
    ldi A 1
    sto A $_net_is_configured
    call @rt_dup
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sys_net_config_if_end_2
    call @rt_drop
    ldi A 256
    stack A $DATASTACK_PTR
:sys_net_config_if_end_2
    ustack A $DATASTACK_PTR
    sto A $_rx_buffer_size
    ldi A 8
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $_port_map
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $_packet_pool
    ldi A 256
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tx_scratchpad
    ld A Z
    sto A $_i
:sys_net_config_while_start_0
    ldm A $_i
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sys_net_config_while_end_0
    ldm A $_rx_buffer_size
    stack A $DATASTACK_PTR
    call @NEW.list
    ldm A $_packet_pool
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldm B $_i
    ldi A 1
    add A B
    sto A $_i
    jmp :sys_net_config_while_start_0
:sys_net_config_while_end_0
    ldi A 4294967296
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $_local_host_id
    stack A $DATASTACK_PTR
    call @HAL.configure
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :sys_net_config_if_end_1
:sys_net_config_if_else_1
    call @rt_drop
    call @rt_drop
    stack Z $DATASTACK_PTR
:sys_net_config_if_end_1
:sys_net_config_if_end_0
    ret
@sys_net_bind
    ldm A $_net_is_configured
    tst A 0
    jmpt :sys_net_bind_if_else_3
    call @rt_swap
    ldm A $_port_map
    stack A $DATASTACK_PTR
    call @DICT.put
    jmp :sys_net_bind_if_end_3
:sys_net_bind_if_else_3
    call @rt_drop
    call @rt_drop
:sys_net_bind_if_end_3
    ret
@_net_write_byte

        ustack A $DATASTACK_PTR ; Address
        ustack C $DATASTACK_PTR ; Value
        ld I A
        stx C $_start_memory_
        ret
@_net_read_byte

        ustack A $DATASTACK_PTR ; Address
        ld I A
        ldx C $_start_memory_
        stack C $DATASTACK_PTR  ; Push value
        ret
@_net_write_16
    ustack A $DATASTACK_PTR
    sto A $w16_off
    ustack A $DATASTACK_PTR
    sto A $w16_val
    ldm A $_tx_scratchpad
    sto A $w16_base
    ldm B $w16_val
    ldi A 256
    dmod B A
    stack A $DATASTACK_PTR
    ldm B $w16_base
    ldm A $w16_off
    add B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @_net_write_byte
    ldm B $w16_val
    ldi A 256
    dmod B A
    stack B $DATASTACK_PTR
    ldm B $w16_base
    ldm A $w16_off
    add B A
    stack B $DATASTACK_PTR
    call @_net_write_byte
    ret
@_net_write_32
    ustack A $DATASTACK_PTR
    sto A $w32_off
    ustack A $DATASTACK_PTR
    sto A $w32_val
    ldm A $_tx_scratchpad
    sto A $w32_base
    ldm B $w32_val
    ldi A 256
    dmod B A
    stack A $DATASTACK_PTR
    ldm B $w32_base
    ldm A $w32_off
    add B A
    ldi A 3
    add B A
    stack B $DATASTACK_PTR
    call @_net_write_byte
    ldm B $w32_val
    ldi A 256
    dmod B A
    ld A B
    sto A $w32_val
    ld B A
    ldi A 256
    dmod B A
    stack A $DATASTACK_PTR
    ldm B $w32_base
    ldm A $w32_off
    add B A
    ldi A 2
    add B A
    stack B $DATASTACK_PTR
    call @_net_write_byte
    ldm B $w32_val
    ldi A 256
    dmod B A
    ld A B
    sto A $w32_val
    ld B A
    ldi A 256
    dmod B A
    stack A $DATASTACK_PTR
    ldm B $w32_base
    ldm A $w32_off
    add B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @_net_write_byte
    ldm B $w32_val
    ldi A 256
    dmod B A
    stack B $DATASTACK_PTR
    ldm B $w32_base
    ldm A $w32_off
    add B A
    stack B $DATASTACK_PTR
    call @_net_write_byte
    ret
@sys_net_send
    ldm A $_net_is_configured
    tst A 0
    jmpt :sys_net_send_if_else_4
    ustack A $DATASTACK_PTR
    sto A $usr_pkt_ptr
    ld B A
    ldi A 3
    add A B
    sto A $usr_tmp_ptr
    ldm I $usr_tmp_ptr
    ldx A $_start_memory_
    sto A $payload_len
    stack A $DATASTACK_PTR
    ldi A 240
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sys_net_send_if_else_5
    stack Z $DATASTACK_PTR
    jmp :sys_net_send_if_end_5
:sys_net_send_if_else_5
    ldm A $usr_pkt_ptr
    sto A $usr_tmp_ptr
    ldm I $usr_tmp_ptr
    ldx A $_start_memory_
    sto A $dest_id
    ldm B $usr_tmp_ptr
    ldi A 1
    add A B
    sto A $usr_tmp_ptr
    ldm I $usr_tmp_ptr
    ldx A $_start_memory_
    sto A $dest_port
    ldm B $usr_tmp_ptr
    ldi A 1
    add A B
    sto A $usr_tmp_ptr
    ldm I $usr_tmp_ptr
    ldx A $_start_memory_
    sto A $src_port
    ldm B $usr_tmp_ptr
    ldi A 1
    add A B
    sto A $usr_tmp_ptr
    ld B A
    ldi A 1
    add A B
    sto A $payload_ptr
    ldm A $dest_id
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @_net_write_32
    ldm A $_local_host_id
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @_net_write_32
    ldm A $dest_port
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    call @_net_write_16
    ldm A $src_port
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @_net_write_16
    stack Z $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    call @_net_write_32
    ld A Z
    sto A $__index
:sys_net_send_while_start_1
    ldm A $__index
    stack A $DATASTACK_PTR
    ldm A $payload_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sys_net_send_while_end_1
    ldm B $payload_ptr
    ldm A $__index
    add B A
    stack B $DATASTACK_PTR
    call @_net_read_byte
    ldm B $_tx_scratchpad
    ldi A 16
    add B A
    ldm A $__index
    add B A
    stack B $DATASTACK_PTR
    call @_net_write_byte
    ldm B $__index
    ldi A 1
    add A B
    sto A $__index
    jmp :sys_net_send_while_start_1
:sys_net_send_while_end_1
    ldi A 16
    ld B A
    ldm A $payload_len
    add B A
    stack B $DATASTACK_PTR
    ldm A $_tx_scratchpad
    stack A $DATASTACK_PTR
    call @rt_swap
    call @HAL.send_raw
    ldi A 1
    stack A $DATASTACK_PTR
:sys_net_send_if_end_5
    jmp :sys_net_send_if_end_4
:sys_net_send_if_else_4
    call @rt_drop
    stack Z $DATASTACK_PTR
:sys_net_send_if_end_4
    ret
@_net_read_16_be
    ustack A $DATASTACK_PTR
    sto A $r16_addr
    stack A $DATASTACK_PTR
    call @_net_read_byte
    ldi A 256
    ustack B $DATASTACK_PTR
    mul A B
    sto A $_r16_val
    ldm B $r16_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @_net_read_byte
    ldm A $_r16_val
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ret
@_net_read_32_be
    ustack A $DATASTACK_PTR
    sto A $r32_addr
    stack A $DATASTACK_PTR
    call @_net_read_byte
    ldi A 256
    ustack B $DATASTACK_PTR
    mul B A
    ldi A 256
    mul B A
    ldi A 256
    mul A B
    sto A $_r32_val
    ldm B $r32_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @_net_read_byte
    ldi A 256
    ustack B $DATASTACK_PTR
    mul B A
    ldi A 256
    mul B A
    ldm A $_r32_val
    add A B
    sto A $_r32_val
    ldm B $r32_addr
    ldi A 2
    add B A
    stack B $DATASTACK_PTR
    call @_net_read_byte
    ldi A 256
    ustack B $DATASTACK_PTR
    mul B A
    ldm A $_r32_val
    add A B
    sto A $_r32_val
    ldm B $r32_addr
    ldi A 3
    add B A
    stack B $DATASTACK_PTR
    call @_net_read_byte
    ldm A $_r32_val
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ret
@_net_poll
    ldm A $_net_is_configured
    tst A 0
    jmpt :_net_poll_if_end_6
    call @HAL.rx_available
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_net_poll_if_end_7
    ldm A $_packet_pool
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_net_poll_if_else_8
    ld A Z
    sto A $rx_buf_ptr
    jmp :_net_poll_if_end_8
:_net_poll_if_else_8
    ldm A $_packet_pool
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $rx_buf_ptr
:_net_poll_if_end_8
    ldm A $rx_buf_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_net_poll_if_else_9
    call @HAL.rx_peek_len
    ustack A $DATASTACK_PTR
    sto A $raw_len
    ldm A $rx_buf_ptr
    stack A $DATASTACK_PTR
    call @HAL.rx_copy_and_advance
    ldm A $rx_buf_ptr
    stack A $DATASTACK_PTR
    call @_net_read_32_be
    ustack A $DATASTACK_PTR
    sto A $pkt_dest_id
    stack A $DATASTACK_PTR
    ldm A $_local_host_id
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_net_poll_if_else_10
    ldm B $rx_buf_ptr
    ldi A 4
    add B A
    stack B $DATASTACK_PTR
    call @_net_read_32_be
    ustack A $DATASTACK_PTR
    sto A $pkt_src_id
    ldm B $rx_buf_ptr
    ldi A 8
    add B A
    stack B $DATASTACK_PTR
    call @_net_read_16_be
    ustack A $DATASTACK_PTR
    sto A $pkt_dest_port
    ldm B $rx_buf_ptr
    ldi A 10
    add B A
    stack B $DATASTACK_PTR
    call @_net_read_16_be
    ustack A $DATASTACK_PTR
    sto A $pkt_src_port
    ldm B $raw_len
    ldi A 16
    sub B A
    ld A B
    sto A $_poll_payload_len
    ld A Z
    sto A $_poll_i
:_net_poll_while_start_2
    ldm A $_poll_i
    stack A $DATASTACK_PTR
    ldm A $_poll_payload_len
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_net_poll_while_end_2
    ldm B $rx_buf_ptr
    ldi A 16
    add B A
    ldm A $_poll_i
    add B A
    stack B $DATASTACK_PTR
    call @_net_read_byte
    ustack A $DATASTACK_PTR
    sto A $byte_val
    stack A $DATASTACK_PTR
    ldm B $rx_buf_ptr
    ldi A 4
    add B A
    ldm A $_poll_i
    add B A
    stack B $DATASTACK_PTR
    call @_net_write_byte
    ldm B $_poll_i
    ldi A 1
    add A B
    sto A $_poll_i
    jmp :_net_poll_while_start_2
:_net_poll_while_end_2
    ldm A $rx_buf_ptr
    sto A $_poll_tmp_ptr
    ldm A $pkt_src_id
    ld B A
    ldm I $_poll_tmp_ptr
    stx B $_start_memory_
    ldm B $_poll_tmp_ptr
    ldi A 1
    add A B
    sto A $_poll_tmp_ptr
    ldm A $pkt_dest_port
    ld B A
    ldm I $_poll_tmp_ptr
    stx B $_start_memory_
    ldm B $_poll_tmp_ptr
    ldi A 1
    add A B
    sto A $_poll_tmp_ptr
    ldm A $pkt_src_port
    ld B A
    ldm I $_poll_tmp_ptr
    stx B $_start_memory_
    ldm B $_poll_tmp_ptr
    ldi A 1
    add A B
    sto A $_poll_tmp_ptr
    ldm A $_poll_payload_len
    ld B A
    ldm I $_poll_tmp_ptr
    stx B $_start_memory_
    ldm A $pkt_dest_port
    stack A $DATASTACK_PTR
    ldm A $_port_map
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $dest_deque_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_net_poll_if_else_11
    ldm A $rx_buf_ptr
    stack A $DATASTACK_PTR
    ldm A $dest_deque_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.append
    jmp :_net_poll_if_end_11
:_net_poll_if_else_11
    ldm A $rx_buf_ptr
    stack A $DATASTACK_PTR
    call @sys_net_free
:_net_poll_if_end_11
    jmp :_net_poll_if_end_10
:_net_poll_if_else_10
    ldm A $rx_buf_ptr
    stack A $DATASTACK_PTR
    call @sys_net_free
:_net_poll_if_end_10
    jmp :_net_poll_if_end_9
:_net_poll_if_else_9
    call @HAL.rx_skip_and_advance
:_net_poll_if_end_9
:_net_poll_if_end_7
:_net_poll_if_end_6
    ret
@sys_net_free
    ldm A $_net_is_configured
    tst A 0
    jmpt :sys_net_free_if_else_12
    ldm A $_packet_pool
    stack A $DATASTACK_PTR
    call @DEQUE.append
    jmp :sys_net_free_if_end_12
:sys_net_free_if_else_12
    call @rt_drop
:sys_net_free_if_end_12
    ret
@sys_net_recv
    call @_net_poll
    ret

# .DATA
% $_tx_scratchpad 0
% $_net_is_configured 0
% $_port_map 0
% $_packet_pool 0
% $_local_host_id 0
% $_rx_buffer_size 0
% $_i 0
% $w16_off 0
% $w16_val 0
% $w16_base 0
% $w32_off 0
% $w32_val 0
% $w32_base 0
% $usr_pkt_ptr 0
% $usr_tmp_ptr 0
% $payload_len 0
% $dest_id 0
% $dest_port 0
% $src_port 0
% $payload_ptr 0
% $__index 0
% $r16_addr 0
% $_r16_val 0
% $r32_addr 0
% $_r32_val 0
% $rx_buf_ptr 0
% $raw_len 0
% $pkt_dest_id 0
% $pkt_src_id 0
% $pkt_dest_port 0
% $pkt_src_port 0
% $_poll_payload_len 0
% $dest_deque_ptr 0
% $_poll_i 0
% $byte_val 0
% $_poll_tmp_ptr 0
