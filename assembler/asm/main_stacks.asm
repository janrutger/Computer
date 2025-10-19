# .HEADER
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
. $i 1
. $center_x 1
. $center_y 1
. $color 1
. $y 1
. $x 1

# .CODE
    call @TURTLE_start
    ldi A 3
    call @push_A
    call @TURTLE_color
    ldi A 3
    call @push_A
    ldi A 2
    call @push_A
    ldi A 14
    call @push_A
    call @rt_udc_control
    call @star
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 10
    call @push_A
    call @rt_udc_control
    call @circle
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 10
    call @push_A
    call @rt_udc_control
    call @lines
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 10
    call @push_A
    call @rt_udc_control
    call @draw_fan_pattern
    ret

# .FUNCTIONS

@_drawTurtle
    ldm A $current_mode
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :_drawTurtle_if_else_0
    ldm A $current_color
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    jmp :_drawTurtle_if_end_0
:_drawTurtle_if_else_0
    ldm A $current_char
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
:_drawTurtle_if_end_0
    ret
@TURTLE_mode
    call @rt_dup
    call @pop_A
    sto A $current_mode
    ldi A 2
    call @push_A
    ldi A 14
    call @push_A
    call @rt_udc_control
    ldm A $current_mode
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TURTLE_mode_if_end_1
    ldi A 0
    call @push_A
    call @pop_A
    sto A $current_flip
:TURTLE_mode_if_end_1
    ldm A $current_mode
    call @push_A
    ldi A 1
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TURTLE_mode_if_end_2
    ldi A 0
    call @push_A
    call @pop_A
    sto A $current_flip
:TURTLE_mode_if_end_2
    ldm A $current_mode
    call @push_A
    ldi A 2
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TURTLE_mode_if_end_3
    ldi A 0
    call @push_A
    call @pop_A
    sto A $current_mode
    ldi A 1
    call @push_A
    call @pop_A
    sto A $current_flip
:TURTLE_mode_if_end_3
    ldm A $current_mode
    call @push_A
    ldi A 3
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TURTLE_mode_if_end_4
    ldi A 1
    call @push_A
    call @pop_A
    sto A $current_mode
    ldi A 1
    call @push_A
    call @pop_A
    sto A $current_flip
:TURTLE_mode_if_end_4
    ldm A $current_mode
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TURTLE_mode_if_end_5
    ldi A 480
    call @push_A
    call @pop_A
    sto A $current_height
    ldi A 640
    call @push_A
    call @pop_A
    sto A $current_width
:TURTLE_mode_if_end_5
    ldm A $current_mode
    call @push_A
    ldi A 1
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TURTLE_mode_if_end_6
    ldi A 60
    call @push_A
    call @pop_A
    sto A $current_height
    ldi A 80
    call @push_A
    call @pop_A
    sto A $current_width
:TURTLE_mode_if_end_6
    ret
@TURTLE_flip
    ldm A $current_flip
    call @push_A
    call @pop_A
    tst A 0
    jmpt :TURTLE_flip_if_end_7
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
:TURTLE_flip_if_end_7
    ret
@TURTLE_right
    call @pop_A
    sto A $degrees_to_turn
    ldm A $TURTLE_HEADING_DEG
    call @push_A
    ldm A $degrees_to_turn
    call @push_A
    call @rt_add
    ldi A 360
    call @push_A
    call @rt_mod
    call @pop_A
    sto A $TURTLE_HEADING_DEG
    ret
@TURTLE_left
    call @pop_A
    sto A $degrees_to_turn
    ldi A 360
    call @push_A
    ldm A $TURTLE_HEADING_DEG
    call @push_A
    call @rt_add
    ldm A $degrees_to_turn
    call @push_A
    call @rt_sub
    ldi A 360
    call @push_A
    call @rt_mod
    call @pop_A
    sto A $TURTLE_HEADING_DEG
    ret
@TURTLE_color
    call @rt_dup
    call @pop_A
    sto A $current_color
    ldi A 2
    call @push_A
    ldi A 13
    call @push_A
    call @rt_udc_control
    ret
