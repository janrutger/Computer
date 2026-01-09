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
. $_gpu_tdl_ptr 1
. $_gpu_temp_ptr 1
. $_nn_scale 1
. $_nn_temp_ptr 1
. $_nn_fill_counter 1
. $_nn_row_counter 1
. $_nn_col_counter 1
. $_nn_train_k 1
. $_nn_net_input_size 1
. $_nn_net_hidden_size 1
. $_nn_net_output_size 1
. $_nn_network_ptr 1
. $_nn_hidden_layer_ptr 1
. $_nn_output_layer_ptr 1
. $_nn_predict_input_ptr 1
. $_nn_predict_layer_ptr 1
. $_nn_predict_output_ptr 1
. $_nn_weights_ptr 1
. $_nn_bias_ptr 1
. $_nn_mat_input_wrapper 1
. $_nn_mat_hidden_activations 1
. $_nn_mat_output_activations 1
. $_nn_mat_target 1
. $_nn_mat_output_error 1
. $_nn_mat_output_deriv 1
. $_nn_mat_output_delta 1
. $_nn_mat_weights_ho_trans 1
. $_nn_mat_hidden_error 1
. $_nn_mat_hidden_deriv 1
. $_nn_mat_hidden_delta 1
. $_nn_mat_hidden_act_trans 1
. $_nn_mat_grad_ho 1
. $_nn_mat_input_trans 1
. $_nn_mat_grad_ih 1
. $_nn_mat_bias_input 1
. $_nn_mat_lr 1
. $_tdl_fh_dot 1
. $_tdl_fh_add 1
. $_tdl_fh_relu 1
. $_tdl_fo_dot 1
. $_tdl_fo_add 1
. $_tdl_fo_relu 1
. $_tdl_bp_err 1
. $_tdl_bp_d_out 1
. $_tdl_bp_delta_o 1
. $_tdl_bp_trans_w 1
. $_tdl_bp_h_err 1
. $_tdl_bp_d_h 1
. $_tdl_bp_delta_h 1
. $_tdl_up_o_trans 1
. $_tdl_up_o_grad 1
. $_tdl_up_o_apply_lr 1
. $_tdl_up_o_add_w 1
. $_tdl_up_o_bias_g 1
. $_tdl_up_o_bias_apply_lr 1
. $_tdl_up_o_add_b 1
. $_tdl_up_h_trans 1
. $_tdl_up_h_grad 1
. $_tdl_up_h_apply_lr 1
. $_tdl_up_h_add_w 1
. $_tdl_up_h_bias_g 1
. $_tdl_up_h_bias_apply_lr 1
. $_tdl_up_h_add_b 1
. $_nn_h_weights 1
. $_nn_h_bias 1
. $_nn_o_weights 1
. $_nn_o_bias 1
. $bias_val 4
. $network_ptr 1
. $output_array_ptr 1
. $current_input_ptr 1
. $current_target_ptr 1
. $learning_rate 1
. $epochs 1
. $i 1
. $rand_idx 1
. $xor_inputs_ptr 1
. $xor_targets_ptr 1
. $fp_0_0 4
. $fp_0_1 4
. $fp_0_5 4
. $fp_1_0 4
. $fp_0_01 5
. $SRAND_str_0 18
. $_main_str_1 42
. $_main_str_2 29
. $_main_str_3 40
. $_main_str_4 25
. $_main_str_5 23
. $_main_str_6 12
. $_main_str_7 2
. $_main_str_8 21
. $_main_str_9 42
. $_main_str_10 9
. $_main_str_11 17
. $_main_str_12 15

