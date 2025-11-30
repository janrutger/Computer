# .HEADER
. $current_x 1
. $current_y 1
. $current_color 1
. $background 1
. $foreground 1
. $score 1
. $GAME_EVENT_NONE 1
. $active_tile_count 1
. $tile_info 1
. $KEYBOARD_TILE 1
. $replace_ptr_new 1
. $reaction_new 1
. $color_new 1
. $data_ptr_new 1
. $start_y_new 1
. $start_x_new 1
. $tile_id 1
. $temp_ptr 1
. $temp_ptr2 1
. $initial_w 1
. $initial_h 1
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
. $tile_w 1
. $tile_h 1
. $loop_y 1
. $loop_x 1
. $moving_tile_id 1
. $pot_y 1
. $pot_x 1
. $pot_w 1
. $pot_h 1
. $collision_found 1
. $moving_data_ptr 1
. $i 1
. $other_tile_ptr 1
. $other_data_ptr 1
. $other_x 1
. $other_y 1
. $other_w 1
. $other_h 1
. $KEYvalue 1
. $active_tile_ptr 1
. $collided_id 1
. $any_tile_moved 1
. $tile_obj_ptr 1
. $is_moved 1
. $old_x 1
. $old_y 1
. $old_w 1
. $old_h 1
. $data_ptr 1
. $new_x 1
. $new_y 1
. $current_h 1
. $current_w 1
. $replace_data_ptr 1
. $new_data_ptr 1
. $new_color 1
. $new_reaction 1
. $actor_ptr 1
. $cooldown 1
. $timer_ptr 1
. $new_sprite_data_ptr 1
. $replacement_data_ptr 1
. $TILE_INFO 88
. $EVENT_TYPE 1
. $EVENT_TARGET 1
. $EVENT_ACTOR 1
. $EVENT_POTENTIAL_X 1
. $EVENT_POTENTIAL_Y 1
. $PLAYER_IS_BLOCKED 1
. $running 1
. $tile_data0 10
. $tile 1
. $tile_data1 11
. $tile1 1
. $tile_data2 6
. $tile2 1
. $locked_door_replacement 3
. $timer_0_time 1
. $timer_0 1
. $timer_0_state 1
. $interacted_id 1
. $game_event 1

# .CODE

   # % $tile_data 1 4 56 50 0 54  ; where 0 is transparent
    % $tile_data0 2 4  129 130  91 93  91 93  203 203
    ldi A $tile_data0
    sto A $tile

    % $tile_data1 3 3 203 203 203 203 0 203 203 203 203
    ldi A $tile_data1
    sto A $tile1

    # % $tile_data2 2 2 42 42 42 42 
    % $tile_data2 1 1 42 
    ldi A $tile_data2
    sto A $tile2
    call @main
    ldm A $score
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ret

# .FUNCTIONS

@_negate
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_swap
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    ret
@init_game_lib
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
    ldi A $TILE_INFO
    sto A $tile_info
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    ustack A $DATASTACK_PTR
    sto A $EVENT_TYPE
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    ustack A $DATASTACK_PTR
    sto A $EVENT_TARGET
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    ustack A $DATASTACK_PTR
    sto A $EVENT_ACTOR
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    ustack A $DATASTACK_PTR
    sto A $EVENT_POTENTIAL_X
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    ustack A $DATASTACK_PTR
    sto A $EVENT_POTENTIAL_Y
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    ustack A $DATASTACK_PTR
    sto A $GAME_EVENT_NONE
    ret
@GAME.init_tile
    ustack A $DATASTACK_PTR
    sto A $replace_ptr_new
    ustack A $DATASTACK_PTR
    sto A $reaction_new
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
    sto A $temp_ptr
    ldm I $data_ptr_new
    ldx A $_start_memory_
    sto A $initial_w
    ldm A $data_ptr_new
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $initial_h
    ldi A 0
    sto A $item_pointer
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 11
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
    ldi A 9
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $initial_w
    ld B A
    ldm I $item_pointer
    stx B $_start_memory_
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $initial_h
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
    ldi A 1
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
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $reaction_new
    ld B A
    ldm I $item_pointer
    stx B $_start_memory_
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 8
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $item_pointer
    ldm A $replace_ptr_new
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
    ldi A 11
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
    ldm A $active_tile_count
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
    ldi A 11
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
    ldm A $i
    stack A $DATASTACK_PTR
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
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
:collision_check_end
    ret
