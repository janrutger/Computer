# .HEADER
. $_power_base 1
. $_power_exp 1
. $_power_res 1
. $SCALE_FACTOR 1
. $FP_DOT_STR 2
. $frac 1
. $num_digits 1
. $MAX_VALID_DIGITS 1
. $temp_scale 1
. $__natoi_p 1
. $__natoi_len 1
. $__natoi_res 1
. $str_ptr 1
. $dot_index 1
. $dot_found 1
. $int_part_fp 1
. $frac_ptr 1
. $frac_len 1
. $total_len 1
. $frac_as_int 1
. $divisor 1
. $_main_str_0 5
. $_main_str_1 2
. $_main_str_2 6
. $_main_str_3 7
. $_main_str_4 25
. $_main_str_5 15
. $_main_str_6 15
. $_main_str_7 37
. $_main_str_8 24
. $_main_str_9 18
. $_main_str_10 6
. $_main_str_11 37
. $_main_str_12 24
. $_main_str_13 3

# .CODE
    ldi A 1
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    call @FP.div
    call @rt_dup
    call @rt_print_tos
    call @rt_dup
    call @FP.print
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_dup
    call @FP.print
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_dup
    ldi A 2
    stack A $DATASTACK_PTR
    call @FP.fprint
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_dup
    ldi A 3
    stack A $DATASTACK_PTR
    call @FP.fprint
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 4
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.mul
    ldi A 15
    stack A $DATASTACK_PTR
    call @FP.fprint
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @STRlen
    call @rt_print_tos
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    ldi A 46
    stack A $DATASTACK_PTR
    call @STRfind
    call @rt_print_tos
    call @rt_print_tos
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @_STRNatoi
    call @rt_print_tos
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @power
    call @rt_print_tos
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @power
    call @rt_print_tos
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_10
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldi A 2
    stack A $DATASTACK_PTR
    call @FP.fprint
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_11
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_12
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_13
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldi A 2
    stack A $DATASTACK_PTR
    call @FP.fprint
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
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


@TOS_nnl

        ustack A $DATASTACK_PTR
        ld C A

        ldi I ~SYS_PRINT_NUMBER
        int $INT_VECTORS
        
        ret
@FP.from_int
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ret
@FP.to_int
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ret
@FP.add
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ret
@FP.sub
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ret
@FP.mul
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ret
@FP.div
    call @rt_swap
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    call @rt_swap
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ret
@FP.print
    call @rt_dup
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ldi A 46
    stack A $DATASTACK_PTR
    call @PRTchar
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $frac
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $frac
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ldm A $frac
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $frac
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $frac
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ldm A $frac
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $frac
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $frac
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ret
@FP.fprint
    ustack A $DATASTACK_PTR
    sto A $num_digits
    ldi A 0
    sto A $MAX_VALID_DIGITS
    ldi A 1
    sto A $temp_scale
:loop_calc_valid_digits
    ldm A $temp_scale
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.fprint_if_end_0
    ldm A $temp_scale
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $temp_scale
    ldm A $MAX_VALID_DIGITS
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $MAX_VALID_DIGITS
    jmp :loop_calc_valid_digits
:FP.fprint_if_end_0
    ldm A $num_digits
    stack A $DATASTACK_PTR
    ldm A $MAX_VALID_DIGITS
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.fprint_if_end_1
    ldm A $MAX_VALID_DIGITS
    sto A $num_digits
:FP.fprint_if_end_1
    call @rt_dup
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ldi A 46
    stack A $DATASTACK_PTR
    call @PRTchar
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $frac
:loop_print_digits
    ldm A $num_digits
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.fprint_if_end_2
    ldm A $frac
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $frac
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ldm A $frac
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $frac
    ldm A $num_digits
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $num_digits
    jmp :loop_print_digits
:FP.fprint_if_end_2
    ret
@_STRNatoi
    ustack A $DATASTACK_PTR
    sto A $__natoi_len
    ustack A $DATASTACK_PTR
    sto A $__natoi_p
    ldi A 0
    sto A $__natoi_res
:loop_natoi
    ldm A $__natoi_len
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_STRNatoi_if_end_3
    ldm A $__natoi_res
    stack A $DATASTACK_PTR
    jmp :_natoi_end
