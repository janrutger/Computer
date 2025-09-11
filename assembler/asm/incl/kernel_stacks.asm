#### Build in Stacks Interpreter for Stern-XT
# Expects:  the interpreter sees the correct buffer 
#           execution mode in A (0 = immediate 1 = progrsm mode)
# runs as subroutine

# Define stacks
# the datastack definition is replaced from os_loader to here
. $DATASTACK 16
. $DATASTACK_PTR 1
. $DATASTACK_INDEX 1
% $DATASTACK_INDEX 0
% $DATASTACK_PTR $DATASTACK

# to keep track of jump-adresses
. $PLACEHOLDER_STACK 16
. $PLACEHOLDER_STACK_PTR 1
. $PLACEHOLDER_STACK_INDEX 1
% $PLACEHOLDER_STACK_INDEX 0
% $PLACEHOLDER_STACK_PTR $PLACEHOLDER_STACK

# to jump back to the loop start
. $LOOP_STACK 16
. $LOOP_STACK_PTR 1
. $LOOP_STACK_INDEX 1
% $LOOP_STACK_INDEX 0
% $LOOP_STACK_PTR $LOOP_STACK


# I need some look-ups to match
# Lookup label addresses
EQU ~max_count_labels 32
. $LABEL_HASH_TABLE 32          ; ~max_count_labels
. $LABEL_HASH_TABLE_BASE 1
% $LABEL_HASH_TABLE_BASE $LABEL_HASH_TABLE

. $LABEL_ADRES_TABLE 32          ; ~max_count_labels
. $LABEL_ADRES_TABLE_BASE 1
% $LABEL_ADRES_TABLE_BASE $LABEL_ADRES_TABLE

. $LABEL_HASH_ADRES_INDEX 1
% $LABEL_HASH_ADRES_INDEX 0
. $LABEL_HASH_ADRES_PTR 1
% $LABEL_HASH_ADRES_PTR 0


# Lookup function addresses
. $FUNCTION_HASH_TABLE 32
. $FUNCTION_HASH_TABLE_BASE 1
% $FUNCTION_HASH_TABLE_BASE $FUNCTION_HASH_TABLE  

. $FUNCTION_ADRES_TABLE 32
. $FUNCTION_ADRES_TABLE_BASE 1
% $FUNCTION_ADRES_TABLE_BASE $FUNCTION_ADRES_TABLE

. $FUNCTION_HASH_ADRES_INDEX 1
% $FUNCTION_HASH_ADRES_INDEX 0

# And some buffer
MALLOC $CODE_BUFFER 5120         ; prog_start + PROG_BUFFER_SIZE
. $CODE_BUFFER_BASE 1
% $CODE_BUFFER_BASE $CODE_BUFFER
. $CODE_BUFFER_PTR 1
% $CODE_BUFFER_PTR 0



MALLOC $FUNCTION_BUFFER 5632     ; + 512

. $CODE_LOCATION_COUNTER 1
% $CODE_LOCATION_COUNTER 0




@run_stacks
    call @_store_registers

    # PROG_BUFFER scan pointer, used by the tokenizer1
    sto Z $CMD_BUFFER_SCAN_PTR  ; Make sure start at the beginning

    # check the mode
    tste A Z
    jmpt :run_immediate_mode
    jmp :run_program_mode

:run_immediate_mode
    call @_executed_immediate

    jmp :end_of_stacks_program

:run_program_mode
    call @_1_scan_phase
:run_compile
    call @_2_compile_phase
:run_execute
    call @_3_execution_phase    
    jmp :end_of_stacks_program

:end_of_stacks_program
    call @_restore_registers
ret



@_executed_immediate 
    :immediate_loop
        call @get_next_token
        ldm A $TOKEN_TYPE   ; A is Token type

        tst A ~TOKEN_UNKNOWN
        jmpt :unkown_token_found

        tst A ~TOKEN_NONE
        jmpt :end_of_immediate_loop

        ldm C $TOKEN_ID     ; C is Token ID
        ldi B ~label
        tstg C B            ; excluding ~label
        jmpf :invalid_immediate_command

        ldi B 299           ; last Keyword operator
        tstg C B
        jmpt :invalid_immediate_command

    :immediate_cmd_check
        tst A ~TOKEN_CMD    ; A is Token type
        jmpf :immediate_num_check
        call @_execute_cmd_token
        jmp :immediate_loop


    :immediate_num_check
        tst A ~TOKEN_NUM
        jmpf :immediate_var_check
        call @_execute_num_token
        jmp :immediate_loop


    :immediate_var_check
        tst A ~TOKEN_VAR
        jmpf :unkown_token_found
        call @_execute_var_token
        jmp :immediate_loop


    :invalid_immediate_command
        call @error_invalid_cmd
        jmp :immediate_loop

