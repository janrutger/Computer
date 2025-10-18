# .HEADER
. $X 1
. $Y 1

# .CODE
    call @screen
:_main_while_start_0
    ldm A $Y
    call @push_A
    ldi A 60
    call @push_A
    call @rt_lt
    call @pop_A
    tst A 0
    jmpt :_main_while_end_0
:_main_while_start_1
    ldm A $X
    call @push_A
    ldi A 80
    call @push_A
    call @rt_lt
    call @pop_A
    tst A 0
    jmpt :_main_while_end_1
    call @rt_rnd
    ldi A 2
    call @push_A
    call @rt_mul
    ldi A 999
    call @push_A
    call @rt_div
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :_main_if_else_0
    ldi A 129
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    jmp :_main_if_end_0
:_main_if_else_0
    ldi A 130
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
:_main_if_end_0
    ldm A $X
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $X
    ldm A $X
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    jmp :_main_while_start_1
:_main_while_end_1
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 0
    call @push_A
    call @pop_A
    sto A $X
    ldm A $X
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldm A $Y
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $Y
    ldm A $Y
    call @push_A
    ldi A 2
    call @push_A
    ldi A 16
    call @push_A
    call @rt_udc_control
    jmp :_main_while_start_0
:_main_while_end_0
    ret

# .FUNCTIONS
@screen
    ldi A 0
    call @push_A
    call @pop_A
    sto A $X
    ldi A 0
    call @push_A
    call @pop_A
    sto A $Y
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 1
    call @push_A
    call @rt_udc_control
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 10
    call @push_A
    call @rt_udc_control
    ldi A 3
    call @push_A
    ldi A 2
    call @push_A
    ldi A 13
    call @push_A
    call @rt_udc_control
    ldi A 3
    call @push_A
    ldi A 2
    call @push_A
    ldi A 14
    call @push_A
    call @rt_udc_control
    ret

# .DATA
% $X 0
% $Y 0
