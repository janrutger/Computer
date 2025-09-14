@error_invalid_cmd
    . $string_invalid_cmd 13
    % $string_invalid_cmd \I \n \v \a \l \i \d \space \c \m \d \Return \null
    ldi A $string_invalid_cmd
    call @print_error_string
    jmp :end_warning

@error_invalid_goto_label
    . $string_invalid_goto_label 20
    % $string_invalid_goto_label \I \n \v \a \l \i \d \space \g \o \t \o \space \l \a \b \e \l \Return \null
    ldi A $string_invalid_goto_label
    call @print_error_string
    jmp :end_warning

@errors_unkown_token
    . $string_unkown_token 15
    % $string_unkown_token \U \n \k \n \o \w \n \space \t \o \k \e \n \Return \null
    ldi A $string_unkown_token
    call @print_error_string
    jmp :end_warning

@errors_invalid_def_name
    . $string_invalid_def_name 17   
    % $string_invalid_def_name \I \n \v \a \l \i \d \space \d \e \f \n \a \m \e \Return \null
    ldi A $string_invalid_def_name
    call @print_error_string
    jmp :end_warning

@errors_invalid_def_body
    . $string_invalid_def_body 17
    % $string_invalid_def_body \I \n \v \a \l \i \d \space \d \e \f \b \o \d \y \Return \null
    ldi A $string_invalid_def_body
    call @print_error_string
    jmp :end_warning

@errors_unterminated_def
    . $string_unterminated_def 23
    % $string_unterminated_def \U \n \t \e \r \m \i \n \a \t \e \d \space \f \u \n \c \t \i \o \n \Return \null
    ldi A $string_unterminated_def
    call @print_error_string
    jmp :end_warning

@errors_fatal_invalid_syntax
    . $string_fatal_invalid_syntax 28
    % $string_fatal_invalid_syntax \F \a \t \a \l \space \i \n \v \a \l \i \d \space \s \y \n \t \a \x  \space \e \r \r \o \r \Return \null
    ldi A $string_fatal_invalid_syntax
    call @print_error_string
    jmp :end_fatal



@fatal_Invalid_instruction_error
    . $string_invalid_instruction 27
    % $string_invalid_instruction \I \n \v \a \l \i \d \space \i \n \s \t \r \u \c \t \i \o \n \space \e \r \r \o \r \Return \null
    ldi A $string_invalid_instruction
    call @print_error_string
    jmp :end_fatal

@error_wrong_filename
    . $string_wrong_filename 16
    % $string_wrong_filename \W \r \o \n \g \space \f \i \l \e \n \a \m \e \Return \null 
    ldi A $string_wrong_filename
    call @print_error_string
    jmp :end_warning


@error_fatal_disk_error
    . $string_disk_error 18
    % $string_disk_error \F \A \T \A \L \space \d \i \s \k \space \e \r \r \o \r \Return \null
    ldi A $string_disk_error
    call @print_error_string
    jmp :end_fatal


:end_warning
    ret


:end_fatal 
    :end_less
        nop
    jmp :end_less


@print_error_string       ; Syscall 24
    ; A holds the address of the string
    :loop
        ld I A              ; Load address from A into I (R0)
        ldx C $start_memory ; Load character from memory[start_memory + I] into C
        tst C \null         ; Check for null terminator
        jmpt :end_loop      ; If null, end loop

        call @print_char    ; Directly call print_char routine

        addi A 1            ; Increment string address
        jmp :loop           ; Continue loop
    :end_loop
    ret