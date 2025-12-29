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
. $_tdl_up_o_add_w 1
. $_tdl_up_o_bias_g 1
. $_tdl_up_o_add_b 1
. $_tdl_up_h_trans 1
. $_tdl_up_h_grad 1
. $_tdl_up_h_add_w 1
. $_tdl_up_h_bias_g 1
. $_tdl_up_h_add_b 1
. $_nn_h_weights 1
. $_nn_h_bias 1
. $_nn_o_weights 1
. $_nn_o_bias 1
. $bias_val 4
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
. $network_ptr 1
. $input_arr 1
. $target_arr 1
. $learning_rate 1
. $tx 1
. $ty 1
. $hx 1
. $hy 1
. $_dx 1
. $_dy 1
. $abs_dx 1
. $abs_dy 1
. $i 1
. $output_ptr 1
. $val_n 1
. $val_s 1
. $val_e 1
. $val_w 1
. $target_idx 1
. $k 1
. $fp_0_1 4
. $fp_0_01 5
. $steps 1
. $predicted_dir 1
. $max_val 1
. $caught 1
. $SRAND_str_0 18
. $TRAIN_NETWORK_str_1 14
. $TRAIN_NETWORK_str_2 12
. $TRAIN_NETWORK_str_3 2
. $TRAIN_NETWORK_str_4 22
. $TEST_NETWORK_str_5 29
. $TEST_NETWORK_str_6 9
. $TEST_NETWORK_str_7 2
. $TEST_NETWORK_str_8 2
. $TEST_NETWORK_str_9 9
. $TEST_NETWORK_str_10 18
. $TEST_NETWORK_str_11 9
. $TEST_NETWORK_str_12 42
. $TEST_NETWORK_str_13 19
. $VISUALIZE_CHASE_str_14 57
. $_main_str_15 45
. $_main_str_16 40
. $_main_str_17 45
. $_main_str_18 43

# .CODE
    call @HEAP.free
    call @SRAND
    ldi A 10000
    stack A $DATASTACK_PTR
    call @FP.set_scale
    ldi A 10000
    stack A $DATASTACK_PTR
    call @NN.set_scale
    ldi A $_main_str_15
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @NN.new_network
    ustack A $DATASTACK_PTR
    sto A $network_ptr
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $input_arr
    ldi A 4
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $target_arr
    call @VISUALIZE_CHASE
    ldi A $_main_str_16
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $fp_0_01
    stack A $DATASTACK_PTR
    call @FP.from_string
    ustack A $DATASTACK_PTR
    sto A $learning_rate
    ldi A 5000
    stack A $DATASTACK_PTR
    call @TRAIN_NETWORK
    call @VISUALIZE_CHASE
    ldi A 5000
    stack A $DATASTACK_PTR
    call @TRAIN_NETWORK
    call @VISUALIZE_CHASE
    ldi A $_main_str_17
    stack A $DATASTACK_PTR
    call @PRTstring
:_main_while_start_3
    call @KEYchar
    ldi A 27
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_3
    ldi A 1000
    stack A $DATASTACK_PTR
    call @TRAIN_NETWORK
    call @VISUALIZE_CHASE
    ldi A $_main_str_18
    stack A $DATASTACK_PTR
    call @PRTstring
    jmp :_main_while_start_3
:_main_while_end_3
    ldi A 13
    stack A $DATASTACK_PTR
    call @PRTchar
    call @VISUALIZE_CHASE
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


@GPU.tdl
    ustack A $DATASTACK_PTR
    sto A $_gpu_tdl_ptr
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm A $_gpu_tdl_ptr
    stack A $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm A $_gpu_tdl_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm A $_gpu_tdl_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm A $_gpu_tdl_ptr
    sto A $_gpu_temp_ptr
    ustack B $DATASTACK_PTR
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ldm A $_gpu_tdl_ptr
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_gpu_temp_ptr
    ldi A 0
    ld B A
    ldm I $_gpu_temp_ptr
    stx B $_start_memory_
    ret
@GPU.exec
    ustack A $DATASTACK_PTR
    sto A $_gpu_tdl_ptr

        ldm A $_gpu_tdl_ptr
        gpu A
        ldm A $_gpu_tdl_ptr
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldm A $_nn_col_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
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
    ldm A $_nn_row_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
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
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_layer_ptr
    stack A $DATASTACK_PTR
    ldm A $_nn_weights_ptr
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldm A $_nn_predict_layer_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_predict_layer_ptr
    jmp :_NN.new_layer_while_start_1