# .CODE
    call @HEAP.free
    call @SRAND
    ldi A 10000
    stack A $DATASTACK_PTR
    call @FP.set_scale
    ldi A 10000
    stack A $DATASTACK_PTR
    call @NN.set_scale
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NN.new_network
    ustack A $DATASTACK_PTR
    sto A $network_ptr
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 4
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $xor_inputs_ptr
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $current_input_ptr
    ldi A $fp_0_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $fp_0_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    ldm A $xor_inputs_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $current_input_ptr
    ldi A $fp_0_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $fp_1_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    ldm A $xor_inputs_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $current_input_ptr
    ldi A $fp_1_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $fp_0_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    ldm A $xor_inputs_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $current_input_ptr
    ldi A $fp_1_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $fp_1_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    ldm A $xor_inputs_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 4
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $xor_targets_ptr
    ldi A $fp_0_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $xor_targets_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $fp_1_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $xor_targets_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $fp_1_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $xor_targets_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $fp_0_0
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldm A $xor_targets_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $current_target_ptr
    ldi A 1500
    sto A $epochs
    ldi A $fp_0_1
    stack A $DATASTACK_PTR
    call @FP.from_string
    ustack A $DATASTACK_PTR
    sto A $learning_rate
    ldi A 0
    sto A $i
    ldi A 0
    stack A $DATASTACK_PTR
    call @TIME.start
    ldi A $_main_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $epochs
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $_main_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
:_main_while_start_0
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $epochs
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
    call @rt_rnd
    ldi A 4
    ustack B $DATASTACK_PTR
    dmod B A
    sto A $rand_idx
    ldm B $i
    ldi A 100
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_0
    ldm A $i
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A 32
    stack A $DATASTACK_PTR
    call @PRTchar
    ldi A 0
    stack A $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A $_main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
:_main_if_end_0
    ldm A $current_target_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.clear
    ldm A $xor_inputs_ptr
    stack A $DATASTACK_PTR
    ldm A $rand_idx
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $current_input_ptr
    ldm A $xor_targets_ptr
    stack A $DATASTACK_PTR
    ldm A $rand_idx
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldm A $current_target_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    ldm A $current_target_ptr
    stack A $DATASTACK_PTR
    ldm A $learning_rate
    stack A $DATASTACK_PTR
    call @NN.train
    ldm B $i
    ldi A 1
    add A B
    sto A $i
    jmp :_main_while_start_0
:_main_while_end_0
    ldi A $_main_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    sto A $i
:_main_while_start_1
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_1
    ldi A $_main_str_10
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $i
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $_main_str_11
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $xor_inputs_ptr
    stack A $DATASTACK_PTR
    ldm A $i
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $current_input_ptr
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldm A $current_input_ptr
    stack A $DATASTACK_PTR
    call @NN.predict
    ldi A 0
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldi A 4
    stack A $DATASTACK_PTR
    call @FP.fprint
    ldi A $_main_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm B $i
    ldi A 1
    add A B
    sto A $i
    jmp :_main_while_start_1
:_main_while_end_1
    ldi A $_main_str_12
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


@GPU.tdl
    ustack A $DATASTACK_PTR
    sto A $_gpu_tdl_ptr
    ld B A
    ldi A 6
    add A B
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm B $_gpu_tdl_ptr
    ldi A 5
    add A B
    sto A $_gpu_temp_ptr
    ldi A 0
    ld B A
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm B $_gpu_tdl_ptr
    ldi A 4
    add A B
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm B $_gpu_tdl_ptr
    ldi A 3
    add A B
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm B $_gpu_tdl_ptr
    ldi A 2
    add A B
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm B $_gpu_tdl_ptr
    ldi A 1
    add A B
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm A $_gpu_tdl_ptr
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ret
@GPU.exec
    ustack A $DATASTACK_PTR
    sto A $_gpu_tdl_ptr

        ldm A $_gpu_tdl_ptr
        gpu A
    ldm B $_gpu_tdl_ptr
    ldi A 5
    add A B
    sto A $_gpu_temp_ptr
    ldm I $_gpu_temp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret


@NN.set_scale
    ustack A $DATASTACK_PTR
    sto A $_nn_scale
    ret
@_NN.new_layer
    ustack A $DATASTACK_PTR
    sto A $_nn_col_counter
    ustack A $DATASTACK_PTR
    sto A $_nn_row_counter
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_nn_temp_ptr
    ldm A $_nn_col_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_row_counter
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_weights_ptr
    ldi A 1
    sto A $_nn_fill_counter
:_NN.new_layer_while_start_0
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm B $_nn_col_counter
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_NN.new_layer_while_end_0
    ldi A 1
    sto A $_nn_predict_layer_ptr
:_NN.new_layer_while_start_1
    ldm A $_nn_predict_layer_ptr
    stack A $DATASTACK_PTR
    ldm B $_nn_row_counter
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_NN.new_layer_while_end_1
    call @rt_rnd
    ldi A 200
    ustack B $DATASTACK_PTR
    dmod B A
    ld B A
    ldi A 100
    sub B A
    stack B $DATASTACK_PTR
    call @FP.from_int
    ldi A 1000
    stack A $DATASTACK_PTR
    call @FP.from_int
    call @FP.div
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_layer_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_weights_ptr
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldm B $_nn_predict_layer_ptr
    ldi A 1
    add A B
    sto A $_nn_predict_layer_ptr
    jmp :_NN.new_layer_while_start_1
