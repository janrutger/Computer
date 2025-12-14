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
. $_nn_temp_ptr 1
. $_nn_num_neurons 1
. $_nn_input_size 1
. $_nn_hidden_size 1
. $_nn_output_size 1
. $_nn_predict_layer_ptr 1
. $_nn_predict_input_ptr 1
. $_nn_predict_output_ptr 1
. $_nn_predict_neuron_idx 1
. $_nn_predict_input_idx 1
. $_nn_predict_weighted_sum 1
. $_nn_fill_counter 1
. $_nn_perceptron_ptr 1
. $_nn_weights_ptr 1
. $_nn_network_ptr 1
. $_nn_hidden_layer_ptr 1
. $_nn_output_layer_ptr 1
. $_nn_input_idx 1
. $network_ptr 1
. $hidden_layer_ptr 1
. $output_layer_ptr 1
. $input_array_ptr 1
. $output_array_ptr 1
. $SRAND_str_0 18
. $_main_str_1 41
. $_main_str_2 29
. $_main_str_3 29
. $_main_str_4 32
. $_main_str_5 15
. $_main_str_6 25
. $_main_str_7 25
. $_main_str_8 30
. $_main_str_9 30
. $_main_str_10 38
. $_main_str_11 36
. $_main_str_12 23
. $_main_str_13 38
. $_main_str_14 22
. $_main_str_15 35
. $_main_str_16 15
. $_main_str_17 50
. $_main_str_18 45
. $_main_str_19 42
. $_main_str_20 34
. $_main_str_21 31
. $_main_str_22 21
. $_main_str_23 60
. $_main_str_24 60
. $_main_str_25 66
. $_main_str_26 58

# .CODE
    call @HEAP.free
    call @SRAND
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NN.new_network
    ustack A $DATASTACK_PTR
    sto A $network_ptr
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $_main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $hidden_layer_ptr
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $output_layer_ptr
    ldi A $_main_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @rt_print_tos
    ldi A $_main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $hidden_layer_ptr
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $_main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $output_layer_ptr
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $_main_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $hidden_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @rt_print_tos
    ldi A $_main_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $output_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @rt_print_tos
    ldi A $_main_str_10
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_11
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $input_array_ptr
    ldi A 1
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldm A $input_array_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 0
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldm A $input_array_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $_main_str_12
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldm A $input_array_ptr
    stack A $DATASTACK_PTR
    call @NN.predict
    ustack A $DATASTACK_PTR
    sto A $output_array_ptr
    ldi A $_main_str_13
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $output_array_ptr
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $_main_str_14
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $output_array_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @rt_print_tos
    ldi A $_main_str_15
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $output_array_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @FP.print
    ldi A $_main_str_16
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_17
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_18
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $hidden_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_perceptron_ptr
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldi A 500
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @_NN.set_weight
    ldi A 500
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @_NN.set_weight
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $hidden_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_perceptron_ptr
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldi A 500
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @_NN.set_weight
    ldi A 500
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @_NN.set_weight
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $output_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_perceptron_ptr
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.put
    ldi A 500
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @_NN.set_weight
    ldi A 500
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @_NN.set_weight
    ldi A $_main_str_19
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldm A $input_array_ptr
    stack A $DATASTACK_PTR
    call @NN.predict
    ustack A $DATASTACK_PTR
    sto A $output_array_ptr
    ldi A $_main_str_20
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $output_array_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @FP.print
    ldi A $_main_str_21
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_22
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_23
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_24
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_25
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_26
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_16
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
    ldi B 0
    sub B A
    ld A B
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
    ldi B 0
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
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
    ldm A $exponent
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
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
    jmpt :FP.from_string_if_end_14
    ldi A 1
    ldi B 0
    sub B A
    ld A B
    sto A $sign
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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


@ARRAY.clear
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_temp_ptr
    ldi A 0
    ld B A
    ldm I $_nn_temp_ptr
    stx B $_start_memory_
    ret
