# Tokenizer and Parser

. $TOKEN_BUFFER_BASE 1
% $TOKEN_BUFFER_BASE 0
. $TOKEN_BUFFER_PTR 1
% $TOKEN_BUFFER_PTR 0

@tokenize_and_execute
; Expects the starting address of the string to be parsed in register A
    sto A $TOKEN_BUFFER_BASE      ; Store the address of the string to be parsed
    sto Z $TOKEN_BUFFER_PTR       ; reset the buffer pointer

# Find the (next) part of the input string
. $current_part 8       ; max lentgh of a part is 8
. $current_part_base 1
% $current_part_base $current_part
. $current_part_ptr 1

    sto Z $current_part_ptr

:find_next_part_or_start_over
    inc I $TOKEN_BUFFER_PTR       ; is previous set back to zero
    ldx C $TOKEN_BUFFER_BASE      ; read the char in C 

    tst C \space
    jmpf :write_char_to_part
    
    ; if it is \space write \null to the part
    ldi M \null
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

:unknown_cmd                    ; maybe its an VAR or a number
    sto Z $current_part_ptr     ; reset the buffer pointer

:check_for_var
    ldm I $current_part_ptr
    ldx A $current_part_base    ; read value from stack
                                ; check if this an single VAR
    ldi B \@                
    tstg A B                    ; From A
    jmpf :check_for_numeric     ; not a var A .. Z
    ldi B \Z                    ; including Z 
    tstg A B
    jmpt :check_for_numeric     ; not a VAR A .. Z
    addi I 1                    ; increment index to next char
    ldx B $current_part_base    ; read value from stack
    tst B \null                 ; Compare with \null, to make sure its a single char var
    jmpf :check_last_part       ; Since first is an char, no need for numeric check

    call @push_A                ; place var (in A) on DATASTACK    
    jmp :check_last_part  


:check_for_numeric
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
    ret


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
    tst A \-
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
