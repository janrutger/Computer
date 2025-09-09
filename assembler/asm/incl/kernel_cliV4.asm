# 
EQU ~CMD_BUFFER_SIZE 80

. $CMD_BUFFER_BASE 1
% $CMD_BUFFER_BASE $CMD_BUFFER
. $CMD_BUFFER 80

. $CMD_BUFFER_PTR 1
% $CMD_BUFFER_PTR 0


# Define 26 vars (A .. Z)
. $STACKS_VARS 26                 ; A .. Z
. $STACKS_VARS_BASE 1
% $STACKS_VARS_BASE $STACKS_VARS



# define the Command sub-routines
@cli_cmd_cls
    #call @clear_screen
    ldi I ~SYS_CLEAR_SCREEN
    int $INT_VECTORS
    ret

@cli_cmd_quit
    ldi I ~SYS_EXIT
    int $INT_VECTORS



###################

@cli_main_loop                  ; CLI main loop
    ldi I ~SYS_GET_CHAR
    int $INT_VECTORS
    ldm C $SYSCALL_RETURN_STATUS    ; read the syscall return status

    tst C 1
    jmpt :char_available
    jmp @cli_main_loop
:char_available
    ldm C $SYSCALL_RETURN_VALUE     ; read the syscall return value

    jmp :store_char_in_buffer

:store_char_in_buffer
    ; C holds the character
    tst C \Return               ; check for last character of the line
    jmpt :cli_process_command_buffer
    tst C \BackSpace            ; check for backspace
    jmpt :cli_handle_backspace

    ; Check CMD BUFFER
    ldm I $CMD_BUFFER_PTR   ; Step 1: Load pointer value
    tst I ~CMD_BUFFER_SIZE  ; Step 2: Check if full
    jmpt @cli_main_loop     ; Step 3: drop value when buffer is full

    ; store char in CMD BUFFER (holds the input string)
    ; This part is only reached if buffer is NOT full
    inc I $CMD_BUFFER_PTR   
    stx C $CMD_BUFFER_BASE

    ; print the char and get an new one
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ; Print cursor
    ldi I ~SYS_PRINT_CURSOR
    int $INT_VECTORS
    jmp @cli_main_loop       ; Continue looping

:cli_handle_backspace
    ldm I $CMD_BUFFER_PTR
    tste I Z                 ; Z containts zero (0) by default
    jmpt @cli_main_loop      ; buffer empty, do nothing

    dec I $CMD_BUFFER_PTR    ; when not empty, go back one step

    ; Delete the cursor
    ldi I ~SYS_DEL_CURSOR
    int $INT_VECTORS

    ; Print the character
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    jmp @cli_main_loop

 
:cli_process_command_buffer
    ; received \Return, so cmd_buffer contains instructions, 
    ; CMD_BUFFER_PTR holds the length

    ; Delete the cursor
    ldi I ~SYS_DEL_CURSOR
    int $INT_VECTORS


    ; print the newline
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ; Terminate the command string, by write \null to the end
    ldi M \null
    inc I $CMD_BUFFER_PTR
    stx M $CMD_BUFFER_BASE      ; Terminate the command string

    ldm A $CMD_BUFFER_BASE      ; Set A to the command buffer for the executor
    ldm B $CMD_BUFFER_PTR       ; Set B to the command buffer pointer for the executor
    call @init_tokenizer_buffer  
    ;call @execute_command_buffer ; Using the 'old' executer
    ldi A 0         ; set execution mode to 0 (immediate) in A
    call @run_stacks

    sto Z $CMD_BUFFER_PTR       ; reset the buffer pointer

    ldi A $kernel_prompt        ; print the prompt
    ldi I ~SYS_PRINT_STRING
    int $INT_VECTORS

    ldi I ~SYS_PRINT_CURSOR     ; Print cursor
    int $INT_VECTORS

    jmp @cli_main_loop          ; Start over


; @execute_command_buffer
;     nop ; stub-code
; ret
; :executor_loop
;     call @get_next_token
;     ldm A $TOKEN_TYPE

;     tst A ~TOKEN_CMD
;     jmpt :execute_cmd_token

;     tst A ~TOKEN_NUM
;     jmpt :execute_num_token

;     tst A ~TOKEN_VAR
;     jmpt :execute_var_token

;     tst A ~TOKEN_UNKNOWN
;     jmpt :execute_unknown_token

;     tst A ~TOKEN_NONE
;     jmpt :executor_loop_end ; No more tokens

;     jmp :executor_loop ; Loop for next token

; :execute_cmd_token
;     ldm I $TOKEN_VALUE
;     callx $start_memory ; Call the command handler
;     jmp :executor_loop

; :execute_num_token
;     ldm A $TOKEN_VALUE
;     call @push_A ; Push the number to the stack
;     jmp :executor_loop

; :execute_var_token
;     ldm A $TOKEN_VALUE
;     call @push_A ; Push the variable to the stack
;     jmp :executor_loop

; :execute_unknown_token
;     call @error_invalid_cmd
;     jmp :executor_loop

; :executor_loop_end
;     ret