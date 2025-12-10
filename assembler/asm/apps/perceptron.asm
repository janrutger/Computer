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
. $num_inputs 1
. $weights_ptr 1
. $perceptron_ptr 1
. $i 1
. $input_val 1
. $input_ptr 1
. $weight_val 1
. $product 1
. $weighted_sum 1
. $bias 1
. $_error 1
. $error_fp 1
. $learning_rate 1
. $old_bias 1
. $old_weight 1
. $adjustment 1
. $weight_delta 1
. $new_bias 1
. $new_weight 1
. $perceptron 1
. $input_array 1
. $x_fp 1
. $y_fp 1
. $x_int 1
. $y_int 1
. $guess 1
. $true_label 1
. $error 1
. $itter 1
. $error_count 1
. $SRAND_str_0 18
. $_main_str_1 23
. $_main_str_2 8
. $_main_str_3 24
. $_main_str_4 34
. $_main_str_5 27
. $_main_str_6 26
. $_main_str_7 21
. $_main_str_8 16
. $_main_str_9 14
. $_main_str_10 18

# .CODE
    call @HEAP.free
    call @SRAND
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
    ldi A 14
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 2
    stack A $DATASTACK_PTR
    call @NN.new_perceptron
    ustack A $DATASTACK_PTR
    sto A $perceptron
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $input_array
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $input_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $input_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $_main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    sto A $itter
:_main_while_start_0
    ldm A $itter
    stack A $DATASTACK_PTR
    ldi A 1000
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
    call @random_xy
    ldm A $x_int
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $input_array
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldm A $y_int
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $input_array
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldm A $input_array
    stack A $DATASTACK_PTR
    ldm A $perceptron
    stack A $DATASTACK_PTR
    call @NN.predict
    ustack A $DATASTACK_PTR
    sto A $guess
    call @Function
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_0
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :_main_if_end_0
:_main_if_else_0
    ldi A 0
    stack A $DATASTACK_PTR
:_main_if_end_0
    ustack A $DATASTACK_PTR
    sto A $true_label
    stack A $DATASTACK_PTR
    ldm A $guess
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $error
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_1
    ldi A 5
    stack A $DATASTACK_PTR
    jmp :_main_if_end_1
:_main_if_else_1
    ldi A 2
    stack A $DATASTACK_PTR
:_main_if_end_1
    ldm A $x_int
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $y_int
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $itter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $itter
    jmp :_main_while_start_0
:_main_while_end_0
    ldi A $_main_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    sto A $itter
:_main_while_start_1
    ldm A $itter
    stack A $DATASTACK_PTR
    ldi A 900
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_1
    call @random_xy
    ldm A $x_int
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $input_array
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldm A $y_int
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $input_array
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldm A $input_array
    stack A $DATASTACK_PTR
    ldm A $perceptron
    stack A $DATASTACK_PTR
    call @NN.predict
    ustack A $DATASTACK_PTR
    sto A $guess
    call @Function
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_2
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :_main_if_end_2
:_main_if_else_2
    ldi A 0
    stack A $DATASTACK_PTR
:_main_if_end_2
    ustack A $DATASTACK_PTR
    sto A $true_label
    stack A $DATASTACK_PTR
    ldm A $guess
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $error
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_3
    ldi A 100
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldm A $error
    stack A $DATASTACK_PTR
    ldm A $input_array
    stack A $DATASTACK_PTR
    ldm A $perceptron
    stack A $DATASTACK_PTR
    call @NN.train_step
:_main_if_end_3
    ldm A $error
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_4
    ldi A 5
    stack A $DATASTACK_PTR
    jmp :_main_if_end_4
:_main_if_else_4
    ldi A 2
    stack A $DATASTACK_PTR
:_main_if_end_4
    ldm A $x_int
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 320
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $y_int
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $itter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $itter
    jmp :_main_while_start_1
