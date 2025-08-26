; STACKS Interpreter

EQU ~PROG_BUFFER_SIZE 512
. $PROG_BUFFER 512          ; ~PROG_BUFFER_SIZE
. $PROG_BUFFER_BASE 1
% $PROG_BUFFER_BASE $PROG_BUFFER

. $PROG_BUFFER_PTR 1
% $PROG_BUFFER_PTR 0

EQU ~MAX_LINES 64
. $LINE_INDEX_ARRAY 64      ; ~MAX_LINES
. $LINE_INDEX_ARRAY_BASE 1
% $LINE_INDEX_ARRAY_BASE $LINE_INDEX_ARRAY


. $LINE_NUMBER 1
% $LINE_NUMBER 1

. $STACKS_WELCOME_MSG 25
% $STACKS_WELCOME_MSG \S \T \A \C \K \S \space \v \0 \. \1 \Return \null

@interpreter_start
    ldm K $PROG_BUFFER_PTR
    tste K Z                    ; test is program already in buffer
    jmpf @stacks_main_loop

    # Print welcome message when buffer is empty and init 
        ldi A $STACKS_WELCOME_MSG
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS

        ; Print newline
        ldi C \Return
        ldi I ~SYS_PRINT_CHAR
        int $INT_VECTORS

        ; Initialize line number and first line index
        ldm I $LINE_NUMBER              ; current line number starts at 1
        subi I 1                        ; Substract one for correct indexing
        ldm K $PROG_BUFFER_PTR          ; 
        stx K $LINE_INDEX_ARRAY_BASE    ; Save K at index I 

        jmp @stacks_main_loop

@stacks_main_loop                       ; start a newline
    ; Print line number
    ldm C $LINE_NUMBER                  ; Print line number 
    call @print_line_number

    ldi C \space                        ; Print space   
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ldi I ~SYS_PRINT_CURSOR             ; Print cursor
    int $INT_VECTORS

:stacks_input_loop                     ; get next char on current line
    ldi I ~SYS_GET_CHAR                ; try to get a character
    int $INT_VECTORS
    ldm C $SYSCALL_RETURN_STATUS       ; read the syscall return status
    tst C 1
    jmpt :stacks_char_available        ; Proceed when char available
    jmp :stacks_input_loop             ; Loop when no char available


:stacks_char_available
    ldm C $SYSCALL_RETURN_VALUE
    jmp :stacks_store_char_in_buffer

:stacks_store_char_in_buffer
    tst C \Return                   ; check for end of line   
    jmpt :stacks_process_line_buffer

    tst C \BackSpace
    jmpt :stacks_handle_backspace

    tst C \ESC
    jmpf :do_store_char             ; store the char when is is not \ESC
                                    ; Check for first char on this line
    ldm I $LINE_NUMBER
    subi I 1                        ; get the right pointer by substracting 1
    ldx M $LINE_INDEX_ARRAY_BASE    ; get first index of this line 

    ldm L $PROG_BUFFER_PTR          ; get the current buffer pointer
    tste M L                        ; if on first char on the line
    jmpf :stacks_input_loop         ; ignore ESC if not the first char of the line
    jmp :stacks_handle_esc          ; otherwise do ESC


:do_store_char
    ldm I $PROG_BUFFER_PTR
    tst I ~PROG_BUFFER_SIZE
    jmpt :stacks_input_loop ; Buffer full, ignore char

    inc I $PROG_BUFFER_PTR
    stx C $PROG_BUFFER_BASE

    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ldi I ~SYS_PRINT_CURSOR
    int $INT_VECTORS
    jmp :stacks_input_loop          ; loop for next char on this line

:stacks_handle_backspace
    ldm I $PROG_BUFFER_PTR
    tste I Z
    jmpt :stacks_input_loop ; Buffer empty, do nothing

    dec I $PROG_BUFFER_PTR

    ldi I ~SYS_DEL_CURSOR
    int $INT_VECTORS
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS
    jmp :stacks_input_loop          ; loop for next char on this line



:stacks_process_line_buffer         ; when hitting \Return
    ; Store line termination first
    ldi C \null
    inc I $PROG_BUFFER_PTR
    stx C $PROG_BUFFER_BASE

    ; Store the current PROG_BUFFER_PTR as the start of the next line
    ldm A $PROG_BUFFER_PTR          ; A = current PROG_BUFFER_PTR (end of current line)
    inc I $LINE_NUMBER              ; I = current line number, line number #1 is the index for line number #2
    stx A $LINE_INDEX_ARRAY_BASE    ; Store A at index I in LINE_INDEX_ARRAY

    ; delete initial cursor
    ldi I ~SYS_DEL_CURSOR
    int $INT_VECTORS

    ; Print newline
    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    jmp @stacks_main_loop           ; loop for new line input


:stacks_handle_esc
    # handle escape key here 
    # for now, just return to cli 
    ldi I ~SYS_DEL_CURSOR          ; remove cursor
    int $INT_VECTORS

    ldi C \Return                  ; Print newline
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS
    
:stacks_cmd_input_loop                ; get next char on current line
    ldi I ~SYS_GET_CHAR               ; try to get a character
    int $INT_VECTORS
    ldm C $SYSCALL_RETURN_STATUS      ; read the syscall return status
    tst C 1
    jmpt :stacks_cmd_available        ; Proceed when char available
    jmp :stacks_cmd_input_loop        ; Loop when no char available

:stacks_cmd_available
    ldm C $SYSCALL_RETURN_VALUE       ; read the syscall return value
    tst C \x                          ; test for e(x)it 
    jmpt :handle_stacks_cmd_exit

    jmp @xstacks_main_loop            ; No valid stacks instruction, jump back to input loop


### stacks command routines here
:handle_stacks_cmd_exit
    ret                     ; Return to kernels CLI, as in exit but
                            ; Mostly returns back to :stacks_main_loop


@print_line_number          ; print_number is already in use as symbol
    ; Prints number in C
    ldi I ~SYS_PRINT_NUMBER
    int $INT_VECTORS
    ret

