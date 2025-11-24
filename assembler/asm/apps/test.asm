# .HEADER
. $HEAP_START 1
. $HEAP_SIZE 1
. $HEAP_FREE 1
. $_ARR_TEMP_PTR 1
. $_ARR_VALUE_PTR 1
. $error_mesg0 29
. $error_mesg1 29
. $error_mesg2 32
. $error_mesg3 32
. $requested_capacity 1
. $total_size 1
. $new_array_pointer 1
. $array_ptr 1
. $_value 1
. $_capacity 1
. $_count 1
. $dest_addr 1
. $_index 1
. $read_addr 1
. $listlen 1
. $N 1
. $val1 1
. $val2 1
. $sorting 1
MALLOC $array_heap 6144
. $sortlist 1
. $size 1
. $listlenn 1
. $NN 1
. $_main_str_0 12
. $_main_str_1 7

# .CODE
    ldi A $array_heap
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    call @HEAP.init
    ldi A 500
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.size
    ustack A $DATASTACK_PTR
    sto A $size
    ldi A 0
    sto A $N
:_main_while_start_0
    ldm A $N
    stack A $DATASTACK_PTR
    ldm A $size
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
    call @rt_rnd
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $N
    jmp :_main_while_start_0
:_main_while_end_0
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1
    stack A $DATASTACK_PTR
    call @TIME.start
    call @sort_list
    ldi A 1
    stack A $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A 32
    stack A $DATASTACK_PTR
    call @PRTchar
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1
    stack A $DATASTACK_PTR
    call @TIME.start
    call @plotlist
    ldi A 1
    stack A $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A 32
    stack A $DATASTACK_PTR
    call @PRTchar
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ret

# .FUNCTIONS

@HEAP.init
    ustack A $DATASTACK_PTR
    sto A $HEAP_SIZE
    ustack A $DATASTACK_PTR
    sto A $HEAP_START
    sto A $HEAP_FREE
    ret
@NEW.array
    ustack A $DATASTACK_PTR
    sto A $requested_capacity
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $total_size
    ldm A $HEAP_FREE
    stack A $DATASTACK_PTR
    ldm A $total_size
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $HEAP_START
    stack A $DATASTACK_PTR
    ldm A $HEAP_SIZE
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NEW.array_if_end_0
    ldi A $error_mesg0
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:NEW.array_if_end_0
    ldm A $HEAP_FREE
    sto A $new_array_pointer
    ldm A $HEAP_FREE
    stack A $DATASTACK_PTR
    ldm A $total_size
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $HEAP_FREE
    ldm A $new_array_pointer
    sto A $_ARR_TEMP_PTR
    ldm A $requested_capacity
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $new_array_pointer
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldi A 0
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $new_array_pointer
    stack A $DATASTACK_PTR
    ret
@ARRAY.append
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    ustack A $DATASTACK_PTR
    sto A $_value
    ldm A $array_ptr
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_capacity
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_count
    stack A $DATASTACK_PTR
    ldm A $_capacity
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.append_if_end_1
    ldi A $error_mesg1
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.append_if_end_1
    ldm A $_count
    stack A $DATASTACK_PTR
    ldm A $_capacity
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.append_if_end_2
    ldi A $error_mesg1
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.append_if_end_2
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_count
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $dest_addr
    sto A $_ARR_TEMP_PTR
    ldm A $_value
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ret
@ARRAY.put
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    ustack A $DATASTACK_PTR
    sto A $_index
    ustack A $DATASTACK_PTR
    sto A $_value
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_count
    ldm A $_index
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.put_if_end_3
    ldi A $error_mesg2
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.put_if_end_3
    ldm A $_index
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.put_if_end_4
    ldi A $error_mesg2
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.put_if_end_4
    ldm A $_index
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.put_if_end_5
    ldi A $error_mesg2
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.put_if_end_5
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_index
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $dest_addr
    sto A $_ARR_TEMP_PTR
    ldm A $_value
    ld B A
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ret
@ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    ustack A $DATASTACK_PTR
    sto A $_index
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    sto A $_count
    ldm A $_index
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.get_if_end_6
    ldi A $error_mesg3
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.get_if_end_6
    ldm A $_index
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.get_if_end_7
    ldi A $error_mesg3
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.get_if_end_7
    ldm A $_index
    stack A $DATASTACK_PTR
    ldm A $_count
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.get_if_end_8
    ldi A $error_mesg3
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.get_if_end_8
    ldm A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_index
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $read_addr
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@ARRAY.size
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $array_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_TEMP_PTR
    ldm I $_ARR_TEMP_PTR
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret

