# .HEADER
. $_power_base 1
. $_power_exp 1
. $_power_res 1
. $n 1
. $res 1
. $SCALE_FACTOR 1
. $FP_DOT_STR 2
. $div_error 38
. $fp_b 1
. $fp_a 1
. $result_sign 1
. $abs_numerator 1
. $abs_denominator 1
. $raw_result 1
. $exponent 1
. $base 1
. $result 1
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
. $sign 1
. $valid_digits 1
. $main_str_0 11
. $real_pi 1
. $last_plot_time 1
. $main_str_1 22
. $main_str_2 33
. $main_str_3 48
. $sum_fp 1
. $denominator 1
. $denominator_fp 1
. $term_fp 1
. $pi_fp 1
. $main_str_4 19
. $main_str_5 19
. $main_str_6 2
. $main_str_7 19
. $main_str_8 19
. $_main_str_9 19
. $_main_str_10 10

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
    ldi A 0
    stack A $DATASTACK_PTR
    call @TIME.start
    call @main
    ldi A $_main_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A $_main_str_10
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
    ldm B $_power_res
    ldm A $_power_base
    mul A B
    sto A $_power_res
    ldm B $_power_exp
    ldi A 1
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
    ldm B $res
    ldm A $n
    mul A B
    sto A $res
    ldm B $n
    ldi A 1
    sub B A
    ld A B
    sto A $n
    jmp :factorial_while_start_1
:factorial_while_end_1
    ldm A $res
    stack A $DATASTACK_PTR
    ret


@FP.set_scale
    ustack A $DATASTACK_PTR
    sto A $SCALE_FACTOR
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
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.mul_if_else_0
    ldm B $SCALE_FACTOR
    ldi A 2
    dmod B A
    ld A B
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    jmp :FP.mul_if_end_0
:FP.mul_if_else_0
    ldm B $SCALE_FACTOR
    ldi A 2
    dmod B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
:FP.mul_if_end_0
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ret
@FP.div
    ldi A 1
    sto A $result_sign
    ustack A $DATASTACK_PTR
    sto A $fp_b
    ustack A $DATASTACK_PTR
    sto A $fp_a
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.div_if_end_1
    ldm A $result_sign
    stack A $DATASTACK_PTR
    ldi A 1
    ldi B 0
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    mul A B
    sto A $result_sign
:FP.div_if_end_1
    ldm A $fp_b
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.div_if_end_2
    ldm A $result_sign
    stack A $DATASTACK_PTR
    ldi A 1
    ldi B 0
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    mul A B
    sto A $result_sign
:FP.div_if_end_2
    ldm A $fp_a
    tstg A Z
    jmpt :FP.div_abs_pos_3
    ldi B 0
    sub B A
    ld A B
:FP.div_abs_pos_3
    sto A $abs_numerator
    ldm A $fp_b
    tstg A Z
    jmpt :FP.div_abs_pos_4
    ldi B 0
    sub B A
    ld A B
:FP.div_abs_pos_4
    sto A $abs_denominator
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.div_if_else_5
    ldm A $div_error
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :FP.div_if_end_5
:FP.div_if_else_5
    ldm B $abs_numerator
    ldm A $SCALE_FACTOR
    mul B A
    stack B $DATASTACK_PTR
    ldm A $abs_denominator
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $result_sign
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
:FP.div_if_end_5
    ret
@FP.power
    ustack A $DATASTACK_PTR
    sto A $exponent
    ustack A $DATASTACK_PTR
    sto A $base
    ldi A 1
    stack A $DATASTACK_PTR
    call @FP.from_int
    ustack A $DATASTACK_PTR
    sto A $result
    ldm A $exponent
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.power_if_end_6
    ldm A $result
    stack A $DATASTACK_PTR
    jmp :_fp_power_end
:FP.power_if_end_6
:loop_power
    ldm A $exponent
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.power_if_end_7
    ldm A $result
    stack A $DATASTACK_PTR
    ldm A $base
    stack A $DATASTACK_PTR
    call @FP.mul
    ustack A $DATASTACK_PTR
    sto A $result
    ldm B $exponent
    ldi A 1
    sub B A
    ld A B
    sto A $exponent
    jmp :loop_power
:FP.power_if_end_7
    ldm A $result
    stack A $DATASTACK_PTR
:_fp_power_end
    ret
