# .HEADER
. $current_x 1
. $current_y 1
. $current_color 1
. $background 1
. $foreground 1
. $GAME_EVENT_NONE 1
. $active_tile_count 1
. $tile_info 1
. $KEYBOARD_TILE 1
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
. $new_data_ptr 1
. $new_color 1
. $new_reaction 1
. $actor_ptr 1
. $cooldown 1
. $timer_ptr 1
. $EVENT_TYPE 1
. $EVENT_TARGET 1
. $EVENT_ACTOR 1
. $EVENT_POTENTIAL_X 1
. $EVENT_POTENTIAL_Y 1
. $PLAYER_IS_BLOCKED 1
. $GAME.running 1
. $Player 1
. $Coin 1
. $Special 1
. $Roof 1
. $ShortWall 1
. $LongWall 1
. $GameOverSprite 1
. $YouWonSprite 1
. $YouLostSprite 1
. $interacted_id 1
. $score 1
. $coins_remaining 1
. $player_won 1
. $t_coin 1
. $t_coin_time 1
. $t_special 1
. $t_special_time 1
. $t_monster_cooldown 1
. $_score_dirty 1
. $_score 1
. $_hunreds 1
. $_tens 1
. $_ones 1
. $_coins_dirty 1
. $_coins 1
. $_data_ptr 1
. $_cost 1
. $_tile_id 1
. $_current_color 1
. $_target_color 1
. $_wall_cost 1
. $player_y 1
. $player_x 1
. $monster_y 1
. $monster_x 1
. $game_event 1

# .CODE
    call @HEAP.free
    ldi A 200
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $Player
    ldi A 42
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $Coin
    ldi A 204
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $Special
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 27
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $Roof
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $ShortWall
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 201
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $LongWall
    ldi A 82
    stack A $DATASTACK_PTR
    ldi A 69
    stack A $DATASTACK_PTR
    ldi A 86
    stack A $DATASTACK_PTR
    ldi A 79
    stack A $DATASTACK_PTR
    ldi A 32
    stack A $DATASTACK_PTR
    ldi A 69
    stack A $DATASTACK_PTR
    ldi A 77
    stack A $DATASTACK_PTR
    ldi A 65
    stack A $DATASTACK_PTR
    ldi A 71
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 9
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $GameOverSprite
    ldi A 78
    stack A $DATASTACK_PTR
    ldi A 79
    stack A $DATASTACK_PTR
    ldi A 87
    stack A $DATASTACK_PTR
    ldi A 32
    stack A $DATASTACK_PTR
    ldi A 85
    stack A $DATASTACK_PTR
    ldi A 79
    stack A $DATASTACK_PTR
    ldi A 89
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $YouWonSprite
    ldi A 84
    stack A $DATASTACK_PTR
    ldi A 83
    stack A $DATASTACK_PTR
    ldi A 79
    stack A $DATASTACK_PTR
    ldi A 76
    stack A $DATASTACK_PTR
    ldi A 32
    stack A $DATASTACK_PTR
    ldi A 85
    stack A $DATASTACK_PTR
    ldi A 79
    stack A $DATASTACK_PTR
    ldi A 89
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    call @NEW.matrix
    ustack A $DATASTACK_PTR
    sto A $YouLostSprite
    call @GAME.init_game_lib
    ldi A 350
    sto A $t_coin
    ldi A 700
    sto A $t_coin_time
    ldi A 100
    sto A $t_special
    ldi A 100
    sto A $t_special_time
    ldi A 0
    sto A $t_monster_cooldown
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 39
    stack A $DATASTACK_PTR
    ldi A 46
    stack A $DATASTACK_PTR
    ldm A $Player
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 30
    stack A $DATASTACK_PTR
    ldi A 40
    stack A $DATASTACK_PTR
    ldm A $Coin
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 34
    stack A $DATASTACK_PTR
    ldm A $Roof
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 35
    stack A $DATASTACK_PTR
    ldm A $ShortWall
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 45
    stack A $DATASTACK_PTR
    ldm A $LongWall
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $ShortWall
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    ldi A 35
    stack A $DATASTACK_PTR
    ldm A $LongWall
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 45
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $Special
    stack A $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.init_tile
    ldi A 8
    sto A $active_tile_count
    ldi A 0
    sto A $KEYBOARD_TILE
    ldi A 1
    sto A $GAME.running
