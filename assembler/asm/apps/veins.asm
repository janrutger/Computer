# .HEADER
. $_power_base 1
. $_power_exp 1
. $_power_res 1
. $n 1
. $res 1
. $_sqrt_y 1
. $_sqrt_L 1
. $_sqrt_R 1
. $_sqrt_M 1
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
. $TURTLE_DX 8
. $TURTLE_DY 8
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
. $_dict_ptr 1
. $_dict_cap 1
. $_dict_cnt 1
. $_dict_key 1
. $_dict_val 1
. $_dict_idx 1
. $_dict_found 1
. $_dict_offset 1
. $_dict_last_off 1
. $_dict_last_key 1
. $_dict_last_val 1
. $_dict_err_full 30
. $_dict_err_key 25
. $_dict_err_bnd 32
. $_dict_err_inv_key 49
. $_cell_ptr 1
. $_auxin_ptr 1
. $_obj_ptr 1
. $_offset 1
. $_i_value 1
. $_fp_vaule 1
. $_obj1_ptr 1
. $_obj2_ptr 1
. $_x1 1
. $_y1 1
. $_x2 1
. $_y2 1
. $_vx 1
. $_vy 1
. $_dx 1
. $_dy 1
. $_distance 1
. $_space_left 1
. $_num_auxins 1
. $last_distance 1
. $current_cell_ptr 1
. $current_auxin_ptr 1
. $current_auxin 1
. $kill_dict 1
. $generation 1
. $Cells_dict 1
. $cell_ptr 1
. $current_cell 1
. $auxin_ptr 1
. $Auxins_dict 1
. $grow_str_0 2
. $initial_cell_count 1
. $_mag 1
. $_scale 1
. $_new_x 1
. $_new_y 1
. $_new_cell_ptr 1
. $main_str_1 28
. $main_str_2 27
. $main_str_3 19
. $main_str_4 22
. $main_str_5 27
. $main_str_6 23
. $main_str_7 15

# .CODE
    call @main
    ret

# .FUNCTIONS

@gcd
:gcd_while_start_0
    call @rt_dup
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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
@isqrt
    ustack A $DATASTACK_PTR
    sto A $_sqrt_y
    ld A Z
    sto A $_sqrt_L
    ldm B $_sqrt_y
    ldi A 1
    add A B
    sto A $_sqrt_R
:isqrt_while_start_2
    ldm A $_sqrt_L
    stack A $DATASTACK_PTR
    ldm B $_sqrt_R
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :isqrt_while_end_2
    ldm B $_sqrt_L
    ldm A $_sqrt_R
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $_sqrt_M
    stack A $DATASTACK_PTR
    call @rt_dup
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldm A $_sqrt_y
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :isqrt_if_else_1
    ldm A $_sqrt_M
    sto A $_sqrt_R
    jmp :isqrt_if_end_1
:isqrt_if_else_1
    ldm A $_sqrt_M
    sto A $_sqrt_L
:isqrt_if_end_1
    jmp :isqrt_while_start_2
:isqrt_while_end_2
    ldm A $_sqrt_L
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
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :FP.div_if_else_5
    ldm A $div_error
    stack A $DATASTACK_PTR
    call @PRTstring
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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
@FP.sqrt
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    call @isqrt
    ret
@FP.print
    call @rt_dup
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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
    ld A Z
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
    stack Z $DATASTACK_PTR
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
    ld A Z
    sto A $__natoi_res
:loop_natoi
    ldm A $__natoi_len
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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


@_drawTurtle
    ldm A $current_mode
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.mode_if_end_1
    ld A Z
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
    ld A Z
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
    ld A Z
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
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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
    ldm B $TURTLE_HEADING_DEG
    ldm A $degrees_to_turn
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
    ld B A
    ldm A $TURTLE_HEADING_DEG
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
    stack Z $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.forward_if_end_7
    jmp :move_end
:TURTLE.forward_if_end_7
    ldm B $TURTLE_HEADING_DEG
    ldi A 22
    add B A
    stack B $DATASTACK_PTR
    ldi A 45
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $TURTLE_HEADING
    ldi A $TURTLE_DX
    ld B A
    ldm A $TURTLE_HEADING
    add A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $dx
    ldi A $TURTLE_DY
    ld B A
    ldm A $TURTLE_HEADING
    add A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $dy
