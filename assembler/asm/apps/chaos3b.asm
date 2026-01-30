# .HEADER
. $self 1
. $iter 1
. $r 1
. $target 1
. $v1 1
. $v2 1
. $v3 1
. $cursor 1
. $_main_str_0 17
. $_main_str_1 4

# .CODE
    call @HEAP.free
    call @Screen.init
    stack Z $DATASTACK_PTR
    call @TIME.start
    call @Point.new
    ustack A $DATASTACK_PTR
    sto A $v1
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $v1
    stack A $DATASTACK_PTR
    call @Point.set
    call @Point.new
    ustack A $DATASTACK_PTR
    sto A $v2
    ldi A 630
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $v2
    stack A $DATASTACK_PTR
    call @Point.set
    call @Point.new
    ustack A $DATASTACK_PTR
    sto A $v3
    ldi A 320
    stack A $DATASTACK_PTR
    ldi A 470
    stack A $DATASTACK_PTR
    ldm A $v3
    stack A $DATASTACK_PTR
    call @Point.set
    call @Point.new
    ustack A $DATASTACK_PTR
    sto A $cursor
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @Point.set
:_main_while_start_0
    ldi A 20000
    stack A $DATASTACK_PTR
    ldm A $iter
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
    call @rt_rnd
    ldi A 3
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 999
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $r
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_0
    ldm A $v1
    sto A $target
:_main_if_end_0
    ldm A $r
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_1
    ldm A $v2
    sto A $target
:_main_if_end_1
    ldm A $r
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_2
    ldm A $v3
    sto A $target
:_main_if_end_2
    stack Z $DATASTACK_PTR
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @LIST.get
    stack Z $DATASTACK_PTR
    ldm A $target
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $target
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @Point.set
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @Point.draw
    ldm B $iter
    ldi A 1
    add A B
    sto A $iter
    ld B A
    ldi A 500
    dmod B A
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_3
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    stack Z $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A 32
    stack A $DATASTACK_PTR
    call @PRTchar
    ldm A $iter
    stack A $DATASTACK_PTR
    call @rt_print_tos
:_main_if_end_3
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_4
    call @rt_drop
    jmp :end_of_chaos
:_main_if_end_4
    jmp :_main_while_start_0
:_main_while_end_0
:end_of_chaos
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    stack Z $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ret

# .FUNCTIONS
@Point.new
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.list
    ret
@Point.set
    ustack A $DATASTACK_PTR
    sto A $self
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $self
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldm A $self
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@Point.draw
    ustack A $DATASTACK_PTR
    sto A $self
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $self
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    stack Z $DATASTACK_PTR
    ldm A $self
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    call @rt_rnd
    ldi A 15
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 999
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@Screen.init
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_udc_control
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret

# .DATA
% $self 0
% $iter 0
% $r 0
% $target 0
% $_main_str_0 \T \o \t \a \l \space \r \u \n \space \t \i \m \e \: \space \null
% $_main_str_1 \! \! \Return \null