:_NN.new_layer_while_end_1
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldm A $_nn_row_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
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
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fh_dot
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
    ldm A $_tdl_fh_dot
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fh_add
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
    ldm A $_tdl_fh_add
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fh_relu
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
    ldm A $_tdl_fh_relu
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fo_dot
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
    ldm A $_tdl_fo_dot
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fo_add
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
    ldm A $_tdl_fo_add
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_fo_relu
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
    ldm A $_tdl_fo_relu
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_err
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
    ldm A $_tdl_bp_err
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_d_out
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
    ldm A $_tdl_bp_d_out
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_delta_o
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
    ldm A $_tdl_bp_delta_o
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_trans_w
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
    ldm A $_tdl_bp_trans_w
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_h_err
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
    ldm A $_tdl_bp_h_err
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_d_h
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
    ldm A $_tdl_bp_d_h
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_bp_delta_h
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
    ldm A $_tdl_bp_delta_h
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_trans
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
    ldm A $_tdl_up_o_trans
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_grad
    ldm A $_nn_mat_hidden_act_trans
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_grad_ho
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_grad
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_add_w
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
    ldm A $_tdl_up_o_add_w
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_bias_g
    ldm A $_nn_mat_bias_input
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_error
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_bias_g
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_o_add_b
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
    ldm A $_tdl_up_o_add_b
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_trans
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
    ldm A $_tdl_up_h_trans
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_grad
    ldm A $_nn_mat_input_trans
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_grad_ih
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_grad
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_add_w
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
    ldm A $_tdl_up_h_add_w
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_bias_g
    ldm A $_nn_mat_bias_input
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_delta
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_hidden_error
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_h_bias_g
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldi A 6
    stack A $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_tdl_up_h_add_b
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
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_nn_mat_input_wrapper
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_fill_counter
    jmp :NN.predict_while_start_3
:NN.predict_while_end_3
    ldm A $_tdl_fh_dot
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fh_add
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fh_relu
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fo_dot
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fo_add
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fo_relu
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
    ldm A $_nn_scale
    stack A $DATASTACK_PTR
    ldm A $_nn_train_k
    stack A $DATASTACK_PTR
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $_nn_train_k
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
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_nn_mat_input_wrapper
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $_nn_mat_target
    stack A $DATASTACK_PTR
    call @MATRIX.put
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_fill_counter
    jmp :NN.train_while_start_5
:NN.train_while_end_5
    ldm A $_tdl_fh_dot
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fh_add
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fh_relu
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fo_dot
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fo_add
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_fo_relu
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_bp_err
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_bp_d_out
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_bp_delta_o
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_bp_trans_w
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_bp_h_err
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_bp_d_h
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_bp_delta_h
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_o_grad
    stack A $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_temp_ptr
    ldm A $_nn_train_k
    ld B A
    ldm I $_nn_temp_ptr
    stx B $_start_memory_
    ldm A $_tdl_up_o_bias_g
    stack A $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_temp_ptr
    ldm A $_nn_train_k
    ld B A
    ldm I $_nn_temp_ptr
    stx B $_start_memory_
    ldm A $_tdl_up_h_grad
    stack A $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_temp_ptr
    ldm A $_nn_train_k
    ld B A
    ldm I $_nn_temp_ptr
    stx B $_start_memory_
    ldm A $_tdl_up_h_bias_g
    stack A $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_nn_temp_ptr
    ldm A $_nn_train_k
    ld B A
    ldm I $_nn_temp_ptr
    stx B $_start_memory_
    ldm A $_tdl_up_o_trans
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_o_grad
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_o_add_w
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_o_bias_g
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_o_add_b
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_h_trans
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_h_grad
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_h_add_w
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_h_bias_g
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
    ldm A $_tdl_up_h_add_b
    stack A $DATASTACK_PTR
    call @GPU.exec
    call @rt_drop
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
    ldi A 3
    sto A $current_mode
       ; one time initialization
    ;. $TURTLE_DX 8
    % $TURTLE_DX  1  1  0 -1 -1 -1  0  1
    ;. $TURTLE_DY 8
    % $TURTLE_DY  0  1  1  1  0 -1 -1 -1
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
@GEN_SAMPLE
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.clear
    ldm A $target_arr
    stack A $DATASTACK_PTR
    call @ARRAY.clear
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $tx
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $ty
    call @rt_rnd
    ldi A 100
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    call @rt_dup
    ldi A 40
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_else_0
    call @rt_drop
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $hx
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $hy
    jmp :GEN_SAMPLE_if_end_0
