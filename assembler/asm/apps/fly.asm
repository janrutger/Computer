# .HEADER
. $_power_base 1
. $_power_exp 1
. $_power_res 1
. $n 1
. $res 1
. $P 1
. $N 1
. $C 1
. $R 1

# .CODE
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
    ldi A 1
    stack A $DATASTACK_PTR
    call @plot
    ldi A 1
    stack A $DATASTACK_PTR
    call @plot
:_main_while_start_0
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 700
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
    ldm A $P
    stack A $DATASTACK_PTR
    ldm A $N
    stack A $DATASTACK_PTR
    call @gcd
    ustack A $DATASTACK_PTR
    sto A $C
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_0
    ldm A $P
    stack A $DATASTACK_PTR
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $R
    jmp :_main_if_end_0
:_main_if_else_0
    ldm A $P
    stack A $DATASTACK_PTR
    ldm A $C
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $R
:_main_if_end_0
    ldm A $R
    stack A $DATASTACK_PTR
    call @plot
    ldm A $R
    sto A $P
    ldm A $N
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $N
    jmp :_main_while_start_0
:_main_while_end_0
    ret

# .FUNCTIONS

@gcd
:gcd_while_start_0
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :gcd_while_end_0
    call @rt_swap
    call @rt_over
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    jmp :gcd_while_start_0
:gcd_while_end_0
    call @rt_drop
    ret
@power
    ustack A $DATASTACK_PTR
    sto A $_power_exp
    ustack A $DATASTACK_PTR
    sto A $_power_base
    ldi A 1
    sto A $_power_res
:loop_POWER
    ldm A $_power_exp
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :power_if_end_0
    ldm A $_power_res
    stack A $DATASTACK_PTR
    jmp :_power_end
:power_if_end_0
    ldm A $_power_res
    stack A $DATASTACK_PTR
    ldm A $_power_base
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $_power_res
    ldm A $_power_exp
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_power_exp
    jmp :loop_POWER
:_power_end
    ret
@factorial
    ldi A 1
    sto A $res
    ustack A $DATASTACK_PTR
    sto A $n
    ldi A 1
    sto A $res
:factorial_while_start_1
    ldm A $n
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :factorial_while_end_1
    ldm A $res
    stack A $DATASTACK_PTR
    ldm A $n
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $res
    ldm A $n
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $n
    jmp :factorial_while_start_1
:factorial_while_end_1
    ldm A $res
    stack A $DATASTACK_PTR
    ret

@plot
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret

# .DATA

% $_power_base 0
% $_power_exp 0
% $_power_res 0
% $n 0
% $res 1
% $P 1
% $N 2
% $C 0
% $R 0