:_main_while_start_0
    ldm A $GAME.running
    tst A 0
    jmpt :_main_while_end_0
    call @update_wall_visuals
    ldm A $coins_remaining
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_15
    ldi A 0
    sto A $GAME.running
:_main_if_end_15
    ldi A $t_coin
    stack A $DATASTACK_PTR
    ldm A $t_coin_time
    stack A $DATASTACK_PTR
    call @GAME.is_timer_ready
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_16
    call @rnd_xy1
    ldi A 1
    stack A $DATASTACK_PTR
    call @GAME.tile_move
    ldm A $coins_remaining
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $coins_remaining
    ldi A 1
    sto A $_coins_dirty
:_main_if_end_16
    ldm A $t_monster_cooldown
    tst A 0
    jmpt :_main_if_else_17
    ldm A $t_monster_cooldown
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $t_monster_cooldown
    jmp :_main_if_end_17
:_main_if_else_17
    ldi A $t_special
    stack A $DATASTACK_PTR
    ldm A $t_special_time
    stack A $DATASTACK_PTR
    call @GAME.is_timer_ready
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_18
    ldi A 0
    stack A $DATASTACK_PTR
    call @GAME.get_xy
    ustack A $DATASTACK_PTR
    sto A $player_y
    ustack A $DATASTACK_PTR
    sto A $player_x
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.get_xy
    ustack A $DATASTACK_PTR
    sto A $monster_y
    ustack A $DATASTACK_PTR
    sto A $monster_x
    ldm A $player_x
    stack A $DATASTACK_PTR
    ldm A $monster_x
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_19
    ldm A $monster_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $monster_x
:_main_if_end_19
    ldm A $player_x
    stack A $DATASTACK_PTR
    ldm A $monster_x
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_20
    ldm A $monster_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $monster_x
:_main_if_end_20
    ldm A $player_y
    stack A $DATASTACK_PTR
    ldm A $monster_y
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_21
    ldm A $monster_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $monster_y
:_main_if_end_21
    ldm A $player_y
    stack A $DATASTACK_PTR
    ldm A $monster_y
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_22
    ldm A $monster_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $monster_y
:_main_if_end_22
    ldm A $monster_x
    stack A $DATASTACK_PTR
    ldm A $monster_y
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.tile_move
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.check_overlap
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_23
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $Special
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.update_tile_props
    ldm A $score
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_24
    ldm A $score
    stack A $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $score
    ldi A 1
    sto A $_score_dirty
:_main_if_end_24
    ldm A $t_special_time
    stack A $DATASTACK_PTR
    ldi A 90
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_25
    ldm A $t_special_time
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $t_special_time
:_main_if_end_25
    ldi A 100
    sto A $t_monster_cooldown
    jmp :_main_if_end_23
:_main_if_else_23
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldm A $Special
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.update_tile_props
:_main_if_end_23
:_main_if_end_18
:_main_if_end_17
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
    jmpt :_main_if_else_26
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_27
    ldm A $score
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $score
    ldi A 1
    sto A $_score_dirty
    ldi A 0
    sto A $t_coin
:_main_if_end_27
    jmp :_main_if_end_26
:_main_if_else_26
    ldm A $game_event
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_28
    call @check_the_walls
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_29
    ldm A $score
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_30
    ldi A 0
    sto A $score
    ldi A 1
    sto A $_score_dirty
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $Special
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.update_tile_props
    ldi A 200
    sto A $t_monster_cooldown
:_main_if_end_30
:_main_if_end_29
:_main_if_end_28
:_main_if_end_26
    ldm A $_score_dirty
    tst A 0
    jmpt :_main_if_end_31
    ldm A $score
    stack A $DATASTACK_PTR
    call @print_score
    call @GAME.refresh
