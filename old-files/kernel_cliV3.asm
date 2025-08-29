# 
EQU ~CMD_BUFFER_SIZE 80

. $CMD_BUFFER_BASE 1
% $CMD_BUFFER_BASE $CMD_BUFFER
. $CMD_BUFFER 80

. $CMD_BUFFER_PTR 1
% $CMD_BUFFER_PTR 0

; Command routine look up table
. $CMD_TABLE 10         ; room for 10 commands,  2 bytes per command
. $CMD_TABLE_BASE 1
% $CMD_TABLE_BASE $CMD_TABLE    

; Command string loop up table 
. $STR_TABLE 10         ; room for 10 commands,  2 bytes per command
. $STR_TABLE_BASE 1
% $STR_TABLE_BASE $STR_TABLE

. $LUT_INDEX 1
% $LUT_INDEX 0

. $LUT_LEN 1
% $CMD_TABLE @cli_cmd_cls @cli_cmd_quit @rt_add @rt_print_tos
% $STR_TABLE $CMD_CLS_STR $CMD_QUIT_STR $RT_ADD_STR $RT_PRINT_STR
EQU ~LUT_LEN 4


# Define the command strings
. $CMD_CLS_STR 4
% $CMD_CLS_STR \c \l \s \null

. $CMD_QUIT_STR 5
% $CMD_QUIT_STR \q \u \i \t \null 

. $RT_ADD_STR 2
% $RT_ADD_STR \+ \null

. $RT_PRINT_STR 2
% $RT_PRINT_STR \. \null

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

    sto Z $CMD_BUFFER_PTR       ; reset the buffer pointer

    # jmp :find_next_part_or_start_over



# compare input buffer string to string look up table
# Keep index
# run subroutine at from cmd loopup table
# when end of input buffer, loop back to beginning
# else loop back to compare input buffer again



# Find the (next) part of the input string
. $current_part 8       ; max lentgh of a part is 8
. $current_part_base 1
% $current_part_base $current_part
. $current_part_ptr 1

sto Z $current_part_ptr

:find_next_part_or_start_over
    inc I $CMD_BUFFER_PTR       ; is previous set back to zero
    ldx C $CMD_BUFFER_BASE      ; read the char in C 

    tst C \space
    jmpf :write_char_to_part
    
    ; if it is \space write \null to the part
    inc I $current_part_ptr
    stx M $current_part_base     ;   M should have \null

    jmp :compare_and_execute 

:write_char_to_part
    inc I $current_part_ptr
    stx C $current_part_base

    tst C \null                 ; don't mess with C
    jmpf :find_next_part_or_start_over

:compare_and_execute
    # compare $current_part to the string look up table
    sto Z $LUT_INDEX
    
:str_table_loop
    inc I $LUT_INDEX
    tst I ~LUT_LEN              ; test for last known command string
    jmpt :unknown_cmd
    ldx K $STR_TABLE_BASE       ; K holds the command string address
    ldx L $CMD_TABLE_BASE       ; L hold the handlers address

    sto Z $current_part_ptr

    :current_part_loop
        inc I $current_part_ptr
        ldx A $current_part_base    ; A hold input char
        
        add I K                     ; next char to compare  (K=absolute base adres)
        ldx B $start_memory         ; B = mem[$start_memory] + I
        
        tste A B                    ; check if equal
        jmpf :str_table_loop        ; not equal, try next string table loop

        tst B \null                 ; eq, Check for null terminator
        jmpt :cmd_execute           ; eq and end of cmd string, execute


        tst A \null                 ; Check for null terminator
        jmpt :str_table_loop        ; If not, continue string table loop


        jmp :current_part_loop
    

:cmd_execute
    ld I L                         ; I = L holds the handler absolute address
    push C                         ; Save C
    callx $start_memory            ; Call the handler
    pop C                          ; Restore C


    # check C if the part was the last part, by checking delimiter
    sto Z $current_part_ptr
    tst C \null  
    jmpf :find_next_part_or_start_over
    jmp :no_next_part 

:unknown_cmd                    ; maybe its an number
    sto Z $current_part_ptr     ; reset the buffer pointer
    call @is_numeric            ; call ATOI routine
                                ; return status bit, when true value in A 
                                ; When false no valid value in A 
    jmpf :check_last_part       ; is not numeric
    call @push_A                ; is numeric, push to DATASTACK

:check_last_part                ; by checking delimiter
    sto Z $current_part_ptr
    tst C \null  
    jmpf :find_next_part_or_start_over
    jmp :no_next_part 



:no_next_part
    sto Z $CMD_BUFFER_PTR       ; reset the buffer pointer

    ldi A $kernel_prompt        ; print the prompt
    ldi I ~SYS_PRINT_STRING
    int $INT_VECTORS

    ldi I ~SYS_PRINT_CURSOR     ; Print cursor
    int $INT_VECTORS

    jmp @cli_main_loop          ; Start over



# HELPER Routines for numeric input

@is_numeric
    ; Checks if the string in $current_part is a number.
    ; Output: Sets S flag to TRUE if numeric, FALSE otherwise.
    ; Output: Returns value in A
    ; Uses: A, B, I, K, L
    ldi K 1                 ; K = signflag 1=pos -1=neg
    ldi L 0                 ; L is temp result

    inc I $current_part_ptr ; get first char
    ldx A $current_part_base

:check_neg_sign             ; first char is -
    tst A \-                ; test for sign
    jmpf :check_pos_sign    ; check also for pos sign
    ldi K -1                ; set flag

    inc I $current_part_ptr ; get next char
    ldx A $current_part_base

    jmp :is_numeric_loop    ; goto loop

:check_pos_sign             ; first char is +
    tst A \+
    jmpf :check_digit       ; also not + sign, it can be an number
    ldi K 1                 ; set flag

    inc I $current_part_ptr ; get next char
    ldx A $current_part_base

    jmp :is_numeric_loop    ; goto loop

:is_numeric_loop
    # keep the current_part_ptr
    tst A \null             ; test for last char
    jmpt :is_numeric_yes    ; it must be numeric

:check_digit                ; check for valid digit
    ldi B \0                ; \0 .. \9
    subi B 1
    tstg A B
    jmpf :is_numeric_no     ; its not a number

    ldi B \9                ; \0 .. \9  
    tstg A B    
    jmpt :is_numeric_no     ; its not a number

:handle_valid_digit
    subi A 48               ; ASCII to int
    muli L 10               ; shift the result
    add L A                 ; add A to result

    inc I $current_part_ptr ; get next char
    ldx A $current_part_base

    jmp :is_numeric_loop



:is_numeric_yes
    ld A L          ; load result to return in A 
    mul A K         ; multiply by sign flag
    tste Z Z        ; Set S flag to true
    ret

:is_numeric_no
    tstg Z Z        ; Set S flag to false
    ret

