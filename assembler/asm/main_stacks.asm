# .HEADER
. $A 1
. $B 1
. $C 1
. $D 1
. $E 1
. $F 1
. $X 1
. $Y 1
. $K 1
. $L 1
. $N 1
. $R 1

# .CODE
    call @screen
:_main_while_start_0
    ldi A 50000
    call @push_A
    ldm A $N
    call @push_A
    call @rt_gt
    call @pop_A
    tst A 0
    jmpt :_main_while_end_0
    call @rt_rnd
    ldi A 3
    call @push_A
    call @rt_mul
    ldi A 999
    call @push_A
    call @rt_div
    call @pop_A
    sto A $R
    ldm A $R
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :_main_if_end_0
    call @select1
:_main_if_end_0
    ldm A $R
    call @push_A
    ldi A 1
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :_main_if_end_1
    call @select2
:_main_if_end_1
    ldm A $R
    call @push_A
    ldi A 2
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :_main_if_end_2
    call @select3
:_main_if_end_2
    ldm A $X
    call @push_A
    ldm A $K
    call @push_A
    call @rt_add
    ldi A 2
    call @push_A
    call @rt_div
    call @pop_A
    sto A $X
    ldm A $Y
    call @push_A
    ldm A $L
    call @push_A
    call @rt_add
    ldi A 2
    call @push_A
    call @rt_div
    call @pop_A
    sto A $Y
    ldm A $X
    call @push_A
    ldm A $Y
    call @push_A
    call @draw
    ldm A $N
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $N
    ldm A $N
    call @push_A
    ldi A 500
    call @push_A
    call @rt_mod
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :_main_if_end_3
    ldm A $N
    call @push_A
    call @rt_print_tos
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
:_main_if_end_3
    jmp :_main_while_start_0
:_main_while_end_0
    ret

# .FUNCTIONS
@screen
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
    ldi A 1
    call @push_A
    ldi A 2
    call @push_A
    ldi A 13
    call @push_A
    call @rt_udc_control
    ldi A 2
    call @push_A
    ldi A 2
    call @push_A
    ldi A 14
    call @push_A
    call @rt_udc_control
    ret
@setX
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ret
@setY
    ldi A 2
    call @push_A
    ldi A 16
    call @push_A
    call @rt_udc_control
    ret
@select1
    ldm A $A
    call @push_A
    call @pop_A
    sto A $K
    ldm A $B
    call @push_A
    call @pop_A
    sto A $L
    ret
@select2
    ldm A $C
    call @push_A
    call @pop_A
    sto A $K
    ldm A $D
    call @push_A
    call @pop_A
    sto A $L
    ret
@select3
    ldm A $E
    call @push_A
    call @pop_A
    sto A $K
    ldm A $F
    call @push_A
    call @pop_A
    sto A $L
    ret
@draw
    call @setY
    call @setX
    call @rt_rnd
    ldi A 15
    call @push_A
    call @rt_mul
    ldi A 999
    call @push_A
    call @rt_div
    ldi A 1
    call @push_A
    call @rt_add
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ret

# .DATA
% $A 10
% $B 10
% $C 630
% $D 10
% $E 320
% $F 470
% $X 10
% $Y 10
% $K 0
% $L 0
% $N 0
% $R 0