:_NN.new_layer_while_end_1
    ldm B $_nn_fill_counter
    ldi A 1
    add A B
    sto A $_nn_fill_counter
    jmp :_NN.new_layer_while_start_0
:_NN.new_layer_while_end_0
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_row_counter
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_bias_ptr
    ldi A 1
    sto A $_nn_fill_counter
:_NN.new_layer_while_start_2
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm B $_nn_row_counter
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_NN.new_layer_while_end_2
    ldi A $bias_val
    stack A $DATASTACK_PTR
    call @FP.from_string
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_bias_ptr
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldm B $_nn_fill_counter
    ldi A 1
    add A B
    sto A $_nn_fill_counter
    jmp :_NN.new_layer_while_start_2
:_NN.new_layer_while_end_2
    ldm A $_nn_weights_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_temp_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_bias_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_temp_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_nn_temp_ptr
    stack A $DATASTACK_PTR
    ret
@NN.new_network
    ustack A $DATASTACK_PTR
    sto A $_nn_net_output_size
    ustack A $DATASTACK_PTR
    sto A $_nn_net_hidden_size
    ustack A $DATASTACK_PTR
    sto A $_nn_net_input_size
    ldi A 3
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $_nn_network_ptr
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    ldm A $_nn_net_input_size
    stack A $DATASTACK_PTR
    call @_NN.new_layer
    ustack A $DATASTACK_PTR
    sto A $_nn_hidden_layer_ptr
    ldm A $_nn_net_output_size
    stack A $DATASTACK_PTR
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    call @_NN.new_layer
    ustack A $DATASTACK_PTR
    sto A $_nn_output_layer_ptr
    ldm A $_nn_net_input_size
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
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_input_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_input_wrapper
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_hidden_activations
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_output_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_output_activations
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_output_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_target
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_output_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_output_error
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_output_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_output_deriv
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_output_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_output_delta
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_hidden_error
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_hidden_deriv
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_hidden_delta
    ldm A $_nn_net_output_size
    stack A $DATASTACK_PTR
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_weights_ho_trans
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_hidden_act_trans
    ldm A $_nn_net_input_size
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_input_trans
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    ldm A $_nn_net_output_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_grad_ho
    ldm A $_nn_net_input_size
    stack A $DATASTACK_PTR
    ldm A $_nn_net_hidden_size
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_grad_ih
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_bias_input
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_bias_input
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $_nn_mat_lr
    ldm A $_nn_hidden_layer_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_h_weights
    ldm A $_nn_hidden_layer_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_h_bias
    ldm A $_nn_output_layer_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_o_weights
    ldm A $_nn_output_layer_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_o_bias
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fh_dot
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fh_add
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fh_relu
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fo_dot
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fo_add
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fo_relu
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_err
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_d_out
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_delta_o
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_trans_w
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_h_err
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_d_h
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_delta_h
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_trans
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_grad
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_apply_lr
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_add_w
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_bias_g
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_bias_apply_lr
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_add_b
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_trans
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_grad
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_apply_lr
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_add_w
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_bias_g
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_bias_apply_lr
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_add_b
    ldm A $_nn_mat_input_wrapper
    stack A $DATASTACK_PTR
    ldm A $_nn_h_weights
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_fh_add
    stack A $DATASTACK_PTR
    ldm A $_tdl_fh_dot
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    ldm A $_nn_h_bias
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_tdl_fh_relu
    stack A $DATASTACK_PTR
    ldm A $_tdl_fh_add
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $_tdl_fo_dot
    stack A $DATASTACK_PTR
    ldm A $_tdl_fh_relu
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    ldm A $_nn_o_weights
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_fo_add
    stack A $DATASTACK_PTR
    ldm A $_tdl_fo_dot
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    ldm A $_nn_o_bias
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_tdl_fo_relu
    stack A $DATASTACK_PTR
    ldm A $_tdl_fo_add
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_tdl_fo_relu
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_target
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_error
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_d_out
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_err
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_deriv
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_delta_o
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_d_out
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_output_error
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_deriv
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_trans_w
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_delta_o
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_o_weights
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_weights_ho_trans
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_h_err
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_trans_w
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_output_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_weights_ho_trans
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_error
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_d_h
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_h_err
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_deriv
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_delta_h
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_d_h
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_hidden_error
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_deriv
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_trans
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_delta_h
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_act_trans
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_grad
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_trans
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_hidden_act_trans
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_grad_ho
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_apply_lr
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_grad
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_grad_ho
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_lr
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_grad_ho
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_add_w
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_apply_lr
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_o_weights
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_grad_ho
    stack A $DATASTACK_PTR
    ldm A $_nn_o_weights
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_bias_g
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_add_w
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_bias_input
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_error
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_bias_apply_lr
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_bias_g
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_output_error
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_lr
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_error
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_add_b
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_bias_apply_lr
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_o_bias
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_error
    stack A $DATASTACK_PTR
    ldm A $_nn_o_bias
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_trans
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_add_b
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_input_wrapper
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_input_trans
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_grad
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_trans
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_input_trans
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_grad_ih
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_apply_lr
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_grad
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_grad_ih
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_lr
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_grad_ih
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_add_w
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_apply_lr
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_h_weights
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_grad_ih
    stack A $DATASTACK_PTR
    ldm A $_nn_h_weights
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_bias_g
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_add_w
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_bias_input
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_error
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_bias_apply_lr
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_bias_g
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_hidden_error
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_lr
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_error
    stack A $DATASTACK_PTR
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_add_b
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_bias_apply_lr
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_h_bias
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_error
    stack A $DATASTACK_PTR
    ldm A $_nn_h_bias
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_add_b
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_network_ptr
    stack A $DATASTACK_PTR
    ret