:unkown_token_found
    call @_execute_unknown_token      

:end_of_immediate_loop
ret

@_1_scan_phase
    sto Z $CMD_BUFFER_SCAN_PTR      ; Make sure the tokenizer1 start at the beginning
    sto Z $CODE_LOCATION_COUNTER    ; Make sure start at the beginning
    sto Z $LABEL_HASH_ADRES_INDEX   ; Make sure start at the beginning

    :1_scan_loop
        call @get_next_token
        ldm A $TOKEN_TYPE       ; A is Token type

        ldm B $TOKEN_ID
        ldi C ~cls
        tstg C B                ; includes [0 .. 99]
        jmpt :valid_program_token
        ldi C 199               
        tstg B C                ; exclude [100 .. 199]
        jmpt :valid_program_token

        call @fatal_Invalid_instruction_error
        # after a fatal, the computer is stopped

    :valid_program_token
        tst A ~TOKEN_NONE       ; no tokens anymore left
        jmpt :end_1_scan_phase  ; Jump to the end 

        tst A ~TOKEN_LABEL      ; test if it a label (where we searching for)
        jmpf :not_a_label       ; if not a label; go for the next token

        inc I $LABEL_HASH_ADRES_INDEX   ; get the current Index
        ldm K $CODE_LOCATION_COUNTER    ; K holds the current Location Counter
        stx K $LABEL_ADRES_TABLE_BASE   

        ldm A $TOKEN_VALUE              ; A holds the hash of the label
        stx A $LABEL_HASH_TABLE_BASE

        jmp :1_scan_loop                ; go for the next token


    ; :not_a_label
    ;     ldm K $CODE_LOCATION_COUNTER   ; Get Location, and increment $CODE_LOCATION_COUNTER
    ;     addi K 2                       ; Advance by 2 
    ;     sto K $CODE_LOCATION_COUNTER   ; Save the new Location Pointer

    ;     jmp :1_scan_loop               ; if not a label; go for the next token

    :not_a_label
        ; It's not a label, so it's part of an instruction.
        ; Check if it's a special instruction that consumes an argument.
        ldm B $TOKEN_ID
        tst B ~goto
        jmpt :handle_scan_goto

        ; --- Default case for simple tokens ---
        ; Most tokens correspond to a 2-word block in the bytecode.
        ldm K $CODE_LOCATION_COUNTER
        addi K 2
        sto K $CODE_LOCATION_COUNTER
        jmp :1_scan_loop

    :handle_scan_goto
        ; A 'goto <label>' sequence in the source becomes one 2-word
        ; instruction in the bytecode. So we advance the counter by 2.
        ldm K $CODE_LOCATION_COUNTER
        addi K 2
        sto K $CODE_LOCATION_COUNTER

        ; We must also consume the next token (the label identifier)
        ; from the token stream so we don't process it again.
        call @get_next_token

        jmp :1_scan_loop

:end_1_scan_phase
ret

@_2_compile_phase
    ; sto Z $CMD_BUFFER_SCAN_PTR    ; Make sure the tokenizer1 start at the beginning
    ldm A $PROG_BUFFER_BASE         ; load PROG_BUFFER
    ldm B $TOKEN_BUFFER_TOTAL_LEN   ; Restore the lenght of the buffer
    call @init_tokenizer_buffer     ; reinit tokenizer
    sto Z $CODE_BUFFER_PTR          ; make sure the code buffer start at the beginning

    :2_compile_loop
        call @get_next_token
        ldm A $TOKEN_TYPE               ; A is Token type

        tst A ~TOKEN_LABEL
        jmpt :2_compile_loop

        tst A ~TOKEN_NONE               ; no tokens anymore left
        jmpt :end_2_compile_phase       ; Jump to the end 

    :handle_num_token                   ; All num tokens are handle the same way
        tst A ~TOKEN_NUM
        jmpf :handle_var_token

        ; ldm A $TOKEN_ID
        ; inc I $CODE_BUFFER_PTR
        ; stx A $CODE_BUFFER_BASE
        ; ldm A $TOKEN_VALUE
        ; inc I $CODE_BUFFER_PTR
        ; stx A $CODE_BUFFER_BASE
        call @2_compile_generic_token
        jmp :2_compile_loop

    :handle_var_token
        tst A ~TOKEN_VAR
        jmpf :handle_cmd_token
        ; ldm A $TOKEN_ID
        ; inc I $CODE_BUFFER_PTR
        ; stx A $CODE_BUFFER_BASE
        ; ldm A $TOKEN_VALUE
        ; inc I $CODE_BUFFER_PTR
        ; stx A $CODE_BUFFER_BASE
        call @2_compile_generic_token
        jmp :2_compile_loop

    :handle_cmd_token
        tst A ~TOKEN_CMD
        jmpf :handle_unknown_token
        #check for complex token like gote, if .. else, while
        ldm B $TOKEN_ID
        tst B ~goto
        jmpt :handle_goto_cmd       ; must retrun to the :2_compile_loop


        #fall thru to the 'simple' tokens, like add and print
        # the all can be handled the same way
        ;ldm A $TOKEN_TYPE
        ; ldm A $TOKEN_ID
        ; inc I $CODE_BUFFER_PTR
        ; stx A $CODE_BUFFER_BASE
        ; ldm A $TOKEN_VALUE
        ; inc I $CODE_BUFFER_PTR
        ; stx A $CODE_BUFFER_BASE
        call @2_compile_generic_token

        jmp :2_compile_loop

    :handle_unknown_token
        tst A ~TOKEN_UNKNOWN
        jmpf :handle_fatal_token_error
        nop
        jmp :2_compile_loop

    :handle_fatal_token_error
        call @fatal_Invalid_instruction_error
        # Halts after fatal

