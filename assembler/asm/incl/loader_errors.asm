@error_invalid_cmd
    . $string_invalid_cmd 13
    % $string_invalid_cmd \I \n \v \a \l \i \d \space \c \m \d \Return \null
    ldi A $string_invalid_cmd
    call @print_error_string
    jmp :end_warning



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
    halt


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