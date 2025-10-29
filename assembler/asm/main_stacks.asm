# .HEADER
. $WIDTH 1
. $HEIGHT 1
. $BOARD_SIZE 1
. $X_OFFSET 1
. $Y_OFFSET 1
. $p_current 1
. $x 1
. $y 1
. $i 1
. $cx 1
. $cy 1
. $new_state 1
MALLOC $current_board 9216
MALLOC $next_board 10416
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
. $y_coord 1
. $x_coord 1
. $board_ptr 1
. $value_in 1
. $_main_str_0 2

# .CODE
    ldi A 0
    stack A $DATASTACK_PTR
    call @TIME.start
    call @TURTLE.start
    ldi A 3
    stack A $DATASTACK_PTR
    call @TURTLE.mode
    call @init_board
    call @copy_board2
:_main_while_start_5
    ldi A 1
    tst A 0
    jmpt :_main_while_end_5
    call @draw_board
    call @TURTLE.flip
    call @compute_next_generation
    call @copy_board2
    ldi A 0
    stack A $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 0
    stack A $DATASTACK_PTR
    call @TIME.start
    jmp :_main_while_start_5
:_main_while_end_5
    ret

# .FUNCTIONS

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

@ROT

        ustack C $DATASTACK_PTR
        ustack B $DATASTACK_PTR
        ustack A $DATASTACK_PTR
        stack B $DATASTACK_PTR
        stack C $DATASTACK_PTR
        stack A $DATASTACK_PTR
        ret
@count_neighbors2

        ; Get arguments from the stack into registers X and Y.
        ustack Y $DATASTACK_PTR  ; Y = y
        ustack X $DATASTACK_PTR  ; X = x

        ; Initialize total_count in register A to zero.
        ld A Z ; (Or ldi A 0)

        ; ---- start Neighbors
        ; --- Neighbor (x-1, y-1) ---
        ldi K 40
        ld M X      ; Load X in M
        subi M 1    
        addi M 40
        dmod M K    ; Calc Neighbors X in K

        ldi L 30
        ld M Y      ; Load Y in M
        subi M 1  
        addi M 30  
        dmod M L    ; Calc Neighbors Y in L


        ; read the value and add to total
        muli L 40
        ldi I $current_board    ; load the index of the currentboard in I
        add I L                 ; add y*40
        add I K                 ; add X, I hold the pointer now

        ldx B $_start_memory_   ; B holds the value at the pointer

        add A B                 ; Update the total counter

        ; --- Neighbor (x, y-1) ---
        ldi K 40
        ld M X      ; No subi M 1, because it's just 'x'
        addi M 40
        dmod M K    ; K = wrapped x

        ldi L 30
        ld M Y
        subi M 1    ; y-1
        addi M 30
        dmod M L    ; L = wrapped y

        ; read the value and add to total
        muli L 40
        ldi I $current_board    ; load the index of the currentboard in I
        add I L                 ; add y*40
        add I K                 ; add X, I hold the pointer now

        ldx B $_start_memory_   ; B holds the value at the pointer

        add A B                 ; Update the total counter

        ; --- Neighbor (x+1, y-1) ---
        ldi K 40
        ld M X
        addi M 1
        addi M 40
        dmod M K    ; K = wrapped

        ldi L 30
        ld M Y
        subi M 1 
        addi M 30
        dmod M L    ; L = wrapped

        ; read the value and add to total
        muli L 40
        ldi I $current_board    ; load the index of the currentboard in I
        add I L                 ; add y*40
        add I K                 ; add X, I hold the pointer now

        ldx B $_start_memory_   ; B holds the value at the pointer

        add A B                 ; Update the total counter

        ; --- Neighbor (x-1, y) ---
        ldi K 40
        ld M X
        subi M 1
        addi M 40
        dmod M K    ; K = wrapped

        ldi L 30
        ld M Y
        addi M 30
        dmod M L    ; L = wrapped

        ; read the value and add to total
        muli L 40
        ldi I $current_board    ; load the index of the currentboard in I
        add I L                 ; add y*40
        add I K                 ; add X, I hold the pointer now

        ldx B $_start_memory_   ; B holds the value at the pointer

        add A B                 ; Update the total counter

        ; --- Neighbor (x+1, y) ---
        ldi K 40
        ld M X
        addi M 1
        addi M 40
        dmod M K    ; K = wrapped

        ldi L 30
        ld M Y
        addi M 30
        dmod M L    ; L = wrapped

        ; read the value and add to total
        muli L 40
        ldi I $current_board    ; load the index of the currentboard in I
        add I L                 ; add y*40
        add I K                 ; add X, I hold the pointer

        ldx B $_start_memory_

        add A B                 ; Update the total counter


        ; --- Neighbor (x-1, y+1) ---
        ldi K 40
        ld M X
        subi M 1
        addi M 40
        dmod M K    ; K = wrapped

        ldi L 30
        ld M Y
        addi M 1
        addi M 30
        dmod M L    ; L = wrapped

        ; read the value and add to total
        muli L 40
        ldi I $current_board    ; load the index of the currentboard in I
        add I L                 ; add y*40
        add I K                 ; add X, I hold the pointer

        ldx B $_start_memory_

        add A B                 ; Update the total counter

        ; --- Neighbor (x, y+1) ---
        ldi K 40
        ld M X
        addi M 40
        dmod M K    ; K = wrapped

        ldi L 30
        ld M Y
        addi M 1
        addi M 30
        dmod M L    ; L = wrapped

        ; read the value and add to total
        muli L 40
        ldi I $current_board    ; load the index of the currentboard in I
        add I L                 ; add y*40
        add I K                 ; add X, I hold the pointer

        ldx B $_start_memory_

        add A B                 ; Update the total counter


        ; --- Neighbor (x+1, y+1) ---
        ldi K 40
        ld M X
        addi M 1
        addi M 40
        dmod M K    ; K = wrapped

        ldi L 30
        ld M Y
        addi M 1
        addi M 30
        dmod M L    ; L = wrapped

        ; read the value and add to total
        muli L 40
        ldi I $current_board    ; load the index of the currentboard in I
        add I L                 ; add y*40
        add I K                 ; add X, I hold the pointer

        ldx B $_start_memory_

        add A B                 ; Update the total counter

        ; ---- End Neighbors

        ; Push the final result from total_count (A) onto the stack.
        stack A $DATASTACK_PTR
        ret
        ret
