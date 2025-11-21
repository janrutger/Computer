# .HEADER
. $_ARR_HEAP_START 1
. $_ARR_HEAP_SIZE 1
. $_ARR_NEXT_FREE 1
. $_ARR_TEMP_PTR 1
. $_ARR_VALUE_PTR 1
. $error_mesg0 36
. $error_mesg1 36
. $error_mesg2 39
. $error_mesg3 39
. $requested_capacity 1
. $total_size 1
. $new_array_pointer 1
. $array_ptr 1
. $_value 1
. $_capacity 1
. $_count 1
. $dest_addr 1
. $index 1
. $read_addr 1
MALLOC $array_heap 6144
. $_main_str_0 19
. $my_array0 1
. $my_array 1
. $_main_str_1 25
. $_main_str_2 2
. $_main_str_3 21
. $_main_str_4 15
. $_main_str_5 17
. $_main_str_6 27
. $_main_str_7 33
. $_main_str_8 33
. $_main_str_9 16

# .CODE
    ldi A $array_heap
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    call @lib_array.init
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 10
    stack A $DATASTACK_PTR
    call @ARRAY.new
    ustack A $DATASTACK_PTR
    sto A $my_array0
    ldi A 10
    stack A $DATASTACK_PTR
    call @ARRAY.new
    ustack A $DATASTACK_PTR
    sto A $my_array
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 111
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 222
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 333
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $_main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @PRTnum
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.size
    call @PRTnum
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @PRTnum
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 444
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldi A $_main_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @PRTnum
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 555
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldi A $_main_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
    ret

# .FUNCTIONS

@HALT

    :loop_endless_halt
        jmp :loop_endless_halt
        ret
@lib_array.init
    ustack A $DATASTACK_PTR
    sto A $_ARR_HEAP_SIZE
    ustack A $DATASTACK_PTR
    sto A $_ARR_HEAP_START
    sto A $_ARR_NEXT_FREE
    ret
@ARRAY.new
    ustack A $DATASTACK_PTR
    sto A $requested_capacity
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $total_size
    ldm A $_ARR_NEXT_FREE
    stack A $DATASTACK_PTR
    ldm A $total_size
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_ARR_HEAP_START
    stack A $DATASTACK_PTR
    ldm A $_ARR_HEAP_SIZE
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :ARRAY.new_if_end_0
    ldi A $error_mesg0
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:ARRAY.new_if_end_0
    ldm A $_ARR_NEXT_FREE
    sto A $new_array_pointer
    ldm A $_ARR_NEXT_FREE
    stack A $DATASTACK_PTR
    ldm A $total_size
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ARR_NEXT_FREE
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
    sto A $index
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
    ldm A $index
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
    ldm A $index
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
    ldm A $index
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
    ldm A $index
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
    sto A $index
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
    ldm A $index
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
    ldm A $index
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
    ldm A $index
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
    ldm A $index
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


# .DATA

% $_ARR_HEAP_START 0
% $_ARR_HEAP_SIZE 0
% $_ARR_NEXT_FREE 0
% $_ARR_TEMP_PTR 0
% $_ARR_VALUE_PTR 0
% $error_mesg0 \P \A \N \I \C \: \space \A \R \R \A \Y \. \n \e \w \: \space \N \o \space \s \p \a \c \e \space \o \n \space \h \e \a \p \Return \null
% $error_mesg1 \P \A \N \I \C \: \space \A \R \R \A \Y \. \a \p \p \e \n \d \: \space \A \r \r \a \y \space \i \s \space \f \u \l \l \Return \null
% $error_mesg2 \P \A \N \I \C \: \space \A \R \R \A \Y \. \p \u \t \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $error_mesg3 \P \A \N \I \C \: \space \A \R \R \A \Y \. \g \e \t \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $requested_capacity 0
% $total_size 0
% $new_array_pointer 0
% $array_ptr 0
% $_value 0
% $_capacity 0
% $_count 0
% $dest_addr 0
% $index 0
% $read_addr 0
% $_main_str_0 \C \r \e \a \t \i \n \g \space \a \r \r \a \y \. \. \. \Return \null
% $_main_str_1 \A \r \r \a \y \space \c \r \e \a \t \e \d \. \space \P \o \i \n \t \e \r \: \space \null
% $_main_str_2 \Return \null
% $_main_str_3 \A \p \p \e \n \d \i \n \g \space \v \a \l \u \e \s \. \. \. \Return \null
% $_main_str_4 \A \r \r \a \y \space \l \e \n \g \t \h \: \space \null
% $_main_str_5 \A \r \r \a \y \space \c \a \p \a \c \i \t \y \: \space \null
% $_main_str_6 \G \e \t \t \i \n \g \space \v \a \l \u \e \space \a \t \space \i \n \d \e \x \space \1 \: \space \null
% $_main_str_7 \P \u \t \t \i \n \g \space \v \a \l \u \e \space \4 \4 \4 \space \a \t \space \i \n \d \e \x \space \1 \. \. \. \Return \null
% $_main_str_8 \G \e \t \t \i \n \g \space \v \a \l \u \e \space \a \t \space \i \n \d \e \x \space \1 \space \a \g \a \i \n \: \space \null
% $_main_str_9 \T \e \s \t \space \f \i \n \i \s \h \e \d \. \Return \null
