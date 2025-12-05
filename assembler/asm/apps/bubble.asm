# .HEADER
. $listlen 1
. $N 1
. $val1 1
. $val2 1
. $sorting 1
. $sortlist 1
MALLOC $array_heap 6144
. $listlenn 1
. $NN 1
. $n_limit 1
. $new_n_limit 1
. $count 1
. $_main_str_0 26
. $size 1
. $_main_str_1 7
. $_main_str_2 12
. $_main_str_3 47

# .CODE
    ldi A $array_heap
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    call @HEAP.init
    call @TOS.check
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_1
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
    ustack A $DATASTACK_PTR
    sto A $count
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1
    stack A $DATASTACK_PTR
    call @TIME.start
    ldm A $count
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
:_main_while_start_3
    ldm A $N
    stack A $DATASTACK_PTR
    ldm A $size
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_3
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
    jmp :_main_while_start_3
:_main_while_end_3
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
    ldi A $_main_str_2
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
    jmp :_main_if_end_1
:_main_if_else_1
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
:_main_if_end_1
    ret

# .FUNCTIONS
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
:plotlist_while_start_0
    ldm A $NN
    stack A $DATASTACK_PTR
    ldm A $listlenn
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :plotlist_while_end_0
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
    jmp :plotlist_while_start_0
:plotlist_while_end_0
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@sort_list
    ldm A $sortlist
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $listlen
    sto A $n_limit
:sort_list_while_start_1
    ldm A $n_limit
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sort_list_while_end_1
    ldi A 0
    sto A $new_n_limit
    ldi A 0
    sto A $N
:sort_list_while_start_2
    ldm A $N
    stack A $DATASTACK_PTR
    ldm A $n_limit
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :sort_list_while_end_2
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
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $new_n_limit
:sort_list_if_end_0
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $N
    jmp :sort_list_while_start_2
:sort_list_while_end_2
    call @plotlist
    ldm A $new_n_limit
    sto A $n_limit
    jmp :sort_list_while_start_1
:sort_list_while_end_1
    ret

# .DATA
% $listlen 0
% $N 0
% $val1 0
% $val2 0
% $sorting 0
% $sortlist 0
% $new_n_limit 0
% $_main_str_0 \C \r \e \a \t \i \n \g \space \u \n \s \o \r \t \e \d \space \l \i \s \t \. \. \. \null
% $_main_str_1 \D \o \n \e \. \Return \null
% $_main_str_2 \S \o \r \t \i \n \g \. \. \. \space \null
% $_main_str_3 \Return \U \s \e \space \o \f \space \B \u \b \b \e \l \e \S \o \r \t \: \space \[ \2 \space \. \. \space \1 \0 \0 \0 \] \space \< \a \d \r \e \s \> \space \U \S \R \space \Return \null
