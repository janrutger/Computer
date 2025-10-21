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
    stack A $DATASTACK_PTR
    ldm A $N
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
    call @rt_rnd
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_mul
    ldi A 999
    stack A $DATASTACK_PTR
    call @rt_div
    ustack A $DATASTACK_PTR
    sto A $R
    ldm A $R
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_0
    call @select1
:_main_if_end_0
    ldm A $R
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_1
    call @select2
:_main_if_end_1
    ldm A $R
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_2
    call @select3
:_main_if_end_2
    ldm A $X
    stack A $DATASTACK_PTR
    ldm A $K
    stack A $DATASTACK_PTR
    call @rt_add
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_div
    ustack A $DATASTACK_PTR
    sto A $X
    ldm A $Y
    stack A $DATASTACK_PTR
    ldm A $L
    stack A $DATASTACK_PTR
    call @rt_add
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_div
    ustack A $DATASTACK_PTR
    sto A $Y
    ldm A $X
    stack A $DATASTACK_PTR
    ldm A $Y
    stack A $DATASTACK_PTR
    call @draw
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_add
    ustack A $DATASTACK_PTR
    sto A $N
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 500
    stack A $DATASTACK_PTR
    call @rt_mod
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_3
    ldm A $N
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
:_main_if_end_3
    jmp :_main_while_start_0
:_main_while_end_0
    ret

# .FUNCTIONS
@screen
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    stack A $DATASTACK_PTR
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
@setX
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@setY
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@select1
    ldm A $A
    stack A $DATASTACK_PTR
    ustack A $DATASTACK_PTR
    sto A $K
    ldm A $B
    stack A $DATASTACK_PTR
    ustack A $DATASTACK_PTR
    sto A $L
    ret
@select2
    ldm A $C
    stack A $DATASTACK_PTR
    ustack A $DATASTACK_PTR
    sto A $K
    ldm A $D
    stack A $DATASTACK_PTR
    ustack A $DATASTACK_PTR
    sto A $L
    ret
@select3
    ldm A $E
    stack A $DATASTACK_PTR
    ustack A $DATASTACK_PTR
    sto A $K
    ldm A $F
    stack A $DATASTACK_PTR
    ustack A $DATASTACK_PTR
    sto A $L
    ret
@draw
    call @setY
    call @setX
    call @rt_rnd
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_mul
    ldi A 999
    stack A $DATASTACK_PTR
    call @rt_div
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_add
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
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