:move_loop
    ldm A $distance
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.forward_if_end_8
    jmp :move_end
:TURTLE.forward_if_end_8
    ldm B $Xax
    ldm A $dx
    add A B
    sto A $Xax
    ldm B $Yax
    ldm A $dy
    add A B
    sto A $Yax
    ldm A $Xax
    stack A $DATASTACK_PTR
    ldm A $Yax
    stack A $DATASTACK_PTR
    call @TURTLE.goto
    ldm B $distance
    ldi A 1
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
    ld B A
    ldm A $i_turtle
    add A B
    sto A $p_char
    ldm I $p_char
    ldx A $_start_memory_
    sto A $char
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    ld B A
    ldm A $i_turtle
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
    ldm B $i_turtle
    ldi A 1
    add A B
    sto A $i_turtle
    jmp :welcome_loop
:welcome_end
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@TURTLE.start
    ldi A 3
    sto A $current_mode
       ; one time initialization
    ;. $TURTLE_DX 8
    % $TURTLE_DX  1  1  0 -1 -1 -1  0  1
    ;. $TURTLE_DY 8
    % $TURTLE_DY  0  1  1  1  0 -1 -1 -1
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
    ldm B $x2
    ldm A $x1
    sub B A
    ld A B
    sto A $dx
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_10
    stack Z $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $dx
    ustack B $DATASTACK_PTR
    mul A B
    sto A $dx
:TURTLE.line_if_end_10
    ldm B $y2
    ldm A $y1
    sub B A
    ld A B
    sto A $dy
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.line_if_end_11
    stack Z $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $dy
    ustack B $DATASTACK_PTR
    mul A B
    sto A $dy
:TURTLE.line_if_end_11
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $dy
    ustack B $DATASTACK_PTR
    mul A B
    sto A $dy
    ldm B $dx
    ldm A $dy
    add A B
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
    ldm B $err
    ldi A 2
    mul A B
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
    ldm B $err
    ldm A $dy
    add A B
    sto A $err
    ldm B $x1
    ldm A $sx
    add A B
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
    ldm B $err
    ldm A $dx
    add A B
    sto A $err
    ldm B $y1
    ldm A $sy
    add A B
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
    ldm B $circ_xc
    ldm A $circ_x
    add B A
    stack B $DATASTACK_PTR
    ldm B $circ_yc
    ldm A $circ_y
    add B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm B $circ_xc
    ldm A $circ_x
    sub B A
    stack B $DATASTACK_PTR
    ldm B $circ_yc
    ldm A $circ_y
    add B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm B $circ_xc
    ldm A $circ_x
    add B A
    stack B $DATASTACK_PTR
    ldm B $circ_yc
    ldm A $circ_y
    sub B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm B $circ_xc
    ldm A $circ_x
    sub B A
    stack B $DATASTACK_PTR
    ldm B $circ_yc
    ldm A $circ_y
    sub B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm B $circ_xc
    ldm A $circ_y
    add B A
    stack B $DATASTACK_PTR
    ldm B $circ_yc
    ldm A $circ_x
    add B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm B $circ_xc
    ldm A $circ_y
    sub B A
    stack B $DATASTACK_PTR
    ldm B $circ_yc
    ldm A $circ_x
    add B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm B $circ_xc
    ldm A $circ_y
    add B A
    stack B $DATASTACK_PTR
    ldm B $circ_yc
    ldm A $circ_x
    sub B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm B $circ_xc
    ldm A $circ_y
    sub B A
    stack B $DATASTACK_PTR
    ldm B $circ_yc
    ldm A $circ_x
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
    ld A Z
    sto A $circ_y
    ldi A 1
    ld B A
    ldm A $circ_p
    sub B A
    ld A B
    sto A $circ_p
:circle_loop
    ldm A $circ_x
    stack A $DATASTACK_PTR
    ldm A $circ_y
    stack A $DATASTACK_PTR
    call @_plot_circle_points
    ldm B $circ_y
    ldi A 1
    add A B
    sto A $circ_y
    stack Z $DATASTACK_PTR
    ldm A $circ_p
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TURTLE.circle_if_else_18
    ldm A $circ_p
    stack A $DATASTACK_PTR
    ldm B $circ_y
    ldi A 2
    mul A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add A B
    sto A $circ_p
    jmp :TURTLE.circle_if_end_18