:_main_if_end_31
    ldm A $_coins_dirty
    tst A 0
    jmpt :_main_if_end_32
    ldm A $coins_remaining
    stack A $DATASTACK_PTR
    call @print_coins
    call @GAME.refresh
:_main_if_end_32
    call @GAME.redraw_all_moved_tiles
    jmp :_main_while_start_0
:_main_while_end_0
    call @game_over_sequence
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
@GAME.init_game_lib
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
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
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
    ldi A 10
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
    ldi A 8
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
    ldi A 9
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
    ldi A 10
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
    ldi A 10
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
@GAME.check_overlap
    ustack A $DATASTACK_PTR
    sto A $moving_tile_id
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $moving_tile_id
    stack A $DATASTACK_PTR
    ldi A 10
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
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $pot_x
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    sto A $pot_y
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
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
:GAME.check_overlap_while_start_5
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $active_tile_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.check_overlap_while_end_5
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $moving_tile_id
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.check_overlap_if_end_6
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 10
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
    jmpt :GAME.check_overlap_if_end_7
    jmp :overlap_not_found
:GAME.check_overlap_if_end_7
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
    jmpt :GAME.check_overlap_if_end_8
    jmp :overlap_not_found
:GAME.check_overlap_if_end_8
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
    jmpt :GAME.check_overlap_if_end_9
    jmp :overlap_not_found
:GAME.check_overlap_if_end_9
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
    jmpt :GAME.check_overlap_if_end_10
    jmp :overlap_not_found
:GAME.check_overlap_if_end_10
    ldm A $i
    stack A $DATASTACK_PTR
    jmp :overlap_check_end
:overlap_not_found
:GAME.check_overlap_if_end_6
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :GAME.check_overlap_while_start_5
:GAME.check_overlap_while_end_5
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
:overlap_check_end
    ret
@GAME.handle_input
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_else_11
    ustack A $DATASTACK_PTR
    sto A $KEYvalue
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $KEYBOARD_TILE
    stack A $DATASTACK_PTR
    ldi A 10
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
    jmpt :GAME.handle_input_if_end_12
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $current_y
:GAME.handle_input_if_end_12
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 50
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_13
    ldm A $current_y
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_y
:GAME.handle_input_if_end_13
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 52
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_14
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $current_x
:GAME.handle_input_if_end_14
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 54
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_15
    ldm A $current_x
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $current_x
:GAME.handle_input_if_end_15
    ldm A $KEYvalue
    stack A $DATASTACK_PTR
    ldi A 27
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_16
    ldi A 0
    sto A $GAME.running
:GAME.handle_input_if_end_16
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
    jmpt :GAME.handle_input_if_end_17
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
:GAME.handle_input_if_end_17
    ldm A $collided_id
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.handle_input_if_end_18
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
    jmpt :GAME.handle_input_if_end_19
    ldm A $KEYBOARD_TILE
    sto A $EVENT_ACTOR
    ldm A $collided_id
    sto A $EVENT_TARGET
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $collided_id
    stack A $DATASTACK_PTR
    ldi A 10
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
:GAME.handle_input_if_end_19
:GAME.handle_input_if_end_18
    jmp :GAME.handle_input_if_end_11
:GAME.handle_input_if_else_11
    ldi A 0
    sto A $PLAYER_IS_BLOCKED
:GAME.handle_input_if_end_11
    ret
@GAME.redraw_all_moved_tiles
    ldi A 0
    sto A $i
    ldi A 0
    sto A $any_tile_moved
    ldi A 0
    sto A $temp_ptr
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
    ldi A 10
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
    jmpt :GAME.redraw_all_moved_tiles_if_end_20
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
    ldi A 8
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr2
    ldm I $temp_ptr2
    ldx A $_start_memory_
    sto A $old_w
    ldm A $tile_obj_ptr
    stack A $DATASTACK_PTR
    ldi A 9
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
:GAME.redraw_all_moved_tiles_if_end_20
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :GAME.redraw_all_moved_tiles_while_start_6
:GAME.redraw_all_moved_tiles_while_end_6
    ldi A 0
    sto A $i