:end_2_compile_phase
    inc I $CODE_BUFFER_PTR
    stx Z $CODE_BUFFER_BASE
ret

@_3_execution_phase
    sto Z $CODE_BUFFER_PTR          ; make sure the code buffer start at the beginning

    :3_execution_loop
        inc I $CODE_BUFFER_PTR
        ldx A $CODE_BUFFER_BASE     ; A contains TOKEN_TYPE
        tst A \null                 ; check for end of the tokens/prgram
        jmpt :end_3_execution_phase

        tst A ~num
        jmpt :3_execute_num_token   ; must jumpback to :3_execution_loop

        tst A ~var
        jmpt :3_execute_var_token   ; must jumpback to :3_execution_loop

        tst A ~add
        jmpt :3_execution_runtime_token  ; must jumpback to :3_execution_loop

        tst A ~sub
        jmpt :3_execution_runtime_token  ; must jumpback to :3_execution_loop

        tst A ~mul
        jmpt :3_execution_runtime_token  ; must jumpback to :3_execution_loop

        tst A ~div
        jmpt :3_execution_runtime_token  ; must jumpback to :3_execution_loop

        tst A ~mod
        jmpt :3_execution_runtime_token  ; must jumpback to :3_execution_loop

        tst A ~store                       ; ! instruction to store a var 
        jmpt :3_execution_runtime_token    ; must jumpback to :3_execution_loop

        tst A ~restore                     ; @ instruction to restore a var 
        jmpt :3_execution_runtime_token  ; must jumpback to :3_execution_loop

        tst A ~print
        jmpt :3_execution_runtime_token   ; must jumpback to :3_execution_loop

        tst A ~label
        jmpt :3_execution_label_token   ; must jumpback to :3_execution_loop

        tst A ~ident
        jmpt :3_execution_unknown_token ; must jumpback to :3_execution_loop

        tst A ~goto
        jmpt :3_execution_goto_token    ; must jumpback to :3_execution_loop

        tst A ~eq
        jmpt :3_execution_runtime_token      ; must jumpback to :3_execution_loop
        
        tst A ~neq
        jmpt :3_execution_runtime_token     ; must jumpback to :3_execution_loop

        tst A ~gt
        jmpt :3_execution_runtime_token      ; must jumpback to :3_execution_loop

        tst A ~lt
        jmpt :3_execution_runtime_token      ; must jumpback to :3_execution_loop


        ; If we get here, it means none of the above matched.
        ; This is an invalid token type in the bytecode.
        call @fatal_Invalid_instruction_error
        # Halts after fatal

:end_3_execution_phase
ret


##### HELPERS

#### Phase 2 compile helpers
:handle_goto_cmd
    call @get_next_token
    ldm A $TOKEN_ID
    tst A ~ident
    jmpf :error_goto_label

    ldm A $TOKEN_VALUE              ; A holds the hash of the label
    sto Z $LABEL_HASH_ADRES_PTR     ; start at 0
    ldm B $LABEL_HASH_ADRES_INDEX   ; the total

    :goto_loop
        inc I $LABEL_HASH_ADRES_PTR     ; get the current Index
        tstg B I                        ; test for last hash
        jmpf :error_goto_label          ; throw error when not found

        ldx C $LABEL_HASH_TABLE_BASE    ; read hash to Compare
        tste A C                        ; Compare hash labels
        jmpf :goto_loop                 ; check next if not equal
                                        ; if equal ...
        ldx B $LABEL_ADRES_TABLE_BASE   ; reads the adres from index I

        ldi A ~goto
        inc I $CODE_BUFFER_PTR
        stx A $CODE_BUFFER_BASE         ; write token ID to codebuffer

        inc I $CODE_BUFFER_PTR
        stx B $CODE_BUFFER_BASE         ; write label adres to codebuffer

        jmp :2_compile_loop