@_NN.new_layer
    ustack A $DATASTACK_PTR
    sto A $_nn_input_size
    ustack A $DATASTACK_PTR
    sto A $_nn_num_neurons
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_nn_temp_ptr
:_NN.new_layer_while_start_0
    ldm A $_nn_num_neurons
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_NN.new_layer_while_end_0
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_nn_perceptron_ptr
    ldm A $_nn_input_size
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_nn_weights_ptr
    ldi A 0
    sto A $_nn_fill_counter
:_NN.new_layer_while_start_1
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_input_size
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_NN.new_layer_while_end_1
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
    ldm A $_nn_weights_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_fill_counter
    jmp :_NN.new_layer_while_start_1
:_NN.new_layer_while_end_1
    ldi A 0
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_weights_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_temp_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_num_neurons
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_nn_num_neurons
    jmp :_NN.new_layer_while_start_0
:_NN.new_layer_while_end_0
    ldm A $_nn_temp_ptr
    stack A $DATASTACK_PTR
    ret
@NN.new_network
    ustack A $DATASTACK_PTR
    sto A $_nn_output_size
    ustack A $DATASTACK_PTR
    sto A $_nn_hidden_size
    ustack A $DATASTACK_PTR
    sto A $_nn_input_size
    ldi A 3
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_nn_network_ptr
    ldm A $_nn_hidden_size
    stack A $DATASTACK_PTR
    ldm A $_nn_input_size
    stack A $DATASTACK_PTR
    call @_NN.new_layer
    ustack A $DATASTACK_PTR
    sto A $_nn_hidden_layer_ptr
    ldm A $_nn_output_size
    stack A $DATASTACK_PTR
    ldm A $_nn_hidden_size
    stack A $DATASTACK_PTR
    call @_NN.new_layer
    ustack A $DATASTACK_PTR
    sto A $_nn_output_layer_ptr
    ldm A $_nn_input_size
    stack A $DATASTACK_PTR
    ldm A $_nn_network_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_hidden_layer_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_network_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_output_layer_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_network_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_network_ptr
    stack A $DATASTACK_PTR
    ret
@_NN.relu
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_NN.relu_if_end_0
    call @rt_drop
    ldi A 0
    stack A $DATASTACK_PTR
    call @FP.from_int
:_NN.relu_if_end_0
    ret
@_NN.relu_derivative
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_NN.relu_derivative_if_else_1
    ldi A 1
    stack A $DATASTACK_PTR
    call @FP.from_int
    jmp :_NN.relu_derivative_if_end_1
:_NN.relu_derivative_if_else_1
    ldi A 0
    stack A $DATASTACK_PTR
    call @FP.from_int
:_NN.relu_derivative_if_end_1
    ret
@_NN.forward_pass_layer
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_input_ptr
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_output_ptr
    ldi A 0
    sto A $_nn_predict_neuron_idx
:_NN.forward_pass_layer_while_start_2
    ldm A $_nn_predict_neuron_idx
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_NN.forward_pass_layer_while_end_2
    ldm A $_nn_predict_layer_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_neuron_idx
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_weighted_sum
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_weights_ptr
    ldi A 0
    sto A $_nn_predict_input_idx
:_NN.forward_pass_layer_while_start_3
    ldm A $_nn_predict_input_idx
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_NN.forward_pass_layer_while_end_3
    ldm A $_nn_weights_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_input_idx
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldm A $_nn_predict_input_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_input_idx
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @FP.mul
    ldm A $_nn_predict_weighted_sum
    stack A $DATASTACK_PTR
    call @FP.add
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_weighted_sum
    ldm A $_nn_predict_input_idx
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_predict_input_idx
    jmp :_NN.forward_pass_layer_while_start_3
:_NN.forward_pass_layer_while_end_3
    ldm A $_nn_predict_weighted_sum
    stack A $DATASTACK_PTR
    call @_NN.relu
    ldm A $_nn_predict_output_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_predict_neuron_idx
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_predict_neuron_idx
    jmp :_NN.forward_pass_layer_while_start_2
