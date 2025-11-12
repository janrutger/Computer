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
. $current_char 1
. $current_mode 1
. $current_color 1
. $current_width 1
. $current_height 1
. $current_flip 1
. $Xax 1
. $Yax 1
. $degrees 1
. $TURTLE_HEADING_DEG 1
. $TURTLE_HEADING 1
. $degrees_to_turn 1
. $dx 1
. $dy 1
. $distance 1
. $temp_ptr 1
. $msg 22
. $i_turtle 1
. $char 1
. $p_char 1
. $x1 1
. $y1 1
. $x2 1
. $y2 1
. $sx 1
. $sy 1
. $err 1
. $e2 1
. $circ_xc 1
. $circ_yc 1
. $circ_x 1
. $circ_y 1
. $circ_p 1
. $SCALE_Y 1
. $function_index 1
. $color 1
. $sx1 1
. $sy1 1
. $prev_sx 1
. $prev_sy 1
. $is_first_point 1
. $world_x 1
. $i 1
. $main_str_0 4
. $main_str_1 35
. $main_str_2 35
. $main_str_3 35
. $main_str_4 35
. $main_str_5 35
. $main_str_6 35
. $main_str_7 35
. $main_str_8 35
. $main_str_9 35
. $main_str_10 14

# .CODE
    ldi A 0
    stack A $DATASTACK_PTR
    call @TIME.start
    call @main
    ldi A 0
    stack A $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A 13
    stack A $DATASTACK_PTR
    call @PRTchar
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
@negate
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_swap
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ret
@abs
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :abs_if_end_1
    call @negate
:abs_if_end_1
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
    ldm A $SCALE_FACTOR
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    jmp :FP.mul_if_end_0
:FP.mul_if_else_0
    ldm A $SCALE_FACTOR
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
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
    stack A $DATASTACK_PTR
    call @negate
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
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
    stack A $DATASTACK_PTR
    call @negate
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $result_sign
:FP.div_if_end_2
    ldm A $fp_a
    stack A $DATASTACK_PTR
    call @abs
    ustack A $DATASTACK_PTR
    sto A $abs_numerator
    ldm A $fp_b
    stack A $DATASTACK_PTR
    call @abs
    ustack A $DATASTACK_PTR
    sto A $abs_denominator
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.div_if_else_3
    ldm A $div_error
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :FP.div_if_end_3
:FP.div_if_else_3
    ldm A $abs_numerator
    stack A $DATASTACK_PTR
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
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
:FP.div_if_end_3
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
    jmpt :FP.power_if_end_4
    ldm A $result
    stack A $DATASTACK_PTR
    jmp :_fp_power_end
:FP.power_if_end_4
:loop_power
    ldm A $exponent
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.power_if_end_5
    ldm A $result
    stack A $DATASTACK_PTR
    ldm A $base
    stack A $DATASTACK_PTR
    call @FP.mul
    ustack A $DATASTACK_PTR
    sto A $result
    ldm A $exponent
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $exponent
    jmp :loop_power
:FP.power_if_end_5
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
    jmpt :FP.print_if_end_6
    ldi A 45
    stack A $DATASTACK_PTR
    call @PRTchar
    call @negate
:FP.print_if_end_6
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
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.fprint_if_end_7
    ldi A 45
    stack A $DATASTACK_PTR
    call @PRTchar
    call @negate
:FP.fprint_if_end_7
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
    jmpt :FP.fprint_if_end_8
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
:FP.fprint_if_end_8
    ldm A $num_digits
    stack A $DATASTACK_PTR
    ldm A $MAX_VALID_DIGITS
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.fprint_if_end_9
    ldm A $MAX_VALID_DIGITS
    sto A $num_digits
:FP.fprint_if_end_9
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
    jmpt :FP.fprint_if_end_10
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
:FP.fprint_if_end_10
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
    jmpt :_STRNatoi_if_end_11
    ldm A $__natoi_res
    stack A $DATASTACK_PTR
    jmp :_natoi_end