:GEN_SAMPLE_if_else_0
    call @rt_dup
    ldi A 70
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_else_1
    call @rt_drop
    ldm A $tx
    stack A $DATASTACK_PTR
    call @rt_rnd
    ldi A 41
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 20
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_2
    call @rt_drop
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_2
    call @rt_dup
    ldi A 99
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_3
    call @rt_drop
    ldi A 99
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_3
    ustack A $DATASTACK_PTR
    sto A $hx
    ldm A $ty
    stack A $DATASTACK_PTR
    call @rt_rnd
    ldi A 41
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 20
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_4
    call @rt_drop
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_4
    call @rt_dup
    ldi A 99
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_5
    call @rt_drop
    ldi A 99
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_5
    ustack A $DATASTACK_PTR
    sto A $hy
    jmp :GEN_SAMPLE_if_end_1
:GEN_SAMPLE_if_else_1
    call @rt_dup
    ldi A 90
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_else_6
    call @rt_drop
    ldm A $tx
    stack A $DATASTACK_PTR
    call @rt_rnd
    ldi A 13
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 6
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_7
    call @rt_drop
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_7
    call @rt_dup
    ldi A 99
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_8
    call @rt_drop
    ldi A 99
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_8
    ustack A $DATASTACK_PTR
    sto A $hx
    ldm A $ty
    stack A $DATASTACK_PTR
    call @rt_rnd
    ldi A 13
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 6
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_9
    call @rt_drop
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_9
    call @rt_dup
    ldi A 99
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_10
    call @rt_drop
    ldi A 99
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_10
    ustack A $DATASTACK_PTR
    sto A $hy
    jmp :GEN_SAMPLE_if_end_6
:GEN_SAMPLE_if_else_6
    call @rt_drop
    ldm A $tx
    stack A $DATASTACK_PTR
    call @rt_rnd
    ldi A 5
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_11
    call @rt_drop
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_11
    call @rt_dup
    ldi A 99
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_12
    call @rt_drop
    ldi A 99
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_12
    ustack A $DATASTACK_PTR
    sto A $hx
    ldm A $ty
    stack A $DATASTACK_PTR
    call @rt_rnd
    ldi A 5
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_dup
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_13
    call @rt_drop
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_13
    call @rt_dup
    ldi A 99
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_end_14
    call @rt_drop
    ldi A 99
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_14
    ustack A $DATASTACK_PTR
    sto A $hy
:GEN_SAMPLE_if_end_6
:GEN_SAMPLE_if_end_1
:GEN_SAMPLE_if_end_0
    ldm A $tx
    stack A $DATASTACK_PTR
    ldm A $hx
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_dx
    ldm A $ty
    stack A $DATASTACK_PTR
    ldm A $hy
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_dy
    ldm A $_dx
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ldm A $_dy
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    tst A 0
    jmpt :GEN_SAMPLE_if_end_15
    ldm A $hx
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $hx
    ldm A $tx
    stack A $DATASTACK_PTR
    ldm A $hx
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_dx
:GEN_SAMPLE_if_end_15
    ldm A $_dx
    tstg A Z
    jmpt :GEN_SAMPLE_abs_pos_16
    ldi B 0
    sub B A
    ld A B
:GEN_SAMPLE_abs_pos_16
    sto A $abs_dx
    ldm A $_dy
    tstg A Z
    jmpt :GEN_SAMPLE_abs_pos_17
    ldi B 0
    sub B A
    ld A B
:GEN_SAMPLE_abs_pos_17
    sto A $abs_dy
    ldm A $_dx
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_dy
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_dy
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_else_18
    ldi A 10000
    stack A $DATASTACK_PTR
    jmp :GEN_SAMPLE_if_end_18
:GEN_SAMPLE_if_else_18
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_18
    ldm A $target_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_dy
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_else_19
    ldi A 10000
    stack A $DATASTACK_PTR
    jmp :GEN_SAMPLE_if_end_19
