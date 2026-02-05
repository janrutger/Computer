# .HEADER
. $_dict_ptr 1
. $_dict_cap 1
. $_dict_cnt 1
. $_dict_key 1
. $_dict_val 1
. $_dict_idx 1
. $_dict_found 1
. $_dict_offset 1
. $_dict_last_off 1
. $_dict_last_key 1
. $_dict_last_val 1
. $_dict_err_full 30
. $_dict_err_key 25
. $_dict_err_bnd 32
. $_dict_err_inv_key 49
. $DEQUE_FREE_HEAD 1
. $DEQUE_POOL_PAGE_SIZE 1
. $_dq_i 1
. $_dq_ptr 1
. $_dq_next_ptr 1
. $_dq_node 1
. $_dq_val 1
. $_dq_list 1
. $_dq_head 1
. $_dq_tail 1
. $_dq_prev 1
. $_dq_next 1
. $_dq_err_empty 27
. $opcode_table 1
. $opcode_runtimes 1
. $label_addresses 1
. $_env_vvm_ptr 1
. $_env_sp_ptr_loc 1
. $_env_sp_addr 1
. $_env_val 1
. $_env_host_ptr_loc 1
. $_env_host_dq 1
. $_env_count 1
. $_env_ptr 1
. $_env_idx 1
. $_env_val_tmp 1
. $_math_a 1
. $_math_b 1
. $_temp_ptr 1
. $_temp_idx 1
. $_temp_val 1
. $_scan_ptr 1
. $_vvm_pc_offset 1
. $_opcode 1
. $_is_opcode 1
. $error_no_code 26
. $error_no_opcode 28
. $error_label_unknown 23
. $error_vvm_overflow 23
. $msg_labels_found 15
. $_run_pc 1
. $_run_opcode 1
. $_run_handler 1
. $_start_argc 1
. $_start_idx 1
. $_VVMpointer 1
. $_VVMHOSTpointer 1
. $_VVMsize 1
. $_SIMPLcode 1
. $_vvm_max_size 1
. $_vvm_needed_size 1
. $_vvm_code_start 1
. $_vvm_write_ptr 1
. $VVM0 1
. $host_comm_deque_ptr 1
. $SIMPL_code 1
. $main_str_0 29
. $main_str_1 30
. $main_str_2 30
. $main_str_3 30
. $main_str_4 30
. $main_str_5 30
. $main_str_6 23
. $main_str_7 14

# .CODE
    call @main
    ret

# .FUNCTIONS

@DICT.new
    ustack A $DATASTACK_PTR
    sto A $_dict_cap
    ld B A
    ldi A 2
    mul B A
    ldi A 2
    add B A
    stack B $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ldm A $_dict_cap
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    ret
@DICT.count
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DICT.put
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ustack A $DATASTACK_PTR
    sto A $_dict_val
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_end_0
    ldi A $_dict_err_inv_key
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DICT.put_if_end_0
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_found
    ld A Z
    sto A $_dict_idx
:DICT.put_while_start_0
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_while_end_0
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_else_1
    ldm A $_dict_val
    stack A $DATASTACK_PTR
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 1
    sto A $_dict_found
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.put_if_end_1
:DICT.put_if_else_1
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.put_if_end_1
    jmp :DICT.put_while_start_0
:DICT.put_while_end_0
    ldm A $_dict_found
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_end_2
    stack Z $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cap
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    ldm A $_dict_cap
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_end_3
    ldi A $_dict_err_full
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DICT.put_if_end_3
    ldm B $_dict_cnt
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    ldm A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_val
    stack A $DATASTACK_PTR
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_dict_cnt
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
:DICT.put_if_end_2
    ret
@DICT.get
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_found
    ld A Z
    sto A $_dict_idx
:DICT.get_while_start_1
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.get_while_end_1
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.get_if_else_4
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 1
    sto A $_dict_found
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.get_if_end_4
:DICT.get_if_else_4
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.get_if_end_4
    jmp :DICT.get_while_start_1
:DICT.get_while_end_1
    ldm A $_dict_found
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.get_if_end_5
    ldi A $_dict_err_key
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DICT.get_if_end_5
    ret
@DICT.has_key
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_found
    ld A Z
    sto A $_dict_idx
:DICT.has_key_while_start_2
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.has_key_while_end_2
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.has_key_if_else_6
    ldi A 1
    sto A $_dict_found
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.has_key_if_end_6
:DICT.has_key_if_else_6
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.has_key_if_end_6
    jmp :DICT.has_key_while_start_2