:TURTLE.circle_if_else_18
    ldm B $circ_x
    ldi A 1
    sub B A
    ld A B
    sto A $circ_x
    ldm A $circ_p
    stack A $DATASTACK_PTR
    ldm B $circ_y
    ldi A 2
    mul A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm B $circ_x
    ldi A 2
    mul A B
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add A B
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


@DICT.new
    ustack A $DATASTACK_PTR
    sto A $_dict_cap
    ld B A
    ldi A 2
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ldm A $_dict_cap
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    ret
@DICT.count
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_swap
    call @LIST.get
    ret
@DICT.put
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ustack A $DATASTACK_PTR
    sto A $_dict_val
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_end_0
    ldi A $_dict_err_inv_key
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:DICT.put_if_end_0
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_found
    ld A Z
    sto A $_dict_idx
:DICT.put_while_start_0
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_while_end_0
    ldm B $_dict_idx
    ldi A 2
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_else_1
    ldm A $_dict_val
    stack A $DATASTACK_PTR
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 1
    sto A $_dict_found
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.put_if_end_1
:DICT.put_if_else_1
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.put_if_end_1
    jmp :DICT.put_while_start_0
:DICT.put_while_end_0
    ldm A $_dict_found
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_end_2
    stack Z $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cap
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    ldm A $_dict_cap
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.put_if_end_3
    ldi A $_dict_err_full
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:DICT.put_if_end_3
    ldm B $_dict_cnt
    ldi A 2
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dict_offset
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    ldm A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_val
    stack A $DATASTACK_PTR
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_dict_cnt
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
:DICT.put_if_end_2
    ret
@DICT.get
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_found
    ld A Z
    sto A $_dict_idx
:DICT.get_while_start_1
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.get_while_end_1
    ldm B $_dict_idx
    ldi A 2
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.get_if_else_4
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldi A 1
    sto A $_dict_found
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.get_if_end_4
:DICT.get_if_else_4
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.get_if_end_4
    jmp :DICT.get_while_start_1
:DICT.get_while_end_1
    ldm A $_dict_found
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.get_if_end_5
    ldi A $_dict_err_key
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:DICT.get_if_end_5
    ret
@DICT.has_key
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_found
    ld A Z
    sto A $_dict_idx
:DICT.has_key_while_start_2
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.has_key_while_end_2
    ldm B $_dict_idx
    ldi A 2
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.has_key_if_else_6
    ldi A 1
    sto A $_dict_found
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.has_key_if_end_6
:DICT.has_key_if_else_6
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.has_key_if_end_6
    jmp :DICT.has_key_while_start_2
:DICT.has_key_while_end_2
    ldm A $_dict_found
    stack A $DATASTACK_PTR
    ret
@DICT.remove
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_key
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ld A Z
    sto A $_dict_idx
:DICT.remove_while_start_3
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.remove_while_end_3
    ldm B $_dict_idx
    ldi A 2
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_dict_key
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.remove_if_else_7
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm B $_dict_cnt
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.remove_if_end_8
    ldm B $_dict_cnt
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dict_last_off
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_last_key
    ldm B $_dict_last_off
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_last_val
    ldm A $_dict_last_key
    stack A $DATASTACK_PTR
    ldm A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_last_val
    stack A $DATASTACK_PTR
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
:DICT.remove_if_end_8
    ldm B $_dict_cnt
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dict_cnt
    sto A $_dict_idx
    jmp :DICT.remove_if_end_7
:DICT.remove_if_else_7
    ldm B $_dict_idx
    ldi A 1
    add A B
    sto A $_dict_idx
:DICT.remove_if_end_7
    jmp :DICT.remove_while_start_3
:DICT.remove_while_end_3
    ret
@DICT.clear
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@DICT.item
    ustack A $DATASTACK_PTR
    sto A $_dict_ptr
    ustack A $DATASTACK_PTR
    sto A $_dict_idx
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dict_cnt
    ldm A $_dict_idx
    stack A $DATASTACK_PTR
    ldm A $_dict_cnt
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DICT.item_if_else_9
    ldm B $_dict_idx
    ldi A 2
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add A B
    sto A $_dict_offset
    stack A $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm B $_dict_offset
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_dict_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    jmp :DICT.item_if_end_9
:DICT.item_if_else_9
    ldi A $_dict_err_bnd
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:DICT.item_if_end_9
    ret