:GEN_SAMPLE_if_else_19
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_19
    ldm A $target_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_dx
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_else_20
    ldi A 10000
    stack A $DATASTACK_PTR
    jmp :GEN_SAMPLE_if_end_20
:GEN_SAMPLE_if_else_20
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_20
    ldm A $target_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_dx
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GEN_SAMPLE_if_else_21
    ldi A 10000
    stack A $DATASTACK_PTR
    jmp :GEN_SAMPLE_if_end_21
:GEN_SAMPLE_if_else_21
    ldi A 0
    stack A $DATASTACK_PTR
:GEN_SAMPLE_if_end_21
    ldm A $target_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ret
@TRAIN_NETWORK
    ustack A $DATASTACK_PTR
    sto A $i
    ldi A $TRAIN_NETWORK_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $i
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $TRAIN_NETWORK_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
:TRAIN_NETWORK_while_start_0
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TRAIN_NETWORK_while_end_0
    call @GEN_SAMPLE
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    ldm A $target_arr
    stack A $DATASTACK_PTR
    ldm A $learning_rate
    stack A $DATASTACK_PTR
    call @NN.train
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $i
    stack A $DATASTACK_PTR
    ldi A 100
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TRAIN_NETWORK_if_end_22
    ldi A $TRAIN_NETWORK_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
:TRAIN_NETWORK_if_end_22
    jmp :TRAIN_NETWORK_while_start_0
:TRAIN_NETWORK_while_end_0
    ldi A $TRAIN_NETWORK_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ret
@TEST_NETWORK
    ldi A $TEST_NETWORK_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $tx
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $ty
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $hx
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $hy
    ldi A $TEST_NETWORK_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $tx
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $TEST_NETWORK_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $ty
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $TEST_NETWORK_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $TEST_NETWORK_str_9
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $hx
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $TEST_NETWORK_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $hy
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $TEST_NETWORK_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    sto A $steps
    ldi A 0
    sto A $caught
:TEST_NETWORK_while_start_1
    ldm A $steps
    stack A $DATASTACK_PTR
    ldi A 200
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TEST_NETWORK_while_end_1
    ldm A $tx
    stack A $DATASTACK_PTR
    ldm A $hx
    stack A $DATASTACK_PTR
    call @rt_eq
    ldm A $ty
    stack A $DATASTACK_PTR
    ldm A $hy
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    tst A 0
    jmpt :TEST_NETWORK_if_else_23
    ldi A $TEST_NETWORK_str_10
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $steps
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $TEST_NETWORK_str_11
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1
    sto A $caught
    ldi A 200
    sto A $steps
    jmp :TEST_NETWORK_if_end_23
:TEST_NETWORK_if_else_23
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.clear
    ldm A $tx
    stack A $DATASTACK_PTR
    ldm A $hx
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_dx
    ldm A $ty
    stack A $DATASTACK_PTR
    ldm A $hy
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_dy
    ldm A $_dx
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_dy
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @NN.predict
    ustack A $DATASTACK_PTR
    sto A $output_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val_n
    ldm A $output_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val_s
    ldm A $output_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val_e
    ldm A $output_ptr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val_w
    ldm A $val_n
    stack A $DATASTACK_PTR
    ldm A $val_s
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TEST_NETWORK_if_else_24
    ldm A $val_n
    stack A $DATASTACK_PTR
    ldi A 6000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TEST_NETWORK_if_end_25
    ldm A $hy
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $hy
:TEST_NETWORK_if_end_25
    jmp :TEST_NETWORK_if_end_24
:TEST_NETWORK_if_else_24
    ldm A $val_s
    stack A $DATASTACK_PTR
    ldi A 6000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TEST_NETWORK_if_end_26
    ldm A $hy
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $hy
:TEST_NETWORK_if_end_26
:TEST_NETWORK_if_end_24
    ldm A $val_e
    stack A $DATASTACK_PTR
    ldm A $val_w
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TEST_NETWORK_if_else_27
    ldm A $val_e
    stack A $DATASTACK_PTR
    ldi A 6000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TEST_NETWORK_if_end_28
    ldm A $hx
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $hx
:TEST_NETWORK_if_end_28
    jmp :TEST_NETWORK_if_end_27
