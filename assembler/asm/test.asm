; Simple display test program
; Writes "TEST" to the screen and then halts.

. $VIDEO_MEM 1
% $VIDEO_MEM 14336

. $Cursor_x 1
% $Cursor_x 0

. $Cursor_y 1
% $Cursor_y 0


##########

LDI C 84     ; Load ASCII for 'T'
inc X $Cursor_x
inc Y $Cursor_y 
call @write_char

LDI C \E     ; Load ASCII for 'E'
inc X $Cursor_x
inc Y $Cursor_y 
call @write_char

LDI C \S     ; Load ASCII for 'S'
inc X $Cursor_x
inc Y $Cursor_y 
call @write_char

LDI C \T     ; Load ASCII for 'T'
inc X $Cursor_x
inc Y $Cursor_y 
call @write_char


HALT         ; Halt the CPU



######### 
EQU ~SCREEN_WIDTH 80
EQU ~SCREEN_HEIGHT 24

@write_char
    # expects cursor_x, Cursor_y
    # char to print in C

    # Check screen bounderies
    ldi M ~SCREEN_WIDTH ; Check X
    tstg M X 
    jmpt :check_y       ; jump when it fits
    ldi X 0             ; reset X
    sto X $Cursor_x
:check_y
    ldi M ~SCREEN_HEIGHT
    tstg M Y 
    jmpt :end_boundery_check
    ldi Y 0             ; reset Y
    sto Y $Cursor_y
:end_boundery_check

    # calculate screenpointer of X Y in I
    ldi I ~SCREEN_WIDTH
    mul I Y                 ; number of lines * width 
    add I X                 ; add the X position

    # write chr (C) to screen (memory)
    stx C $VIDEO_MEM

ret