:GAME.redraw_all_moved_tiles_while_start_7
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $active_tile_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.redraw_all_moved_tiles_while_end_7
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 10
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
    jmpt :GAME.redraw_all_moved_tiles_if_end_21
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
    ldi A 8
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
    ldi A 9
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr2
    ldm A $current_h
    ld B A
    ldm I $temp_ptr2
    stx B $_start_memory_
:GAME.redraw_all_moved_tiles_if_end_21
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :GAME.redraw_all_moved_tiles_while_start_7
:GAME.redraw_all_moved_tiles_while_end_7
    ldm A $any_tile_moved
    tst A 0
    jmpt :GAME.redraw_all_moved_tiles_if_end_22
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
:GAME.redraw_all_moved_tiles_if_end_22
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
    ldi A 10
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
@GAME.delete_tile
    ustack A $DATASTACK_PTR
    sto A $tile_id
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 10
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
@GAME.get_color
    ustack A $DATASTACK_PTR
    sto A $tile_id
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 5
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@GAME.get_xy
    ustack A $DATASTACK_PTR
    sto A $tile_id
    ldi A 0
    sto A $temp_ptr
    ldi A 0
    sto A $tile_base_prt
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 10
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
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm A $tile_base_prt
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $temp_ptr
    ldm I $temp_ptr
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ret
@GAME.draw_all_tiles
    ldi A 0
    sto A $i
:GAME.draw_all_tiles_while_start_8
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $active_tile_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.draw_all_tiles_while_end_8
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
    jmp :GAME.draw_all_tiles_while_start_8
:GAME.draw_all_tiles_while_end_8
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
    jmpt :GAME.process_events_if_end_23
    ldm A $EVENT_TYPE
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.process_events_if_end_24
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $EVENT_TARGET
    stack A $DATASTACK_PTR
    jmp :process_events_end
:GAME.process_events_if_end_24
    ldm A $EVENT_TYPE
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :GAME.process_events_if_end_25
    ldm A $EVENT_TARGET
    stack A $DATASTACK_PTR
    call @GAME.delete_tile
    ldi A 0
    sto A $temp_ptr
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $EVENT_ACTOR
    stack A $DATASTACK_PTR
    ldi A 10
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
:GAME.process_events_if_end_25
:GAME.process_events_if_end_23
    ldm A $GAME_EVENT_NONE
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @_negate
:process_events_end
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
@GAME.is_timer_ready
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
    jmpt :GAME.is_timer_ready_if_else_26
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
    jmp :GAME.is_timer_ready_if_end_26
:GAME.is_timer_ready_if_else_26
    ldm A $cooldown
    ld B A
    ldm I $timer_ptr
    stx B $_start_memory_
    ldi A 1
    stack A $DATASTACK_PTR
:GAME.is_timer_ready_if_end_26
    ret
@GAME.tile_move
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
    ldi A 10
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
@GAME.update_tile_props
    ustack A $DATASTACK_PTR
    sto A $tile_id
    ustack A $DATASTACK_PTR
    sto A $new_data_ptr
    ustack A $DATASTACK_PTR
    sto A $new_color
    ustack A $DATASTACK_PTR
    sto A $new_reaction
    ldm A $tile_info
    stack A $DATASTACK_PTR
    ldm A $tile_id
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    mul B A
    ld A B
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $tile_obj_ptr
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

@rnd_xy1
    call @rt_rnd
    ldi A 25
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 27
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_rnd
    ldi A 24
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 35
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ret
@rnd_xy2
    call @rt_rnd
    ldi A 24
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 27
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    call @rt_rnd
    ldi A 23
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 35
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ret
@print_score
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 32
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ustack A $DATASTACK_PTR
    sto A $_score
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 203
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_score
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :print_score_if_else_0
    ldi A 45
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_score
    stack A $DATASTACK_PTR
    call @_negate
    ustack A $DATASTACK_PTR
    sto A $_score
    jmp :print_score_if_end_0
