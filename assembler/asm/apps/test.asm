# .HEADER
. $current_x 1
. $current_y 1
. $current_color 1
. $tile_data0 10
. $tile 1
. $tile_data1 11
. $tile1 1
. $tile_data2 6
. $background 1
. $foreground 1
. $TILE_INFO 14
. $tile_info 1
. $KEYBOARD_TILE 1
. $color_new 1
. $data_ptr_new 1
. $start_y_new 1
. $start_x_new 1
. $tile_id 1
. $item_pointer 1
. $tile_base_prt 1
. $sprite_id 1
. $shape_h 1
. $shape_w 1
. $start_y 1
. $start_x 1
. $rect_y 1
. $rect_x 1
. $tile_ptr 1
. $temp_ptr 1
. $tile_w 1
. $tile_h 1
. $loop_y 1
. $loop_x 1
. $moving_tile_id 1
. $pot_y 1
. $pot_x 1
. $collision_found 1
. $moving_data_ptr 1
. $pot_w 1
. $pot_h 1
. $i 1
. $other_tile_ptr 1
. $other_x 1
. $other_y 1
. $other_data_ptr 1
. $other_w 1
. $other_h 1
. $KEYvalue 1
. $active_tile_ptr 1
. $running 1
. $any_tile_moved 1
. $tile_obj_ptr 1
. $is_moved 1
. $data_ptr 1
. $old_x 1
. $old_y 1
. $new_x 1
. $new_y 1

# .CODE

   # % $tile_data 1 4 56 50 0 54  ; where 0 is an transparant sprite
    % $tile_data0 2 4  129 130  91 93  91 93  203 203
    ldi A $tile_data0
    sto A $tile

    % $tile_data1 3 3 203 203 203 203 0 203 203 203 203
    ldi A $tile_data1
    sto A $tile1

    % $tile_data2 2 2 42 42 42 42 
    ldi A $tile_data2
    sto A $tile1
    ldi A $TILE_INFO
    sto A $tile_info
    call @main
    ret

# .FUNCTIONS
@init_single_tile
    ustack A $DATASTACK_PTR
    sto A $color_new
    ustack A $DATASTACK_PTR
    sto A $data_ptr_new
    ustack A $DATASTACK_PTR
    sto A $start_y_new
    ustack A $DATASTACK_PTR
    sto A $start_x_new
    ustack A $DATASTACK_PTR
    sto A $tile_id
    ldi A 0
    sto A $item_pointer
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 0
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $start_x_new
    ld B A
    ldm I $item_pointer
    stx B $_start_memory_
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $start_y_new
    ld B A
    ldm I $item_pointer
    stx B $_start_memory_
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $start_x_new
    ld B A
    ldm I $item_pointer
    stx B $_start_memory_
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $start_y_new
    ld B A
    ldm I $item_pointer
    stx B $_start_memory_
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldi A 0
    ld B A
    ldm I $item_pointer
    stx B $_start_memory_
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $color_new
    ld B A
    ldm I $item_pointer
    stx B $_start_memory_
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 6
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $data_ptr_new
    ld B A
    ldm I $item_pointer
    stx B $_start_memory_
    ret
@clear_rect
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
    ldi A 0
    sto A $rect_y
    ldm A $start_y
    sto A $rect_y
:clear_rect_while_start_0
    ldm A $rect_y
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
    jmpt :clear_rect_while_end_0
    ldm A $rect_y
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    sto A $rect_x
    ldm A $start_x
    sto A $rect_x
:clear_rect_while_start_1
    ldm A $rect_x
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
    jmpt :clear_rect_while_end_1
    ldm A $rect_x
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
    ldm A $rect_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $rect_x
    jmp :clear_rect_while_start_1
:clear_rect_while_end_1
    ldm A $rect_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $rect_y
    jmp :clear_rect_while_start_0
:clear_rect_while_end_0
    ret
@draw_tile_from_data
    ustack A $DATASTACK_PTR
    sto A $tile_ptr
    ustack A $DATASTACK_PTR
    sto A $start_y
    ustack A $DATASTACK_PTR
    sto A $start_x
    ldi A 0
    sto A $temp_ptr
    ldm I $tile_ptr
    ldx A $_start_memory_
    sto A $tile_w
    ldm A $tile_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $tile_h
    ldi A 0
    sto A $loop_y