@NEW.cell
    ldi A 4
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_cell_ptr
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_cell_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_cell_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_cell_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_cell_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_cell_ptr
    stack A $DATASTACK_PTR
    ret
@NEW.auxin
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_auxin_ptr
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_auxin_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_auxin_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_auxin_ptr
    stack A $DATASTACK_PTR
    ret
@OBJ.put
    call @LIST.put
    ret
@OBJ.get
    call @LIST.get
    ret
@OBJ.distance
    ustack A $DATASTACK_PTR
    sto A $_obj1_ptr
    ustack A $DATASTACK_PTR
    sto A $_obj2_ptr
    stack Z $DATASTACK_PTR
    ldm A $_obj1_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_x1
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_obj1_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_y1
    stack Z $DATASTACK_PTR
    ldm A $_obj2_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_x2
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_obj2_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_y2
    ldm A $_x1
    stack A $DATASTACK_PTR
    ldm A $_x2
    stack A $DATASTACK_PTR
    call @FP.sub
    call @rt_dup
    call @FP.mul
    ldm A $_y1
    stack A $DATASTACK_PTR
    ldm A $_y2
    stack A $DATASTACK_PTR
    call @FP.sub
    call @rt_dup
    call @FP.mul
    call @FP.add
    call @FP.sqrt
    ret
@CELL.clear_direction
    ustack A $DATASTACK_PTR
    sto A $_cell_ptr
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_cell_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    stack Z $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_cell_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@CELL.update_direction
    ustack A $DATASTACK_PTR
    sto A $_obj1_ptr
    ustack A $DATASTACK_PTR
    sto A $_obj2_ptr
    ustack A $DATASTACK_PTR
    sto A $_distance
    stack Z $DATASTACK_PTR
    ldm A $_obj1_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_x1
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_obj1_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_y1
    stack Z $DATASTACK_PTR
    ldm A $_obj2_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_x2
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_obj2_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_y2
    ldm A $_x2
    stack A $DATASTACK_PTR
    ldm A $_x1
    stack A $DATASTACK_PTR
    call @FP.sub
    ustack A $DATASTACK_PTR
    sto A $_vx
    ldm A $_y2
    stack A $DATASTACK_PTR
    ldm A $_y1
    stack A $DATASTACK_PTR
    call @FP.sub
    ustack A $DATASTACK_PTR
    sto A $_vy
    ldm A $_vx
    stack A $DATASTACK_PTR
    ldm A $_distance
    stack A $DATASTACK_PTR
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $_vx
    ldm A $_vy
    stack A $DATASTACK_PTR
    ldm A $_distance
    stack A $DATASTACK_PTR
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $_vy
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_obj1_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dx
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_obj1_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_dy
    ldm A $_dx
    stack A $DATASTACK_PTR
    ldm A $_vx
    stack A $DATASTACK_PTR
    call @FP.add
    ustack A $DATASTACK_PTR
    sto A $_dx
    ldm A $_dy
    stack A $DATASTACK_PTR
    ldm A $_vy
    stack A $DATASTACK_PTR
    call @FP.add
    ustack A $DATASTACK_PTR
    sto A $_dy
    ldm A $_dx
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_obj1_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_dy
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_obj1_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ret
@AUXIN.create
    ldm A $Auxins_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    ldi A 40
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :AUXIN.create_if_end_0
    ldi A 40
    stack A $DATASTACK_PTR
    ldm A $Auxins_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_space_left
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :AUXIN.create_if_else_1
    ldi A 5
    sto A $_num_auxins
    jmp :AUXIN.create_if_end_1
:AUXIN.create_if_else_1
    ldm A $_space_left
    sto A $_num_auxins
