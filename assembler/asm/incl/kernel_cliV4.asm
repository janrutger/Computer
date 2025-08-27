# 
EQU ~CMD_BUFFER_SIZE 80

. $CMD_BUFFER_BASE 1
% $CMD_BUFFER_BASE $CMD_BUFFER
. $CMD_BUFFER 80

. $CMD_BUFFER_PTR 1
% $CMD_BUFFER_PTR 0

; Command routine look up table
. $CMD_TABLE 16         ; room for 16 commands,  1 bytes per command
. $CMD_TABLE_BASE 1
% $CMD_TABLE_BASE $CMD_TABLE    

; Command string loop up table 
. $STR_TABLE 16         ; room for 16 commands,  1 bytes per command
. $STR_TABLE_BASE 1
% $STR_TABLE_BASE $STR_TABLE

. $LUT_INDEX 1
% $LUT_INDEX 0

. $LUT_LEN 1
% $CMD_TABLE @cli_cmd_cls @cli_cmd_quit @rt_add @rt_print_tos @interpreter_start @rt_stacks_cmd_list @rt_stacks_cmd_run @rt_next @rt_store_var @rt_restore_var
% $STR_TABLE $CMD_CLS_STR $CMD_QUIT_STR $RT_ADD_STR $RT_PRINT_STR $CMD_STACKS_STR $CMD_LIST_STR $CMD_RUN_STR $RT_NEXT_STR $RT_STORE_VAR $RT_RESTORE_VAR

EQU ~LUT_LEN 10

# Define 26 vars (A .. Z)
. $STACKS_VARS 26                 ; A .. Z
. $STACKS_VARS_BASE 1
% $STACKS_VARS_BASE $STACKS_VARS


# Define the command strings
. $CMD_CLS_STR 4
% $CMD_CLS_STR \c \l \s \null

. $CMD_QUIT_STR 5
% $CMD_QUIT_STR \q \u \i \t \null 

. $CMD_STACKS_STR 7
% $CMD_STACKS_STR \s \t \a \c \k \s \null

. $CMD_LIST_STR 5
% $CMD_LIST_STR \l \i \s \t \null

. $CMD_RUN_STR 4
% $CMD_RUN_STR \r \u \n \null

. $RT_ADD_STR 2
% $RT_ADD_STR \+ \null

. $RT_PRINT_STR 2
% $RT_PRINT_STR \. \null

. $RT_STORE_VAR 2
% $RT_STORE_VAR \! \null

. $RT_RESTORE_VAR 2
% $RT_RESTORE_VAR \@ \null

. $RT_NEXT_STR 5
% $RT_NEXT_STR \n \e \x \t \null


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
    #call @print_char         ; Print the character
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
    #call @print_char         ; Print the character
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ; Terminate the command string, by write \null to the end
    ldi M \null
    inc I $CMD_BUFFER_PTR
    stx M $CMD_BUFFER_BASE      ; Terminate the command string

    ldm A $CMD_BUFFER_BASE      ; EXECUTE Command string
    call @tokenize_and_execute

    sto Z $CMD_BUFFER_PTR       ; reset the buffer pointer

    ldi A $kernel_prompt        ; print the prompt
    ldi I ~SYS_PRINT_STRING
    int $INT_VECTORS

    ldi I ~SYS_PRINT_CURSOR     ; Print cursor
    int $INT_VECTORS

    jmp @cli_main_loop          ; Start over