:TEST_NETWORK_if_else_27
    ldm A $val_w
    stack A $DATASTACK_PTR
    ldi A 6000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TEST_NETWORK_if_end_29
    ldm A $hx
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $hx
:TEST_NETWORK_if_end_29
:TEST_NETWORK_if_end_27
    ldm A $steps
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $steps
:TEST_NETWORK_if_end_23
    jmp :TEST_NETWORK_while_start_1
:TEST_NETWORK_while_end_1
    ldm A $caught
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TEST_NETWORK_if_end_30
    ldi A $TEST_NETWORK_str_12
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $TEST_NETWORK_str_13
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $hx
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $TEST_NETWORK_str_7
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $hy
    stack A $DATASTACK_PTR
    call @PRTnum
    ldi A $TEST_NETWORK_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
:TEST_NETWORK_if_end_30
    ret
@VISUALIZE_CHASE
    ldi A $VISUALIZE_CHASE_str_14
    stack A $DATASTACK_PTR
    call @PRTstring
    call @TURTLE.start
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.mode
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $tx
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $ty
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $hx
    call @rt_rnd
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $hy
    ldi A 0
    sto A $steps
    ldi A 0
    sto A $caught
    call @TURTLE.flip
:VISUALIZE_CHASE_while_start_2
    ldm A $steps
    stack A $DATASTACK_PTR
    ldi A 200
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VISUALIZE_CHASE_while_end_2
    ldm A $tx
    stack A $DATASTACK_PTR
    ldm A $hx
    stack A $DATASTACK_PTR
    call @rt_eq
    ldm A $ty
    stack A $DATASTACK_PTR
    ldm A $hy
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    tst A 0
    jmpt :VISUALIZE_CHASE_if_else_31
    ldi A 1
    sto A $caught
    ldi A 500
    sto A $steps
    jmp :VISUALIZE_CHASE_if_end_31
:VISUALIZE_CHASE_if_else_31
    ldi A 0
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldm A $tx
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 120
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $ty
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 40
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    ldm A $hx
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 120
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $hy
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 40
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.clear
    ldm A $tx
    stack A $DATASTACK_PTR
    ldm A $hx
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_dx
    ldm A $ty
    stack A $DATASTACK_PTR
    ldm A $hy
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $_dy
    ldm A $_dx
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $_dy
    stack A $DATASTACK_PTR
    call @FP.from_int
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @NN.predict
    ustack A $DATASTACK_PTR
    sto A $output_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val_n
    ldm A $output_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val_s
    ldm A $output_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val_e
    ldm A $output_ptr
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $val_w
    ldm A $val_n
    stack A $DATASTACK_PTR
    ldm A $val_s
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VISUALIZE_CHASE_if_else_32
    ldm A $val_n
    stack A $DATASTACK_PTR
    ldi A 6000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VISUALIZE_CHASE_if_end_33
    ldm A $hy
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $hy
:VISUALIZE_CHASE_if_end_33
    jmp :VISUALIZE_CHASE_if_end_32
:VISUALIZE_CHASE_if_else_32
    ldm A $val_s
    stack A $DATASTACK_PTR
    ldi A 6000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VISUALIZE_CHASE_if_end_34
    ldm A $hy
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $hy
:VISUALIZE_CHASE_if_end_34
:VISUALIZE_CHASE_if_end_32
    ldm A $val_e
    stack A $DATASTACK_PTR
    ldm A $val_w
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VISUALIZE_CHASE_if_else_35
    ldm A $val_e
    stack A $DATASTACK_PTR
    ldi A 6000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VISUALIZE_CHASE_if_end_36
    ldm A $hx
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $hx
:VISUALIZE_CHASE_if_end_36
    jmp :VISUALIZE_CHASE_if_end_35
:VISUALIZE_CHASE_if_else_35
    ldm A $val_w
    stack A $DATASTACK_PTR
    ldi A 6000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VISUALIZE_CHASE_if_end_37
    ldm A $hx
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $hx
:VISUALIZE_CHASE_if_end_37
:VISUALIZE_CHASE_if_end_35
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldm A $tx
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 120
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $ty
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 40
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    ldi A 5
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldm A $hx
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 120
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $hy
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 40
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    call @TURTLE.flip
    ldm A $steps
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $steps
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VISUALIZE_CHASE_if_end_38
    ldi A 32
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :VISUALIZE_CHASE_if_end_39
    ldi A 200
    sto A $steps