:draw_tile_from_data_while_start_2
    ldm A $loop_y
    stack A $DATASTACK_PTR
    ldm A $tile_h
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_tile_from_data_while_end_2
    ldi A 0
    sto A $loop_x
:draw_tile_from_data_while_start_3
    ldm A $loop_x
    stack A $DATASTACK_PTR
    ldm A $tile_w
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_tile_from_data_while_end_3
    ldm A $tile_ptr
    stack A $DATASTACK_PTR
    ldm A $loop_y
    stack A $DATASTACK_PTR
    ldm A $tile_w
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldm A $loop_x
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $sprite_id
    tst A 0
    jmpt :draw_tile_from_data_if_end_0
    ldm A $start_x
    stack A $DATASTACK_PTR
    ldm A $loop_x
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $start_y
    stack A $DATASTACK_PTR
    ldm A $loop_y
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $sprite_id
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
:draw_tile_from_data_if_end_0
    ldm A $loop_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $loop_x
    jmp :draw_tile_from_data_while_start_3
:draw_tile_from_data_while_end_3
    ldm A $loop_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $loop_y
    jmp :draw_tile_from_data_while_start_2
:draw_tile_from_data_while_end_2
    ret
@check_collision
    ustack A $DATASTACK_PTR
    sto A $moving_tile_id
    ustack A $DATASTACK_PTR
    sto A $pot_y
    ustack A $DATASTACK_PTR
    sto A $pot_x
    ldi A 0
    sto A $collision_found
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $moving_tile_id
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 6
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $moving_data_ptr
    ldm I $moving_data_ptr
    ldx A $_start_memory_
    sto A $pot_w
    ldm A $moving_data_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $pot_h
    ldi A 0
    sto A $i
:check_collision_while_start_4
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_collision_while_end_4
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $moving_tile_id
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_collision_if_end_1
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $other_tile_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $other_x
    ldm A $other_tile_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $other_y
    ldm A $other_tile_ptr
    stack A $DATASTACK_PTR
    ldi A 6
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $other_data_ptr
    ldm I $other_data_ptr
    ldx A $_start_memory_
    sto A $other_w
    ldm A $other_data_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $other_h
    ldm A $pot_x
    stack A $DATASTACK_PTR
    ldm A $pot_w
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $other_x
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_collision_if_end_2
    jmp :no_collision_found
:check_collision_if_end_2
    ldm A $other_x
    stack A $DATASTACK_PTR
    ldm A $other_w
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $pot_x
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_collision_if_end_3
    jmp :no_collision_found
:check_collision_if_end_3
    ldm A $pot_y
    stack A $DATASTACK_PTR
    ldm A $pot_h
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $other_y
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_collision_if_end_4
    jmp :no_collision_found
:check_collision_if_end_4
    ldm A $other_y
    stack A $DATASTACK_PTR
    ldm A $other_h
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ldm A $pot_y
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_collision_if_end_5
    jmp :no_collision_found
:check_collision_if_end_5
    ldi A 1
    sto A $collision_found
    jmp :collision_check_end
:no_collision_found
:check_collision_if_end_1
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :check_collision_while_start_4
:check_collision_while_end_4
:collision_check_end
    ldm A $collision_found
    stack A $DATASTACK_PTR
    ret
@handle_input
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :handle_input_if_end_6
    ustack A $DATASTACK_PTR
    sto A $KEYvalue
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $KEYBOARD_TILE
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $active_tile_ptr
    ldi A 0
    sto A $temp_ptr
    ldm A $active_tile_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $current_x
    ldm A $active_tile_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $current_y
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 56
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :handle_input_if_end_7
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $current_y
:handle_input_if_end_7
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :handle_input_if_end_8
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_y
:handle_input_if_end_8
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :handle_input_if_end_9
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $current_x
:handle_input_if_end_9
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 54
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :handle_input_if_end_10
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_x
:handle_input_if_end_10
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 32
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :handle_input_if_end_11
    ldi A 0
    sto A $running