@FP.print
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.print_if_end_8
    ldi A 45
    stack A $DATASTACK_PTR
    call @PRTchar
    ustack A $DATASTACK_PTR
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
:FP.print_if_end_8
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
    ld B A
    ldi A 10
    mul A B
    sto A $frac
    ld B A
    ldm A $SCALE_FACTOR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ldm B $frac
    ldm A $SCALE_FACTOR
    dmod B A
    sto A $frac
    ld B A
    ldi A 10
    mul A B
    sto A $frac
    ld B A
    ldm A $SCALE_FACTOR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ldm B $frac
    ldm A $SCALE_FACTOR
    dmod B A
    sto A $frac
    ld B A
    ldi A 10
    mul A B
    sto A $frac
    ld B A
    ldm A $SCALE_FACTOR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ret
@FP.fprint
    ustack A $DATASTACK_PTR
    sto A $num_digits
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.fprint_if_end_9
    ldi A 45
    stack A $DATASTACK_PTR
    call @PRTchar
    ustack A $DATASTACK_PTR
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
:FP.fprint_if_end_9
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
    jmpt :FP.fprint_if_end_10
    ldm B $temp_scale
    ldi A 10
    mul A B
    sto A $temp_scale
    ldm B $MAX_VALID_DIGITS
    ldi A 1
    add A B
    sto A $MAX_VALID_DIGITS
    jmp :loop_calc_valid_digits
:FP.fprint_if_end_10
    ldm A $num_digits
    stack A $DATASTACK_PTR
    ldm A $MAX_VALID_DIGITS
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.fprint_if_end_11
    ldm A $MAX_VALID_DIGITS
    sto A $num_digits
:FP.fprint_if_end_11
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
    jmpt :FP.fprint_if_end_12
    ldm B $frac
    ldi A 10
    mul A B
    sto A $frac
    ld B A
    ldm A $SCALE_FACTOR
    dmod B A
    stack B $DATASTACK_PTR
    call @TOS_nnl
    ldm B $frac
    ldm A $SCALE_FACTOR
    dmod B A
    sto A $frac
    ldm B $num_digits
    ldi A 1
    sub B A
    ld A B
    sto A $num_digits
    jmp :loop_print_digits
:FP.fprint_if_end_12
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
    jmpt :_STRNatoi_if_end_13
    ldm A $__natoi_res
    stack A $DATASTACK_PTR
    jmp :_natoi_end
:_STRNatoi_if_end_13
    ldm I $__natoi_p
    ldx A $_start_memory_
    ld B A
    ldi A 48
    sub B A
    stack B $DATASTACK_PTR
    ldm B $__natoi_res
    ldi A 10
    mul A B
    ustack B $DATASTACK_PTR
    add A B
    sto A $__natoi_res
    ldm B $__natoi_p
    ldi A 1
    add A B
    sto A $__natoi_p
    ldm B $__natoi_len
    ldi A 1
    sub B A
    ld A B
    sto A $__natoi_len
    jmp :loop_natoi
:_natoi_end
    ret
@FP.from_string
    ustack A $DATASTACK_PTR
    sto A $str_ptr
    ldi A 1
    sto A $sign
    ldm I $str_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 45
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.from_string_if_end_14
    ldi A 1
    ldi B 0
    sub B A
    ld A B
    sto A $sign
    ldm B $str_ptr
    ldi A 1
    add A B
    sto A $str_ptr
:FP.from_string_if_end_14
    ldm A $str_ptr
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
    jmpt :FP.from_string_if_end_15
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
    ldm A $sign
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    jmp :_fp_from_string_end
:FP.from_string_if_end_15
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    ldm A $dot_index
    stack A $DATASTACK_PTR
    call @_STRNatoi
    call @FP.from_int
    ustack A $DATASTACK_PTR
    sto A $int_part_fp
    ldm B $str_ptr
    ldm A $dot_index
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add A B
    sto A $frac_ptr
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    call @STRlen
    ustack A $DATASTACK_PTR
    sto A $total_len
    ld B A
    ldm A $dot_index
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
    ldm B $frac_as_int
    ldm A $SCALE_FACTOR
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
    ldm A $sign
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
:_fp_from_string_end
    ret

@main
    ldi A 10000000000
    stack A $DATASTACK_PTR
    call @FP.set_scale
    ldi A 8
    sto A $valid_digits
    ldi A $main_str_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ustack A $DATASTACK_PTR
    sto A $real_pi
    ldi A 3
    stack A $DATASTACK_PTR
    call @TIME.start
    ldi A 3
    stack A $DATASTACK_PTR
    call @TIME.read
    ustack A $DATASTACK_PTR
    sto A $last_plot_time
    ldi A $main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 500000
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    call @FP.from_int
    ustack A $DATASTACK_PTR
    sto A $sum_fp
    ldi A 1
    sto A $n
