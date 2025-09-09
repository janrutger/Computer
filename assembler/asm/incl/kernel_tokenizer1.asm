# Tokenizer and Parser (Refactored)
# This file contains the tokenizer and parser for the assembly language.
# It is responsible for breaking down a line of code into tokens that can be understood by the interpreter.

# --- Token Definitions ---
. $TOKEN_TYPE 1             ; Variable to store the type of the last token found
. $TOKEN_VALUE 1            ; Variable to store the value of the last token (e.g., numeric value or command jump adres)
. $TOKEN_ID 1               ; variable to store the ID of the token
. $TOKEN_BUFFER_BASE 1      ; Base address of the input string buffer
% $TOKEN_BUFFER_BASE \null  ; Initialize the buffer with a null terminator
. $CMD_BUFFER_SCAN_PTR 1    ; Pointer to the current position in the input string buffer
% $CMD_BUFFER_SCAN_PTR 0    ; Initialize the scan pointer to the beginning of the buffer

# --- Token Type Constants ---
EQU ~TOKEN_NONE 0           ; No token found
EQU ~TOKEN_UNKNOWN 1        ; Unknown token
EQU ~TOKEN_CMD 2            ; Command token
EQU ~TOKEN_NUM 3            ; Numeric token
EQU ~TOKEN_VAR 4            ; Variable token (A-Z)
EQU ~TOKEN_LABEL 5          ; Label token

# --- Current Token Buffer ---
. $current_part 25          ; Buffer to store the current token being parsed (max length 24 chars + \null)
. $current_part_base 1      ; Base address of the current token buffer
% $current_part_base $current_part ; Set the base address to the start of the buffer
. $current_part_ptr 1       ; Pointer to the current position in the token buffer

; # --- Current Label Buffer ---
; . $current_label 9           ; Buffer to store the current label being parsed (max length 8 chars + \null)
; . $current_label_base 1      ; Base address of the current label buffer
; % $current_label_base $current_label ; Set the base address to the start of the buffer
; . $current_label_ptr 1       ; Pointer to the current position in the label buffer

# --- Main Tokenizer Routine ---

# Initializes the tokenizer with the input string.
# Input: A = address of the input string
@init_tokenizer_buffer
    sto A $TOKEN_BUFFER_BASE    ; Store the input string address
    sto Z $CMD_BUFFER_SCAN_PTR  ; Reset the scan pointer
    ret

# Scans the input string and returns the next token.
@get_next_token
    ; --- Skip Whitespace ---
:skip_loop
    ldm I $CMD_BUFFER_SCAN_PTR  ; Load the scan pointer
    ldx C $TOKEN_BUFFER_BASE    ; Load the character at the scan pointer
    tst C \space                ; Test if the character is a space
    jmpf :found_token_start     ; If not a space, start parsing the token
    tst C \null                 ; Test if the character is a null terminator
    jmpt :return_no_token       ; If null, there are no more tokens
    
    ; --- Move to the next character ---
    ldm K $CMD_BUFFER_SCAN_PTR  ; Load the scan pointer
    addi K 1                    ; Increment the scan pointer
    sto K $CMD_BUFFER_SCAN_PTR  ; Store the updated scan pointer
    jmp :skip_loop              ; Continue skipping whitespace

:found_token_start
    ; --- Parse Token ---
    sto Z $current_part_ptr     ; Reset the current token buffer pointer
:parse_loop
    ldm I $CMD_BUFFER_SCAN_PTR  ; Load the scan pointer
    ldx C $TOKEN_BUFFER_BASE    ; Load the character at the scan pointer
    tst C \space                ; Test if the character is a space
    jmpt :end_token             ; If it is a space, the token has ended
    tst C \null                 ; Test if the character is a null terminator
    jmpt :end_token             ; If it is a null terminator, the token has ended

    ; --- Add character to the current token buffer ---
    ldm I $current_part_ptr     ; Load the current token buffer pointer
    stx C $current_part_base    ; Store the character in the buffer
    
    ; --- Increment current token buffer pointer ---
    ldm K $current_part_ptr     ; Load the pointer
    addi K 1                    ; Increment the pointer
    sto K $current_part_ptr     ; Store the updated pointer

    ; --- Increment scan pointer ---
    ldm K $CMD_BUFFER_SCAN_PTR  ; Load the scan pointer
    addi K 1                    ; Increment the scan pointer
    sto K $CMD_BUFFER_SCAN_PTR  ; Store the updated scan pointer
    jmp :parse_loop             ; Continue parsing the token

