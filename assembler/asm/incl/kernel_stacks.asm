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
    call @_2_compile_phase
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
:step
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


    :not_a_label
        ldm K $CODE_LOCATION_COUNTER   ; Get Location, and increment $CODE_LOCATION_COUNTER
        addi K 2                       ; Advance by 2 
        sto K $CODE_LOCATION_COUNTER   ; Save the new Location Pointer

        jmp :1_scan_loop               ; if not a label; go for the next token

:end_1_scan_phase
:debug 
ret

@_2_compile_phase
    nop
ret

@_3_execution_phase
    nop
ret


##### HELPERS

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