:handle_input_if_end_11
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldm A $KEYBOARD_TILE
    stack A $DATASTACK_PTR
    call @check_collision
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :handle_input_if_else_12
    jmp :handle_input_if_end_12
:handle_input_if_else_12
    ldm A $active_tile_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $current_x
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $active_tile_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $current_y
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $active_tile_ptr
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldi A 1
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
:handle_input_if_end_12
:handle_input_if_end_6
    ret
@redraw_all_moved_tiles
    ldi A 0
    sto A $i
    ldi A 0
    sto A $any_tile_moved
    ldi A 0
    sto A $temp_ptr
:redraw_all_moved_tiles_while_start_5
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :redraw_all_moved_tiles_while_end_5
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $is_moved
    tst A 0
    jmpt :redraw_all_moved_tiles_if_end_13
    ldi A 1
    sto A $any_tile_moved
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 6
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $data_ptr
    ldm I $data_ptr
    ldx A $_start_memory_
    sto A $tile_w
    ldm A $data_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $tile_h
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $old_x
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $old_y
    ldm A $old_x
    stack A $DATASTACK_PTR
    ldm A $old_y
    stack A $DATASTACK_PTR
    ldm A $tile_w
    stack A $DATASTACK_PTR
    ldm A $tile_h
    stack A $DATASTACK_PTR
    ldi A 203
    stack A $DATASTACK_PTR
    call @clear_rect
:redraw_all_moved_tiles_if_end_13
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :redraw_all_moved_tiles_while_start_5
:redraw_all_moved_tiles_while_end_5
    ldi A 0
    sto A $i
:redraw_all_moved_tiles_while_start_6
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :redraw_all_moved_tiles_while_end_6
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $is_moved
    tst A 0
    jmpt :redraw_all_moved_tiles_if_end_14
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 6
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $data_ptr
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $new_x
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $new_y
    ldm A $new_x
    stack A $DATASTACK_PTR
    ldm A $new_y
    stack A $DATASTACK_PTR
    ldm A $data_ptr
    stack A $DATASTACK_PTR
    call @draw_tile_from_data
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $new_x
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $new_y
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldi A 0
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
:redraw_all_moved_tiles_if_end_14
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :redraw_all_moved_tiles_while_start_6
:redraw_all_moved_tiles_while_end_6
    ldm A $any_tile_moved
    tst A 0
    jmpt :redraw_all_moved_tiles_if_end_15
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
:redraw_all_moved_tiles_if_end_15
    ret
@draw_tile_by_id
    ustack A $DATASTACK_PTR
    sto A $tile_id
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 6
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $data_ptr
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $current_x
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $current_y
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldm A $data_ptr
    stack A $DATASTACK_PTR
    call @draw_tile_from_data
    ret
@delete_tile
    ustack A $DATASTACK_PTR
    sto A $tile_id
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldi A 0
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldi A 200
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 4
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldi A 1
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ret
@draw_all_tiles
    ldi A 0
    sto A $i
:draw_all_tiles_while_start_7
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :draw_all_tiles_while_end_7
    ldm A $i
    stack A $DATASTACK_PTR
    call @draw_tile_by_id
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :draw_all_tiles_while_start_7
:draw_all_tiles_while_end_7
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@refresh_tiles
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
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
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 40
    stack A $DATASTACK_PTR
    ldi A 30
    stack A $DATASTACK_PTR
    ldm A $tile
    stack A $DATASTACK_PTR
    ldm A $foreground
    stack A $DATASTACK_PTR
    call @init_single_tile
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $tile1
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @init_single_tile
    ldi A 0
    stack A $DATASTACK_PTR
    call @draw_tile_by_id
    ldi A 1
    stack A $DATASTACK_PTR
    call @draw_tile_by_id
    call @refresh_tiles
    ldi A 0
    stack A $DATASTACK_PTR
    call @delete_tile
    ldi A 1
    sto A $running
:main_while_start_8
    ldm A $running
    tst A 0
    jmpt :main_while_end_8
    call @handle_input
    call @redraw_all_moved_tiles
    jmp :main_while_start_8
:main_while_end_8
    ret

# .DATA
% $current_x 0
% $current_y 0
% $current_color 1
% $background 0
% $foreground 5
% $KEYBOARD_TILE 1