:AUXIN.create_if_end_1
:AUXIN.create_while_start_0
    ldm A $_num_auxins
    tst A 0
    jmpt :AUXIN.create_while_end_0
    call @rt_rnd
    ldi A 636
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 999
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $_i_value
    stack A $DATASTACK_PTR
    call @FP.from_int
    ustack A $DATASTACK_PTR
    sto A $_x1
    call @rt_rnd
    ldi A 476
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 999
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $_i_value
    stack A $DATASTACK_PTR
    call @FP.from_int
    ustack A $DATASTACK_PTR
    sto A $_y1
    call @NEW.auxin
    ustack A $DATASTACK_PTR
    sto A $auxin_ptr
    ldm A $_x1
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $auxin_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_y1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $auxin_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $auxin_ptr
    stack A $DATASTACK_PTR
    ldm A $auxin_ptr
    stack A $DATASTACK_PTR
    ldm A $Auxins_dict
    stack A $DATASTACK_PTR
    call @DICT.put
    ldm B $_num_auxins
    ldi A 1
    sub B A
    ld A B
    sto A $_num_auxins
    jmp :AUXIN.create_while_start_0
:AUXIN.create_while_end_0
:AUXIN.create_if_end_0
    ret
@DRAW.cells
    ldi A 5
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ld A Z
    sto A $current_cell
:DRAW.cells_while_start_1
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DRAW.cells_while_end_1
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $cell_ptr
    stack Z $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.get
    ustack A $DATASTACK_PTR
    sto A $_x1
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.get
    ustack A $DATASTACK_PTR
    sto A $_y1
    ldm A $_x1
    stack A $DATASTACK_PTR
    call @FP.to_int
    ldm A $_y1
    stack A $DATASTACK_PTR
    call @FP.to_int
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    ldm B $current_cell
    ldi A 1
    add A B
    sto A $current_cell
    call @rt_drop
    jmp :DRAW.cells_while_start_1
:DRAW.cells_while_end_1
    call @TURTLE.flip
    ret
@DRAW.auxins
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ld A Z
    sto A $current_cell
:DRAW.auxins_while_start_2
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $Auxins_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :DRAW.auxins_while_end_2
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $Auxins_dict
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $auxin_ptr
    stack Z $DATASTACK_PTR
    ldm A $auxin_ptr
    stack A $DATASTACK_PTR
    call @OBJ.get
    ustack A $DATASTACK_PTR
    sto A $_x1
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $auxin_ptr
    stack A $DATASTACK_PTR
    call @OBJ.get
    ustack A $DATASTACK_PTR
    sto A $_y1
    ldm A $_x1
    stack A $DATASTACK_PTR
    call @FP.to_int
    ldm A $_y1
    stack A $DATASTACK_PTR
    call @FP.to_int
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    ldm B $current_cell
    ldi A 1
    add A B
    sto A $current_cell
    call @rt_drop
    jmp :DRAW.auxins_while_start_2
:DRAW.auxins_while_end_2
    call @TURTLE.flip
    ret
@grow
    ld A Z
    sto A $current_cell
:grow_while_start_3
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :grow_while_end_3
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $cell_ptr
    call @rt_drop
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @CELL.clear_direction
    ldm B $current_cell
    ldi A 1
    add A B
    sto A $current_cell
    jmp :grow_while_start_3
:grow_while_end_3
    ld A Z
    sto A $current_auxin
    ldm A $kill_dict
    stack A $DATASTACK_PTR
    call @DICT.clear
:grow_while_start_4
    ldm A $current_auxin
    stack A $DATASTACK_PTR
    ldm A $Auxins_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :grow_while_end_4
    ldi A $grow_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ld A Z
    sto A $current_cell
    ldi A 780
    stack A $DATASTACK_PTR
    call @FP.from_int
    ustack A $DATASTACK_PTR
    sto A $last_distance
    ldm A $current_auxin
    stack A $DATASTACK_PTR
    ldm A $Auxins_dict
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $auxin_ptr
    call @rt_drop
:grow_while_start_5
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :grow_while_end_5
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $cell_ptr
    call @rt_drop
    ldm A $auxin_ptr
    stack A $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.distance
    ustack A $DATASTACK_PTR
    sto A $_distance
    stack A $DATASTACK_PTR
    ldm A $last_distance
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :grow_if_end_2
    ldm A $_distance
    sto A $last_distance
    ldm A $cell_ptr
    sto A $current_cell_ptr
    ldm A $auxin_ptr
    sto A $current_auxin_ptr
:grow_if_end_2
    ldm B $current_cell
    ldi A 1
    add A B
    sto A $current_cell
    jmp :grow_while_start_5