@TURTLE_goto
    ldm A $current_height
    call @push_A
    call @rt_mod
    call @rt_dup
    call @pop_A
    sto A $Yax
    ldi A 2
    call @push_A
    ldi A 16
    call @push_A
    call @rt_udc_control
    ldm A $current_width
    call @push_A
    call @rt_mod
    call @rt_dup
    call @pop_A
    sto A $Xax
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    call @_drawTurtle
    ret
@TURTLE_forward
    call @pop_A
    sto A $distance
    ldm A $distance
    call @push_A
    ldi A 0
    call @push_A
    call @rt_lt
    call @pop_A
    tst A 0
    jmpt :TURTLE_forward_if_end_8
    jmp :move_end
:TURTLE_forward_if_end_8
    ldm A $TURTLE_HEADING_DEG
    call @push_A
    ldi A 22
    call @push_A
    call @rt_add
    ldi A 45
    call @push_A
    call @rt_div
    call @pop_A
    sto A $TURTLE_HEADING
    ldi A $TURTLE_DX
    call @push_A
    ldm A $TURTLE_HEADING
    call @push_A
    call @rt_add
    call @pop_A
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    call @push_A
    call @pop_A
    sto A $dx
    ldi A $TURTLE_DY
    call @push_A
    ldm A $TURTLE_HEADING
    call @push_A
    call @rt_add
    call @pop_A
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    call @push_A
    call @pop_A
    sto A $dy
:move_loop
    ldm A $distance
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TURTLE_forward_if_end_9
    jmp :move_end
:TURTLE_forward_if_end_9
    ldm A $Xax
    call @push_A
    ldm A $dx
    call @push_A
    call @rt_add
    call @pop_A
    sto A $Xax
    ldm A $Yax
    call @push_A
    ldm A $dy
    call @push_A
    call @rt_add
    call @pop_A
    sto A $Yax
    ldm A $Xax
    call @push_A
    ldm A $Yax
    call @push_A
    call @TURTLE_goto
    ldm A $distance
    call @push_A
    ldi A 1
    call @push_A
    call @rt_sub
    call @pop_A
    sto A $distance
    jmp :move_loop
:move_end
    ret
@_welcome_at_turtle
    ldi A 32
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 1
    call @push_A
    ldi A 2
    call @push_A
    ldi A 16
    call @push_A
    call @rt_udc_control
    ldi A 3
    call @push_A
    ldi A 2
    call @push_A
    ldi A 14
    call @push_A
    call @rt_udc_control
    ldi A 87
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 33
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 101
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 34
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 108
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 35
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 107
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 36
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 111
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 37
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 109
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 38
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 32
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 39
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 116
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 40
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 111
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 41
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 32
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 42
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 84
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 43
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 85
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 44
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 82
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 45
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 84
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 46
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 76
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 47
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 69
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 48
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 42
    call @push_A
    ldi A 2
    call @push_A
    ldi A 17
    call @push_A
    call @rt_udc_control
    ldi A 49
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 1
    call @push_A
    ldi A 2
    call @push_A
    ldi A 14
    call @push_A
    call @rt_udc_control
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 15
    call @push_A
    call @rt_udc_control
    ldi A 1
    call @push_A
    ldi A 2
    call @push_A
    ldi A 16
    call @push_A
    call @rt_udc_control
    ret
@TURTLE_start

    . $TURTLE_DX 8
    % $TURTLE_DX  1  1  0 -1 -1 -1  0  1
    . $TURTLE_DY 8
    % $TURTLE_DY  0  1  1  1  0 -1 -1 -1
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 1
    call @push_A
    call @rt_udc_control
    ldm A $current_mode
    call @push_A
    ldi A 2
    call @push_A
    ldi A 14
    call @push_A
    call @rt_udc_control
    ldm A $current_color
    call @push_A
    ldi A 2
    call @push_A
    ldi A 13
    call @push_A
    call @rt_udc_control
    call @_welcome_at_turtle
    ret
@TURTLE_line
    call @pop_A
    sto A $y2
    call @pop_A
    sto A $x2
    call @pop_A
    sto A $y1
    call @pop_A
    sto A $x1
    ldm A $x2
    call @push_A
    ldm A $x1
    call @push_A
    call @rt_sub
    call @pop_A
    sto A $dx
    ldm A $dx
    call @push_A
    ldi A 0
    call @push_A
    call @rt_lt
    call @pop_A
    tst A 0
    jmpt :TURTLE_line_if_end_10
    ldi A 0
    call @push_A
    ldi A 1
    call @push_A
    call @rt_sub
    ldm A $dx
    call @push_A
    call @rt_mul
    call @pop_A
    sto A $dx