:_main_while_end_1
    ldi A $_main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    sto A $itter
    ldi A 0
    sto A $error_count
:_main_while_start_2
    ldm A $itter
    stack A $DATASTACK_PTR
    ldi A 1000
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_2
    call @random_xy
    ldm A $x_int
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $input_array
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldm A $y_int
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $input_array
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldm A $input_array
    stack A $DATASTACK_PTR
    ldm A $perceptron
    stack A $DATASTACK_PTR
    call @NN.predict
    ustack A $DATASTACK_PTR
    sto A $guess
    call @Function
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_5
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :_main_if_end_5
:_main_if_else_5
    ldi A 0
    stack A $DATASTACK_PTR
:_main_if_end_5
    ustack A $DATASTACK_PTR
    sto A $true_label
    stack A $DATASTACK_PTR
    ldm A $guess
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $error
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_6
    ldm A $error_count
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $error_count
:_main_if_end_6
    ldm A $error
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_7
    ldi A 2
    stack A $DATASTACK_PTR
    jmp :_main_if_end_7
:_main_if_else_7
    ldm A $guess
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_8
    ldi A 13
    stack A $DATASTACK_PTR
    jmp :_main_if_end_8
:_main_if_else_8
    ldi A 7
    stack A $DATASTACK_PTR
:_main_if_end_8
:_main_if_end_7
    ldm A $x_int
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 320
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $y_int
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 240
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $itter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $itter
    jmp :_main_while_start_2
:_main_while_end_2
    ldi A $_main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $error_count
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $_main_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1000
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $_main_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
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


@NN.new_perceptron
    ustack A $DATASTACK_PTR
    sto A $num_inputs
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $weights_ptr
    ldi A 0
    sto A $i
:NN.new_perceptron_while_start_0
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $num_inputs
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NN.new_perceptron_while_end_0
    call @rt_rnd
    ldi A 200
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 100
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @FP.from_int
    ldi A 1000
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.div
    ldm A $weights_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :NN.new_perceptron_while_start_0
:NN.new_perceptron_while_end_0
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $perceptron_ptr
    ldi A 0
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldm A $perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $weights_ptr
    stack A $DATASTACK_PTR
    ldm A $perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $perceptron_ptr
    stack A $DATASTACK_PTR
    ret
@NN.predict
    ustack A $DATASTACK_PTR
    sto A $perceptron_ptr
    ustack A $DATASTACK_PTR
    sto A $input_ptr
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $bias
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $weights_ptr
    ldm A $bias
    sto A $weighted_sum
    ldi A 0
    sto A $i
    ldm A $input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $num_inputs
:NN.predict_while_start_1
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $num_inputs
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NN.predict_while_end_1
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $input_val
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $weights_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $weight_val
    ldm A $input_val
    stack A $DATASTACK_PTR
    ldm A $weight_val
    stack A $DATASTACK_PTR
    call @FP.mul
    ustack A $DATASTACK_PTR
    sto A $product
    ldm A $weighted_sum
    stack A $DATASTACK_PTR
    ldm A $product
    stack A $DATASTACK_PTR
    call @FP.add
    ustack A $DATASTACK_PTR
    sto A $weighted_sum
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :NN.predict_while_start_1
:NN.predict_while_end_1
    ldm A $weighted_sum
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NN.predict_if_else_0
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :NN.predict_if_end_0
:NN.predict_if_else_0
    ldi A 0
    stack A $DATASTACK_PTR
:NN.predict_if_end_0
    ret