:_STRNatoi_if_end_11
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
    jmpt :FP.from_string_if_end_12
    ldi A 1
    stack A $DATASTACK_PTR
    call @negate
    ustack A $DATASTACK_PTR
    sto A $sign
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $str_ptr
:FP.from_string_if_end_12
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
    jmpt :FP.from_string_if_end_13
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
:FP.from_string_if_end_13
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
    ldm A $sign
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
:_fp_from_string_end
    ret


@_drawTurtle
    ldm A $current_mode
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_drawTurtle_if_else_0
    ldm A $current_color
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    jmp :_drawTurtle_if_end_0
:_drawTurtle_if_else_0
    ldm A $current_char
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
:_drawTurtle_if_end_0
    ret
@TURTLE.mode
    call @rt_dup
    ustack A $DATASTACK_PTR
    sto A $current_mode
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $current_mode
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.mode_if_end_1
    ldi A 0
    sto A $current_flip
:TURTLE.mode_if_end_1
    ldm A $current_mode
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.mode_if_end_2
    ldi A 0
    sto A $current_flip
:TURTLE.mode_if_end_2
    ldm A $current_mode
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.mode_if_end_3
    ldi A 0
    sto A $current_mode
    ldi A 1
    sto A $current_flip
:TURTLE.mode_if_end_3
    ldm A $current_mode
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.mode_if_end_4
    ldi A 1
    sto A $current_mode
    ldi A 1
    sto A $current_flip
:TURTLE.mode_if_end_4
    ldm A $current_mode
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.mode_if_else_5
    ldi A 480
    sto A $current_height
    ldi A 640
    sto A $current_width
    jmp :TURTLE.mode_if_end_5
:TURTLE.mode_if_else_5
    ldi A 60
    sto A $current_height
    ldi A 80
    sto A $current_width
:TURTLE.mode_if_end_5
    ret
@TURTLE.flip
    ldm A $current_flip
    tst A 0
    jmpt :TURTLE.flip_if_end_6
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
:TURTLE.flip_if_end_6
    ret
@TURTLE.right
    ustack A $DATASTACK_PTR
    sto A $degrees_to_turn
    ldm A $TURTLE_HEADING_DEG
    stack A $DATASTACK_PTR
    ldm A $degrees_to_turn
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 360
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $TURTLE_HEADING_DEG
    ret
@TURTLE.left
    ustack A $DATASTACK_PTR
    sto A $degrees_to_turn
    ldi A 360
    stack A $DATASTACK_PTR
    ldm A $TURTLE_HEADING_DEG
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $degrees_to_turn
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldi A 360
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $TURTLE_HEADING_DEG
    ret
@TURTLE.color
    call @rt_dup
    ustack A $DATASTACK_PTR
    sto A $current_color
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@TURTLE.goto
    ldm A $current_height
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    call @rt_dup
    ustack A $DATASTACK_PTR
    sto A $Yax
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $current_width
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    call @rt_dup
    ustack A $DATASTACK_PTR
    sto A $Xax
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    call @_drawTurtle
    ret
@TURTLE.forward
    ustack A $DATASTACK_PTR
    sto A $distance
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.forward_if_end_7
    jmp :move_end
:TURTLE.forward_if_end_7
    ldm A $TURTLE_HEADING_DEG
    stack A $DATASTACK_PTR
    ldi A 22
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 45
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $TURTLE_HEADING
    ldi A $TURTLE_DX
    stack A $DATASTACK_PTR
    ldm A $TURTLE_HEADING
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $dx
    ldi A $TURTLE_DY
    stack A $DATASTACK_PTR
    ldm A $TURTLE_HEADING
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $dy
:move_loop
    ldm A $distance
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.forward_if_end_8
    jmp :move_end
:TURTLE.forward_if_end_8
    ldm A $Xax
    stack A $DATASTACK_PTR
    ldm A $dx
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $Xax
    ldm A $Yax
    stack A $DATASTACK_PTR
    ldm A $dy
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $Yax
    ldm A $Xax
    stack A $DATASTACK_PTR
    ldm A $Yax
    stack A $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $distance
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $distance
    jmp :move_loop
:move_end
    ret
@_welcome_at_turtle
    ldi A 30
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
:welcome_loop
    ldi A $msg
    stack A $DATASTACK_PTR
    ldm A $i_turtle
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $p_char
    ldm I $p_char
    ldx A $_start_memory_
    sto A $char
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_welcome_at_turtle_if_end_9
    jmp :welcome_end