:TURTLE_line_if_end_10
    ldm A $y2
    call @push_A
    ldm A $y1
    call @push_A
    call @rt_sub
    call @pop_A
    sto A $dy
    ldm A $dy
    call @push_A
    ldi A 0
    call @push_A
    call @rt_lt
    call @pop_A
    tst A 0
    jmpt :TURTLE_line_if_end_11
    ldi A 0
    call @push_A
    ldi A 1
    call @push_A
    call @rt_sub
    ldm A $dy
    call @push_A
    call @rt_mul
    call @pop_A
    sto A $dy
:TURTLE_line_if_end_11
    ldi A 0
    call @push_A
    ldi A 1
    call @push_A
    call @rt_sub
    call @pop_A
    sto A $sx
    ldm A $x1
    call @push_A
    ldm A $x2
    call @push_A
    call @rt_lt
    call @pop_A
    tst A 0
    jmpt :TURTLE_line_if_end_12
    ldi A 1
    call @push_A
    call @pop_A
    sto A $sx
:TURTLE_line_if_end_12
    ldi A 0
    call @push_A
    ldi A 1
    call @push_A
    call @rt_sub
    call @pop_A
    sto A $sy
    ldm A $y1
    call @push_A
    ldm A $y2
    call @push_A
    call @rt_lt
    call @pop_A
    tst A 0
    jmpt :TURTLE_line_if_end_13
    ldi A 1
    call @push_A
    call @pop_A
    sto A $sy
:TURTLE_line_if_end_13
    ldi A 0
    call @push_A
    ldi A 1
    call @push_A
    call @rt_sub
    ldm A $dy
    call @push_A
    call @rt_mul
    call @pop_A
    sto A $dy
    ldm A $dx
    call @push_A
    ldm A $dy
    call @push_A
    call @rt_add
    call @pop_A
    sto A $err
:line_loop
    ldm A $x1
    call @push_A
    ldm A $y1
    call @push_A
    call @TURTLE_goto
    ldm A $x1
    call @push_A
    ldm A $x2
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TURTLE_line_if_end_14
    ldm A $y1
    call @push_A
    ldm A $y2
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TURTLE_line_if_end_15
    jmp :line_end
:TURTLE_line_if_end_15
:TURTLE_line_if_end_14
    ldm A $err
    call @push_A
    ldi A 2
    call @push_A
    call @rt_mul
    call @pop_A
    sto A $e2
    ldm A $e2
    call @push_A
    ldm A $dy
    call @push_A
    call @rt_lt
    call @pop_A
    tst A 0
    jmpt :TURTLE_line_if_end_16
    jmp :skip_x_move
:TURTLE_line_if_end_16
    ldm A $err
    call @push_A
    ldm A $dy
    call @push_A
    call @rt_add
    call @pop_A
    sto A $err
    ldm A $x1
    call @push_A
    ldm A $sx
    call @push_A
    call @rt_add
    call @pop_A
    sto A $x1
:skip_x_move
    ldm A $e2
    call @push_A
    ldm A $dx
    call @push_A
    call @rt_gt
    call @pop_A
    tst A 0
    jmpt :TURTLE_line_if_end_17
    jmp :skip_y_move
:TURTLE_line_if_end_17
    ldm A $err
    call @push_A
    ldm A $dx
    call @push_A
    call @rt_add
    call @pop_A
    sto A $err
    ldm A $y1
    call @push_A
    ldm A $sy
    call @push_A
    call @rt_add
    call @pop_A
    sto A $y1
:skip_y_move
    jmp :line_loop
:line_end
    ldm A $x2
    call @push_A
    call @pop_A
    sto A $Xax
    ldm A $y2
    call @push_A
    call @pop_A
    sto A $Yax
    ret
