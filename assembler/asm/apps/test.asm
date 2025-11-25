# .HEADER
. $current_x 1
. $current_y 1
. $current_color 1
. $tile_x 1
. $tile_y 1
. $old_tile_x 1
. $old_tile_y 1
. $tile_is_moved 1
. $tile_width 1
. $tile_height 1
. $background 1
. $foreground 1
. $sprite_id 1
. $shape_h 1
. $shape_w 1
. $start_y 1
. $start_x 1
. $KEYvalue 1
. $draw_tile_str_0 13
. $running 1

# .CODE
    call @main
    ret

# .FUNCTIONS
@draw_screen
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    sto A $current_y
:draw_screen_while_start_0
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 60
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_screen_while_end_0
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    sto A $current_x
:draw_screen_while_start_1
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 80
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_screen_while_end_1
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 203
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_x
    jmp :draw_screen_while_start_1
:draw_screen_while_end_1
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_y
    jmp :draw_screen_while_start_0
:draw_screen_while_end_0
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@draw_shape
    ustack A $DATASTACK_PTR
    sto A $sprite_id
    ustack A $DATASTACK_PTR
    sto A $shape_h
    ustack A $DATASTACK_PTR
    sto A $shape_w
    ustack A $DATASTACK_PTR
    sto A $start_y
    ustack A $DATASTACK_PTR
    sto A $start_x
    ldm A $start_y
    sto A $current_y
:draw_shape_while_start_2
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldm A $start_y
    stack A $DATASTACK_PTR
    ldm A $shape_h
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_shape_while_end_2
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $start_x
    sto A $current_x
:draw_shape_while_start_3
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldm A $start_x
    stack A $DATASTACK_PTR
    ldm A $shape_w
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_shape_while_end_3
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $sprite_id
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_x
    jmp :draw_shape_while_start_3
:draw_shape_while_end_3
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_y
    jmp :draw_shape_while_start_2
:draw_shape_while_end_2
    ret
@draw_tile
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_tile_if_end_0
    ustack A $DATASTACK_PTR
    sto A $KEYvalue
    ldi A $draw_tile_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 56
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_tile_if_end_1
    ldm A $tile_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $tile_y
    ldi A 1
    sto A $tile_is_moved
:draw_tile_if_end_1
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_tile_if_end_2
    ldm A $tile_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_y
    ldi A 1
    sto A $tile_is_moved
:draw_tile_if_end_2
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_tile_if_end_3
    ldm A $tile_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $tile_x
    ldi A 1
    sto A $tile_is_moved
:draw_tile_if_end_3
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 54
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_tile_if_end_4
    ldm A $tile_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_x
    ldi A 1
    sto A $tile_is_moved
:draw_tile_if_end_4
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 32
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_tile_if_end_5
    ldi A 0
    sto A $running
:draw_tile_if_end_5
:draw_tile_if_end_0
    ldm A $tile_is_moved
    tst A 0
    jmpt :draw_tile_if_end_6
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $old_tile_x
    stack A $DATASTACK_PTR
    ldm A $old_tile_y
    stack A $DATASTACK_PTR
    ldm A $tile_width
    stack A $DATASTACK_PTR
    ldm A $tile_height
    stack A $DATASTACK_PTR
    ldi A 203
    stack A $DATASTACK_PTR
    call @draw_shape
    ldm A $foreground
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $tile_x
    stack A $DATASTACK_PTR
    ldm A $tile_y
    stack A $DATASTACK_PTR
    ldm A $tile_width
    stack A $DATASTACK_PTR
    ldm A $tile_height
    stack A $DATASTACK_PTR
    ldi A 42
    stack A $DATASTACK_PTR
    call @draw_shape
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $tile_x
    sto A $old_tile_x
    ldm A $tile_y
    sto A $old_tile_y
    ldi A 0
    sto A $tile_is_moved
:draw_tile_if_end_6
    ret
@main
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
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 1
    sto A $running
:main_while_start_4
    ldm A $running
    tst A 0
    jmpt :main_while_end_4
    call @draw_tile
    jmp :main_while_start_4
:main_while_end_4
    ret

# .DATA
% $current_x 0
% $current_y 0
% $current_color 1
% $tile_x 40
% $tile_y 30
% $old_tile_x 40
% $old_tile_y 30
% $tile_is_moved 0
% $tile_width 1
% $tile_height 4
% $background 0
% $foreground 5
% $draw_tile_str_0 \K \e \y \space \p \r \e \s \s \e \d \space \null