:loop_leibniz
    ldm A $n
    stack A $DATASTACK_PTR
    ldi A 500000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_0
    jmp :end_leibniz
:main_if_end_0
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_1
    ldi A 27
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_2
    jmp :end_leibniz
:main_if_end_2
:main_if_end_1
    ldm B $n
    ldi A 2
    mul B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $denominator
    stack A $DATASTACK_PTR
    call @FP.from_int
    ustack A $DATASTACK_PTR
    sto A $denominator_fp
    ldi A 1
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldm A $denominator_fp
    stack A $DATASTACK_PTR
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $term_fp
    ldm B $n
    ldi A 2
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_3
    ldm A $sum_fp
    stack A $DATASTACK_PTR
    ldm A $term_fp
    stack A $DATASTACK_PTR
    call @FP.add
    ustack A $DATASTACK_PTR
    sto A $sum_fp
    jmp :main_if_end_3
:main_if_else_3
    ldm A $sum_fp
    stack A $DATASTACK_PTR
    ldm A $term_fp
    stack A $DATASTACK_PTR
    call @FP.sub
    ustack A $DATASTACK_PTR
    sto A $sum_fp
:main_if_end_3
    ldm B $n
    ldi A 1
    add A B
    sto A $n
    ld B A
    ldi A 100
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_4
    ldm A $sum_fp
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.mul
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 3
    stack A $DATASTACK_PTR
    call @TIME.read
    ldm A $last_plot_time
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldi A 5000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_5
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 3
    stack A $DATASTACK_PTR
    call @TIME.read
    ustack A $DATASTACK_PTR
    sto A $last_plot_time
:main_if_end_5
:main_if_end_4
    jmp :loop_leibniz
:end_leibniz
    ldm A $sum_fp
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.mul
    ustack A $DATASTACK_PTR
    sto A $pi_fp
    ldi A $main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $n
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A 13
    stack A $DATASTACK_PTR
    call @PRTchar
    ldi A $main_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $pi_fp
    stack A $DATASTACK_PTR
    ldm A $valid_digits
    stack A $DATASTACK_PTR
    call @FP.fprint
    ldi A $main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $real_pi
    stack A $DATASTACK_PTR
    ldm A $valid_digits
    stack A $DATASTACK_PTR
    call @FP.fprint
    ldi A $main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $main_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $real_pi
    stack A $DATASTACK_PTR
    ldm A $pi_fp
    stack A $DATASTACK_PTR
    call @FP.sub
    ldm A $valid_digits
    stack A $DATASTACK_PTR
    call @FP.fprint
    ldi A $main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ret

# .DATA

% $_power_base 0
% $_power_exp 0
% $_power_res 0
% $n 0
% $res 1

% $SCALE_FACTOR 1000
% $FP_DOT_STR \. \null
% $div_error \E \R \R \O \R \: \space \F \i \x \e \d \space \p \o \i \n \t \space \D \i \v \i \s \i \o \n \space \b \y \space \z \e \r \o \! \Return \null
% $fp_b 0
% $fp_a 0
% $result_sign 1
% $abs_numerator 0
% $abs_denominator 0
% $raw_result 0
% $exponent 0
% $base 0
% $result 0
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
% $sign 1
% $main_str_0 \3 \. \1 \4 \1 \5 \9 \2 \6 \3 \null
% $main_str_1 \C \a \l \c \u \l \a \t \i \n \g \space \P \I \space \u \s \i \n \g \space \null
% $main_str_2 \space \t \e \r \m \s \space \o \f \space \t \h \e \space \L \e \i \b \n \i \z \space \s \e \r \i \e \s \. \. \. \Return \null
% $main_str_3 \T \a \k \e \s \space \a \r \r \o \u \n \d \space \1 \8 \space \m \i \n \u \t \e \s \, \space \p \r \e \s \s \space \< \e \s \c \> \space \t \o \space \s \t \o \p \Return \Return \null
% $main_str_4 \N \space \t \e \r \m \s \space \p \a \s \s \e \d \space \space \: \space \null
% $main_str_5 \P \I \space \a \p \p \r \o \x \i \m \a \t \i \o \n \: \space \null
% $main_str_6 \Return \null
% $main_str_7 \R \e \a \l \space \P \i \space \space \space \space \space \space \space \space \space \: \space \null
% $main_str_8 \D \i \f \f \e \r \e \n \c \e \space \t \o \space \P \i \: \space \null
% $_main_str_9 \C \a \l \c \u \l \a \t \i \o \n \space \t \o \o \k \: \space \null
% $_main_str_10 \space \s \e \c \o \n \d \s \Return \null