:_welcome_at_turtle_if_end_9
    ldm A $char
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 30
    stack A $DATASTACK_PTR
    ldm A $i_turtle
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $i_turtle
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i_turtle
    jmp :welcome_loop
:welcome_end
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@TURTLE.start

    . $TURTLE_DX 8
    % $TURTLE_DX  1  1  0 -1 -1 -1  0  1
    . $TURTLE_DY 8
    % $TURTLE_DY  0  1  1  1  0 -1 -1 -1
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $current_mode
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $current_color
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    call @_welcome_at_turtle
    ret
@TURTLE.line
    ustack A $DATASTACK_PTR
    sto A $y2
    ustack A $DATASTACK_PTR
    sto A $x2
    ustack A $DATASTACK_PTR
    sto A $y1
    ustack A $DATASTACK_PTR
    sto A $x1
    ldm A $x2
    stack A $DATASTACK_PTR
    ldm A $x1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $dx
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_10
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $dx
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $dx
:TURTLE.line_if_end_10
    ldm A $y2
    stack A $DATASTACK_PTR
    ldm A $y1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $dy
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_11
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $dy
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $dy
:TURTLE.line_if_end_11
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $sx
    ldm A $x1
    stack A $DATASTACK_PTR
    ldm A $x2
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_12
    ldi A 1
    sto A $sx
:TURTLE.line_if_end_12
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $sy
    ldm A $y1
    stack A $DATASTACK_PTR
    ldm A $y2
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_13
    ldi A 1
    sto A $sy
:TURTLE.line_if_end_13
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $dy
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $dy
    ldm A $dx
    stack A $DATASTACK_PTR
    ldm A $dy
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $err
:line_loop
    ldm A $x1
    stack A $DATASTACK_PTR
    ldm A $y1
    stack A $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $x1
    stack A $DATASTACK_PTR
    ldm A $x2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_14
    ldm A $y1
    stack A $DATASTACK_PTR
    ldm A $y2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_15
    jmp :line_end
:TURTLE.line_if_end_15
:TURTLE.line_if_end_14
    ldm A $err
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    sto A $e2
    stack A $DATASTACK_PTR
    ldm A $dy
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_16
    jmp :skip_x_move
:TURTLE.line_if_end_16
    ldm A $err
    stack A $DATASTACK_PTR
    ldm A $dy
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $err
    ldm A $x1
    stack A $DATASTACK_PTR
    ldm A $sx
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $x1
:skip_x_move
    ldm A $e2
    stack A $DATASTACK_PTR
    ldm A $dx
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_17
    jmp :skip_y_move
:TURTLE.line_if_end_17
    ldm A $err
    stack A $DATASTACK_PTR
    ldm A $dx
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $err
    ldm A $y1
    stack A $DATASTACK_PTR
    ldm A $sy
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $y1
:skip_y_move
    jmp :line_loop
:line_end
    ldm A $x2
    sto A $Xax
    ldm A $y2
    sto A $Yax
    ret