@get_cell_state
    ustack A $DATASTACK_PTR
    sto A $y_coord
    ustack A $DATASTACK_PTR
    sto A $x_coord
    ustack A $DATASTACK_PTR
    sto A $board_ptr
    stack A $DATASTACK_PTR
    ldm A $y_coord
    stack A $DATASTACK_PTR
    ldm A $WIDTH
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $x_coord
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $p_current
    ldm I $p_current
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@set_cell_state
    ustack A $DATASTACK_PTR
    sto A $value_in
    ustack A $DATASTACK_PTR
    sto A $y_coord
    ustack A $DATASTACK_PTR
    sto A $x_coord
    ustack A $DATASTACK_PTR
    sto A $board_ptr
    stack A $DATASTACK_PTR
    ldm A $y_coord
    stack A $DATASTACK_PTR
    ldm A $WIDTH
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $x_coord
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $p_current
    ldm A $value_in
    stack A $DATASTACK_PTR
    ldm A $p_current
    sto A $p_current
    ustack B $DATASTACK_PTR
    ldm I $p_current
    stx B $_start_memory_
    ret
@init_board
    ldi A 0
    sto A $i
:init_board_while_start_0
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $BOARD_SIZE
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :init_board_while_end_0
    call @rt_rnd
    ldi A 500
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :init_board_if_else_0
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :init_board_if_end_0
:init_board_if_else_0
    ldi A 1
    stack A $DATASTACK_PTR
:init_board_if_end_0
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldm A $i
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $p_current
    ustack B $DATASTACK_PTR
    ldm I $p_current
    stx B $_start_memory_
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :init_board_while_start_0
:init_board_while_end_0
    ret
