@error_invalid_cmd
    . $string_invalid_cmd 12
    % $string_invalid_cmd \I \n \v \a \l \i \d \space \c \m \d \null

    ldi A $string_invalid_cmd
    ldi I ~SYS_PRINT_STRING
    int $INT_VECTORS
    jmp :end_warning



:end_warning
    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS
    ret


:end_fatal 
    halt