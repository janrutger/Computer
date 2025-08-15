@kernel_entry
    ; This code will test the screen scrolling functionality
    ; by printing 1930 'X' characters, which is more
    ; than the 1920 characters the screen can hold.

    ldi B 2500     ; Y = loop counter
    ldi C \X       ; C = character to print

:print_loop
    call @print_char
    subi B 1
    tst B 0
    jmpf :print_loop

    ; After the loop, print a final message on a new line.
    ; To force a newline, we manually set the cursor's X position to 0.
    ldi X 0
    sto X $cursor_x

    ldi C \D
    call @print_char
    ldi C \O
    call @print_char
    ldi C \N
    call @print_char
    ldi C \E
    call @print_char

    ret