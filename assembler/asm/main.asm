# .HEADER
. $_start_memory_ 1
. $P 1
. $N 1
. $C 1
. $R 1

# .CODE
    ldi A 0
    call @push_A
    ldi A 1
    call @push_A
    ldi A 1
    call @push_A
    call @rt_udc_control
    ldi A 0
    call @push_A
    ldi A 1
    call @push_A
    ldi A 10
    call @push_A
    call @rt_udc_control
    ldi A 1
    call @push_A
    call @plot
    ldi A 1
    call @push_A
    call @plot
:while_start_1
    ldm A $N
    call @push_A
    ldi A 700
    call @push_A
    call @rt_lt
    call @pop_A
    tst A 0
    jmpt :while_end_1
    ldm A $P
    call @push_A
    ldm A $N
    call @push_A
    call @gcd
    call @pop_A
    sto A $C
    ldm A $C
    call @push_A
    ldi A 1
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :if_else_0
    ldm A $P
    call @push_A
    ldm A $N
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @rt_add
    call @pop_A
    sto A $R
    jmp :if_end_0
:if_else_0
    ldm A $P
    call @push_A
    ldm A $C
    call @push_A
    call @rt_div
    call @pop_A
    sto A $R
:if_end_0
    ldm A $R
    call @push_A
    call @plot
    ldm A $R
    call @push_A
    call @pop_A
    sto A $P
    ldm A $N
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $N
    jmp :while_start_1
:while_end_1

    ret

# .FUNCTIONS
@plot
    ldi A 1
    call @push_A
    ldi A 11
    call @push_A
    call @rt_udc_control
    ret

@gcd
:while_start_0
    call @rt_dup
    ldi A 0
    call @push_A
    call @rt_neq
    call @pop_A
    tst A 0
    jmpt :while_end_0
    call @rt_swap
    call @rt_over
    call @rt_mod
    jmp :while_start_0
:while_end_0
    call @rt_drop
    ret


# .DATA
% $_start_memory_ 0
% $P 1
% $N 2