@_plot_circle_points
    ustack A $DATASTACK_PTR
    sto A $circ_y
    ustack A $DATASTACK_PTR
    sto A $circ_x
    ldm A $circ_xc
    stack A $DATASTACK_PTR
    ldm A $circ_x
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $circ_yc
    stack A $DATASTACK_PTR
    ldm A $circ_y
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $circ_xc
    stack A $DATASTACK_PTR
    ldm A $circ_x
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $circ_yc
    stack A $DATASTACK_PTR
    ldm A $circ_y
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $circ_xc
    stack A $DATASTACK_PTR
    ldm A $circ_x
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $circ_yc
    stack A $DATASTACK_PTR
    ldm A $circ_y
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $circ_xc
    stack A $DATASTACK_PTR
    ldm A $circ_x
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $circ_yc
    stack A $DATASTACK_PTR
    ldm A $circ_y
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $circ_xc
    stack A $DATASTACK_PTR
    ldm A $circ_y
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $circ_yc
    stack A $DATASTACK_PTR
    ldm A $circ_x
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $circ_xc
    stack A $DATASTACK_PTR
    ldm A $circ_y
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $circ_yc
    stack A $DATASTACK_PTR
    ldm A $circ_x
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $circ_xc
    stack A $DATASTACK_PTR
    ldm A $circ_y
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $circ_yc
    stack A $DATASTACK_PTR
    ldm A $circ_x
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $circ_xc
    stack A $DATASTACK_PTR
    ldm A $circ_y
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $circ_yc
    stack A $DATASTACK_PTR
    ldm A $circ_x
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ret
@TURTLE.circle
    ustack A $DATASTACK_PTR
    sto A $circ_p
    ustack A $DATASTACK_PTR
    sto A $circ_yc
    ustack A $DATASTACK_PTR
    sto A $circ_xc
    ldm A $circ_p
    sto A $circ_x
    ldi A 0
    sto A $circ_y
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $circ_p
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $circ_p
:circle_loop
    ldm A $circ_x
    stack A $DATASTACK_PTR
    ldm A $circ_y
    stack A $DATASTACK_PTR
    call @_plot_circle_points
    ldm A $circ_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $circ_y
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $circ_p
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.circle_if_else_18
    ldm A $circ_p
    stack A $DATASTACK_PTR
    ldm A $circ_y
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $circ_p
    jmp :TURTLE.circle_if_end_18
:TURTLE.circle_if_else_18
    ldm A $circ_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $circ_x
    ldm A $circ_p
    stack A $DATASTACK_PTR
    ldm A $circ_y
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $circ_x
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $circ_p
:TURTLE.circle_if_end_18
    ldm A $circ_x
    stack A $DATASTACK_PTR
    ldm A $circ_y
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.circle_if_end_19
    jmp :circle_loop
:TURTLE.circle_if_end_19
    ldm A $circ_x
    stack A $DATASTACK_PTR
    ldm A $circ_y
    stack A $DATASTACK_PTR
    call @_plot_circle_points
    ret

@screen_to_world_x
    call @FP.from_int
    ldi A 320
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.sub
    ldi A 51
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.div
    ret
@world_to_screen_x
    ldi A 51
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.mul
    ldi A 320
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.add
    call @FP.to_int
    ret
@world_to_screen_y
    ldm A $SCALE_Y
    stack A $DATASTACK_PTR
    call @FP.mul
    ldi A 240
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @rt_swap
    call @FP.sub
    call @FP.to_int
    ret
@function_to_draw1
    ret
@function_to_draw2
    call @rt_dup
    ldi A 3
    stack A $DATASTACK_PTR
    call @FP.power
    ldi A 3
    stack A $DATASTACK_PTR
    call @factorial
    call @FP.from_int
    call @FP.div
    call @FP.sub
    ret
@function_to_draw3
    call @rt_dup
    call @function_to_draw2
    call @rt_swap
    ldi A 5
    stack A $DATASTACK_PTR
    call @FP.power
    ldi A 5
    stack A $DATASTACK_PTR
    call @factorial
    call @FP.from_int
    call @FP.div
    call @FP.add
    ret
@function_to_draw4
    call @rt_dup
    call @function_to_draw3
    call @rt_swap
    ldi A 7
    stack A $DATASTACK_PTR
    call @FP.power
    ldi A 7
    stack A $DATASTACK_PTR
    call @factorial
    call @FP.from_int
    call @FP.div
    call @FP.sub
    ret
@function_to_draw5
    call @rt_dup
    call @function_to_draw4
    call @rt_swap
    ldi A 9
    stack A $DATASTACK_PTR
    call @FP.power
    ldi A 9
    stack A $DATASTACK_PTR
    call @factorial
    call @FP.from_int
    call @FP.div
    call @FP.add
    ret
@function_to_draw6
    call @rt_dup
    call @function_to_draw5
    call @rt_swap
    ldi A 11
    stack A $DATASTACK_PTR
    call @FP.power
    ldi A 11
    stack A $DATASTACK_PTR
    call @factorial
    call @FP.from_int
    call @FP.div
    call @FP.sub
    ret