:DICT.has_key_while_end_2
    ldm A $_dict_found
    stack A $DATASTACK_PTR
    ret
@DICT.remove
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_idx
:DICT.remove_while_start_3
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.remove_while_end_3
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.remove_if_else_7
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm B $_dict_cnt
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.remove_if_end_8
    ldm B $_dict_cnt
    ldi A 1
    sub B A
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_last_off
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_last_key
    ldm B $_dict_last_off
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_last_val
    ldm A $_dict_last_key
    stack A $DATASTACK_PTR
    ldm A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_last_val
    stack A $DATASTACK_PTR
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
:DICT.remove_if_end_8
    ldm B $_dict_cnt
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.remove_if_end_7
:DICT.remove_if_else_7
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.remove_if_end_7
    jmp :DICT.remove_while_start_3
:DICT.remove_while_end_3
    ret
@DICT.clear
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@DICT.item
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_idx
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.item_if_else_9
    ldm B $_dict_idx
    ldi A 2
    mul B A
    ldi A 2
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    jmp :DICT.item_if_end_9
:DICT.item_if_else_9
    ldi A $_dict_err_bnd
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DICT.item_if_end_9
    ret


@_DEQUE.grow_pool
    ldm B $DEQUE_POOL_PAGE_SIZE
    ldi A 3
    mul B A
    stack B $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_dq_ptr
    ld A Z
    sto A $_dq_i
:_DEQUE.grow_pool_while_start_0
    ldm A $_dq_i
    stack A $DATASTACK_PTR
    ldm B $DEQUE_POOL_PAGE_SIZE
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_DEQUE.grow_pool_while_end_0
    ldm A $_dq_ptr
    stack A $DATASTACK_PTR
    ldm B $_dq_i
    ldi A 3
    mul A B
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dq_node
    ldm A $_dq_ptr
    stack A $DATASTACK_PTR
    ldm B $_dq_i
    ldi A 1
    add B A
    ldi A 3
    mul A B
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dq_next_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_dq_i
    ldi A 1
    add A B
    sto A $_dq_i
    jmp :_DEQUE.grow_pool_while_start_0
:_DEQUE.grow_pool_while_end_0
    ldm A $_dq_ptr
    stack A $DATASTACK_PTR
    ldm B $_dq_i
    ldi A 3
    mul A B
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dq_node
    ldm A $DEQUE_FREE_HEAD
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_ptr
    sto A $DEQUE_FREE_HEAD
    ret
@DEQUE.init_pool
    ustack A $DATASTACK_PTR
    sto A $DEQUE_POOL_PAGE_SIZE
    ld A Z
    sto A $DEQUE_FREE_HEAD
    call @_DEQUE.grow_pool
    ret
@_DEQUE.alloc_node
    ldm A $DEQUE_FREE_HEAD
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_DEQUE.alloc_node_if_end_0
    call @_DEQUE.grow_pool
:_DEQUE.alloc_node_if_end_0
    ldm A $DEQUE_FREE_HEAD
    sto A $_dq_node
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $DEQUE_FREE_HEAD
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ret
@_DEQUE.free_node
    ustack A $DATASTACK_PTR
    sto A $_dq_node
    ldm A $DEQUE_FREE_HEAD
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_node
    sto A $DEQUE_FREE_HEAD
    ret
@DEQUE.new
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    ret
@DEQUE.is_empty
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    stack Z $DATASTACK_PTR
    call @rt_eq
    ret
@DEQUE.push
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    ustack A $DATASTACK_PTR
    sto A $_dq_val
    call @_DEQUE.alloc_node
    ustack A $DATASTACK_PTR
    sto A $_dq_node
    ldm A $_dq_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_head
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.push_if_else_1
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :DEQUE.push_if_end_1
:DEQUE.push_if_else_1
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
:DEQUE.push_if_end_1
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@DEQUE.append
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    ustack A $DATASTACK_PTR
    sto A $_dq_val
    call @_DEQUE.alloc_node
    ustack A $DATASTACK_PTR
    sto A $_dq_node
    ldm A $_dq_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_tail
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.append_if_else_2
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :DEQUE.append_if_end_2
:DEQUE.append_if_else_2
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
:DEQUE.append_if_end_2
    ldm A $_dq_node
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_head
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.pop_if_end_3
    ldi A $_dq_err_empty
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DEQUE.pop_if_end_3
    stack Z $DATASTACK_PTR
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_val
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_next
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_next
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.pop_if_else_4
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_next
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :DEQUE.pop_if_end_4
:DEQUE.pop_if_else_4
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
:DEQUE.pop_if_end_4
    ldm A $_dq_head
    stack A $DATASTACK_PTR
    call @_DEQUE.free_node
    ldm A $_dq_val
    stack A $DATASTACK_PTR
    ret