@_plot_circle_points
    call @pop_A
    sto A $circ_y
    call @pop_A
    sto A $circ_x
    ldm A $circ_xc
    call @push_A
    ldm A $circ_x
    call @push_A
    call @rt_add
    ldm A $circ_yc
    call @push_A
    ldm A $circ_y
    call @push_A
    call @rt_add
    call @TURTLE_goto
    ldm A $circ_xc
    call @push_A
    ldm A $circ_x
    call @push_A
    call @rt_sub
    ldm A $circ_yc
    call @push_A
    ldm A $circ_y
    call @push_A
    call @rt_add
    call @TURTLE_goto
    ldm A $circ_xc
    call @push_A
    ldm A $circ_x
    call @push_A
    call @rt_add
    ldm A $circ_yc
    call @push_A
    ldm A $circ_y
    call @push_A
    call @rt_sub
    call @TURTLE_goto
    ldm A $circ_xc
    call @push_A
    ldm A $circ_x
    call @push_A
    call @rt_sub
    ldm A $circ_yc
    call @push_A
    ldm A $circ_y
    call @push_A
    call @rt_sub
    call @TURTLE_goto
    ldm A $circ_xc
    call @push_A
    ldm A $circ_y
    call @push_A
    call @rt_add
    ldm A $circ_yc
    call @push_A
    ldm A $circ_x
    call @push_A
    call @rt_add
    call @TURTLE_goto
    ldm A $circ_xc
    call @push_A
    ldm A $circ_y
    call @push_A
    call @rt_sub
    ldm A $circ_yc
    call @push_A
    ldm A $circ_x
    call @push_A
    call @rt_add
    call @TURTLE_goto
    ldm A $circ_xc
    call @push_A
    ldm A $circ_y
    call @push_A
    call @rt_add
    ldm A $circ_yc
    call @push_A
    ldm A $circ_x
    call @push_A
    call @rt_sub
    call @TURTLE_goto
    ldm A $circ_xc
    call @push_A
    ldm A $circ_y
    call @push_A
    call @rt_sub
    ldm A $circ_yc
    call @push_A
    ldm A $circ_x
    call @push_A
    call @rt_sub
    call @TURTLE_goto
    ret
@TURTLE_circle
    call @pop_A
    sto A $circ_p
    call @pop_A
    sto A $circ_yc
    call @pop_A
    sto A $circ_xc
    ldm A $circ_p
    call @push_A
    call @pop_A
    sto A $circ_x
    ldi A 0
    call @push_A
    call @pop_A
    sto A $circ_y
    ldi A 1
    call @push_A
    ldm A $circ_p
    call @push_A
    call @rt_sub
    call @pop_A
    sto A $circ_p
:circle_loop
    ldm A $circ_x
    call @push_A
    ldm A $circ_y
    call @push_A
    call @_plot_circle_points
    ldm A $circ_y
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $circ_y
    ldi A 0
    call @push_A
    ldm A $circ_p
    call @push_A
    call @rt_gt
    call @pop_A
    tst A 0
    jmpt :TURTLE_circle_if_else_18
    ldm A $circ_p
    call @push_A
    ldm A $circ_y
    call @push_A
    ldi A 2
    call @push_A
    call @rt_mul
    call @rt_add
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $circ_p
    jmp :TURTLE_circle_if_end_18
:TURTLE_circle_if_else_18
    ldm A $circ_x
    call @push_A
    ldi A 1
    call @push_A
    call @rt_sub
    call @pop_A
    sto A $circ_x
    ldm A $circ_p
    call @push_A
    ldm A $circ_y
    call @push_A
    ldi A 2
    call @push_A
    call @rt_mul
    call @rt_add
    ldm A $circ_x
    call @push_A
    ldi A 2
    call @push_A
    call @rt_mul
    call @rt_sub
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $circ_p
:TURTLE_circle_if_end_18
    ldm A $circ_x
    call @push_A
    ldm A $circ_y
    call @push_A
    call @rt_gt
    call @pop_A
    tst A 0
    jmpt :TURTLE_circle_if_end_19
    jmp :circle_loop
:TURTLE_circle_if_end_19
    ldm A $circ_x
    call @push_A
    ldm A $circ_y
    call @push_A
    call @_plot_circle_points
    ret