@function_to_draw7
    call @rt_dup
    call @function_to_draw6
    call @rt_swap
    ldi A 13
    stack A $DATASTACK_PTR
    call @FP.power
    ldi A 13
    stack A $DATASTACK_PTR
    call @factorial
    call @FP.from_int
    call @FP.div
    call @FP.add
    ret
@function_to_draw8
    call @rt_dup
    call @function_to_draw7
    call @rt_swap
    ldi A 15
    stack A $DATASTACK_PTR
    call @FP.power
    ldi A 15
    stack A $DATASTACK_PTR
    call @factorial
    call @FP.from_int
    call @FP.div
    call @FP.sub
    ret
@function_to_draw9
    call @rt_dup
    call @function_to_draw8
    call @rt_swap
    ldi A 17
    stack A $DATASTACK_PTR
    call @FP.power
    ldi A 17
    stack A $DATASTACK_PTR
    call @factorial
    call @FP.from_int
    call @FP.div
    call @FP.add
    ret
@draw_axes
    ldi A 15
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldi A 320
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 320
    stack A $DATASTACK_PTR
    ldi A 480
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @TURTLE.line
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 240
    stack A $DATASTACK_PTR
    ldi A 640
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldi A 240
    stack A $DATASTACK_PTR
    call @TURTLE.line
    ret
@draw_plot
    ustack A $DATASTACK_PTR
    sto A $function_index
    ustack A $DATASTACK_PTR
    sto A $color
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldi A 0
    sto A $sx1
    ldi A 0
    sto A $sy1
    ldi A 0
    sto A $prev_sx
    ldi A 0
    sto A $prev_sy
    ldi A 1
    sto A $is_first_point
    ldi A 0
    sto A $world_x
    ldi A 63
    stack A $DATASTACK_PTR
    call @negate
    ustack A $DATASTACK_PTR
    sto A $i
:loop_draw
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 63
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_end_0
    jmp :end_draw_plot
:draw_plot_if_end_0
    ldm A $i
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 10
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $world_x
    stack A $DATASTACK_PTR
    call @world_to_screen_x
    ustack A $DATASTACK_PTR
    sto A $sx1
    ldm A $world_x
    stack A $DATASTACK_PTR
    ldm A $function_index
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_else_1
    call @function_to_draw1
    jmp :draw_plot_if_end_1
:draw_plot_if_else_1
    ldm A $function_index
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_else_2
    call @function_to_draw2
    jmp :draw_plot_if_end_2
:draw_plot_if_else_2
    ldm A $function_index
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_else_3
    call @function_to_draw3
    jmp :draw_plot_if_end_3
:draw_plot_if_else_3
    ldm A $function_index
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_else_4
    call @function_to_draw4
    jmp :draw_plot_if_end_4
:draw_plot_if_else_4
    ldm A $function_index
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_else_5
    call @function_to_draw5
    jmp :draw_plot_if_end_5
:draw_plot_if_else_5
    ldm A $function_index
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_else_6
    call @function_to_draw6
    jmp :draw_plot_if_end_6
:draw_plot_if_else_6
    ldm A $function_index
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_else_7
    call @function_to_draw7
    jmp :draw_plot_if_end_7
:draw_plot_if_else_7
    ldm A $function_index
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_else_8
    call @function_to_draw8
    jmp :draw_plot_if_end_8
:draw_plot_if_else_8
    ldm A $function_index
    stack A $DATASTACK_PTR
    ldi A 9
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_end_9
    call @function_to_draw9
:draw_plot_if_end_9
:draw_plot_if_end_8
:draw_plot_if_end_7
:draw_plot_if_end_6
:draw_plot_if_end_5
:draw_plot_if_end_4
:draw_plot_if_end_3
:draw_plot_if_end_2
:draw_plot_if_end_1
    call @world_to_screen_y
    ustack A $DATASTACK_PTR
    sto A $sy1
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_end_10
    ldm A $sy1
    stack A $DATASTACK_PTR
    ldi A 480
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_plot_if_end_11
    ldm A $is_first_point
    tst A 0
    jmpt :draw_plot_if_else_12
    ldi A 0
    sto A $is_first_point
    jmp :draw_plot_if_end_12