:VISUALIZE_CHASE_if_end_39
:VISUALIZE_CHASE_if_end_38
:VISUALIZE_CHASE_if_end_31
    jmp :VISUALIZE_CHASE_while_start_2
:VISUALIZE_CHASE_while_end_2
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
% $_tdl_up_o_add_w 0
% $_tdl_up_o_bias_g 0
% $_tdl_up_o_add_b 0
% $_tdl_up_h_trans 0
% $_tdl_up_h_grad 0
% $_tdl_up_h_add_w 0
% $_tdl_up_h_bias_g 0
% $_tdl_up_h_add_b 0
% $_nn_h_weights 0
% $_nn_h_bias 0
% $_nn_o_weights 0
% $_nn_o_bias 0
% $bias_val \0 \. \1 \null

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
% $network_ptr 0
% $input_arr 0
% $target_arr 0
% $learning_rate 0
% $tx 0
% $ty 0
% $hx 0
% $hy 0
% $_dx 0
% $_dy 0
% $abs_dx 0
% $abs_dy 0
% $i 0
% $output_ptr 0
% $val_n 0
% $val_s 0
% $val_e 0
% $val_w 0
% $target_idx 0
% $k 0
% $fp_0_1 \0 \. \1 \null
% $fp_0_01 \0 \. \0 \1 \null
% $steps 0
% $predicted_dir 0
% $max_val 0
% $caught 0
% $SRAND_str_0 \N \e \w \space \r \a \n \d \o \m \space \s \e \e \d \: \space \null
% $TRAIN_NETWORK_str_1 \T \r \a \i \n \i \n \g \space \f \o \r \space \null
% $TRAIN_NETWORK_str_2 \space \e \p \o \c \h \s \. \. \. \Return \null
% $TRAIN_NETWORK_str_3 \. \null
% $TRAIN_NETWORK_str_4 \space \space \T \r \a \i \n \i \n \g \space \C \o \m \p \l \e \t \e \. \Return \null
% $TEST_NETWORK_str_5 \Return \- \- \- \space \S \i \m \u \l \a \t \i \n \g \space \a \space \c \h \a \s \e \space \- \- \- \Return \null
% $TEST_NETWORK_str_6 \T \a \r \g \e \t \: \space \null
% $TEST_NETWORK_str_7 \, \null
% $TEST_NETWORK_str_8 \Return \null
% $TEST_NETWORK_str_9 \H \u \n \t \e \r \: \space \null
% $TEST_NETWORK_str_10 \C \a \u \g \h \t \space \T \a \r \g \e \t \space \i \n \space \null
% $TEST_NETWORK_str_11 \space \s \t \e \p \s \! \Return \null
% $TEST_NETWORK_str_12 \F \a \i \l \e \d \space \t \o \space \c \a \t \c \h \space \t \a \r \g \e \t \space \w \i \t \h \i \n \space \2 \0 \0 \space \s \t \e \p \s \. \Return \null
% $TEST_NETWORK_str_13 \F \i \n \a \l \space \H \u \n \t \e \r \space \P \o \s \: \space \null
% $VISUALIZE_CHASE_str_14 \V \i \s \u \a \l \i \z \i \n \g \space \C \h \a \s \e \space \o \n \space \T \u \r \t \l \e \space \G \r \a \p \h \i \c \s \, \space \< \s \p \a \c \e \> \space \t \o \space \s \t \o \p \space \Return \Return \null
% $_main_str_15 \C \r \e \a \t \i \n \g \space \2 \- \4 \- \4 \space \N \e \t \w \o \r \k \space \( \R \e \l \a \t \i \v \e \space \I \n \p \u \t \s \) \. \. \. \Return \null
% $_main_str_16 \T \r \a \i \n \i \n \g \space \P \h \a \s \e \space \( \5 \k \space \e \p \o \c \h \s \, \space \L \R \= \0 \. \0 \1 \) \. \. \. \Return \null
% $_main_str_17 \R \u \n \space \a \g \a \i \n \? \space \p \r \e \s \s \space \a \space \k \e \y \, \space \t \o \space \s \t \o \p \space \p \r \e \s \s \space \< \e \s \c \> \Return \null
% $_main_str_18 \R \u \n \space \a \g \a \i \n \? \space \p \r \e \s \s \space \k \e \y \, \space \t \o \space \s \t \o \p \space \p \r \e \s \s \space \< \e \s \c \> \Return \null
