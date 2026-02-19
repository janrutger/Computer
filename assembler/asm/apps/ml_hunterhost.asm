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
. $VVM0 1
. $VVM1 1
. $vvm_timeslice 1
. $loop_counter 1
. $network_ptr 1
. $target_x 1
. $target_y 1
. $input_arr 1
. $output_ptr 1
. $dx_fp 1
. $dy_fp 1
. $vx_fp 1
. $vy_fp 1
. $reward_fp 1
. $tx_fp 1
. $ty_fp 1
. $target_arr 1
. $VVM0_host_dq 1
. $VVM1_host_dq 1
. $AGENT_code 1
. $old_x0 1
. $old_y0 1
. $old_x1 1
. $old_y1 1
. $create_neural_network_str_0 18
. $_init_main_str_1 29
. $_init_main_str_2 30
. $_init_main_str_3 17
. $_init_main_str_4 25
. $_init_main_str_5 25
. $_main_str_6 15
. $_main_str_7 15
. $_main_str_8 2

# .CODE
    call @_init_main
    call @create_neural_network
    ustack A $DATASTACK_PTR
    sto A $network_ptr
    call @init_playground
    ldm A $target_x
    stack A $DATASTACK_PTR
    ldm A $target_y
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.start
    ldi A $_main_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $target_x
    stack A $DATASTACK_PTR
    ldm A $target_y
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.start
    ldi A $_main_str_7
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :_main_while_start_0
    stack Z $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    stack Z $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add A B
    tst A 0
    jmpt :_main_while_end_0
    ldm A $vvm_timeslice
    sto A $loop_counter
:_main_while_start_1
    ldm A $loop_counter
    tst A 0
    jmpt :_main_while_end_1
    stack Z $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_10
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.run
:_main_if_end_10
    stack Z $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVMpeek
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_11
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.run
:_main_if_end_11
    ldm B $loop_counter
    ldi A 1
    sub B A
    ld A B
    sto A $loop_counter
    jmp :_main_while_start_1
:_main_while_end_1
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.check_syscalls
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.check_syscalls
    ldi A $_main_str_8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        jmp :_main_while_start_0
:_main_while_end_0
    ret

# .FUNCTIONS

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
:factorial_while_start_0
    ldm A $n
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :factorial_while_end_0
    ldm B $res
    ldm A $n
    mul A B
    sto A $res
    ldm B $n
    ldi A 1
    sub B A
    ld A B
    sto A $n
    jmp :factorial_while_start_0
:factorial_while_end_0
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
:isqrt_while_start_1
    ldm A $_sqrt_L
    stack A $DATASTACK_PTR
    ldm B $_sqrt_R
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :isqrt_while_end_1
    ldm B $_sqrt_L
    ldm A $_sqrt_R
    add B A
    ldi A 2
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
    jmp :isqrt_while_start_1
:isqrt_while_end_1
    ldm A $_sqrt_L
    stack A $DATASTACK_PTR
    ret


@TOS_nnl

        ustack A $DATASTACK_PTR
        ld C A

        ldi I ~SYS_PRINT_NUMBER
        int $INT_VECTORS
        
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

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    jmp :FP.div_if_end_5
:FP.div_if_else_5
    ldm B $abs_numerator
    ldm A $SCALE_FACTOR
    mul B A
    ldm A $abs_denominator
    dmod B A
    ldm A $result_sign
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
    ld B A
    ldm A $SCALE_FACTOR
    mul A B
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
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul B A
    ldm A $sign
    mul B A
    stack B $DATASTACK_PTR
    jmp :_fp_from_string_end
