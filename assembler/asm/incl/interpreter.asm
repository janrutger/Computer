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
    ; Print welcome message
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

@stacks_main_loop
    ; Print line number
    ldm C $LINE_NUMBER
    call @print_line_number

    ; Print space
    ldi C \space
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ; Print initial cursor
    ldi I ~SYS_PRINT_CURSOR
    int $INT_VECTORS

:stacks_input_loop
    ldi I ~SYS_GET_CHAR
    int $INT_VECTORS
    ldm C $SYSCALL_RETURN_STATUS
    tst C 1
    jmpt :stacks_char_available
    jmp :stacks_input_loop

:stacks_char_available
    ldm C $SYSCALL_RETURN_VALUE
    jmp :stacks_store_char_in_buffer

:stacks_store_char_in_buffer
    tst C \Return
    jmpt :stacks_process_line_buffer
    tst C \BackSpace
    jmpt :stacks_handle_backspace

    ldm I $PROG_BUFFER_PTR
    tst I ~PROG_BUFFER_SIZE
    jmpt :stacks_input_loop ; Buffer full, ignore char

    inc I $PROG_BUFFER_PTR
    stx C $PROG_BUFFER_BASE

    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ldi I ~SYS_PRINT_CURSOR
    int $INT_VECTORS
    jmp :stacks_input_loop

:stacks_handle_backspace
    ldm I $PROG_BUFFER_PTR
    tste I Z
    jmpt :stacks_input_loop ; Buffer empty, do nothing

    dec I $PROG_BUFFER_PTR

    ldi I ~SYS_DEL_CURSOR
    int $INT_VECTORS
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS
    jmp :stacks_input_loop

:stacks_process_line_buffer
    ; Store line termination first
    ldi C \null
    inc I $PROG_BUFFER_PTR
    stx C $PROG_BUFFER_BASE

    ; Store the current PROG_BUFFER_PTR as the start of the next line
    ldm A $PROG_BUFFER_PTR          ; A = current PROG_BUFFER_PTR (end of current line)
    inc I $LINE_NUMBER              ; I = next line number, line number #1 is the index for line number #2
    stx A $LINE_INDEX_ARRAY_BASE    ; Store A at index I in LINE_INDEX_ARRAY

    ; delete initial cursor
    ldi I ~SYS_DEL_CURSOR
    int $INT_VECTORS

    ; Print newline
    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    jmp @stacks_main_loop


@print_line_number          ; print_number is already in use as symbol
    ; Prints number in C
    ldi I ~SYS_PRINT_NUMBER
    int $INT_VECTORS
    ret