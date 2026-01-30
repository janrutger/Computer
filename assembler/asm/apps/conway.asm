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
. $counter 1
MALLOC $current_board 12288
MALLOC $next_board 13488
. $y_coord 1
. $x_coord 1
. $board_ptr 1
. $value_in 1
. $solid_block 1
. $last_color 1
. $current_color 1
. $_main_str_0 2

# .CODE
    stack Z $DATASTACK_PTR
    call @TIME.start
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
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    call @rt_udc_control
    call @test_glider_pattern
    call @test_pulsar_pattern
    call @copy_board2
:_main_while_start_5
    ldi A 1
    tst A 0
    jmpt :_main_while_end_5
    call @fast_draw_board
    stack Z $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A $_main_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldm A $counter
    stack A $DATASTACK_PTR
    call @rt_print_tos
    stack Z $DATASTACK_PTR
    call @TIME.start
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_6
    ldi A 27
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_7
    jmp :stop_conway
:_main_if_end_7
:_main_if_end_6
    call @compute_next_generation
    call @copy_board2
    ldm B $counter
    ldi A 1
    add A B
    sto A $counter
    jmp :_main_while_start_5
:_main_while_end_5
:stop_conway
    ret

# .FUNCTIONS
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
        ;ret
        ret
@get_cell_state
    ustack A $DATASTACK_PTR
    sto A $y_coord
    ustack A $DATASTACK_PTR
    sto A $x_coord
    ustack A $DATASTACK_PTR
    sto A $board_ptr
    stack A $DATASTACK_PTR
    ldm B $y_coord
    ldm A $WIDTH
    mul A B
    ustack B $DATASTACK_PTR
    add B A
    ldm A $x_coord
    add A B
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
    ldm B $y_coord
    ldm A $WIDTH
    mul A B
    ustack B $DATASTACK_PTR
    add B A
    ldm A $x_coord
    add A B
    sto A $p_current
    ldm A $value_in
    stack A $DATASTACK_PTR
    ldm A $p_current
    sto A $p_current
    ustack B $DATASTACK_PTR
    ldm I $p_current
    stx B $_start_memory_
    ret
@fast_draw_board
    ld A Z
    sto A $y
:fast_draw_board_while_start_0
    ldm A $y
    stack A $DATASTACK_PTR
    ldm A $HEIGHT
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :fast_draw_board_while_end_0
    ldm B $y
    ldm A $Y_OFFSET
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ld A Z
    sto A $x
:fast_draw_board_while_start_1
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $WIDTH
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :fast_draw_board_while_end_1
    ldi A $current_board
    stack A $DATASTACK_PTR
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $y
    stack A $DATASTACK_PTR
    call @get_cell_state
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :fast_draw_board_if_else_0
    ldi A 10
    stack A $DATASTACK_PTR
    jmp :fast_draw_board_if_end_0
:fast_draw_board_if_else_0
    ldi A 11
    stack A $DATASTACK_PTR
:fast_draw_board_if_end_0
    ustack A $DATASTACK_PTR
    sto A $current_color
    stack A $DATASTACK_PTR
    ldm A $last_color
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :fast_draw_board_if_end_1
    ldm A $current_color
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $current_color
    sto A $last_color
:fast_draw_board_if_end_1
    ldm B $x
    ldm A $X_OFFSET
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm A $solid_block
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldm B $x
    ldi A 1
    add A B
    sto A $x
    jmp :fast_draw_board_while_start_1
:fast_draw_board_while_end_1
    ldm B $y
    ldi A 1
    add A B
    sto A $y
    jmp :fast_draw_board_while_start_0
:fast_draw_board_while_end_0
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@compute_next_generation
    ld A Z
    sto A $y
:compute_next_generation_while_start_2
    ldm A $y
    stack A $DATASTACK_PTR
    ldm A $HEIGHT
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :compute_next_generation_while_end_2
    ld A Z
    sto A $x
:compute_next_generation_while_start_3
    ldm A $x
    stack A $DATASTACK_PTR
    ldm A $WIDTH
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :compute_next_generation_while_end_3
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
    ld A Z
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
    stack Z $DATASTACK_PTR
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
    ldm B $x
    ldi A 1
    add A B
    sto A $x
    jmp :compute_next_generation_while_start_3
:compute_next_generation_while_end_3
    ldm B $y
    ldi A 1
    add A B
    sto A $y
    jmp :compute_next_generation_while_start_2
:compute_next_generation_while_end_2
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
       ; ret
        ret
@test_random_board
    ld A Z
    sto A $i
:test_random_board_while_start_4
    ldm A $i
    stack A $DATASTACK_PTR
    ldm A $BOARD_SIZE
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :test_random_board_while_end_4
    call @rt_rnd
    ldi A 500
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :test_random_board_if_else_5
    stack Z $DATASTACK_PTR
    jmp :test_random_board_if_end_5
:test_random_board_if_else_5
    ldi A 1
    stack A $DATASTACK_PTR
:test_random_board_if_end_5
    ldi A $next_board
    ld B A
    ldm A $i
    add A B
    sto A $p_current
    ustack B $DATASTACK_PTR
    ldm I $p_current
    stx B $_start_memory_
    ldm B $i
    ldi A 1
    add A B
    sto A $i
    jmp :test_random_board_while_start_4
:test_random_board_while_end_4
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
@test_r_pentomino_pattern
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
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ret
@test_gosper_glider_gun_pattern
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 11
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    ldi A 9
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 9
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 23
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 23
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 25
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 25
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 25
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 25
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 35
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 35
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 36
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 36
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ret
@test_pulsar_pattern
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 23
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 24
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 12
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 18
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
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 23
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 24
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 23
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 24
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 19
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 21
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 26
    stack A $DATASTACK_PTR
    ldi A 20
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 23
    stack A $DATASTACK_PTR
    ldi A 22
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @set_cell_state
    ldi A $next_board
    stack A $DATASTACK_PTR
    ldi A 24
    stack A $DATASTACK_PTR
    ldi A 22
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
% $counter 0
% $solid_block 203
% $last_color 999
% $_main_str_0 \space \null