:FP.from_string_if_end_15
    ldm A $str_ptr
    stack A $DATASTACK_PTR
    ldm A $dot_index
    stack A $DATASTACK_PTR
    call @_STRNatoi
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul A B
    sto A $int_part_fp
    ldm B $str_ptr
    ldm A $dot_index
    add B A
    ldi A 1
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
    ldi A 1
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
    ldm A $divisor
    dmod B A
    ldm A $int_part_fp
    add B A
    ldm A $sign
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
    ld B Z
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
    ldm A $SCALE_FACTOR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 1000
    ld B A
    ldm A $SCALE_FACTOR
    mul B A
    stack B $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    ldm A $_nn_hidden_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_h_weights
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_hidden_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_h_bias
    stack Z $DATASTACK_PTR
    ldm A $_nn_output_layer_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $_nn_o_weights
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_nn_output_layer_ptr
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
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_tdl_fh_relu
    stack A $DATASTACK_PTR
    ldm A $_tdl_fh_add
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_nn_mat_hidden_activations
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_tdl_fo_relu
    stack A $DATASTACK_PTR
    ldm A $_tdl_fo_add
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_tdl_fo_relu
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_target
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    ldm A $_nn_mat_output_error
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_d_out
    stack A $DATASTACK_PTR
    ldm A $_tdl_bp_err
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_output_activations
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    ldm A $_nn_mat_weights_ho_trans
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    ldm A $_nn_mat_hidden_act_trans
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_tdl_up_h_trans
    stack A $DATASTACK_PTR
    ldm A $_tdl_up_o_add_b
    stack A $DATASTACK_PTR
    call @GPU.tdl
    ldm A $_nn_mat_input_wrapper
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_nn_mat_input_trans
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
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
    ld A Z
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
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_input_ptr
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
    ld A Z
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
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_input_ptr
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
    ld A Z
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
    ldm A $_nn_fill_counter
    stack A $DATASTACK_PTR
    ldm A $_nn_predict_output_ptr
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
    ldi A 360
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
    ldm A $degrees_to_turn
    sub B A
    ldi A 360
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
    ldi A 45
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
    ldi A 1
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
    ldm A $dx
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
    ldm A $dy
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
    ldm A $dy
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
    ldi A 1
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
    ldi A 1
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

@create_neural_network
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $input_arr
    ldi A 2
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $target_arr
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @NN.new_network
    call @rt_dup
    call @PRTnum
    ldi A $create_neural_network_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ret
@random_xy
    call @rt_rnd
    ldi A 440
    ustack B $DATASTACK_PTR
    mul B A
    ldi A 999
    dmod B A
    stack B $DATASTACK_PTR
    call @rt_rnd
    ldi A 440
    ustack B $DATASTACK_PTR
    mul B A
    ldi A 999
    dmod B A
    stack B $DATASTACK_PTR
    ret
@init_playground
    call @TURTLE.start
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.mode
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 12
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 540
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    call @TURTLE.line
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A 460
    stack A $DATASTACK_PTR
    ldi A 540
    stack A $DATASTACK_PTR
    ldi A 460
    stack A $DATASTACK_PTR
    call @TURTLE.line
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 100
    stack A $DATASTACK_PTR
    ldi A 460
    stack A $DATASTACK_PTR
    call @TURTLE.line
    ldi A 540
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 540
    stack A $DATASTACK_PTR
    ldi A 460
    stack A $DATASTACK_PTR
    call @TURTLE.line
    call @TURTLE.flip
    call @random_xy
    ustack A $DATASTACK_PTR
    sto A $target_y
    ustack A $DATASTACK_PTR
    sto A $target_x
    ldi A 5
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldm B $target_x
    ldi A 100
    add B A
    stack B $DATASTACK_PTR
    ldm B $target_y
    ldi A 20
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    call @TURTLE.flip
    ret
@_HOST.predict
    ldm B $input_arr
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 440
    ld B A
    ldi A 10
    dmod B A
    ldm A $SCALE_FACTOR
    mul B A
    stack B $DATASTACK_PTR
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $dy_fp
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 440
    ld B A
    ldi A 10
    dmod B A
    ldm A $SCALE_FACTOR
    mul B A
    stack B $DATASTACK_PTR
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $dx_fp
    stack A $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $dy_fp
    stack A $DATASTACK_PTR
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
    stack Z $DATASTACK_PTR
    ldm A $output_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $vx_fp
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $output_ptr
    stack A $DATASTACK_PTR
    call @ARRAY.get
    ustack A $DATASTACK_PTR
    sto A $vy_fp
    call @rt_rnd
    ldi A 100
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.predict_if_else_0
    call @rt_rnd
    ldi A 3
    ustack B $DATASTACK_PTR
    dmod B A
    ld B A
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    call @rt_rnd
    ldi A 3
    ustack B $DATASTACK_PTR
    dmod B A
    ld B A
    ldi A 1
    sub B A
    stack B $DATASTACK_PTR
    jmp :_HOST.predict_if_end_0