:end_handle_goto_cmd
    jmp :2_compile_loop

    :error_goto_label
        call @error_invalid_goto_label
        jmp :2_compile_loop

@2_compile_generic_token
    ldm A $TOKEN_ID
    inc I $CODE_BUFFER_PTR
    stx A $CODE_BUFFER_BASE
    ldm A $TOKEN_VALUE
    inc I $CODE_BUFFER_PTR
    stx A $CODE_BUFFER_BASE        
    ret


#### Phase 3 execution helpers
@3_execute_runtime_command
    inc I $CODE_BUFFER_PTR
    ldx A $CODE_BUFFER_BASE
    ld I A
    callx $start_memory
    ret

@3_execute_push_value
    inc I $CODE_BUFFER_PTR
    ldx A $CODE_BUFFER_BASE
    call @push_A
    ret

:3_execute_num_token
    ; inc I $CODE_BUFFER_PTR      ; Points to the value now
    ; ldx A $CODE_BUFFER_BASE     ; Reads the value in A
    ; call @push_A                ; Push the number to the stack
    call @3_execute_push_value
    jmp :3_execution_loop

:3_execute_var_token
    ; inc I $CODE_BUFFER_PTR      ; Points to the value now
    ; ldx A $CODE_BUFFER_BASE     ; Reads the value in A
    ; call @push_A                ; Push the number to the stack
    call @3_execute_push_value
    jmp :3_execution_loop

:3_execution_label_token        ; Phase 3 will never see an label token
    nop             ; for now a dummy
    jmp :3_execution_loop

:3_execution_unknown_token
    nop             ; for now a dummy
    jmp :3_execution_loop

; :3_execution_add_token
;     ; inc I $CODE_BUFFER_PTR
;     ; ldx A $CODE_BUFFER_BASE
;     ; ld I A 
;     ; callx $start_memory ; Call the command handler
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execution_sub_token
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execution_mul_token
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execution_div_token
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execution_mod_token
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execution_print_token
;     ; inc I $CODE_BUFFER_PTR
;     ; ldx A $CODE_BUFFER_BASE
;     ; ld I A 
;     ; callx $start_memory ; Call the command handler
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execute_store_var_token
;     ; inc I $CODE_BUFFER_PTR
;     ; ldx A $CODE_BUFFER_BASE
;     ; ld I A              ; I is pointer to command handler
;     ; callx $start_memory ; Call start_memory(0) + I
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execute_restore_var_token
;     ; inc I $CODE_BUFFER_PTR
;     ; ldx A $CODE_BUFFER_BASE
;     ; ld I A              ; I is pointer to command handler
;     ; callx $start_memory ; Call start_memory(0) + I
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

:3_execution_goto_token
    inc I $CODE_BUFFER_PTR
    ldx A $CODE_BUFFER_BASE     ; A contains new buffer_ptr
    sto A $CODE_BUFFER_PTR
    jmp :3_execution_loop

; :3_execution_eq_token
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execution_neq_token
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execution_gt_token
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

; :3_execution_lt_token
;     call @3_execute_runtime_command
;     jmp :3_execution_loop

# Generic executer for runtime tokens
:3_execution_runtime_token
    call @3_execute_runtime_command
    jmp :3_execution_loop




### Executers for the Immediate execution mode
@_execute_cmd_token
    ldm I $TOKEN_VALUE
    callx $start_memory ; Call the command handler
    ret

@_execute_num_token
    ldm A $TOKEN_VALUE
    call @push_A ; Push the number to the stack
    ret

@_execute_var_token
    ldm A $TOKEN_VALUE
    call @push_A ; Push the variable to the stack
    ret

@_execute_unknown_token
    call @errors_unkown_token
    ret


# other helpers

@_store_registers
# register Z remains 0 all the time
# never trust I rgeister
pop I       ; get return adres of this call

push A      ; Save all registers
push B
push C
push K 
push L
push M 
push X 
push Y 

push I      ; push return adres back to the stack
ret         ; return to main loop

@_restore_registers
# register Z remains 0 all the time
# never trust I rgeister
pop I       ; get return adres of this call

pop Y      ; restore all registers
pop X 
pop M
pop L  
pop K
pop C 
pop B 
pop A 

push I      ; push return adres back to the stack
ret         ; return to main loop