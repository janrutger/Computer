EQU ~CMD_BUFFER_SIZE 80

. $CMD_BUFFER_BASE 1
% $CMD_BUFFER_BASE $CMD_BUFFER
. $CMD_BUFFER 80

. $CMD_BUFFER_PTR 1
% $CMD_BUFFER_PTR 0

; Command table
. $CMD_TABLE 20         ; room for 10 commands,  2 bytes per command
% $CMD_TABLE $CMD_CLS_STR @cli_cmd_cls $CMD_QUIT_STR @cli_cmd_quit
. $CMD_TABLE_BASE 1
% $CMD_TABLE_BASE $CMD_TABLE    

. $CMD_TABLE_INDEX 1
% $CMD_TABLE_INDEX 0

. $CMD_CLS_STR 4
% $CMD_CLS_STR \c \l \s \null

. $CMD_QUIT_STR 5
% $CMD_QUIT_STR \q \u \i \t \null 

@cli_main_loop               ; CLI main loop
    call @KBD_GET_CHAR       ; Call the routine to get a character
    jmpt :cli_char_available ; Branch if Status flag is set (character available)
    jmp @cli_main_loop       ; If no character, loop again

:cli_char_available
    ; C holds the character
    tst C \Return
    jmpt :cli_process_command
    tst C \BackSpace
    jmpt :cli_handle_backspace

    ; It's a printable character, add to buffer and print
    ldm I $CMD_BUFFER_PTR   ; Step 1: Load pointer value (e.g., 80)
    tst I ~CMD_BUFFER_SIZE  ; Step 2: Check if full
    jmpt @cli_main_loop     ; Step 3: Jump if full, without changing anything

    ; store char in buffer
    inc I $CMD_BUFFER_PTR   ; This part is only reached if buffer is NOT full
    stx C $CMD_BUFFER_BASE

    call @print_char         ; Print the character
    jmp @cli_main_loop       ; Continue looping

:cli_handle_backspace
    ldm I $CMD_BUFFER_PTR
    tste I Z                 ; Z containts zero (0) by default
    jmpt @cli_main_loop      ; buffer empty, do nothing

    dec I $CMD_BUFFER_PTR
    call @print_char
    jmp @cli_main_loop

:cli_process_command
    ; command is in CMD_BUFFER, CMD_BUFFER_PTR holds the length
    call @print_char ; print the newline

    ldi M \null
    inc I $CMD_BUFFER_PTR
    stx M $CMD_BUFFER_BASE      ; Terminate the command string

    sto Z $CMD_BUFFER_PTR       ; reset the buffer pointer

    ; Iterate through the command table
    sto Z $CMD_TABLE_INDEX    ; Z = 0

:cmd_table_loop
    inc I $CMD_TABLE_INDEX    ; I = 0, mem +1
    ldx K $CMD_TABLE_BASE     ; Get the command string address

    inc I $CMD_TABLE_INDEX    ; I = 1, mem +2
    ldx L $CMD_TABLE_BASE     ; Get the command handler address

    call @string_compare     ; Compare input with command string
    jmpt :cmd_found          ; If match, jump to handler

    ldm I $CMD_TABLE_INDEX   ; restore table index in I
    tst I 4                  ; Check if end of table
    jmpf :cmd_table_loop     ; If not, continue loop

    jmp :cli_unknown_command ; If no match, unknown command

:cmd_found
    ld I L                      ; I = L holds the handler absolute address
    callx $start_memory            ; Call the handler
    jmp :cli_clear_cmd_buffer   ; Clear the command buffer

# K = the absolute string pointer, L = handler pointer

@string_compare
    ; Compares the command buffer with the string at address K
    ; Returns with S flag set if strings are equal

    sto Z $CMD_BUFFER_PTR
:str_cmp_loop
    inc I $CMD_BUFFER_PTR
    ldx A $CMD_BUFFER_BASE

    add I K                 ; next char to compare  (K=absolute base adres)
    ldx B $start_memory     ; B = mem[$start_memory] + I
    tste A B    
    jmpf :str_cmp_not_equal

    tst B \null              ; Check for null terminator
    jmpt :str_cmp_equal      ; If null, strings are equal

    tst A \null             ; Check for null terminator
    jmpt :str_cmp_not_equal

    jmp :str_cmp_loop

:str_cmp_not_equal
    tstg A A
    ret

:str_cmp_equal
    tste A A
    ret

@cli_cmd_cls
    call @clear_screen
    ret

@cli_cmd_quit
    halt        ; just halt for now

:cli_unknown_command
    ; just print a newline for now, maybe errors later
    ; call @print_char ; or do nothing for a more clear output

:cli_clear_cmd_buffer
    ; clear buffer
    sto Z $CMD_BUFFER_PTR
    jmp @cli_main_loop