:_NN.forward_pass_layer_while_end_2
    ldm A $_nn_predict_output_ptr
    stack A $DATASTACK_PTR
    ret
@NN.predict
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_input_ptr
    ustack A $DATASTACK_PTR
    sto A $_nn_network_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_hidden_layer_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_input_ptr
    stack A $DATASTACK_PTR
    call @_NN.forward_pass_layer
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_output_ptr
    sto A $_nn_predict_input_ptr
    ldm A $_nn_network_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_output_layer_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_input_ptr
    stack A $DATASTACK_PTR
    call @_NN.forward_pass_layer
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_output_ptr
    stack A $DATASTACK_PTR
    ret
@_NN.set_weight
    ustack A $DATASTACK_PTR
    sto A $_nn_perceptron_ptr
    ustack A $DATASTACK_PTR
    sto A $_nn_input_idx
    ustack A $DATASTACK_PTR
    sto A $_nn_temp_ptr
    ldm A $_nn_perceptron_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_weights_ptr
    ldm A $_nn_temp_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_input_idx
    stack A $DATASTACK_PTR
    ldm A $_nn_weights_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.put
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

% $_nn_temp_ptr 0
% $_nn_num_neurons 0
% $_nn_input_size 0
% $_nn_hidden_size 0
% $_nn_output_size 0
% $_nn_predict_layer_ptr 0
% $_nn_predict_input_ptr 0
% $_nn_predict_output_ptr 0
% $_nn_predict_neuron_idx 0
% $_nn_predict_input_idx 0
% $_nn_predict_weighted_sum 0
% $_nn_fill_counter 0
% $_nn_perceptron_ptr 0
% $_nn_weights_ptr 0
% $_nn_network_ptr 0
% $_nn_hidden_layer_ptr 0
% $_nn_output_layer_ptr 0
% $_nn_input_idx 0
% $network_ptr 0
% $hidden_layer_ptr 0
% $output_layer_ptr 0
% $input_array_ptr 0
% $output_array_ptr 0
% $SRAND_str_0 \N \e \w \space \r \a \n \d \o \m \space \s \e \e \d \: \space \null
% $_main_str_1 \- \- \- \space \P \h \a \s \e \space \1 \: \space \T \e \s \t \i \n \g \space \N \N \. \n \e \w \_ \n \e \t \w \o \r \k \space \- \- \- \Return \null
% $_main_str_2 \C \r \e \a \t \i \n \g \space \a \space \2 \- \2 \- \1 \space \n \e \t \w \o \r \k \. \. \. \Return \null
% $_main_str_3 \N \e \t \w \o \r \k \space \c \r \e \a \t \e \d \space \a \t \space \a \d \d \r \e \s \s \: \space \null
% $_main_str_4 \V \e \r \i \f \y \i \n \g \space \n \e \t \w \o \r \k \space \s \t \r \u \c \t \u \r \e \. \. \. \Return \null
% $_main_str_5 \space \space \I \n \p \u \t \space \s \i \z \e \: \space \null
% $_main_str_6 \space \space \H \i \d \d \e \n \space \l \a \y \e \r \space \p \o \i \n \t \e \r \: \space \null
% $_main_str_7 \space \space \O \u \t \p \u \t \space \l \a \y \e \r \space \p \o \i \n \t \e \r \: \space \null
% $_main_str_8 \space \space \H \i \d \d \e \n \space \l \a \y \e \r \space \n \e \u \r \o \n \space \c \o \u \n \t \: \space \null
% $_main_str_9 \space \space \O \u \t \p \u \t \space \l \a \y \e \r \space \n \e \u \r \o \n \space \c \o \u \n \t \: \space \null
% $_main_str_10 \Return \- \- \- \space \P \h \a \s \e \space \2 \: \space \T \e \s \t \i \n \g \space \N \N \. \p \r \e \d \i \c \t \space \- \- \- \Return \null
% $_main_str_11 \C \r \e \a \t \i \n \g \space \i \n \p \u \t \space \a \r \r \a \y \space \[ \1 \. \0 \, \space \0 \. \0 \] \. \. \. \Return \null
% $_main_str_12 \R \u \n \n \i \n \g \space \p \r \e \d \i \c \t \i \o \n \. \. \. \Return \null
% $_main_str_13 \P \r \e \d \i \c \t \i \o \n \space \f \i \n \i \s \h \e \d \. \space \O \u \t \p \u \t \space \p \o \i \n \t \e \r \: \space \null
% $_main_str_14 \O \u \t \p \u \t \space \a \r \r \a \y \space \l \e \n \g \t \h \: \space \null
% $_main_str_15 \P \r \e \d \i \c \t \e \d \space \v \a \l \u \e \space \( \r \a \n \d \o \m \space \w \e \i \g \h \t \s \) \: \space \null
% $_main_str_16 \Return \A \L \L \space \D \O \N \E \. \. \. \space \Return \null
% $_main_str_17 \Return \- \- \- \space \P \h \a \s \e \space \2 \b \: \space \D \e \t \e \r \m \i \n \i \s \t \i \c \space \P \r \e \d \i \c \t \i \o \n \space \T \e \s \t \space \- \- \- \Return \null
% $_main_str_18 \S \e \t \t \i \n \g \space \w \e \i \g \h \t \s \space \t \o \space \0 \. \5 \space \a \n \d \space \b \i \a \s \e \s \space \t \o \space \0 \. \1 \. \. \. \Return \null
% $_main_str_19 \R \u \n \n \i \n \g \space \p \r \e \d \i \c \t \i \o \n \space \w \i \t \h \space \k \n \o \w \n \space \w \e \i \g \h \t \s \. \. \. \Return \null
% $_main_str_20 \P \r \e \d \i \c \t \e \d \space \v \a \l \u \e \space \( \k \n \o \w \n \space \w \e \i \g \h \t \s \) \: \space \null
% $_main_str_21 \Return \E \x \p \e \c \t \e \d \space \o \u \t \p \u \t \space \c \a \l \c \u \l \a \t \i \o \n \: \Return \null
% $_main_str_22 \space \space \I \n \p \u \t \: \space \[ \1 \. \0 \, \space \0 \. \0 \] \Return \null
% $_main_str_23 \space \space \H \0 \_ \o \u \t \space \= \space \r \e \l \u \( \1 \. \0 \* \0 \. \5 \space \+ \space \0 \. \0 \* \0 \. \5 \space \+ \space \0 \. \1 \) \space \= \space \r \e \l \u \( \0 \. \6 \) \space \= \space \0 \. \6 \Return \null
% $_main_str_24 \space \space \H \1 \_ \o \u \t \space \= \space \r \e \l \u \( \1 \. \0 \* \0 \. \5 \space \+ \space \0 \. \0 \* \0 \. \5 \space \+ \space \0 \. \1 \) \space \= \space \r \e \l \u \( \0 \. \6 \) \space \= \space \0 \. \6 \Return \null
% $_main_str_25 \space \space \O \0 \_ \o \u \t \space \= \space \r \e \l \u \( \0 \. \6 \* \0 \. \5 \space \+ \space \0 \. \6 \* \0 \. \5 \space \+ \space \0 \. \1 \) \space \= \space \r \e \l \u \( \0 \. \3 \space \+ \space \0 \. \3 \space \+ \space \0 \. \1 \) \Return \null
% $_main_str_26 \space \space \space \space \space \space \space \space \space \= \space \r \e \l \u \( \0 \. \7 \) \space \= \space \0 \. \7 \Return \space \Return \space \E \x \p \e \c \t \e \d \space \p \r \e \d \i \c \t \i \o \n \: \space \0 \. \7 \0 \0 \Return \null