@DEQUE.pop_tail
    ustack A $DATASTACK_PTR
    sto A $_dq_list
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_tail
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.pop_tail_if_end_5
    ldi A $_dq_err_empty
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:DEQUE.pop_tail_if_end_5
    stack Z $DATASTACK_PTR
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_val
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dq_prev
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dq_prev
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DEQUE.pop_tail_if_else_6
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dq_prev
    stack A $DATASTACK_PTR
    call @LIST.put
    jmp :DEQUE.pop_tail_if_end_6
:DEQUE.pop_tail_if_else_6
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dq_list
    stack A $DATASTACK_PTR
    call @LIST.put
:DEQUE.pop_tail_if_end_6
    ldm A $_dq_tail
    stack A $DATASTACK_PTR
    call @_DEQUE.free_node
    ldm A $_dq_val
    stack A $DATASTACK_PTR
    ret
@DEQUE.head
    stack Z $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DEQUE.tail
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DEQUE.is_last
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    stack Z $DATASTACK_PTR
    call @rt_eq
    ret
@DEQUE.is_first
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    stack Z $DATASTACK_PTR
    call @rt_eq
    ret
@DEQUE.next
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DEQUE.prev
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DEQUE.value
    stack Z $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret


@VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_ptr
    ustack A $DATASTACK_PTR
    sto A $_env_idx
    ldm I $_env_ptr
    ldx A $_start_memory_
    sto A $_env_ptr
    ld B A
    ldm A $_env_idx
    add A B
    sto A $_env_ptr
    ldm I $_env_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@VVMpoke
    ustack A $DATASTACK_PTR
    sto A $_env_ptr
    ustack A $DATASTACK_PTR
    sto A $_env_idx
    ustack A $DATASTACK_PTR
    sto A $_env_val_tmp
    ldm I $_env_ptr
    ldx A $_start_memory_
    sto A $_env_ptr
    ld B A
    ldm A $_env_idx
    add A B
    sto A $_env_ptr
    ldm A $_env_val_tmp
    ld B A
    ldm I $_env_ptr
    stx B $_start_memory_
    ret
@s_halt
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 4
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_nop
    ret
@s_sys
    ret
@s_out
    ret
@s_fetch
    ret
@s_dup
    ret
@s_drop
    ret
@s_swap
    ret
@s_over
    ret
@s_add
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ld B A
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_b
    ldm B $_env_sp_addr
    ldi A 1
    sub B A
    ld A B
    sto A $_env_sp_addr
    ldm I $_env_sp_addr
    ldx A $_start_memory_
    sto A $_math_a
    ld B A
    ldm A $_math_b
    add B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_sub
    ret
@s_mul
    ret
@s_div
    ret
@s_mod
    ret
@s_push
    ustack A $DATASTACK_PTR
    sto A $_env_vvm_ptr
    ustack A $DATASTACK_PTR
    sto A $_env_val
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_env_sp_addr
    ldm A $_env_val
    ld B A
    ldm I $_env_sp_addr
    stx B $_start_memory_
    ldm B $_env_sp_addr
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_env_vvm_ptr
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@s_get
    ret
@s_set
    ret
@s_bra
    ret
@s_brz
    ret
@s_bnz
    ret
@s_brp
    ret
@s_brn
    ret
