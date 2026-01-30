# .HEADER
. $X 1
. $Y 1

# .CODE
    call @screen
:_main_while_start_0
    ldm A $Y
    stack A $DATASTACK_PTR
    ldi A 60
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
:_main_while_start_1
    ldm A $X
    stack A $DATASTACK_PTR
    ldi A 80
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_1
    call @rt_rnd
    ldi A 2
    ustack B $DATASTACK_PTR
    mul B A
    ldi A 999
    dmod B A
    stack B $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_0
    ldi A 129
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    jmp :_main_if_end_0
:_main_if_else_0
    ldi A 130
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
:_main_if_end_0
    ldm B $X
    ldi A 1
    add A B
    sto A $X
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    jmp :_main_while_start_1
:_main_while_end_1
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ld A Z
    sto A $X
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm B $Y
    ldi A 1
    add A B
    sto A $Y
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    jmp :_main_while_start_0
:_main_while_end_0
    ret

# .FUNCTIONS
@screen
    ld A Z
    sto A $X
    ld A Z
    sto A $Y
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
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret

# .DATA
% $X 0
% $Y 0