:print_score_if_else_0
    ldi A 43
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
:print_score_if_end_0
    ldm A $_score
    stack A $DATASTACK_PTR
    ldi A 100
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldi A 48
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_hunreds
    ldm A $_score
    stack A $DATASTACK_PTR
    ldi A 100
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldi A 48
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_tens
    ldm A $_score
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 48
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ones
    ldi A 27
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 203
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_hunreds
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 28
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 203
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_tens
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 29
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 203
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_ones
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    sto A $_score_dirty
    ret
@print_coins
    ldi A 49
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 32
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ustack A $DATASTACK_PTR
    sto A $_coins
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 203
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 42
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_coins
    stack A $DATASTACK_PTR
    ldi A 100
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldi A 48
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_hunreds
    ldm A $_coins
    stack A $DATASTACK_PTR
    ldi A 100
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldi A 48
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_tens
    ldm A $_coins
    stack A $DATASTACK_PTR
    ldi A 10
    ustack B $DATASTACK_PTR
    dmod B A
    stack A $DATASTACK_PTR
    ldi A 48
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $_ones
    ldi A 50
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 203
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_hunreds
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 51
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 203
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_tens
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 52
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $background
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 203
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $_ones
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 0
    sto A $_coins_dirty
    ret
@check_and_update_color
    ustack A $DATASTACK_PTR
    sto A $_data_ptr
    ustack A $DATASTACK_PTR
    sto A $_cost
    ustack A $DATASTACK_PTR
    sto A $_tile_id
    stack A $DATASTACK_PTR
    call @GAME.get_color
    ustack A $DATASTACK_PTR
    sto A $_current_color
    ldm A $score
    stack A $DATASTACK_PTR
    ldm A $_cost
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_and_update_color_if_else_1
    ldi A 8
    stack A $DATASTACK_PTR
    jmp :check_and_update_color_if_end_1
:check_and_update_color_if_else_1
    ldi A 13
    stack A $DATASTACK_PTR
:check_and_update_color_if_end_1
    ustack A $DATASTACK_PTR
    sto A $_target_color
    ldm A $_current_color
    stack A $DATASTACK_PTR
    ldm A $_target_color
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_and_update_color_if_end_2
    ldi A 0
    stack A $DATASTACK_PTR
    ldm A $_target_color
    stack A $DATASTACK_PTR
    ldm A $_data_ptr
    stack A $DATASTACK_PTR
    ldm A $_tile_id
    stack A $DATASTACK_PTR
    call @GAME.update_tile_props
:check_and_update_color_if_end_2
    ret
@update_wall_visuals
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $Roof
    stack A $DATASTACK_PTR
    call @check_and_update_color
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $ShortWall
    stack A $DATASTACK_PTR
    call @check_and_update_color
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $LongWall
    stack A $DATASTACK_PTR
    call @check_and_update_color
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldm A $ShortWall
    stack A $DATASTACK_PTR
    call @check_and_update_color
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldm A $LongWall
    stack A $DATASTACK_PTR
    call @check_and_update_color
    ret
@_is_wall_is_green
    call @GAME.get_color
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_eq
    ret
@are_all_walls_green
    ldi A 2
    stack A $DATASTACK_PTR
    call @_is_wall_is_green
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :are_all_walls_green_if_end_3
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :all_walls_are_not_green
:are_all_walls_green_if_end_3
    ldi A 3
    stack A $DATASTACK_PTR
    call @_is_wall_is_green
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :are_all_walls_green_if_end_4
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :all_walls_are_not_green
:are_all_walls_green_if_end_4
    ldi A 4
    stack A $DATASTACK_PTR
    call @_is_wall_is_green
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :are_all_walls_green_if_end_5
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :all_walls_are_not_green
:are_all_walls_green_if_end_5
    ldi A 5
    stack A $DATASTACK_PTR
    call @_is_wall_is_green
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :are_all_walls_green_if_end_6
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :all_walls_are_not_green
:are_all_walls_green_if_end_6
    ldi A 6
    stack A $DATASTACK_PTR
    call @_is_wall_is_green
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :are_all_walls_green_if_end_7
    ldi A 0
    stack A $DATASTACK_PTR
    jmp :all_walls_are_not_green