@VVM.init
    ldi A 100
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $opcode_table
    ldi A 100
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $opcode_runtimes
    ldi A 100
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $label_addresses
    stack Z $DATASTACK_PTR
    ldi A 6384101742
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_halt
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 193464626
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_nop
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 193470404
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_sys
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 193465917
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_out
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 210673137615
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_fetch
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 193453934
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_dup
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 11
    stack A $DATASTACK_PTR
    ldi A 6383976602
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_drop
    stack A $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 12
    stack A $DATASTACK_PTR
    ldi A 6384520640
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_swap
    stack A $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 13
    stack A $DATASTACK_PTR
    ldi A 6384375937
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_over
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_add
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 193470255
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_sub
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 193463731
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_mul
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 23
    stack A $DATASTACK_PTR
    ldi A 193453544
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_div
    stack A $DATASTACK_PTR
    ldi A 23
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 24
    stack A $DATASTACK_PTR
    ldi A 193463525
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_mod
    stack A $DATASTACK_PTR
    ldi A 24
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 50
    stack A $DATASTACK_PTR
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_push
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 51
    stack A $DATASTACK_PTR
    ldi A 193456677
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_get
    stack A $DATASTACK_PTR
    ldi A 51
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 52
    stack A $DATASTACK_PTR
    ldi A 193469745
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_set
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 60
    stack A $DATASTACK_PTR
    ldi A 210680089861
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A 61
    stack A $DATASTACK_PTR
    ldi A 193451642
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_bra
    stack A $DATASTACK_PTR
    ldi A 61
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 62
    stack A $DATASTACK_PTR
    ldi A 193451667
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_brz
    stack A $DATASTACK_PTR
    ldi A 62
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 63
    stack A $DATASTACK_PTR
    ldi A 193451535
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_bnz
    stack A $DATASTACK_PTR
    ldi A 63
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 64
    stack A $DATASTACK_PTR
    ldi A 193451657
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_brp
    stack A $DATASTACK_PTR
    ldi A 64
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 65
    stack A $DATASTACK_PTR
    ldi A 193451655
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A @s_brn
    stack A $DATASTACK_PTR
    ldi A 65
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.put
    ret


@VVM.create
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    ustack A $DATASTACK_PTR
    sto A $_VVMHOSTpointer
    ustack A $DATASTACK_PTR
    sto A $_VVMsize
    ustack A $DATASTACK_PTR
    sto A $_SIMPLcode
    ldi A 4
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_VVMsize
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm I $_VVMpointer
    ldx A $_start_memory_
    ld B A
    ldi A 50
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm I $_VVMpointer
    ldx A $_start_memory_
    ld B A
    ldi A 6
    add B A
    stack B $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm I $_VVMHOSTpointer
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.clear
    ld A Z
    sto A $_vvm_pc_offset
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_0
    ldi A $error_no_code
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
    jmp :VVM.create_if_end_0
:VVM.create_if_else_0
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.head
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
:VVM.create_while_start_0
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_while_end_0
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.value
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_1
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_opcode
    stack A $DATASTACK_PTR
    ldi A 60
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_2
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_3
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.value
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    ldm A $_vvm_pc_offset
    stack A $DATASTACK_PTR
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.put
:VVM.create_if_end_3
    jmp :VVM.create_if_end_2
:VVM.create_if_else_2
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_4
    ldm B $_vvm_pc_offset
    ldi A 1
    add A B
    sto A $_vvm_pc_offset
    jmp :VVM.create_if_end_4
:VVM.create_if_else_4
    ldm B $_vvm_pc_offset
    ldi A 2
    add A B
    sto A $_vvm_pc_offset
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
:VVM.create_if_end_4
:VVM.create_if_end_2
    jmp :VVM.create_if_end_1
:VVM.create_if_else_1
    ldi A $error_no_opcode
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_1
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_5
    ldm A $_scan_ptr
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $_scan_ptr
:VVM.create_if_end_5
    jmp :VVM.create_while_start_0
:VVM.create_while_end_0
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.count
    call @PRTnum
    ldi A $msg_labels_found
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :VVM.create_if_end_0
    ldm B $_VVMsize
    ldi A 1024
    mul A B
    sto A $_vvm_max_size
    ldi A 50
    ld B A
    ldm A $_vvm_pc_offset
    add A B
    sto A $_vvm_needed_size
    stack A $DATASTACK_PTR
    ldm A $_vvm_max_size
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_6
    ldi A $error_vvm_overflow
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_6
    ldm I $_VVMpointer
    ldx A $_start_memory_
    sto A $_temp_ptr
    ld B A
    ldi A 50
    add A B
    sto A $_vvm_code_start
    sto A $_vvm_write_ptr
:VVM.create_while_start_1
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_while_end_1
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $opcode_table
    stack A $DATASTACK_PTR
    call @DICT.get
    ustack A $DATASTACK_PTR
    sto A $_opcode
    stack A $DATASTACK_PTR
    ldi A 60
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_7
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_drop
    jmp :VVM.create_if_end_7