:_HOST.predict_if_else_0
    ldm A $vx_fp
    stack A $DATASTACK_PTR
    ldi A 3000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.predict_if_else_1
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :_HOST.predict_if_end_1
:_HOST.predict_if_else_1
    ldm A $vx_fp
    stack A $DATASTACK_PTR
    ldi A 3000
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.predict_if_else_2
    ldi A 1
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
    jmp :_HOST.predict_if_end_2
:_HOST.predict_if_else_2
    stack Z $DATASTACK_PTR
:_HOST.predict_if_end_2
:_HOST.predict_if_end_1
    ldm A $vy_fp
    stack A $DATASTACK_PTR
    ldi A 3000
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.predict_if_else_3
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :_HOST.predict_if_end_3
:_HOST.predict_if_else_3
    ldm A $vy_fp
    stack A $DATASTACK_PTR
    ldi A 3000
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.predict_if_else_4
    ldi A 1
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
    jmp :_HOST.predict_if_end_4
:_HOST.predict_if_else_4
    stack Z $DATASTACK_PTR
:_HOST.predict_if_end_4
:_HOST.predict_if_end_3
:_HOST.predict_if_end_0
    ret
@_HOST.train
    ustack A $DATASTACK_PTR
    sto A $reward_fp
    ustack A $DATASTACK_PTR
    sto A $vy_fp
    ustack A $DATASTACK_PTR
    sto A $vx_fp
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 440
    ld B A
    ldi A 10
    dmod B A
    ldm A $SCALE_FACTOR
    mul B A
    stack B $DATASTACK_PTR
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $dy_fp
    ldm A $SCALE_FACTOR
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 440
    ld B A
    ldi A 10
    dmod B A
    ldm A $SCALE_FACTOR
    mul B A
    stack B $DATASTACK_PTR
    call @FP.div
    ustack A $DATASTACK_PTR
    sto A $dx_fp
    ldm B $input_arr
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $dx_fp
    stack A $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $dy_fp
    stack A $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm B $vx_fp
    ldm A $reward_fp
    mul B A
    ldm A $SCALE_FACTOR
    mul A B
    sto A $tx_fp
    ldm B $vy_fp
    ldm A $reward_fp
    mul B A
    ldm A $SCALE_FACTOR
    mul A B
    sto A $ty_fp
    ldm A $vx_fp
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.train_if_end_5
    ldm A $dx_fp
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.train_if_else_6
    ldi A 10000
    stack A $DATASTACK_PTR
    jmp :_HOST.train_if_end_6
:_HOST.train_if_else_6
    ldi A 10000
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
:_HOST.train_if_end_6
    ustack A $DATASTACK_PTR
    sto A $tx_fp
:_HOST.train_if_end_5
    ldm A $vy_fp
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.train_if_end_7
    ldm A $dy_fp
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.train_if_else_8
    ldi A 10000
    stack A $DATASTACK_PTR
    jmp :_HOST.train_if_end_8
:_HOST.train_if_else_8
    ldi A 10000
    ldi B 0
    sub B A
    stack B $DATASTACK_PTR
:_HOST.train_if_end_8
    ustack A $DATASTACK_PTR
    sto A $ty_fp
:_HOST.train_if_end_7
    ldm B $target_arr
    ldi A 1
    add A B
    sto A $_ARR_TEMP_PTR
    ld B Z
    ldm I $_ARR_TEMP_PTR
    stx B $_start_memory_
    ldm A $tx_fp
    stack A $DATASTACK_PTR
    ldm A $target_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $ty_fp
    stack A $DATASTACK_PTR
    ldm A $target_arr
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldm A $network_ptr
    stack A $DATASTACK_PTR
    ldm A $input_arr
    stack A $DATASTACK_PTR
    ldm A $target_arr
    stack A $DATASTACK_PTR
    ldi A 1000
    stack A $DATASTACK_PTR
    call @NN.train
    ret
