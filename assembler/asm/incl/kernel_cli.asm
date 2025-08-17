EQU ~CMD_BUFFER_SIZE 80

. $CMD_BUFFER_BASE 1
% $CMD_BUFFER_BASE $CMD_BUFFER
. $CMD_BUFFER 80

. $CMD_BUFFER_PTR 1
% $CMD_BUFFER_PTR 0

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

    ldm M $CMD_BUFFER_PTR       ; save the lenght in M 
    sto Z $CMD_BUFFER_PTR       ; reset the buffer pointer

    ; check for 'cls' command
    inc I $CMD_BUFFER_PTR       ; get the first index
    ldx K $CMD_BUFFER_BASE      ; load the buffer into K
    tst K \c
    jmpf :cli_not_cls

    INC I $CMD_BUFFER_PTR       ; get the second index
    ldx K $CMD_BUFFER_BASE
    tst K \l
    jmpf :cli_not_cls

    INC I $CMD_BUFFER_PTR       ; get the third index
    ldx K $CMD_BUFFER_BASE
    tst K \s
    jmpf :cli_not_cls
    
    call @clear_screen          ; clear the screen
    jmp :cli_clear_cmd_buffer

:cli_not_cls
    ; unknown command
    ; just print a newline for now
    call @print_char

:cli_clear_cmd_buffer
    ; clear buffer
    sto Z $CMD_BUFFER_PTR
    jmp @cli_main_loop