:VVM.create_if_else_7
    ldm A $_opcode
    ld B A
    ldm I $_vvm_write_ptr
    stx B $_start_memory_
    ldm B $_vvm_write_ptr
    ldi A 1
    add A B
    sto A $_vvm_write_ptr
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 49
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_end_8
    ldm I $_SIMPLcode
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 60
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_9
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.has_key
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.create_if_else_10
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldm A $label_addresses
    stack A $DATASTACK_PTR
    call @DICT.get
    ldm A $_vvm_code_start
    ustack B $DATASTACK_PTR
    add A B
    sto A $_temp_val
    jmp :VVM.create_if_end_10
:VVM.create_if_else_10
    ldi A $error_label_unknown
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @HALT
:VVM.create_if_end_10
    jmp :VVM.create_if_end_9
:VVM.create_if_else_9
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 51
    stack A $DATASTACK_PTR
    call @rt_eq
    ldm A $_opcode
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add A B
    tst A 0
    jmpt :VVM.create_if_end_11
    ldm I $_temp_val
    ldx A $_start_memory_
    ld B A
    ldi A 65
    sub B A
    ld A B
    sto A $_temp_val
:VVM.create_if_end_11
:VVM.create_if_end_9
    ldm A $_temp_val
    ld B A
    ldm I $_vvm_write_ptr
    stx B $_start_memory_
    ldm B $_vvm_write_ptr
    ldi A 1
    add A B
    sto A $_vvm_write_ptr
:VVM.create_if_end_8
:VVM.create_if_end_7
    jmp :VVM.create_while_start_1
:VVM.create_while_end_1
    ret
@VVM.start
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    ustack A $DATASTACK_PTR
    sto A $_start_argc
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_start_argc
    sto A $_start_idx
:VVM.start_while_start_2
    ldm A $_start_idx
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.start_while_end_2
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    stack A $DATASTACK_PTR
    ldi A 22
    ld B A
    ldm A $_start_idx
    add B A
    stack B $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm B $_start_idx
    ldi A 1
    sub B A
    ld A B
    sto A $_start_idx
    jmp :VVM.start_while_start_2
:VVM.start_while_end_2
    ldm I $_VVMpointer
    ldx A $_start_memory_
    ld B A
    ldi A 50
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ret
@VVM.run
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_temp_val
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.run_if_else_12
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ustack A $DATASTACK_PTR
    sto A $_run_pc
    ldm I $_run_pc
    ldx A $_start_memory_
    sto A $_run_opcode
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.run_if_else_13
    ldi A 1
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    jmp :VVM.run_if_end_13
:VVM.run_if_else_13
    ldm B $_run_pc
    ldi A 1
    add A B
    sto A $_run_pc
    ldm A $_run_opcode
    stack A $DATASTACK_PTR
    ldi A 49
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.run_if_end_14
    ldm I $_run_pc
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm B $_run_pc
    ldi A 1
    add A B
    sto A $_run_pc
:VVM.run_if_end_14
    ldm A $_run_pc
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    ldm A $_run_opcode
    stack A $DATASTACK_PTR
    ldm A $opcode_runtimes
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_run_handler
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    ldm A $_run_handler
    stack A $DATASTACK_PTR
    calls $DATASTACK_PTR
:VVM.run_if_end_13
    jmp :VVM.run_if_end_12
:VVM.run_if_else_12
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.run_if_end_15
    ldm A $_temp_val
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
:VVM.run_if_end_15
:VVM.run_if_end_12
    ret
@VVM.check_syscalls
    ustack A $DATASTACK_PTR
    sto A $_VVMpointer
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VVM.check_syscalls_if_end_16
    ldi A 2
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_VVMpointer
    stack A $DATASTACK_PTR
    call @VVMpoke
:VVM.check_syscalls_if_end_16
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
    sto A $host_comm_deque_ptr
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $SIMPL_code
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 12
    stack A $DATASTACK_PTR
    ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384411237
    stack A $DATASTACK_PTR
    ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 30
    stack A $DATASTACK_PTR
    ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 193450094
    stack A $DATASTACK_PTR
    ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 6384101742
    stack A $DATASTACK_PTR
    ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    call @DEQUE.append
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
        ldm A $SIMPL_code
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $main_str_3
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $host_comm_deque_ptr
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $main_str_4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $VVM0
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $main_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $VVM0
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $SIMPL_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $host_comm_deque_ptr
    stack A $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $main_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    ldi A $VVM0
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
    call @VVM.run
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
:DEBUG
    ret

# .DATA