:end_token
    ; --- Null-terminate the current token ---
    ldm I $current_part_ptr     ; Load the current token buffer pointer
    ldi M \null                 ; Load a null terminator
    stx M $current_part_base    ; Store the null terminator at the end of the token

    ; --- Classify Token ---
    jmp :classify_token         ; Jump to the token classification routine

# Determines the type of the token in `$current_part`.
:classify_token
    sto Z $LUT_INDEX            ; Initialize the lookup table index

:str_table_loop
    ; --- Compare the token with the command lookup table ---
    inc I $LUT_INDEX            ; Increment the lookup table index
    tst I ~LUT_LEN              ; Check if we have reached the end of the table
    jmpt :check_for_var_or_numeric ; If so, check if the token is a variable or a number
    ldx K $STR_TABLE_BASE       ; Load the base address of the string table
    ldx L $CMD_TABLE_BASE       ; Load the base address of the command table
    ldx M $ID_TABLE_BASE        ; load the cmd ID from the ID table


    sto Z $current_part_ptr     ; Reset the current token buffer pointer

    :current_part_loop
        ; --- Compare the token with the current entry in the string table ---
        inc I $current_part_ptr ; Increment the pointer to the current token buffer
        ldx A $current_part_base ; Load a character from the token
        add I K                 ; Calculate the address of the character in the string table
        ldx B $start_memory     ; Load the character from the string table
        tste A B                ; Test if the characters are equal
        jmpf :str_table_loop    ; If not, check the next entry in the string table
        tst B \null             ; Check if we have reached the end of the string in the table
        jmpt :return_cmd_token  ; If so, we have found a command token
        tst A \null             ; Check if we have reached the end of the token
        jmpt :str_table_loop    ; If so, the token is shorter than the command, so it's not a match
        jmp :current_part_loop  ; Continue comparing the next character

:return_cmd_token
    ; --- Return a command token ---
    ldi A ~TOKEN_CMD            ; Set the token type to command
    sto A $TOKEN_TYPE           ; Store the token type
    sto M $TOKEN_ID             ; Store the command ID
    sto L $TOKEN_VALUE          ; Store the command value
    ret

:check_for_var_or_numeric
    ; --- Check if the token is a variable or a number ---
    sto Z $current_part_ptr     ; Reset the current token buffer pointer
    ldm I $current_part_ptr     ; Load the pointer
    ldx A $current_part_base    ; Load the first character of the token

    tst A \null                 ; Check if the token is empty
    jmpt :return_no_token       ; If so, return no token

:check_for_label                ; --- Check for a label  ---
    ldi B \:                    ; Load :
    tste A B                    ; check if it is :
    jmpf :check_for_var         ; If not, it can't be a label

    ## This step is needed because the first check did not inc the pointer
    ## i keep it this way for compability reasons, so i advance here
    inc I $current_part_ptr     ; Move to the next character

    inc I $current_part_ptr     ; Move to the next character
    ldx A $current_part_base    ; Load the next character
    tst A \null                 ; Check if it is the end of the string
    jmpt :return_unknown_token  ; If so, it's not a single character, so not a label

    ldm A $current_part_base    ; Load the first character of the label
    addi A 1                    ; Skip : move to the next character
    call @hash_filename         ; borrowd from loader_vdisk_routines
                                ; returns the hask in A

    ; sto Z $current_label_ptr    ; Reset the current label buffer pointer

    ; :label_loop                 ; when entering A holds the first char of the label
    ;     inc I $current_label_ptr    ; 
    ;     stx A $current_label_base   ; Store the character in the label buffer

    ;     inc I $current_part_ptr     ; Move to the next character
    ;     ldx A $current_part_base    ; Load the next character
    ;     tst A \null                 ; Check if it is the end

    ;     jmpf :label_loop
    
    ; ; ldi A \null                   ; A is already \null here
    ; inc I $current_label_ptr    ; Move to the next character
    ; stx A $current_label_base   ; Store the null terminator in the label buffer

    ; --- It is a label ---

    ldi B ~TOKEN_LABEL          ; Set the token type to label
    sto B $TOKEN_TYPE           ; Store the token type
    ldi B ~label                ; Set the token ID to label
    sto B $TOKEN_ID             ; Store the label ID
    sto A $TOKEN_VALUE          ; Store the label value (A hold hash value)


    ; sto Z $current_label_ptr    ; Reset the current label buffer pointer
    ret
    