@NN.train_step
    ustack A $DATASTACK_PTR
    sto A $perceptron_ptr
    ustack A $DATASTACK_PTR
    sto A $input_ptr
    ustack A $DATASTACK_PTR
    sto A $_error
    ustack A $DATASTACK_PTR
    sto A $learning_rate
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $old_bias
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $weights_ptr
    ldm A $_error
    stack A $DATASTACK_PTR
    call @FP.from_int
    ustack A $DATASTACK_PTR
    sto A $error_fp
    ldm A $learning_rate
    stack A $DATASTACK_PTR
    ldm A $error_fp
    stack A $DATASTACK_PTR
    call @FP.mul
    ustack A $DATASTACK_PTR
    sto A $adjustment
    ldm A $old_bias
    stack A $DATASTACK_PTR
    ldm A $adjustment
    stack A $DATASTACK_PTR
    call @FP.add
    ustack A $DATASTACK_PTR
    sto A $new_bias
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldi A 0
    sto A $i
    ldm A $input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    ustack A $DATASTACK_PTR
    sto A $num_inputs
:NN.train_step_while_start_2
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $num_inputs
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NN.train_step_while_end_2
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $input_val
    ldm A $adjustment
    stack A $DATASTACK_PTR
    ldm A $input_val
    stack A $DATASTACK_PTR
    call @FP.mul
    ustack A $DATASTACK_PTR
    sto A $weight_delta
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $weights_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $old_weight
    stack A $DATASTACK_PTR
    ldm A $weight_delta
    stack A $DATASTACK_PTR
    call @FP.add
    ustack A $DATASTACK_PTR
    sto A $new_weight
    stack A $DATASTACK_PTR
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $weights_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :NN.train_step_while_start_2
:NN.train_step_while_end_2
    ret

@SRAND
    ldm I $p_currentime
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 65536
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $random_seed
    ldi A $SRAND_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $random_seed
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ret
@random_xy
    call @rt_rnd
    ldi A 50
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 999
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $x_int
    call @rt_rnd
    ldi A 50
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 999
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $y_int
    ret
@Function
    ldm A $y_int
    stack A $DATASTACK_PTR
    ldm A $x_int
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    call @rt_gt
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

% $num_inputs 0
% $weights_ptr 0
% $perceptron_ptr 0
% $i 0
% $input_val 0
% $input_ptr 0
% $weight_val 0
% $product 0
% $weighted_sum 0
% $bias 0
% $_error 0
% $error_fp 0
% $learning_rate 0
% $old_bias 0
% $old_weight 0
% $adjustment 0
% $weight_delta 0
% $new_bias 0
% $new_weight 0
% $perceptron 0
% $input_array 0
% $x_fp 0
% $y_fp 0
% $x_int 0
% $y_int 0
% $guess 0
% $true_label 0
% $error 0
% $itter 0
% $error_count 0
% $SRAND_str_0 \N \e \w \space \r \a \n \d \o \m \space \s \e \e \d \: \space \null
% $_main_str_1 \C \r \e \a \t \i \n \g \space \P \e \r \c \e \p \t \r \o \n \. \. \. \null
% $_main_str_2 \space \D \o \n \e \. \Return \null
% $_main_str_3 \C \r \e \a \t \i \n \g \space \i \n \p \u \t \space \a \r \r \a \y \. \. \. \null
% $_main_str_4 \- \- \- \space \P \h \a \s \e \space \0 \: \space \U \n \t \r \a \i \n \e \d \space \M \o \d \e \l \space \- \- \- \Return \null
% $_main_str_5 \- \- \- \space \P \h \a \s \e \space \1 \: \space \T \r \a \i \n \i \n \g \space \- \- \- \Return \null
% $_main_str_6 \- \- \- \space \P \h \a \s \e \space \2 \: \space \T \e \s \t \i \n \g \space \- \- \- \Return \null
% $_main_str_7 \- \- \- \space \T \e \s \t \space \R \e \p \o \r \t \space \- \- \- \Return \null
% $_main_str_8 \space \e \r \r \o \r \s \space \o \u \t \space \o \f \space \null
% $_main_str_9 \space \t \e \s \t \space \c \a \s \e \s \. \Return \null
% $_main_str_10 \- \- \- \space \A \l \l \space \D \o \n \e \space \- \- \- \Return \null