:grow_while_end_5
    ldm A $last_distance
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :grow_if_else_3
    ldm A $current_auxin_ptr
    stack A $DATASTACK_PTR
    ldm A $current_auxin_ptr
    stack A $DATASTACK_PTR
    ldm A $kill_dict
    stack A $DATASTACK_PTR
    call @DICT.put
    jmp :grow_if_end_3
:grow_if_else_3
    ldm A $last_distance
    stack A $DATASTACK_PTR
    ldm A $current_auxin_ptr
    stack A $DATASTACK_PTR
    ldm A $current_cell_ptr
    stack A $DATASTACK_PTR
    call @CELL.update_direction
:grow_if_end_3
    ldm B $current_auxin
    ldi A 1
    add A B
    sto A $current_auxin
    jmp :grow_while_start_4
:grow_while_end_4
    ld A Z
    sto A $current_auxin
:grow_while_start_6
    ldm A $current_auxin
    stack A $DATASTACK_PTR
    ldm A $kill_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :grow_while_end_6
    ldm A $current_auxin
    stack A $DATASTACK_PTR
    ldm A $kill_dict
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $auxin_ptr
    call @rt_drop
    ldm A $auxin_ptr
    stack A $DATASTACK_PTR
    ldm A $Auxins_dict
    stack A $DATASTACK_PTR
    call @DICT.remove
    ldm B $current_auxin
    ldi A 1
    add A B
    sto A $current_auxin
    jmp :grow_while_start_6
:grow_while_end_6
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    ustack A $DATASTACK_PTR
    sto A $initial_cell_count
    ld A Z
    sto A $current_cell
:grow_while_start_7
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $initial_cell_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :grow_while_end_7
    ldm A $current_cell
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.item
    ustack A $DATASTACK_PTR
    sto A $cell_ptr
    call @rt_drop
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.get
    ustack A $DATASTACK_PTR
    sto A $_dx
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.get
    ustack A $DATASTACK_PTR
    sto A $_dy
    ldm A $_dx
    tstg A Z
    jmpt :grow_abs_pos_4
    ldi B 0
    sub B A
    ld A B
:grow_abs_pos_4
    stack A $DATASTACK_PTR
    ldm A $_dy
    tstg A Z
    jmpt :grow_abs_pos_5
    ldi B 0
    sub B A
    ld A B
:grow_abs_pos_5
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :grow_if_end_6
    ldm A $_dx
    stack A $DATASTACK_PTR
    call @rt_dup
    call @FP.mul
    ldm A $_dy
    stack A $DATASTACK_PTR
    call @rt_dup
    call @FP.mul
    call @FP.add
    call @FP.sqrt
    ustack A $DATASTACK_PTR
    sto A $_mag
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :grow_if_end_7
    ldi A 2
    ld B A
    ldi A 2
    mul B A
    stack B $DATASTACK_PTR
    call @FP.from_int
    ldm A $_mag
    stack A $DATASTACK_PTR
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $_scale
    stack Z $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.get
    ldm A $_dx
    stack A $DATASTACK_PTR
    ldm A $_scale
    stack A $DATASTACK_PTR
    call @FP.mul
    call @FP.add
    ustack A $DATASTACK_PTR
    sto A $_new_x
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.get
    ldm A $_dy
    stack A $DATASTACK_PTR
    ldm A $_scale
    stack A $DATASTACK_PTR
    call @FP.mul
    call @FP.add
    ustack A $DATASTACK_PTR
    sto A $_new_y
    call @NEW.cell
    ustack A $DATASTACK_PTR
    sto A $_new_cell_ptr
    ldm A $_new_x
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_new_cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.put
    ldm A $_new_y
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_new_cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.put
    ldm A $_new_cell_ptr
    stack A $DATASTACK_PTR
    ldm A $_new_cell_ptr
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.put
:grow_if_end_7
:grow_if_end_6
    ldm B $current_cell
    ldi A 1
    add A B
    sto A $current_cell
    jmp :grow_while_start_7
:grow_while_end_7
    ret
