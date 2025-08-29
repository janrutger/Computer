# Tokenizer and Parser (Refactored)

# --- Token Definitions ---
. $TOKEN_TYPE 1
. $TOKEN_VALUE 1
. $TOKEN_BUFFER_BASE 1
% $TOKEN_BUFFER_BASE \null
. $CMD_BUFFER_SCAN_PTR 1
% $CMD_BUFFER_SCAN_PTR 0

EQU ~TOKEN_NONE 0
EQU ~TOKEN_UNKNOWN 1
EQU ~TOKEN_CMD 2
EQU ~TOKEN_NUM 3
EQU ~TOKEN_VAR 4

. $current_part 8       ; max lentgh of a part is 8
. $current_part_base 1
% $current_part_base $current_part
. $current_part_ptr 1

# --- Main Tokenizer Routine ---
@init_tokenizer_buffer
    sto A $TOKEN_BUFFER_BASE
    sto Z $CMD_BUFFER_SCAN_PTR
    ret

@get_next_token
    ; --- Skip Whitespace ---
:skip_loop
    ldm I $CMD_BUFFER_SCAN_PTR
    ldx C $TOKEN_BUFFER_BASE
    tst C \space
    jmpf :found_token_start
    tst C \null
    jmpt :return_no_token
    
    ldm K $CMD_BUFFER_SCAN_PTR
    addi K 1
    sto K $CMD_BUFFER_SCAN_PTR
    jmp :skip_loop

:found_token_start
    ; --- Parse Token ---
    sto Z $current_part_ptr
:parse_loop
    ldm I $CMD_BUFFER_SCAN_PTR
    ldx C $TOKEN_BUFFER_BASE
    tst C \space
    jmpt :end_token
    tst C \null
    jmpt :end_token

    ; Add char to current_part
    ldm I $current_part_ptr
    stx C $current_part_base
    
    ; Increment current_part_ptr
    ldm K $current_part_ptr
    addi K 1
    sto K $current_part_ptr

    ; Increment scan pointer
    ldm K $CMD_BUFFER_SCAN_PTR
    addi K 1
    sto K $CMD_BUFFER_SCAN_PTR
    jmp :parse_loop

:end_token
    ldm I $current_part_ptr
    ldi M \null
    stx M $current_part_base

    ; --- Classify Token ---
    jmp :classify_token

:classify_token
    sto Z $LUT_INDEX

:str_table_loop
    inc I $LUT_INDEX
    tst I ~LUT_LEN
    jmpt :check_for_var_or_numeric
    ldx K $STR_TABLE_BASE
    ldx L $CMD_TABLE_BASE

    sto Z $current_part_ptr

    :current_part_loop
        inc I $current_part_ptr
        ldx A $current_part_base
        add I K
        ldx B $start_memory
        tste A B
        jmpf :str_table_loop
        tst B \null
        jmpt :return_cmd_token
        tst A \null
        jmpt :str_table_loop
        jmp :current_part_loop

:return_cmd_token
    ldi A ~TOKEN_CMD
    sto A $TOKEN_TYPE
    sto L $TOKEN_VALUE
    ret

:check_for_var_or_numeric
    sto Z $current_part_ptr
    ldm I $current_part_ptr
    ldx A $current_part_base

    tst A \null
    jmpt :return_no_token

    ; Check for variable
    ldi B \@
    tstg A B
    jmpf :check_for_numeric
    ldi B \Z
    tstg A B
    jmpt :check_for_numeric
    addi I 1
    ldx B $current_part_base
    tst B \null
    jmpf :return_unknown_token ; Not a single character, so not a var

    ; It is a var
    ldi B ~TOKEN_VAR
    sto B $TOKEN_TYPE
    sto A $TOKEN_VALUE
    ret

:check_for_numeric
    call @is_numeric
    jmpf :return_unknown_token

    ; It is a number
    ldi B ~TOKEN_NUM
    sto B $TOKEN_TYPE
    sto A $TOKEN_VALUE
    ret

:return_unknown_token
    ldi A ~TOKEN_UNKNOWN
    sto A $TOKEN_TYPE
    ret

:return_no_token
    ldi A ~TOKEN_NONE
    sto A $TOKEN_TYPE
    ret

# --- Helper Routines ---
@is_numeric
    ; Checks if the string in $current_part is a number.
    ; Output: Sets S flag to TRUE if numeric, FALSE otherwise.
    ; Output: Returns value in A
    ; Uses: A, B, I, K, L
    ldi K 1                 ; K = signflag 1=pos -1=neg
    ldi L 0                 ; L is temp result

    inc I $current_part_ptr ; get first char
    ldx A $current_part_base

:check_neg_sign
    tst A \-
    jmpf :check_pos_sign
    ldi K -1
    inc I $current_part_ptr
    ldx A $current_part_base
    jmp :is_numeric_loop

:check_pos_sign
    tst A \+
    jmpf :check_digit
    ldi K 1
    inc I $current_part_ptr
    ldx A $current_part_base
    jmp :is_numeric_loop

:is_numeric_loop
    tst A \null
    jmpt :is_numeric_yes

:check_digit
    ldi B \0
    subi B 1
    tstg A B
    jmpf :is_numeric_no
    ldi B \9
    tstg A B
    jmpt :is_numeric_no

:handle_valid_digit
    subi A 48
    muli L 10
    add L A
    inc I $current_part_ptr
    ldx A $current_part_base
    jmp :is_numeric_loop

:is_numeric_yes
    ld A L
    mul A K
    tste Z Z
    ret

:is_numeric_no
    tstg Z Z
    ret