:are_all_walls_green_if_end_7
    ldi A 1
    stack A $DATASTACK_PTR
    jmp :check_walls_done
:all_walls_are_not_green
    ldi A 0
    stack A $DATASTACK_PTR
:check_walls_done
    ret
@check_the_walls
    ldi A 0
    sto A $_wall_cost
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_the_walls_if_else_8
    ldi A 10
    sto A $_wall_cost
    jmp :check_the_walls_if_end_8
:check_the_walls_if_else_8
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_the_walls_if_else_9
    ldi A 2
    sto A $_wall_cost
    jmp :check_the_walls_if_end_9
:check_the_walls_if_else_9
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_the_walls_if_else_10
    ldi A 3
    sto A $_wall_cost
    jmp :check_the_walls_if_end_10
:check_the_walls_if_else_10
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_the_walls_if_else_11
    ldi A 5
    sto A $_wall_cost
    jmp :check_the_walls_if_end_11
:check_the_walls_if_else_11
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_the_walls_if_end_12
    ldi A 8
    sto A $_wall_cost
:check_the_walls_if_end_12
:check_the_walls_if_end_11
:check_the_walls_if_end_10
:check_the_walls_if_end_9
:check_the_walls_if_end_8
    ldm A $_wall_cost
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_the_walls_if_end_13
    call @are_all_walls_green
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :check_the_walls_if_else_14
    ldi A 1
    sto A $player_won
    ldm A $interacted_id
    stack A $DATASTACK_PTR
    call @GAME.delete_tile
    ldm A $score
    stack A $DATASTACK_PTR
    ldm A $_wall_cost
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $score
    ldi A 1
    sto A $_score_dirty
    ldi A 0
    sto A $GAME.running
    jmp :check_the_walls_if_end_14
:check_the_walls_if_else_14
    ldm A $score
    stack A $DATASTACK_PTR
    ldm A $_wall_cost
    ustack B $DATASTACK_PTR
    sub B A
    ld A B
    sto A $score
    ldi A 1
    sto A $_score_dirty
:check_the_walls_if_end_14
:check_the_walls_if_end_13
    ret
@game_over_sequence
    ldi A 0
    sto A $i
:game_over_sequence_while_start_1
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $active_tile_count
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :game_over_sequence_while_end_1
    ldm A $i
    stack A $DATASTACK_PTR
    call @GAME.delete_tile
    ldm A $i
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $i
    jmp :game_over_sequence_while_start_1
:game_over_sequence_while_end_1
    ldm A $player_won
    tst A 0
    jmpt :game_over_sequence_if_else_33
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    ldm A $YouWonSprite
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.update_tile_props
    ldi A 36
    stack A $DATASTACK_PTR
    ldi A 47
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.tile_move
    jmp :game_over_sequence_if_end_33
:game_over_sequence_if_else_33
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $YouLostSprite
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.update_tile_props
    ldi A 36
    stack A $DATASTACK_PTR
    ldi A 47
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @GAME.tile_move
:game_over_sequence_if_end_33
    call @GAME.redraw_all_moved_tiles
    call @GAME.refresh
    ret

# .DATA

% $current_x 0
% $current_y 0
% $current_color 1
% $background 0
% $foreground 5
% $GAME_EVENT_NONE 0
% $active_tile_count 0
% $tile_info 0
% $KEYBOARD_TILE 0
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
% $new_data_ptr 0
% $new_color 0
% $new_reaction 0
% $actor_ptr 0
% $cooldown 0
% $timer_ptr 0
% $EVENT_TYPE 0
% $EVENT_TARGET 0
% $EVENT_ACTOR 0
% $EVENT_POTENTIAL_X 0
% $EVENT_POTENTIAL_Y 0
% $PLAYER_IS_BLOCKED 0
% $GAME.running 0
% $interacted_id 0
% $score 0
% $coins_remaining 20
% $player_won 0
% $_score_dirty 1
% $_coins_dirty 1