@_HOST.plot
    ustack A $DATASTACK_PTR
    sto A $dy_fp
    ustack A $DATASTACK_PTR
    sto A $dx_fp
    ustack A $DATASTACK_PTR
    sto A $vx_fp
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_HOST.plot_if_else_9
    ldi A 11
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldm B $old_x0
    ldi A 100
    add B A
    stack B $DATASTACK_PTR
    ldm B $old_y0
    ldi A 20
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    ldm A $dx_fp
    sto A $old_x0
    ldm A $dy_fp
    sto A $old_y0
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldm B $old_x0
    ldi A 100
    add B A
    stack B $DATASTACK_PTR
    ldm B $old_y0
    ldi A 20
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    jmp :_HOST.plot_if_end_9
:_HOST.plot_if_else_9
    ldi A 11
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldm B $old_x1
    ldi A 100
    add B A
    stack B $DATASTACK_PTR
    ldm B $old_y1
    ldi A 20
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.circle
    ldm A $dx_fp
    sto A $old_x1
    ldm A $dy_fp
    sto A $old_y1
    ldi A 6
    stack A $DATASTACK_PTR
    call @TURTLE.color
    ldm B $old_x1
    ldi A 100
    add B A
    stack B $DATASTACK_PTR
    ldm B $old_y1
    ldi A 20
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @TURTLE.circle
:_HOST.plot_if_end_9
    call @TURTLE.flip
    ret
@_init_main
    ldm A $HEAP_START
    sto A $HEAP_FREE
    ldi A 50
    stack A $DATASTACK_PTR
    call @DEQUE.init_pool
    ldi A $_init_main_str_1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 10000
    sto A $SCALE_FACTOR
    ldi A 10000
    stack A $DATASTACK_PTR
    call @NN.set_scale
    call @rt_rnd
    call @rt_drop
    call @rt_rnd
    call @rt_drop
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM0_host_dq
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $VVM1_host_dq
    call @DEQUE.new
    ustack A $DATASTACK_PTR
    sto A $AGENT_code
    call @VVM.init
    ldi A $_init_main_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A @_HOST.predict
    stack A $DATASTACK_PTR
    ldi A 100
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @_HOST.train
    stack A $DATASTACK_PTR
    ldi A 101
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldi A @_HOST.plot
    stack A $DATASTACK_PTR
    ldi A 102
    stack A $DATASTACK_PTR
    call @VVM.bind
    ldm A $AGENT_code
    stack A $DATASTACK_PTR
    ldi A $_init_main_str_3
    stack A $DATASTACK_PTR
    call @VVM.loadcode
    ldi A $AGENT_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $VVM0_host_dq
    stack A $DATASTACK_PTR
    ldi A $VVM0
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $_init_main_str_4
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $AGENT_code
    stack A $DATASTACK_PTR
    ldi A $_init_main_str_3
    stack A $DATASTACK_PTR
    call @VVM.loadcode
    ldi A $AGENT_code
    stack A $DATASTACK_PTR
    ldi A 1024
    stack A $DATASTACK_PTR
    ldi A $VVM1_host_dq
    stack A $DATASTACK_PTR
    ldi A $VVM1
    stack A $DATASTACK_PTR
    call @VVM.create
    ldi A $_init_main_str_5
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
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
% $VVM0 30720
% $VVM1 31744
% $vvm_timeslice 50
% $loop_counter 0
% $network_ptr 0
% $target_x 0
% $target_y 0
% $input_arr 0
% $output_ptr 0
% $dx_fp 0
% $dy_fp 0
% $vx_fp 0
% $vy_fp 0
% $reward_fp 0
% $tx_fp 0
% $ty_fp 0
% $target_arr 0
% $VVM0_host_dq 0
% $VVM1_host_dq 0
% $AGENT_code 0
% $old_x0 0
% $old_y0 0
% $old_x1 0
% $old_y1 0
% $create_neural_network_str_0 \space \N \e \t \w \o \r \k \space \a \d \d \r \e \s \s \Return \null
% $_init_main_str_1 \P \o \o \l \space \i \n \i \t \i \a \l \i \z \e \d \space \( \s \i \z \e \space \5 \0 \) \. \Return \null
% $_init_main_str_2 \V \V \M \space \E \n \v \i \r \o \n \m \e \n \t \space \I \n \i \t \i \a \l \i \z \e \d \: \Return \null
% $_init_main_str_3 \s \b \c \_ \h \u \n \t \e \r \_ \a \g \e \n \t \null
% $_init_main_str_4 \V \V \M \0 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \Return \null
% $_init_main_str_5 \V \V \M \1 \space \i \n \s \t \a \n \c \e \space \c \r \e \a \t \e \d \space \Return \Return \null
% $_main_str_6 \V \V \M \0 \space \s \t \a \r \t \e \d \space \Return \null
% $_main_str_7 \V \V \M \1 \space \s \t \a \r \t \e \d \space \Return \null
% $_main_str_8 \. \null