@NN.predict
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_input_ptr
    ustack A $DATASTACK_PTR
    sto A $_nn_network_ptr
    ldi A 0
    sto A $_nn_fill_counter
:NN.predict_while_start_3
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NN.predict_while_end_3
    ldm A $_nn_predict_input_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldi A 1
    stack A $DATASTACK_PTR
    ldm B $_nn_fill_counter
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_nn_mat_input_wrapper
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldm B $_nn_fill_counter
    ldi A 1
    add A B
    sto A $_nn_fill_counter
    jmp :NN.predict_while_start_3
:NN.predict_while_end_3
    ldm A $_tdl_fh_dot
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    ret
@NN.train
    ustack A $DATASTACK_PTR
    sto A $_nn_train_k
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_output_ptr
    ustack A $DATASTACK_PTR
    sto A $_nn_predict_input_ptr
    ustack A $DATASTACK_PTR
    sto A $_nn_network_ptr
    ldm A $_nn_train_k
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_lr
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldi A 0
    sto A $_nn_fill_counter
:NN.train_while_start_4
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_input_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NN.train_while_end_4
    ldm A $_nn_predict_input_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldi A 1
    stack A $DATASTACK_PTR
    ldm B $_nn_fill_counter
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_nn_mat_input_wrapper
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldm B $_nn_fill_counter
    ldi A 1
    add A B
    sto A $_nn_fill_counter
    jmp :NN.train_while_start_4
:NN.train_while_end_4
    ldi A 0
    sto A $_nn_fill_counter
:NN.train_while_start_5
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_output_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.len
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NN.train_while_end_5
    ldm A $_nn_predict_output_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ldi A 1
    stack A $DATASTACK_PTR
    ldm B $_nn_fill_counter
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldm A $_nn_mat_target
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldm B $_nn_fill_counter
    ldi A 1
    add A B
    sto A $_nn_fill_counter
    jmp :NN.train_while_start_5
:NN.train_while_end_5
    ldm A $_tdl_fh_dot
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_bp_err
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ret

@SRAND
    ldm I $p_currentime
    ldx A $_start_memory_
    ld B A
    ldi A 65536
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

% $_gpu_tdl_ptr 0
% $_gpu_temp_ptr 0