:draw_plot_if_else_12
    ldm A $prev_sx
    stack A $DATASTACK_PTR
    ldm A $prev_sy
    stack A $DATASTACK_PTR
    ldm A $sx1
    stack A $DATASTACK_PTR
    ldm A $sy1
    stack A $DATASTACK_PTR
    call @TURTLE.line
:draw_plot_if_end_12
:draw_plot_if_end_11
:draw_plot_if_end_10
    ldm A $sx1
    sto A $prev_sx
    ldm A $sy1
    sto A $prev_sy
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :loop_draw
:end_draw_plot
    ret
@main
    ldi A 1000
    stack A $DATASTACK_PTR
    call @FP.set_scale
    call @TURTLE.start
    ldi A 0
    stack A $DATASTACK_PTR
    call @TURTLE.mode
    call @draw_axes
    ldi A $main_str_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ustack A $DATASTACK_PTR
    sto A $SCALE_Y
    ldi A $main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @draw_plot
    ldi A $main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @draw_plot
    ldi A $main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @draw_plot
    ldi A $main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @draw_plot
    ldi A $main_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @draw_plot
    ldi A $main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    call @draw_plot
    ldi A $main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @draw_plot
    ldi A $main_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    call @draw_plot
    ldi A $main_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 9
    stack A $DATASTACK_PTR
    call @draw_plot
    ldi A $main_str_10
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

% $current_char 203
% $current_mode 3
% $current_color 5
% $current_width 80
% $current_height 60
% $current_flip 1
% $Xax 0
% $Yax 0
% $degrees 0
% $TURTLE_HEADING_DEG 0
% $TURTLE_HEADING 0
% $degrees_to_turn 0
% $dx 0
% $dy 0
% $distance 0
% $temp_ptr 0
% $msg \* \space \W \e \l \c \o \m \e \space \a \t \space \T \U \R \T \L \E \space \* \null
% $i_turtle 0
% $char 0
% $p_char 0
% $x1 0
% $y1 0
% $x2 0
% $y2 0
% $sx 0
% $sy 0
% $err 0
% $e2 0
% $circ_xc 0
% $circ_yc 0
% $circ_x 0
% $circ_y 0
% $circ_p 0
% $SCALE_Y 0
% $main_str_0 \1 \2 \0 \null
% $main_str_1 \D \r \a \w \i \n \g \space \1 \- \t \e \r \m \space \( \b \l \u \e \) \space \y \= \x \. \. \. \. \. \. \. \. \Return \null
% $main_str_2 \D \r \a \w \i \n \g \space \2 \- \t \e \r \m \space \( \g \r \e \e \n \) \space \s \e \r \i \e \s \. \. \. \. \Return \null
% $main_str_3 \D \r \a \w \i \n \g \space \3 \- \t \e \r \m \space \( \r \e \d \) \space \s \e \r \i \e \s \. \. \. \. \. \. \Return \null
% $main_str_4 \D \r \a \w \i \n \g \space \4 \- \t \e \r \m \space \( \c \y \a \n \) \space \s \e \r \i \e \s \. \. \. \. \. \Return \null
% $main_str_5 \D \r \a \w \i \n \g \space \5 \- \t \e \r \m \space \( \y \e \l \l \o \w \) \space \s \e \r \i \e \s \. \. \. \Return \null
% $main_str_6 \D \r \a \w \i \n \g \space \6 \- \t \e \r \m \space \( \m \a \g \e \n \t \a \) \space \s \e \r \i \e \s \. \. \Return \null
% $main_str_7 \D \r \a \w \i \n \g \space \7 \- \t \e \r \m \space \( \l \i \g \h \t \B \l \u \e \) \space \s \e \r \i \e \s \Return \null
% $main_str_8 \D \r \a \w \i \n \g \space \8 \- \t \e \r \m \space \( \l \i \g \h \t \R \e \d \) \space \s \e \r \i \e \s \. \Return \null
% $main_str_9 \D \r \a \w \i \n \g \space \9 \- \t \e \r \m \space \( \w \h \i \t \e \) \space \s \e \r \i \e \s \. \. \. \. \Return \null
% $main_str_10 \A \l \l \space \d \o \n \e \! \space \i \n \space \null