:_STRNatoi_if_end_3
    ldm I $__natoi_p
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 48
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $__natoi_res
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $__natoi_res
    ldm A $__natoi_p
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $__natoi_p
    ldm A $__natoi_len
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $__natoi_len
    jmp :loop_natoi
:_natoi_end
    ret
@FP.from_string
    ustack A $DATASTACK_PTR
    sto A $str_ptr
    stack A $DATASTACK_PTR
    ldi A 46
    stack A $DATASTACK_PTR
    call @STRfind
    ustack A $DATASTACK_PTR
    sto A $dot_found
    ustack A $DATASTACK_PTR
    sto A $dot_index
    ldm A $dot_found
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.from_string_if_end_4
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    call @STRlen
    ustack A $DATASTACK_PTR
    sto A $total_len
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    ldm A $total_len
    stack A $DATASTACK_PTR
    call @_STRNatoi
    call @FP.from_int
    jmp :_fp_from_string_end
:FP.from_string_if_end_4
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    ldm A $dot_index
    stack A $DATASTACK_PTR
    call @_STRNatoi
    call @FP.from_int
    ustack A $DATASTACK_PTR
    sto A $int_part_fp
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    ldm A $dot_index
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $frac_ptr
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    call @STRlen
    ustack A $DATASTACK_PTR
    sto A $total_len
    stack A $DATASTACK_PTR
    ldm A $dot_index
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $frac_len
    ldm A $frac_ptr
    stack A $DATASTACK_PTR
    ldm A $frac_len
    stack A $DATASTACK_PTR
    call @_STRNatoi
    ustack A $DATASTACK_PTR
    sto A $frac_as_int
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $frac_len
    stack A $DATASTACK_PTR
    call @power
    ustack A $DATASTACK_PTR
    sto A $divisor
    ldm A $frac_as_int
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldm A $divisor
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $int_part_fp
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
:_fp_from_string_end
    ret


# .DATA

% $_power_base 0
% $_power_exp 0
% $_power_res 0

% $SCALE_FACTOR 10000000
% $FP_DOT_STR \. \null
% $frac 0
% $num_digits 0
% $MAX_VALID_DIGITS 0
% $temp_scale 1
% $__natoi_p 0
% $__natoi_len 0
% $__natoi_res 0
% $str_ptr 0
% $dot_index 0
% $dot_found 0
% $int_part_fp 0
% $frac_ptr 0
% $frac_len 0
% $total_len 0
% $frac_as_int 0
% $divisor 0
% $_main_str_0 \3 \. \1 \4 \null
% $_main_str_1 \Return \null
% $_main_str_2 \1 \0 \5 \1 \2 \null
% $_main_str_3 \1 \0 \. \5 \1 \2 \null
% $_main_str_4 \P \a \r \s \i \n \g \space \1 \0 \space \f \r \o \m \space \1 \0 \. \5 \1 \2 \: \space \null
% $_main_str_5 \T \e \s \t \i \n \g \space \1 \0 \^ \2 \: \space \null
% $_main_str_6 \T \e \s \t \i \n \g \space \1 \0 \^ \3 \: \space \null
% $_main_str_7 \T \e \s \t \i \n \g \space \F \P \. \f \r \o \m \_ \s \t \r \i \n \g \space \w \i \t \h \space \1 \2 \. \7 \5 \. \. \. \null
% $_main_str_8 \E \x \p \e \c \t \e \d \space \o \u \t \p \u \t \: \space \1 \2 \. \7 \5 \0 \null
% $_main_str_9 \A \c \t \u \a \l \space \o \u \t \p \u \t \: \space \space \space \null
% $_main_str_10 \1 \2 \. \7 \5 \null
% $_main_str_11 \T \e \s \t \i \n \g \space \w \i \t \h \space \a \n \space \i \n \t \e \g \e \r \space \s \t \r \i \n \g \space \1 \5 \. \. \. \null
% $_main_str_12 \E \x \p \e \c \t \e \d \space \o \u \t \p \u \t \: \space \1 \5 \. \0 \0 \0 \null
% $_main_str_13 \1 \5 \null
