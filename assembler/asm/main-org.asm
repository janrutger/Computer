EQU ~device 2
EQU ~online 1
EQU ~offline 2

EQU ~setX 15
EQU ~setY 16
EQU ~draw 17

EQU ~deviceColor 13
EQU ~color 3
EQU ~deviceMode  14
EQU ~mode 1 

EQU ~char1 202
EQU ~char2 202


@main
    call @screen_on

    ldi K 80
    ldi L 60

    ldi X 0
    ldi Y 0

    call @setY

    :draw_loop
        call @setX
        call @draw1
        addi X 1
        tstg K X 
        jmpf :next_line

        call @setX
        call @draw2
        addi X 1
        tstg K X 
        jmpf :next_line

        jmp :draw_loop
    :next_line
        addi Y 1
        tstg L Y
        jmpf :end_main

        ldi X 0
        call @setY 
        jmp :draw_loop
:end_main
ret


@screen_on
    ldi A ~device

    ldi B ~online       
    ldi C 0
    ldi I 33
    int $INT_VECTORS

    ldi B ~deviceMode
    ldi C ~mode
    ldi I 33
    int $INT_VECTORS

    ldi B ~deviceColor
    ldi C ~color
    ldi I 33
    int $INT_VECTORS

    
    ret

@draw1
    ldi A ~device
    ldi B ~draw
    ldi C ~char1
    ldi I 33
    int $INT_VECTORS
    ret

@draw2
    ldi A ~device
    ldi B ~draw
    ldi C ~char2
    ldi I 33
    int $INT_VECTORS
    ret


@setX
    ; X contains X
    ldi A ~device
    ldi B ~setX
    ld C X
    ldi I 33
    int $INT_VECTORS
    ret

@setY
    ; Y contains Y
    ldi A ~device
    ldi B ~setY
    ld C Y
    ldi I 33
    int $INT_VECTORS
    ret


