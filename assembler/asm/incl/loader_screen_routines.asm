##### PRINTING ROUTINES
# print char routine
# print char in C at x,y position on the screen
# keep track of globel x,y pointers
# after printing advance the x position
# check for end of line x=80
# perform newline
# check fullscreen, scroll screen one lines
# cursor stay on the last line

# set the globel screen cursor
. $cursor_x 1
. $cursor_y 1
% $cursor_x 0
% $cursor_y 0


@print_char
    # Read system cursorX cursorY
    ldm X $cursor_x
    ldm Y $cursor_y

    # char to write, hold in C 
    # check for \Return

    tst C \Return
    jmpt :do_print_Return
    tst C \BackSpace
    jmpt :do_print_BackSpace
    jmp :do_print_char


:do_print_Return
    ld X Z          ; reset X to zero
    addi Y 1        ; advance Y
    jmp :check_bounderies

:do_print_BackSpace
    tste X Z        ; check if X on first colom
    jmpt :print_char_done ; if so, do nothing

    subi X 1        ; Decrement X to move cursor back

    ; Now, erase the character at the new cursor position
    ldi C \space    ; Fill C with blank for erasing
    
    # calculate mem write pointer
    ldi I ~SCREEN_WIDTH
    mul I Y        ; Number of lines * width
    add I X        ; add the X possition

    stx C $VIDEO_MEM            ; write char in memory
    
    jmp :print_char_done

:do_print_char
    # calculate mem write pointer
    ldi I ~SCREEN_WIDTH
    mul I Y        ; Number of lines * width
    add I X        ; add the X possition

    stx C $VIDEO_MEM            ; write char in memory

    # advance X position and check bounderies
    addi X 1
    tst X ~SCREEN_WIDTH         ; Check X, 80 is next line
    jmpf :print_char_done   
    ldi X 0                     ; reset X, newline
    addi Y 1                    ; advance Y
:check_bounderies
    tst Y ~SCREEN_HEIGHT        ; Check Y, 24 is scrollline
    jmpf :print_char_done
    call @scroll_screen
    ldi Y 23                    ; reset Y, keep on the last line of the screen
                                ; X is alread set to 0, start of line
:print_char_done
    sto X $cursor_x     ; save new cursor_x
    sto Y $cursor_y     ; save new cursor_y

ret


@scroll_screen                  ; Scroll the screen one line
                                ; make the last line fill with blanks
    ldi K ~VIDEO_MEM            ; K = write pointer
    ldi L ~VIDEO_MEM            ;
    addi L ~SCREEN_WIDTH        ; L = read pointer


:scroll_screen_loop     ; loop to move one char 
    ld I L              ; Load the read pointer
    ldx M $start_memory ; read valu to move in M
    ld I K              ; load the write pointer
    stx M $start_memory ; store the value

    addi K 1            ; advance the write pointer  
    addi L 1            ; advance the read pointer

    tst L ~SCREEN_LAST_ADRES    ; test for end of video memory
    jmpf :scroll_screen_loop    ; jump to loop to move next char

    # calculate start of last line, to fill with blanks
    ldi M \space                ; fill M with blank char

    ; K is already at the start of the last line, no need to recalculate
    ld I K                      ; load the write pointer
    
:scroll_screen_blank_loop
    stx M $start_memory             ; write blank char
    addi I 1                        ; advance the write pointer
    tst I ~SCREEN_LAST_ADRES        ; test for end of video memory
    jmpf :scroll_screen_blank_loop  ; jump to loop to blank next position


ret