@GAME.handle_input
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_else_6
    ustack A $DATASTACK_PTR
    sto A $KEYvalue
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $KEYBOARD_TILE
    stack A $DATASTACK_PTR
    ldi A 11
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
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    ustack A $DATASTACK_PTR
    sto A $EVENT_TYPE
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 56
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_7
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $current_y
:GAME.handle_input_if_end_7
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_8
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_y
:GAME.handle_input_if_end_8
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_9
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $current_x
:GAME.handle_input_if_end_9
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 54
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_10
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_x
:GAME.handle_input_if_end_10
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 27
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_11
    ldi A 0
    sto A $running
:GAME.handle_input_if_end_11
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldm A $KEYBOARD_TILE
    stack A $DATASTACK_PTR
    call @check_collision
    ustack A $DATASTACK_PTR
    sto A $collided_id
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_12
    ldm A $active_tile_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldi A 0
    sto A $PLAYER_IS_BLOCKED
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
:GAME.handle_input_if_end_12
    ldm A $collided_id
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_13
    ldm A $KEYBOARD_TILE
    sto A $EVENT_ACTOR
    ldm A $collided_id
    sto A $EVENT_TARGET
    ldm A $PLAYER_IS_BLOCKED
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_14
    ldm A $KEYBOARD_TILE
    sto A $EVENT_ACTOR
    ldm A $collided_id
    sto A $EVENT_TARGET
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $collided_id
    stack A $DATASTACK_PTR
    ldi A 11
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $EVENT_TYPE
    ldm A $current_x
    sto A $EVENT_POTENTIAL_X
    ldm A $current_y
    sto A $EVENT_POTENTIAL_Y
    ldi A 1
    sto A $PLAYER_IS_BLOCKED
:GAME.handle_input_if_end_14
:GAME.handle_input_if_end_13
    jmp :GAME.handle_input_if_end_6
:GAME.handle_input_if_else_6
    ldi A 0
    sto A $PLAYER_IS_BLOCKED
:GAME.handle_input_if_end_6
    ret
@GAME.redraw_all_moved_tiles
    ldi A 0
    sto A $i
    ldi A 0
    sto A $any_tile_moved
    ldi A 0
    sto A $temp_ptr
:GAME.redraw_all_moved_tiles_while_start_5
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $active_tile_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.redraw_all_moved_tiles_while_end_5
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 11
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
    jmpt :GAME.redraw_all_moved_tiles_if_end_15
    ldi A 1
    sto A $any_tile_moved
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    sto A $temp_ptr2
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr2
    ldm I $temp_ptr2
    ldx A $_start_memory_
    sto A $old_x
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 3
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr2
    ldm I $temp_ptr2
    ldx A $_start_memory_
    sto A $old_y
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 9
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr2
    ldm I $temp_ptr2
    ldx A $_start_memory_
    sto A $old_w
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr2
    ldm I $temp_ptr2
    ldx A $_start_memory_
    sto A $old_h
    ldm A $old_x
    stack A $DATASTACK_PTR
    ldm A $old_y
    stack A $DATASTACK_PTR
    ldm A $old_w
    stack A $DATASTACK_PTR
    ldm A $old_h
    stack A $DATASTACK_PTR
    ldi A 203
    stack A $DATASTACK_PTR
    call @clear_rect
:GAME.redraw_all_moved_tiles_if_end_15
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :GAME.redraw_all_moved_tiles_while_start_5
:GAME.redraw_all_moved_tiles_while_end_5
    ldi A 0
    sto A $i
:GAME.redraw_all_moved_tiles_while_start_6
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $active_tile_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.redraw_all_moved_tiles_while_end_6
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 11
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
    jmpt :GAME.redraw_all_moved_tiles_if_end_16
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
    ldi A 0
    sto A $temp_ptr2
    ldm I $data_ptr
    ldx A $_start_memory_
    sto A $current_w
    ldm A $data_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr2
    ldm I $temp_ptr2
    ldx A $_start_memory_
    sto A $current_h
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 9
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr2
    ldm A $current_w
    ld B A
    ldm I $temp_ptr2
    stx B $_start_memory_
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr2
    ldm A $current_h
    ld B A
    ldm I $temp_ptr2
    stx B $_start_memory_