@draw_board
    ldi A 0
    sto A $y
:draw_board_while_start_1
    ldm A $y
    stack A $DATASTACK_PTR
    ldm A $HEIGHT
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_board_while_end_1
    ldi A 0
    sto A $x
:draw_board_while_start_2
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $WIDTH
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_board_while_end_2
    ldi A $current_board
    stack A $DATASTACK_PTR
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $y
    stack A $DATASTACK_PTR
    call @get_cell_state
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_board_if_else_1
    ldi A 5
    stack A $DATASTACK_PTR
    call @TURTLE.color
    jmp :draw_board_if_end_1
:draw_board_if_else_1
    ldi A 0
    stack A $DATASTACK_PTR
    call @TURTLE.color
:draw_board_if_end_1
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $X_OFFSET
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldm A $y
    stack A $DATASTACK_PTR
    ldm A $Y_OFFSET
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @TURTLE.goto
    ldm A $x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $x
    jmp :draw_board_while_start_2
:draw_board_while_end_2
    ldm A $y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $y
    jmp :draw_board_while_start_1
:draw_board_while_end_1
    ret
@compute_next_generation
    ldi A 0
    sto A $y
:compute_next_generation_while_start_3
    ldm A $y
    stack A $DATASTACK_PTR
    ldm A $HEIGHT
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :compute_next_generation_while_end_3
    ldi A 0
    sto A $x
:compute_next_generation_while_start_4
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $WIDTH
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :compute_next_generation_while_end_4
    ldi A $current_board
    stack A $DATASTACK_PTR
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $y
    stack A $DATASTACK_PTR
    call @get_cell_state
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $y
    stack A $DATASTACK_PTR
    call @count_neighbors2
    ldi A 0
    sto A $new_state
    call @rt_dup
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :compute_next_generation_if_else_2
    ldi A 1
    sto A $new_state
    jmp :compute_next_generation_if_end_2
:compute_next_generation_if_else_2
    call @rt_over
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :compute_next_generation_if_end_3
    call @rt_dup
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :compute_next_generation_if_end_4
    ldi A 1
    sto A $new_state
:compute_next_generation_if_end_4
:compute_next_generation_if_end_3
:compute_next_generation_if_end_2
    call @rt_drop
    call @rt_drop
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $y
    stack A $DATASTACK_PTR
    ldm A $new_state
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldm A $x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $x
    jmp :compute_next_generation_while_start_4
:compute_next_generation_while_end_4
    ldm A $y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $y
    jmp :compute_next_generation_while_start_3
:compute_next_generation_while_end_3
    ret
@copy_board2

        ; 1. Initialize pointers and a counter
        ldi K $next_board       ; Use K as the source pointer
        ldi L $current_board    ; Use L as the destination pointer
        ldi C 0                 ; Use C as the loop counter (1200),
                                ; start at 0

    :copy_loop
        ; Check if we are done
        tst C 1200
        jmpt :copy_loop_end

        ; --- Main copy operation ---
        ; Move a single value from source to destination
        ld I K      ; Move source pointer into the index register I
        add I C     ; add the current index
        ldx A $_start_memory_   ; Load the value from source into register A

        ld I L      ; Move destination pointer into the index register I
        add I C     ; add the current index
        stx A $_start_memory_  ; Store the value from A to the destination

        ; --- Move to the next memory location ---
        # addi K 1     ; Increment source pointer
        # addi L 1     ; Increment destination pointer
        addi C 1     ; Increment loop counter
        jmp :copy_loop

    :copy_loop_end
        ret
        ret
@test_blinker_pattern
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ret
@test_glider_pattern
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ret

# .DATA
% $WIDTH 40
% $HEIGHT 30
% $BOARD_SIZE 1200
% $X_OFFSET 20
% $Y_OFFSET 15
% $p_current 0
% $x 0
% $y 0
% $i 0
% $cx 0
% $cy 0
% $new_state 0

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
% $_main_str_0 \Return \null