% $_dict_ptr 0
% $_dict_cap 0
% $_dict_cnt 0
% $_dict_key 0
% $_dict_val 0
% $_dict_idx 0
% $_dict_found 0
% $_dict_offset 0
% $_dict_last_off 0
% $_dict_last_key 0
% $_dict_last_val 0
% $_dict_err_full \D \I \C \T \. \p \u \t \: \space \D \i \c \t \i \o \n \a \r \y \space \i \s \space \f \u \l \l \Return \null
% $_dict_err_key \D \I \C \T \. \g \e \t \: \space \K \e \y \space \n \o \t \space \f \o \u \n \d \Return \null
% $_dict_err_bnd \D \I \C \T \. \i \t \e \m \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $_dict_err_inv_key \D \I \C \T \. \p \u \t \: \space \K \e \y \space \0 \space \i \s \space \r \e \s \e \r \v \e \d \space \a \n \d \space \c \a \n \n \o \t \space \b \e \space \u \s \e \d \. \Return \null

% $DEQUE_FREE_HEAD 0
% $DEQUE_POOL_PAGE_SIZE 0
% $_dq_i 0
% $_dq_ptr 0
% $_dq_next_ptr 0
% $_dq_node 0
% $_dq_val 0
% $_dq_list 0
% $_dq_head 0
% $_dq_tail 0
% $_dq_prev 0
% $_dq_next 0
% $_dq_err_empty \D \E \Q \U \E \. \p \o \p \: \space \D \e \q \u \e \space \i \s \space \e \m \p \t \y \Return \null

% $opcode_table 0
% $opcode_runtimes 0
% $label_addresses 0
% $_env_vvm_ptr 0
% $_env_sp_ptr_loc 0
% $_env_sp_addr 0
% $_env_val 0
% $_env_host_ptr_loc 0
% $_env_host_dq 0
% $_env_count 0
% $_env_ptr 0
% $_env_idx 0
% $_env_val_tmp 0
% $_math_a 0
% $_math_b 0

% $_temp_ptr 0
% $_temp_idx 0
% $_temp_val 0
% $_scan_ptr 0
% $_vvm_pc_offset 0
% $_opcode 0
% $_is_opcode 0
% $error_no_code \N \o \space \S \I \M \P \L \space \c \o \d \e \space \p \r \o \v \i \d \e \d \. \space \Return \null
% $error_no_opcode \V \V \M \space \i \n \v \a \l \i \d \space \O \P \C \O \D \E \space \f \o \u \n \d \. \space \Return \null
% $error_label_unknown \V \V \M \space \l \a \b \e \l \space \n \o \t \space \f \o \u \n \d \. \space \Return \null
% $error_vvm_overflow \V \V \M \space \m \e \m \o \r \y \space \o \v \e \r \f \l \o \w \. \space \Return \null
% $msg_labels_found \space \l \a \b \e \l \s \space \f \o \u \n \d \Return \null
% $_run_pc 0
% $_run_opcode 0
% $_run_handler 0
% $_start_argc 0
% $_start_idx 0
% $_VVMpointer 0
% $_VVMHOSTpointer 0
% $_VVMsize 0
% $_SIMPLcode 0
% $_vvm_max_size 0
% $_vvm_needed_size 0
% $_vvm_code_start 0
% $_vvm_write_ptr 0
% $VVM0 15360
% $host_comm_deque_ptr 0
% $SIMPL_code 0
% $main_str_0 \P \o \o \l \space \i \n \i \t \i \a \l \i \z \e \d \space \( \s \i \z \e \space \1 \0 \) \. \Return \null
% $main_str_1 \V \V \M \space \E \n \v \i \r \o \n \m \e \n \t \space \I \n \i \t \i \a \l \i \z \e \d \. \Return \null
% $main_str_2 \S \I \M \P \L \_ \c \o \d \e \space \p \o \i \n \t \e \r \space \space \space \space \space \space \space \space \space \: \space \null
% $main_str_3 \h \o \s \t \_ \c \o \m \m \_ \d \e \q \u \e \_ \p \t \r \space \p \o \i \n \t \e \r \: \space \null
% $main_str_4 \V \V \M \0 \space \b \a \s \e \space \a \d \d \r \e \s \s \space \space \space \space \space \space \space \space \space \space \: \space \null
% $main_str_5 \A \d \d \r \e \s \s \space \o \f \space \V \V \M \0 \space \v \a \r \i \a \b \l \e \space \space \space \: \space \null
% $main_str_6 \V \V \M \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \null
% $main_str_7 \V \V \M \space \s \t \a \r \t \e \d \space \Return \null