:GAME.redraw_all_moved_tiles_if_end_16
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :GAME.redraw_all_moved_tiles_while_start_6
:GAME.redraw_all_moved_tiles_while_end_6
    ldm A $any_tile_moved
    tst A 0
    jmpt :GAME.redraw_all_moved_tiles_if_end_17
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
:GAME.redraw_all_moved_tiles_if_end_17
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
    ldi A 11
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
    ldi A 11
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
@replace_tile
    ustack A $DATASTACK_PTR
    sto A $tile_id
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 11
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 8
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $replace_data_ptr
    ldm I $replace_data_ptr
    ldx A $_start_memory_
    sto A $new_data_ptr
    ldm A $replace_data_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $new_color
    ldm A $replace_data_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $new_reaction
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 6
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $new_data_ptr
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $new_color
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 7
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $new_reaction
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
    ldm A $active_tile_count
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
@GAME.process_events
    ldm A $EVENT_TYPE
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.process_events_if_end_18
    ldm A $EVENT_TYPE
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.process_events_if_end_19
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $EVENT_TARGET
    stack A $DATASTACK_PTR
    jmp :process_events_end
:GAME.process_events_if_end_19
    ldm A $EVENT_TYPE
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.process_events_if_end_20
    ldm A $EVENT_TARGET
    stack A $DATASTACK_PTR
    call @delete_tile
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $EVENT_ACTOR
    stack A $DATASTACK_PTR
    ldi A 11
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $actor_ptr
    stack A $DATASTACK_PTR
    ldi A 0
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $EVENT_POTENTIAL_X
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $actor_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $EVENT_POTENTIAL_Y
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $actor_ptr
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
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $EVENT_TARGET
    stack A $DATASTACK_PTR
    jmp :process_events_end
:GAME.process_events_if_end_20
    ldm A $EVENT_TYPE
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.process_events_if_end_21
    ldm A $EVENT_TARGET
    stack A $DATASTACK_PTR
    call @replace_tile
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $EVENT_TARGET
    stack A $DATASTACK_PTR
    jmp :process_events_end
:GAME.process_events_if_end_21
:GAME.process_events_if_end_18
    ldm A $GAME_EVENT_NONE
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
:process_events_end
    ldm A $GAME_EVENT_NONE
    sto A $EVENT_TYPE
    ret
@GAME.refresh
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@is_timer_ready
    ustack A $DATASTACK_PTR
    sto A $cooldown
    ustack A $DATASTACK_PTR
    sto A $timer_ptr
    ldm I $timer_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :is_timer_ready_if_else_22
    ldm I $timer_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ldm I $timer_ptr
    stx B $_start_memory_
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :is_timer_ready_if_end_22
:is_timer_ready_if_else_22
    ldm A $cooldown
    ld B A
    ldm I $timer_ptr
    stx B $_start_memory_
    ldi A 1
    stack A $DATASTACK_PTR
:is_timer_ready_if_end_22
    ret
@tile_move
    ustack A $DATASTACK_PTR
    sto A $tile_id
    ustack A $DATASTACK_PTR
    sto A $new_y
    ustack A $DATASTACK_PTR
    sto A $new_x
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 11
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_obj_ptr
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 0
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
    ldi A 1
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
    ldi A 1
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ret
@define_replacement
    ustack A $DATASTACK_PTR
    sto A $new_reaction
    ustack A $DATASTACK_PTR
    sto A $new_color
    ustack A $DATASTACK_PTR
    sto A $new_sprite_data_ptr
    ustack A $DATASTACK_PTR
    sto A $replacement_data_ptr
    ldi A 0
    sto A $temp_ptr
    ldm A $replacement_data_ptr
    sto A $temp_ptr
    ldm A $new_sprite_data_ptr
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $replacement_data_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $new_color
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ldm A $replacement_data_ptr
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm A $new_reaction
    ld B A
    ldm I $temp_ptr
    stx B $_start_memory_
    ret