:check_for_var                  ; --- Check for a variable (A-Z) ---
    ldi B \@                    ; Load the character before 'A'
    tstg A B                    ; Test if the first character is greater than '@'
    jmpf :check_for_numeric     ; If not, it can't be a variable
    ldi B \Z                    ; Load the character 'Z'
    tstg A B                    ; Test if the first character is greater than 'Z'
    jmpt :check_for_numeric     ; If so, it can't be a variable
    addi I 1                    ; Move to the next character
    ldx B $current_part_base    ; Load the next character
    tst B \null                 ; Check if it is the end of the string
    jmpf :return_unknown_token  ; If not, it's not a single character, so not a variable

    ; --- It is a variable ---
    ldi B ~TOKEN_VAR            ; Set the token type to variable
    sto B $TOKEN_TYPE           ; Store the token type
    ldi B ~var 
    sto B $TOKEN_ID             ; Store the variable ID
    sto A $TOKEN_VALUE          ; Store the character code of the variable
    ret

:check_for_numeric
    ; --- Check if the token is a number ---
    call @is_numeric            ; Call the is_numeric helper routine
    jmpf :return_unknown_token  ; If it's not a number, return an unknown token

    ; --- It is a number ---
    ldi B ~TOKEN_NUM            ; Set the token type to number
    sto B $TOKEN_TYPE           ; Store the token type
    ldi B ~num
    sto B $TOKEN_ID             ; Store the number ID
    sto A $TOKEN_VALUE          ; Store the numeric value
    ret

:return_unknown_token           ; Any unkown string is an unkown identifier
    ; --- Return an unknown token ---
    ldi A ~TOKEN_UNKNOWN        ; Set the token type to unknown
    sto A $TOKEN_TYPE           ; Store the token type
    ldi A ~ident                ; Set the token ID to ident
    sto A $TOKEN_ID             ; Store the ident ID
    ldm A $current_part_base    ; load start adrs of the part string in A
    call @hash_filename         ; borrowd from loader_vdisk_routines
                                ; returns the hask in A
    sto A $TOKEN_VALUE          ; Store the hash value
    ret

:return_no_token
    ; --- Return no token ---
    ldi A ~TOKEN_NONE           ; Set the token type to none
    sto A $TOKEN_TYPE           ; Store the token type
    ret

# --- Helper Routines ---

# Checks if the string in `$current_part` is a number.
# Output: Sets S flag to TRUE if numeric, FALSE otherwise.
# Output: Returns value in A
# Uses: A, B, I, K, L
@is_numeric
    ldi K 1                     ; K = sign flag: 1 for positive, -1 for negative
    ldi L 0                     ; L = temporary result

    inc I $current_part_ptr     ; Get the first character
    ldx A $current_part_base

:check_neg_sign
    ; --- Check for a negative sign ---
    tst A \-                    ; Test if the character is '-'
    jmpf :check_pos_sign        ; If not, check for a positive sign
    ldi K -1                    ; Set the sign flag to negative
    inc I $current_part_ptr     ; Move to the next character
    ldx A $current_part_base
    jmp :is_numeric_loop

:check_pos_sign
    ; --- Check for a positive sign ---
    tst A \+                    ; Test if the character is '+'
    jmpf :check_digit           ; If not, check if it's a digit
    ldi K 1                     ; Set the sign flag to positive
    inc I $current_part_ptr     ; Move to the next character
    ldx A $current_part_base
    jmp :is_numeric_loop

:is_numeric_loop
    ; --- Loop through the remaining characters ---
    tst A \null                 ; Check if we have reached the end of the string
    jmpt :is_numeric_yes        ; If so, the string is a valid number

:check_digit
    ; --- Check if the character is a digit (0-9) ---
    ldi B \0                    ; Load '0'
    subi B 1                    ; Subtract 1 to check for less than '0'
    tstg A B                    ; Test if the character is less than '0'
    jmpf :is_numeric_no         ; If so, it's not a digit
    ldi B \9                    ; Load '9'
    tstg A B                    ; Test if the character is greater than '9'
    jmpt :is_numeric_no         ; If so, it's not a digit

:handle_valid_digit
    ; --- Convert the character to a digit and add it to the result ---
    subi A 48                   ; Convert ASCII to digit
    muli L 10                   ; Multiply the current result by 10
    add L A                     ; Add the new digit
    inc I $current_part_ptr     ; Move to the next character
    ldx A $current_part_base
    jmp :is_numeric_loop

:is_numeric_yes
    ; --- The string is a valid number ---
    ld A L                      ; Load the result into A
    mul A K                     ; Apply the sign
    tste Z Z                    ; Set the status flag to TRUE
    ret

:is_numeric_no
    ; --- The string is not a valid number ---
    tstg Z Z                    ; Set the status flag to FALSE
    ret