@circle
    ldi A 40
    call @push_A
    ldi A 30
    call @push_A
    ldi A 25
    call @push_A
    call @TURTLE_circle
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 2
    call @push_A
    call @TURTLE_color
    ldi A 40
    call @push_A
    ldi A 30
    call @push_A
    ldi A 20
    call @push_A
    call @TURTLE_circle
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 10
    call @push_A
    call @TURTLE_color
    ldi A 40
    call @push_A
    ldi A 30
    call @push_A
    ldi A 15
    call @push_A
    call @TURTLE_circle
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 5
    call @push_A
    call @TURTLE_color
    ldi A 40
    call @push_A
    ldi A 30
    call @push_A
    ldi A 10
    call @push_A
    call @TURTLE_circle
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 4
    call @push_A
    call @TURTLE_color
    ldi A 40
    call @push_A
    ldi A 30
    call @push_A
    ldi A 5
    call @push_A
    call @TURTLE_circle
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 6
    call @push_A
    call @TURTLE_color
    ldi A 40
    call @push_A
    ldi A 30
    call @push_A
    ldi A 2
    call @push_A
    call @TURTLE_circle
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ret
@lines
    ldi A 0
    call @push_A
    call @TURTLE_color
    ldi A 20
    call @push_A
    ldi A 30
    call @push_A
    ldi A 60
    call @push_A
    ldi A 30
    call @push_A
    call @TURTLE_line
    ldi A 1
    call @push_A
    call @pop_A
    sto A $i
:line_loop1
    ldm A $i
    call @push_A
    ldi A 16
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :lines_if_end_0
    jmp :end_loop1
:lines_if_end_0
    ldm A $i
    call @push_A
    call @TURTLE_color
    ldi A 20
    call @push_A
    ldi A 30
    call @push_A
    ldm A $i
    call @push_A
    call @rt_add
    ldi A 59
    call @push_A
    ldi A 30
    call @push_A
    ldm A $i
    call @push_A
    call @rt_add
    call @TURTLE_line
    ldi A 20
    call @push_A
    ldi A 30
    call @push_A
    ldm A $i
    call @push_A
    call @rt_sub
    ldi A 59
    call @push_A
    ldi A 30
    call @push_A
    ldm A $i
    call @push_A
    call @rt_sub
    call @TURTLE_line
    ldm A $i
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $i
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    jmp :line_loop1
:end_loop1
    ret
@star
    ldi A 2
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 70
    call @push_A
    ldi A 30
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 8
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 66
    call @push_A
    ldi A 45
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 7
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 55
    call @push_A
    ldi A 56
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 13
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 40
    call @push_A
    ldi A 58
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 5
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 25
    call @push_A
    ldi A 56
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 3
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 14
    call @push_A
    ldi A 45
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 14
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 10
    call @push_A
    ldi A 30
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 6
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 14
    call @push_A
    ldi A 15
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 4
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 25
    call @push_A
    ldi A 4
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 10
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 40
    call @push_A
    ldi A 2
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 9
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 55
    call @push_A
    ldi A 4
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldi A 1
    call @push_A
    call @TURTLE_color
    ldm A $center_x
    call @push_A
    ldm A $center_y
    call @push_A
    ldi A 66
    call @push_A
    ldi A 15
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ret
@draw_fan_pattern
:alternate_loop
    ldm A $x
    call @push_A
    ldi A 60
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :draw_fan_pattern_if_end_1
    jmp :end_loop
:draw_fan_pattern_if_end_1
    ldm A $color
    call @push_A
    call @TURTLE_color
    ldi A 20
    call @push_A
    ldi A 10
    call @push_A
    ldm A $x
    call @push_A
    ldi A 49
    call @push_A
    call @TURTLE_line
    ldi A 20
    call @push_A
    ldi A 10
    call @push_A
    ldi A 59
    call @push_A
    ldm A $y
    call @push_A
    call @TURTLE_line
    ldi A 0
    call @push_A
    ldi A 2
    call @push_A
    ldi A 18
    call @push_A
    call @rt_udc_control
    ldm A $x
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $x
    ldm A $y
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $y
    ldm A $color
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    ldi A 15
    call @push_A
    call @rt_mod
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $color
    jmp :alternate_loop
:end_loop
    ret

# .DATA

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
% $center_x 40
% $center_y 30
% $color 1
% $y 10
% $x 20
