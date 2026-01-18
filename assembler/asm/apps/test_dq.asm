# .HEADER
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
. $my_deque 1
. $my_deque2 1
. $node 1
. $_main_str_0 28
. $_main_str_1 20
. $_main_str_2 19
. $_main_str_3 20
. $_main_str_4 27
. $_main_str_5 26
. $_main_str_6 19
. $_main_str_7 19
. $_main_str_8 11
. $_main_str_9 40
. $_main_str_10 19
. $_main_str_11 19
. $_main_str_12 19
. $_main_str_13 19
. $_main_str_14 22
. $_main_str_15 22
. $_main_str_16 22
. $_main_str_17 22

# .CODE
    call @HEAP.free
    ldi A 2
    stack A $DATASTACK_PTR
    call @DEQUE.init_pool
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $my_deque
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.push
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.push
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.push
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.append
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.head
    ustack A $DATASTACK_PTR
    sto A $node
:_main_while_start_0
    ldm A $node
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
    ldm A $node
    stack A $DATASTACK_PTR
    call @DEQUE.value
    call @rt_print_tos
    ldm A $node
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $node
    jmp :_main_while_start_0
:_main_while_end_0
    ldi A $_main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_print_tos
    ldi A $_main_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    call @rt_print_tos
    ldi A $_main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.head
    ustack A $DATASTACK_PTR
    sto A $node
:_main_while_start_1
    ldm A $node
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_1
    ldm A $node
    stack A $DATASTACK_PTR
    call @DEQUE.value
    call @rt_print_tos
    ldm A $node
    stack A $DATASTACK_PTR
    call @DEQUE.next
    ustack A $DATASTACK_PTR
    sto A $node
    jmp :_main_while_start_1
:_main_while_end_1
    ldi A $_main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
:_main_while_start_2
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_2
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_drop
    jmp :_main_while_start_2
:_main_while_end_2
    ldi A $_main_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.is_empty
    call @rt_print_tos
    ldi A $_main_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $my_deque2
    ldi A $_main_str_10
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 100
    stack A $DATASTACK_PTR
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.push
    ldi A $_main_str_11
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 200
    stack A $DATASTACK_PTR
    ldm A $my_deque2
    stack A $DATASTACK_PTR
    call @DEQUE.push
    ldi A $_main_str_12
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 101
    stack A $DATASTACK_PTR
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.push
    ldi A $_main_str_13
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 201
    stack A $DATASTACK_PTR
    ldm A $my_deque2
    stack A $DATASTACK_PTR
    call @DEQUE.push
    ldi A $_main_str_14
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_print_tos
    ldi A $_main_str_15
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_deque2
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_print_tos
    ldi A $_main_str_16
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_print_tos
    ldi A $_main_str_17
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_deque2
    stack A $DATASTACK_PTR
    call @DEQUE.pop
    call @rt_print_tos
    ldm A $my_deque
    stack A $DATASTACK_PTR
    call @DEQUE.pop_tail
    ret

# .FUNCTIONS

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
    stack B $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
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
    call @PRTstring
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
    call @PRTstring
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


# .DATA

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
% $my_deque 0
% $my_deque2 0
% $node 0
% $_main_str_0 \P \o \o \l \space \i \n \i \t \i \a \l \i \z \e \d \space \( \s \i \z \e \space \2 \) \. \Return \null
% $_main_str_1 \P \u \s \h \i \n \g \space \1 \, \space \2 \, \space \3 \. \. \. \Return \null
% $_main_str_2 \A \p \p \e \n \d \i \n \g \space \4 \, \space \5 \. \. \. \Return \null
% $_main_str_3 \T \r \a \v \e \r \s \i \n \g \space \d \e \q \u \e \: \space \Return \null
% $_main_str_4 \P \o \p \p \i \n \g \space \f \r \o \n \t \space \( \e \x \p \e \c \t \space \3 \) \: \space \null
% $_main_str_5 \P \o \p \p \i \n \g \space \b \a \c \k \space \( \e \x \p \e \c \t \space \5 \) \: \space \null
% $_main_str_6 \R \e \m \a \i \n \i \n \g \space \d \e \q \u \e \: \space \Return \null
% $_main_str_7 \E \m \p \t \y \i \n \g \space \d \e \q \u \e \. \. \. \Return \null
% $_main_str_8 \I \s \space \e \m \p \t \y \? \space \null
% $_main_str_9 \Return \- \- \- \space \T \e \s \t \: \space \T \w \o \space \D \e \q \u \e \s \space \S \h \a \r \i \n \g \space \P \o \o \l \space \- \- \- \Return \null
% $_main_str_10 \P \u \s \h \i \n \g \space \1 \0 \0 \space \t \o \space \D \1 \Return \null
% $_main_str_11 \P \u \s \h \i \n \g \space \2 \0 \0 \space \t \o \space \D \2 \Return \null
% $_main_str_12 \P \u \s \h \i \n \g \space \1 \0 \1 \space \t \o \space \D \1 \Return \null
% $_main_str_13 \P \u \s \h \i \n \g \space \2 \0 \1 \space \t \o \space \D \2 \Return \null
% $_main_str_14 \D \1 \space \P \o \p \space \( \e \x \p \e \c \t \space \1 \0 \1 \) \: \space \null
% $_main_str_15 \D \2 \space \P \o \p \space \( \e \x \p \e \c \t \space \2 \0 \1 \) \: \space \null
% $_main_str_16 \D \1 \space \P \o \p \space \( \e \x \p \e \c \t \space \1 \0 \0 \) \: \space \null
% $_main_str_17 \D \2 \space \P \o \p \space \( \e \x \p \e \c \t \space \2 \0 \0 \) \: \space \null