% $_nn_scale 10000
% $_nn_temp_ptr 0
% $_nn_fill_counter 0
% $_nn_row_counter 0
% $_nn_col_counter 0
% $_nn_train_k 0
% $_nn_net_input_size 0
% $_nn_net_hidden_size 0
% $_nn_net_output_size 0
% $_nn_network_ptr 0
% $_nn_hidden_layer_ptr 0
% $_nn_output_layer_ptr 0
% $_nn_predict_input_ptr 0
% $_nn_predict_layer_ptr 0
% $_nn_predict_output_ptr 0
% $_nn_weights_ptr 0
% $_nn_bias_ptr 0
% $_nn_mat_input_wrapper 0
% $_nn_mat_hidden_activations 0
% $_nn_mat_output_activations 0
% $_nn_mat_target 0
% $_nn_mat_output_error 0
% $_nn_mat_output_deriv 0
% $_nn_mat_output_delta 0
% $_nn_mat_weights_ho_trans 0
% $_nn_mat_hidden_error 0
% $_nn_mat_hidden_deriv 0
% $_nn_mat_hidden_delta 0
% $_nn_mat_hidden_act_trans 0
% $_nn_mat_grad_ho 0
% $_nn_mat_input_trans 0
% $_nn_mat_grad_ih 0
% $_nn_mat_bias_input 0
% $_nn_mat_lr 0
% $_tdl_fh_dot 0
% $_tdl_fh_add 0
% $_tdl_fh_relu 0
% $_tdl_fo_dot 0
% $_tdl_fo_add 0
% $_tdl_fo_relu 0
% $_tdl_bp_err 0
% $_tdl_bp_d_out 0
% $_tdl_bp_delta_o 0
% $_tdl_bp_trans_w 0
% $_tdl_bp_h_err 0
% $_tdl_bp_d_h 0
% $_tdl_bp_delta_h 0
% $_tdl_up_o_trans 0
% $_tdl_up_o_grad 0
% $_tdl_up_o_apply_lr 0
% $_tdl_up_o_add_w 0
% $_tdl_up_o_bias_g 0
% $_tdl_up_o_bias_apply_lr 0
% $_tdl_up_o_add_b 0
% $_tdl_up_h_trans 0
% $_tdl_up_h_grad 0
% $_tdl_up_h_apply_lr 0
% $_tdl_up_h_add_w 0
% $_tdl_up_h_bias_g 0
% $_tdl_up_h_bias_apply_lr 0
% $_tdl_up_h_add_b 0
% $_nn_h_weights 0
% $_nn_h_bias 0
% $_nn_o_weights 0
% $_nn_o_bias 0
% $bias_val \0 \. \1 \null
% $network_ptr 0
% $output_array_ptr 0
% $current_input_ptr 0
% $current_target_ptr 0
% $learning_rate 0
% $epochs 0
% $i 0
% $rand_idx 0
% $xor_inputs_ptr 0
% $xor_targets_ptr 0
% $fp_0_0 \0 \. \0 \null
% $fp_0_1 \0 \. \1 \null
% $fp_0_5 \0 \. \5 \null
% $fp_1_0 \1 \. \0 \null
% $fp_0_01 \0 \. \0 \1 \null
% $SRAND_str_0 \N \e \w \space \r \a \n \d \o \m \space \s \e \e \d \: \space \null
% $_main_str_1 \- \- \- \space \P \h \a \s \e \space \1 \: \space \C \r \e \a \t \i \n \g \space \a \space \2 \- \4 \- \1 \space \n \e \t \w \o \r \k \. \. \. \Return \null
% $_main_str_2 \N \e \t \w \o \r \k \space \c \r \e \a \t \e \d \space \a \t \space \a \d \d \r \e \s \s \: \space \null
% $_main_str_3 \Return \- \- \- \space \P \h \a \s \e \space \2 \: \space \T \r \a \i \n \i \n \g \space \t \h \e \space \N \e \t \w \o \r \k \space \- \- \- \Return \null
% $_main_str_4 \C \r \e \a \t \i \n \g \space \X \O \R \space \d \a \t \a \s \e \t \. \. \. \Return \null
% $_main_str_5 \S \t \a \r \t \i \n \g \space \t \r \a \i \n \i \n \g \space \f \o \r \space \null
% $_main_str_6 \space \e \p \o \c \h \s \. \. \. \Return \null
% $_main_str_7 \Return \null
% $_main_str_8 \T \r \a \i \n \i \n \g \space \c \o \m \p \l \e \t \e \. \space \Return \null
% $_main_str_9 \Return \- \- \- \space \P \h \a \s \e \space \3 \: \space \T \e \s \t \i \n \g \space \t \r \a \i \n \e \d \space \n \e \t \w \o \r \k \. \. \. \Return \null
% $_main_str_10 \space \space \I \n \p \u \t \space \null
% $_main_str_11 \space \- \> \space \P \r \e \d \i \c \t \i \o \n \: \space \null
% $_main_str_12 \Return \A \L \L \space \D \O \N \E \. \. \. \space \Return \null