@main
    call @HEAP.free
    ldi A 1000
    stack A $DATASTACK_PTR
    call @FP.set_scale
    call @TURTLE.start
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.mode
    ldi A $main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 250
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $Cells_dict
    call @NEW.cell
    ustack A $DATASTACK_PTR
    sto A $cell_ptr
    ldi A 320
    stack A $DATASTACK_PTR
    call @FP.from_int
    stack Z $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.put
    ldi A 320
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    call @OBJ.put
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    ldm A $cell_ptr
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.put
    ldi A $main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 40
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $Auxins_dict
    ldi A 40
    stack A $DATASTACK_PTR
    call @DICT.new
    ustack A $DATASTACK_PTR
    sto A $kill_dict
    call @AUXIN.create
    ldi A $main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 75
    sto A $generation
:main_while_start_8
    ldm A $generation
    stack A $DATASTACK_PTR
    ldm A $Cells_dict
    stack A $DATASTACK_PTR
    call @DICT.count
    ldi A 200
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul A B
    tst A 0
    jmpt :main_while_end_8
    call @DRAW.cells
    call @DRAW.auxins
    ldi A $main_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    call @AUXIN.create
    ldi A $main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    call @grow
    ldi A $main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $generation
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldm B $generation
    ldi A 1
    sub B A
    ld A B
    sto A $generation
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
    jmp :main_while_start_8
:main_while_end_8
    ldi A $main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ret

# .DATA

% $_power_base 0
% $_power_exp 0
% $_power_res 0
% $n 0
% $res 1
% $_sqrt_y 0
% $_sqrt_L 0
% $_sqrt_R 0
% $_sqrt_M 0

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

% $_dict_ptr 0
% $_dict_cap 0
% $_dict_cnt 0
% $_dict_key 0
% $_dict_val 0
% $_dict_idx 0
% $_dict_found 0
% $_dict_offset 0
% $_dict_last_off 0
% $_dict_last_key 0
% $_dict_last_val 0
% $_dict_err_full \D \I \C \T \. \p \u \t \: \space \D \i \c \t \i \o \n \a \r \y \space \i \s \space \f \u \l \l \Return \null
% $_dict_err_key \D \I \C \T \. \g \e \t \: \space \K \e \y \space \n \o \t \space \f \o \u \n \d \Return \null
% $_dict_err_bnd \D \I \C \T \. \i \t \e \m \: \space \I \n \d \e \x \space \o \u \t \space \o \f \space \b \o \u \n \d \s \Return \null
% $_dict_err_inv_key \D \I \C \T \. \p \u \t \: \space \K \e \y \space \0 \space \i \s \space \r \e \s \e \r \v \e \d \space \a \n \d \space \c \a \n \n \o \t \space \b \e \space \u \s \e \d \. \Return \null
% $_cell_ptr 0
% $_auxin_ptr 0
% $_obj_ptr 0
% $_offset 0
% $_i_value 0
% $_fp_vaule 0
% $_obj1_ptr 0
% $_obj2_ptr 0
% $_x1 0
% $_y1 0
% $_x2 0
% $_y2 0
% $_vx 0
% $_vy 0
% $_dx 0
% $_dy 0
% $_distance 0
% $_space_left 0
% $_num_auxins 0
% $last_distance 0
% $current_cell_ptr 0
% $current_auxin_ptr 0
% $current_auxin 0
% $kill_dict 0
% $generation 0
% $Cells_dict 0
% $cell_ptr 0
% $current_cell 0
% $auxin_ptr 0
% $Auxins_dict 0
% $grow_str_0 \. \null
% $main_str_1 \Return \S \t \a \r \t \space \o \f \space \S \i \m \u \l \a \t \i \o \n \. \. \. \. \. \space \Return \null
% $main_str_2 \- \- \space \C \e \l \l \space \d \i \c \t \o \n \a \r \y \space \c \r \e \a \t \e \d \Return \null
% $main_str_3 \- \- \space \A \u \x \i \n \s \space \c \r \e \a \t \e \d \Return \null
% $main_str_4 \- \- \space \- \- \space \S \t \a \r \t \space \g \e \n \e \r \a \t \o \r \null
% $main_str_5 \- \- \space \C \e \l \l \s \space \a \n \d \space \A \u \x \i \n \s \space \d \r \a \w \n \Return \null
% $main_str_6 \Return \- \- \space \G \r \o \w \i \n \g \space \d \o \n \e \space \f \o \r \: \space \null
% $main_str_7 \A \l \l \space \D \o \n \e \space \. \. \. \. \Return \null