@main
    call @init_game_lib
    ldi A $locked_door_replacement
    stack A $DATASTACK_PTR
    ldi A $tile_data2
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @define_replacement
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 40
    stack A $DATASTACK_PTR
    ldi A 30
    stack A $DATASTACK_PTR
    ldm A $tile
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A $locked_door_replacement
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 30
    stack A $DATASTACK_PTR
    ldm A $tile1
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 40
    stack A $DATASTACK_PTR
    ldi A 40
    stack A $DATASTACK_PTR
    ldm A $tile2
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 3
    sto A $active_tile_count
    ldi A 1
    sto A $KEYBOARD_TILE
    ldi A 0
    stack A $DATASTACK_PTR
    call @draw_tile_by_id
    ldi A 1
    stack A $DATASTACK_PTR
    call @draw_tile_by_id
    ldi A 2
    stack A $DATASTACK_PTR
    call @draw_tile_by_id
    call @GAME.refresh
    ldi A 750
    sto A $timer_0_time
    ldi A 0
    sto A $timer_0
    ldi A 0
    sto A $timer_0_state
    ldi A 1
    sto A $running
:main_while_start_0
    ldm A $running
    tst A 0
    jmpt :main_while_end_0
    ldi A $timer_0
    stack A $DATASTACK_PTR
    ldm A $timer_0_time
    stack A $DATASTACK_PTR
    call @is_timer_ready
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_0
    ldm A $timer_0_state
    tst A 0
    jmpt :main_if_else_1
    ldi A 40
    stack A $DATASTACK_PTR
    ldi A 30
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @tile_move
    ldi A 0
    sto A $timer_0_state
    jmp :main_if_end_1
:main_if_else_1
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @tile_move
    ldi A 1
    sto A $timer_0_state
:main_if_end_1
:main_if_end_0
    call @GAME.handle_input
    call @GAME.process_events
    ustack A $DATASTACK_PTR
    sto A $interacted_id
    ustack A $DATASTACK_PTR
    sto A $game_event
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_2
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_3
    ldm A $score
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $score
:main_if_end_3
    jmp :main_if_end_2
:main_if_else_2
    ldm A $game_event
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_else_4
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_5
    ldm A $score
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $score
:main_if_end_5
    jmp :main_if_end_4
:main_if_else_4
    ldm A $game_event
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_6
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :main_if_end_7
    ldm A $score
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $score
:main_if_end_7
:main_if_end_6
:main_if_end_4
:main_if_end_2
    call @GAME.redraw_all_moved_tiles
    jmp :main_while_start_0
:main_while_end_0
    ret

# .DATA

% $current_x 0
% $current_y 0
% $current_color 1
% $background 0
% $foreground 5
% $score 0
% $GAME_EVENT_NONE 0
% $active_tile_count 0
% $tile_info 0
% $KEYBOARD_TILE 0
% $replace_ptr_new 0
% $reaction_new 0
% $color_new 0
% $data_ptr_new 0
% $start_y_new 0
% $start_x_new 0
% $tile_id 0
% $temp_ptr 0
% $temp_ptr2 0
% $initial_w 0
% $initial_h 0
% $item_pointer 0
% $tile_base_prt 0
% $sprite_id 0
% $shape_h 0
% $shape_w 0
% $start_y 0
% $start_x 0
% $rect_y 0
% $rect_x 0
% $tile_ptr 0
% $tile_w 0
% $tile_h 0
% $loop_y 0
% $loop_x 0
% $moving_tile_id 0
% $pot_y 0
% $pot_x 0
% $pot_w 0
% $pot_h 0
% $collision_found 0
% $moving_data_ptr 0
% $i 0
% $other_tile_ptr 0
% $other_data_ptr 0
% $other_x 0
% $other_y 0
% $other_w 0
% $other_h 0
% $KEYvalue 0
% $active_tile_ptr 0
% $collided_id 0
% $any_tile_moved 0
% $tile_obj_ptr 0
% $is_moved 0
% $old_x 0
% $old_y 0
% $old_w 0
% $old_h 0
% $data_ptr 0
% $new_x 0
% $new_y 0
% $current_h 0
% $current_w 0
% $replace_data_ptr 0
% $new_data_ptr 0
% $new_color 0
% $new_reaction 0
% $actor_ptr 0
% $cooldown 0
% $timer_ptr 0
% $new_sprite_data_ptr 0
% $replacement_data_ptr 0
% $EVENT_TYPE 0
% $EVENT_TARGET 0
% $EVENT_ACTOR 0
% $EVENT_POTENTIAL_X 0
% $EVENT_POTENTIAL_Y 0
% $PLAYER_IS_BLOCKED 0
% $running 0