@plotlist
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $listlenn
    ldi A 0
    sto A $NN
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
:plotlist_while_start_1
    ldm A $NN
    stack A $DATASTACK_PTR
    ldm A $listlenn
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :plotlist_while_end_1
    ldm A $NN
    stack A $DATASTACK_PTR
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $NN
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $NN
    jmp :plotlist_while_start_1
:plotlist_while_end_1
    ret
@printlist
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $listlen
    ldi A 0
    sto A $N
:printlist_while_start_2
    ldm A $N
    stack A $DATASTACK_PTR
    ldm A $listlen
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :printlist_while_end_2
    ldm A $N
    stack A $DATASTACK_PTR
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @PRTnum
    ldi A 32
    stack A $DATASTACK_PTR
    call @PRTchar
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $N
    jmp :printlist_while_start_2
:printlist_while_end_2
    ldi A 13
    stack A $DATASTACK_PTR
    call @PRTchar
    ret
@sort_list
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $listlen
    ldi A 1
    sto A $sorting
:sort_list_while_start_3
    ldm A $sorting
    tst A 0
    jmpt :sort_list_while_end_3
    ldi A 0
    sto A $sorting
    ldi A 0
    sto A $N
:sort_list_while_start_4
    ldm A $N
    stack A $DATASTACK_PTR
    ldm A $listlen
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sort_list_while_end_4
    ldm A $N
    stack A $DATASTACK_PTR
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val1
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val2
    ldm A $val1
    stack A $DATASTACK_PTR
    ldm A $val2
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sort_list_if_end_0
    ldm A $val2
    stack A $DATASTACK_PTR
    ldm A $N
    stack A $DATASTACK_PTR
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldm A $val1
    stack A $DATASTACK_PTR
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldi A 1
    sto A $sorting
:sort_list_if_end_0
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $N
    jmp :sort_list_while_start_4
:sort_list_while_end_4
    call @plotlist
    ldi A 3000
    stack A $DATASTACK_PTR
    call @TIME.wait
    jmp :sort_list_while_start_3
:sort_list_while_end_3
    ret

# .DATA

% $HEAP_START 0
% $HEAP_SIZE 0
% $HEAP_FREE 0
% $_ARR_TEMP_PTR 0
% $_ARR_VALUE_PTR 0
% $error_mesg0 \N \E \W \. \a \r \r \a \y \: \space \N \o \space \s \p \a \c \e \space \o \n \space \h \e \a \p \Return \null
% $error_mesg1 \A \R \R \A \Y \. \a \p \p \e \n \d \: \space \A \r \r \a \y \space \i \s \space \f \u \l \l \Return \null
% $error_mesg2 \A \R \R \A \Y \. \p \u \t \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $error_mesg3 \A \R \R \A \Y \. \g \e \t \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $requested_capacity 0
% $total_size 0
% $new_array_pointer 0
% $array_ptr 0
% $_value 0
% $_capacity 0
% $_count 0
% $dest_addr 0
% $_index 0
% $read_addr 0
% $listlen 0
% $N 0
% $val1 0
% $val2 0
% $sorting 0
% $_main_str_0 \S \o \r \t \i \n \g \. \. \. \space \null
% $_main_str_1 \D \o \n \e \. \Return \null
