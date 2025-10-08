#### Build in Stacks Interpreter for Stern-XT
# Expects:  the interpreter sees the correct buffer 
#           execution mode in A (0 = immediate 1 = progrsm mode)
# runs as subroutine

# Define stacks
# the datastack definition is replaced from os_loader to here
# and i plaed it back for better Stacks compiler support
; . $DATASTACK 32
; . $DATASTACK_PTR 1
; . $DATASTACK_INDEX 1
; % $DATASTACK_INDEX 0
; % $DATASTACK_PTR $DATASTACK

# to keep track of jump-adresses
. $PLACEHOLDER_STACK 16     ;16 nested if else end or while do loop
. $PLACEHOLDER_STACK_PTR 1
. $PLACEHOLDER_STACK_INDEX 1
% $PLACEHOLDER_STACK_INDEX 0
% $PLACEHOLDER_STACK_PTR $PLACEHOLDER_STACK

# to jump back to the loop start
. $LOOP_STACK 16            ; 16 nested while loops
. $LOOP_STACK_PTR 1
. $LOOP_STACK_INDEX 1
% $LOOP_STACK_INDEX 0
% $LOOP_STACK_PTR $LOOP_STACK

# to keep track of the function return adres
# and the code-base pointer at return
. $CALL_STACK 32            ; max 16 nesting calls deep
. $CALL_STACK_PTR 1
. $CALL_STACK_INDEX 1
% $CALL_STACK_INDEX 0
% $CALL_STACK_PTR $CALL_STACK



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
. $FUNCTION_HASH_ADRES_PTR 1
% $FUNCTION_HASH_ADRES_PTR 0

# And some buffer
MALLOC $CODE_BUFFER 5120         ; prog_start + PROG_BUFFER_SIZE
. $CODE_BUFFER_BASE 1
% $CODE_BUFFER_BASE $CODE_BUFFER
. $CODE_BUFFER_PTR 1
% $CODE_BUFFER_PTR 0



MALLOC $FUNCTION_BUFFER 5632     ; + 512
. $FUNCTION_BUFFER_BASE 1
% $FUNCTION_BUFFER_BASE $FUNCTION_BUFFER
. $FUNCTION_BUFFER_PTR 1
% $FUNCTION_BUFFER_PTR 0

. $PATCH_ADRES 1
. $CODE_LOCATION_COUNTER 1
% $CODE_LOCATION_COUNTER 0

# to save compiler pointers when compiling functions
. $COMPILER_STATE_STACK 16
. $COMPILER_STATE_STACK_PTR 1
. $COMPILER_STATE_STACK_INDEX 1
% $COMPILER_STATE_STACK_INDEX 0
% $COMPILER_STATE_STACK_PTR $COMPILER_STATE_STACK


# lookup tables for loading external libraries
# load max 4 libraries
## registraion tables
. $LIB_REG_HASH_TABLE 4
. $LIB_REG_HASH_TABLE_BASE 1
% $LIB_REG_HASH_TABLE_BASE $LIB_REG_HASH_TABLE

. $LIB_REG_ADRES_TABLE 4
. $LIB_REG_ADRES_TABLE_BASE 1
% $LIB_REG_ADRES_TABLE_BASE $LIB_REG_ADRES_TABLE

. $LIB_REG_HASH_ADRES_PTR 1
% $LIB_REG_HASH_ADRES_PTR 0
##

## Lib function tables
## In total 32 functions for all 4 libraries
. $LIB_FUNC_HASH_TABLE 32
. $LIB_FUNC_HASH_TABLE_BASE 1
% $LIB_FUNC_HASH_TABLE_BASE $LIB_FUNC_HASH_TABLE

. $LIB_FUNC_ADRES_TABLE 32
. $LIB_FUNC_ADRES_TABLE_BASE 1
% $LIB_FUNC_ADRES_TABLE_BASE $LIB_FUNC_ADRES_TABLE

. $LIB_FUNC_HASH_ADRES_PTR 1
% $LIB_FUNC_HASH_ADRES_PTR 0
##





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
        
        ldm B $TOKEN_ID     ; Get token ID in B
        tst B ~load         ; Check if it's the load command
        jmpt :is_load_or_save_cmd
        tst B ~save
        jmpt :is_load_or_save_cmd

        ; checked for Load/Save command
        ; If not, execute normally
        call @_execute_cmd_token
        jmp :immediate_loop

    :is_load_or_save_cmd
        ; It is the LOAD or SAVE command
        ldm I $TOKEN_VALUE   ; Read the token: Load or Save
        push I               ; Save the Token on the stack

        call @get_next_token     ; Get the filename
        ldm A $current_part_base ; Get pointer to filename
        call @push_A             ; Push pointer to stack

        ; now execute the command
        pop I                ; Restore I 
        callx $start_memory  ; Call the command handler
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



    :not_a_label
        ; It\'s not a label, so it\'s part of an instruction.
        ; Check if it\'s a special instruction that consumes an argument.
        ldm B $TOKEN_ID
        tst B ~goto
        jmpt :handle_scan_goto

        tst B ~def
        jmpt :1_handle_scan_def

        tst B ~use
        jmpt :1_handle_scan_use

        ; The END keyword is a compile-time directive and produces no bytecode.
        ; We skip advancing the location counter to ensure subsequent label addresses are calculated correctly.
        tst B ~end
        jmpt :1_scan_loop

        ; WHILE is also a zero-width compile-time directive.
        tst B ~while
        jmpt :1_scan_loop 

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
        ; from the token stream so we don\'t process it again.
        call @get_next_token
        jmp :1_scan_loop


    :1_handle_scan_def
    ; A DEF block is being defined. We need to consume all tokens
    ; until we find the closing '}' without advancing the code location counter,
    ; as the function body is compiled elsewhere.

        ; First, consume the function name token
        call @get_next_token

        ; Next, consume the '{' token
        call @get_next_token

        ; Now, loop until we find '}'
    :1_scan_def_loop
        call @get_next_token
        
        ldm A $TOKEN_ID
        tst A ~close-curly
        jmpt :1_scan_def_end ; Found the '}', we are done with the block.

        ldm A $TOKEN_TYPE
        tst A ~TOKEN_NONE
        jmpf :1_scan_def_loop           ; proceed when token found
        call @errors_fatal_invalid_syntax   ; Else throw an fatal syntax error 

        # YOU WILL NEVER REACH THIS LINE
        jmp :1_scan_def_loop
        
    :1_scan_def_end
        ; We have successfully consumed the entire DEF block.
        ; Now, jump back to the main scan loop to process the rest of the program.
        jmp :1_scan_loop

    :1_handle_scan_use
        ; A 'use <libname>' sequence is two tokens in the source, but
        ; becomes one 2-word instruction in the bytecode.
        ; So we advance the counter by 2.
        ldm K $CODE_LOCATION_COUNTER
        addi K 2
        sto K $CODE_LOCATION_COUNTER

        ; We must also consume the next token (the libname identifier)
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
        call @2_compile_generic_token
        jmp :2_compile_loop

    :handle_var_token
        tst A ~TOKEN_VAR
        jmpf :handle_cmd_token
        call @2_compile_generic_token
        jmp :2_compile_loop

    :handle_cmd_token
        tst A ~TOKEN_CMD
        jmpf :handle_unknown_token
        #check for complex token like gote, if else end 
        ldm B $TOKEN_ID

        tst B ~def
        jmpt :2_handle_def_cmd        ; must retrun to the :2_compile_loop

        tst B ~close-curly
        jmpt :2_end_def_compile_loop  ; must retrun to the :2_compile_loop

        tst B ~goto
        jmpt :2_handle_goto_cmd       ; must retrun to the :2_compile_loop

        tst B ~if 
        jmpt :2_handle_if_cmd         ; must return to the :2_compile_loop

        tst B ~else
        jmpt :2_handle_else_cmd       ; must return to the :2_compile_loop

        tst B ~end
        jmpt :2_handle_end_cmd        ; must return to the :2_compile_loop

        tst B ~while
        jmpt :2_handle_while_cmd      ; must return to the :2_compile_loop

        tst B ~do
        jmpt :2_handle_do_cmd         ; must return to the :2_compile_loop

        tst B ~done
        jmpt :2_handle_done_cmd       ; must return to the :2_compile_loop

        tst B ~use
        jmpt :2_handle_use_cmd        ; must return to the :2_compile loop


        #fall thru to the 'simple' command tokens, like add, print, ==, ..... alot of them
        # the all can be handled the same way
        call @2_compile_generic_token
        jmp :2_compile_loop

    :handle_unknown_token
        tst A ~TOKEN_UNKNOWN
        call @2_compile_generic_token
        ; jmpf :handle_fatal_token_error
        ; nop
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

        tst A ~ret
        jmpt :3_execute_ret_token      ; must jumpback to :3_execution_loop

        tst A ~ident
        jmpt :3_execute_unknown_token_smart ; must jumpback to :3_execution_loop

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

        tst A ~dup
        jmpt :3_execution_runtime_token      ; must jumpback to :3_execution_loop

        tst A ~swap
        jmpt :3_execution_runtime_token      ; must jumpback to :3_execution_loop

        tst A ~drop
        jmpt :3_execution_runtime_token      ; must jumpback to :3_execution_loop

        tst A ~over
        jmpt :3_execution_runtime_token      ; must jumpback to :3_execution_loop

        tst A ~if
        jmpt :3_execution_if_token      ; must jumpback to :3_execution_loop

        tst A ~else
        jmpt :3_execution_else_token      ; must jumpback to :3_execution_loop

        tst A ~io
        jmpt :3_execution_runtime_token     ;  must jumpback to :3_execution_loop

        tst A ~rnd
        jmpt :3_execution_runtime_token     ; must jumpback to :3_execution_loop

        tst A ~use
        jmpt :3_execution_use_token         ; must jumpback to :3_execution_loop


        # The 'WHILE condition DO code END' construction is reusing the IF-END, and GOTO implementation
        # so no traces found here for the WHILE loop construction

        ; If we get here, it means none of the above matched.
        ; This is an invalid token type in the bytecode.
        call @fatal_Invalid_instruction_error
        # Halts after fatal

:end_3_execution_phase
ret


##### HELPERS

#### Phase 2 compile helpers
:2_handle_def_cmd
    ; 1. Get function name
    call @get_next_token
    ldm A $TOKEN_ID
    tst A ~ident
    jmpf :error_def_name ; Expected an identifier for the function name

    ; 2. Store function metadata
    inc I $FUNCTION_HASH_ADRES_INDEX
    ldm A $TOKEN_VALUE              ; A holds the hash of the function name
    stx A $FUNCTION_HASH_TABLE_BASE

    ldm K $FUNCTION_BUFFER_PTR      ; K holds the current function buffer pointer
    stx K $FUNCTION_ADRES_TABLE_BASE

    ; 3. Find '{'
    call @get_next_token
    ldm A $TOKEN_ID
    tst A ~open-curly
    jmpf :error_def_body ; Expected '{' to start function body

    ; 4. HIJACK PHASE: Save current pointers and switch to FUNCTION_BUFFER
    ldm A $CODE_BUFFER_PTR
    call @push_compilerstate_A
    ldm A $CODE_BUFFER_BASE
    call @push_compilerstate_A

    ldm A $FUNCTION_BUFFER_PTR
    sto A $CODE_BUFFER_PTR
    ldm A $FUNCTION_BUFFER_BASE
    sto A $CODE_BUFFER_BASE

    ; 4b. Re-enter the main compile loop to process the function body
    jmp :2_compile_loop

:2_end_def_compile_loop
    ; 6. Write the implicit ~ret token by setting the token variables
    ;    and calling the generic compiler function.
    ldi A ~ret
    sto A $TOKEN_ID
    sto Z $TOKEN_VALUE ; ret has no value, so we store 0
    call @2_compile_generic_token ; This now writes (~ret, 0) to the hijacked buffer

    ; 7. Update the FUNCTION_BUFFER_PTR for the next function
    ldm A $CODE_BUFFER_PTR
    sto A $FUNCTION_BUFFER_PTR

    ; 8. RESTORE PHASE: Restore original pointers
    call @pop_compilerstate_A
    sto A $CODE_BUFFER_BASE
    call @pop_compilerstate_A
    sto A $CODE_BUFFER_PTR

    jmp :2_compile_loop ; Continue compiling the main program

:error_def_name
    call @errors_invalid_def_name
    jmp :2_compile_loop

:error_def_body
    call @errors_invalid_def_body
    jmp :2_compile_loop

:error_def_body_end
    call @errors_unterminated_def
    jmp :2_compile_loop


:2_handle_goto_cmd
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


:2_handle_if_cmd
    ; Manually compile the IF token with a placeholder for the jump offset.
    ; 1. Write the token ID (~if) to the code buffer
    ldi A ~if
    inc I $CODE_BUFFER_PTR
    stx A $CODE_BUFFER_BASE

    ; 2. Write a 0 placeholder and get its address
    inc I $CODE_BUFFER_PTR
    stx Z $CODE_BUFFER_BASE     ; Write 0 as the placeholder value (location)

    ; 3. Push the placeholder\'s address onto the stack for later patching
    ld A I
    call @push_placeholder_A
    jmp :2_compile_loop

:2_handle_else_cmd
    ; 1. Pop the IF placeholder address and save it temporarily.
    call @pop_placeholder_A     
    sto A $PATCH_ADRES

    ; 2. Manually compile the ELSE token with its own placeholder.
    ldm A $TOKEN_ID
    inc I $CODE_BUFFER_PTR
    stx A $CODE_BUFFER_BASE
    inc I $CODE_BUFFER_PTR
    stx Z $CODE_BUFFER_BASE

    ; 3. Push the new ELSE placeholder\'s address onto the stack.
    ld A I
    call @push_placeholder_A

    ; 4. Patch the original IF\'s placeholder to jump to the current location.
    ldm I $PATCH_ADRES          ; I = address of IF\'s placeholder
    ldm B $CODE_BUFFER_PTR      ; B = current location (target for the jump)
    stx B $CODE_BUFFER_BASE     ; Patch the IF\'s jump destination
    jmp :2_compile_loop

:2_handle_end_cmd
    ; 1. Pop the placeholder address from the last IF or ELSE.
    call @pop_placeholder_A
    sto A $PATCH_ADRES

    ; 2. Patch the placeholder to jump to the current location.
    ldm I $PATCH_ADRES          ; I = address of the placeholder
    ldm B $CODE_BUFFER_PTR      ; B = current location (target for the jump)
    stx B $CODE_BUFFER_BASE     ; Patch the jump destination

    ; 3. END does not generate any bytecode, so just continue.
    jmp :2_compile_loop

:2_handle_while_cmd
    ; WHILE marks the start of the loop\'s condition.
    ; Save the current address to the loop stack for the eventual backward jump.
    ldm A $CODE_BUFFER_PTR
    call @push_loop_A
    ; WHILE does not generate any bytecode, so just continue
    jmp :2_compile_loop

:2_handle_do_cmd
    ; DO marks the end of the condition and compiles a forward conditional jump.
    ; We reuse the IF token for this.
    ldi A ~if
    inc I $CODE_BUFFER_PTR
    stx A $CODE_BUFFER_BASE     ; Write ~if token
    inc I $CODE_BUFFER_PTR
    stx Z $CODE_BUFFER_BASE     ; Write 0 placeholder for the jump address
    ld A I                      ; Get the address of the placeholder
    call @push_placeholder_A    ; Push it for patching later by DONE
    jmp :2_compile_loop


:2_handle_done_cmd
    ; DONE closes a DO loop with two actions:
    ; 1. Create the unconditional GOTO to jump back to the start of the loop.
    ; 2. Patch the DO\'s conditional jump to exit the loop.

    ; Action 1: Create the loop-back GOTO
    call @pop_loop_A            ; Get loop start address in A
    ld B A                     ; Temporarily save it in B
    ldi A ~goto                 ; Load ~goto token ID
    inc I $CODE_BUFFER_PTR
    stx A $CODE_BUFFER_BASE     ; Write ~goto token
    inc I $CODE_BUFFER_PTR
    stx B $CODE_BUFFER_BASE     ; Write the loop start address as the target

    ; Action 2: Patch the DO\'s forward jump
    call @pop_placeholder_A     ; Get DO\'s placeholder address in A
    sto A $PATCH_ADRES
    ldm I $PATCH_ADRES
    ldm B $CODE_BUFFER_PTR      ; B = current location (the exit address)
    stx B $CODE_BUFFER_BASE     ; Patch the placeholder with the exit address

    jmp :2_compile_loop

:2_handle_use_cmd 
    call @get_next_token
    ldm A $TOKEN_ID
    tst A ~ident
    jmpf :error_use_name

    ldm A $TOKEN_VALUE      ; A holds the hash of the Library name
    ld I Z                  ; Use I as index and start at 0

    :use_loop
        ldm B $LIB_REG_HASH_ADRES_PTR
        tstg B I                        ; test for last hash    
        jmpf :error_use_name            ; library not found

        ldx C $LIB_REG_HASH_TABLE_BASE  ; the hash of the lib
        tste A C                        ; Compare hash labels
        jmpf :try_next_use

        ldx B $LIB_REG_ADRES_TABLE_BASE ; The adres of the init funciton of the lib
        ## If found
        ldi A ~use
        inc I $CODE_BUFFER_PTR          ; Write use to the codebuffer
        stx A $CODE_BUFFER_BASE

        inc I $CODE_BUFFER_PTR          ; write adres to codebuffer
        stx B $CODE_BUFFER_BASE

    jmp :2_compile_loop

    :try_next_use
        addi I 1
        jmp :use_loop

    :error_use_name
        call @error_unkown_library
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
    call @3_execute_push_value
    jmp :3_execution_loop

:3_execute_var_token
    call @3_execute_push_value
    jmp :3_execution_loop


:3_execution_unknown_token
    nop             ; for now a dummy
    jmp :3_execution_loop


:3_execution_goto_token
    inc I $CODE_BUFFER_PTR
    ldx A $CODE_BUFFER_BASE     ; A contains new buffer_ptr
    sto A $CODE_BUFFER_PTR
    jmp :3_execution_loop



:3_execution_if_token
    call @pop_A                 ; Pop comparison result into A
    inc I $CODE_BUFFER_PTR      ; Point to the jump offset value
    ldx B $CODE_BUFFER_BASE     ; Load the jump offset into B
    tste A Z                     ; Check if result is zero (false)
    jmpf :if_true               ; If not zero (true), continue past jump

    ; Condition is false, so jump
    sto B $CODE_BUFFER_PTR      ; Set the instruction pointer
    jmp :3_execution_loop       ; Continue execution from new location

:if_true
    ; Condition is true, just continue to the next instruction
    jmp :3_execution_loop

:3_execution_else_token
    ; Unconditional jump
    inc I $CODE_BUFFER_PTR      ; Move to the offset value
    ldx A $CODE_BUFFER_BASE     ; Load the jump offset into A
    sto A $CODE_BUFFER_PTR      ; Set the instruction pointer
    jmp :3_execution_loop       ; Continue execution from new location

:3_execute_ret_token
    ; 1. RESTORE STATE from the Call Stack
    ; First, pop the old code_base pointer and restore it
    call @pop_return_adres_A
    sto A $CODE_BUFFER_BASE

    ; Second, pop the return address
    call @pop_return_adres_A
    ; Decrement to account for the loop's 'inc' at the top
    subi A 1
    sto A $CODE_BUFFER_PTR

    ; 2. JUMP (by continuing the execution loop with the restored pointers)
    jmp :3_execution_loop

:3_execution_use_token
    inc I $CODE_BUFFER_PTR
    ldx A $CODE_BUFFER_BASE     ; A contains the adres of the init function
    ld I A                      ; Load adres to Index
    callx $start_memory         ; Call the init function

    jmp :3_execution_loop




:3_execute_unknown_token_smart
    ; An ~ident token was found. Its value is a hash.
    inc I $CODE_BUFFER_PTR
    ldx A $CODE_BUFFER_BASE ; A = hash value

    ; Search the function hash table
    sto Z $FUNCTION_HASH_ADRES_PTR
    ldm B $FUNCTION_HASH_ADRES_INDEX

:search_func_loop   # user DEFined functions
    ldm I $FUNCTION_HASH_ADRES_PTR
    tstg B I
    jmpf :check_for_library_word      ; If search pointer >= total, hash not found

    ldx C $FUNCTION_HASH_TABLE_BASE
    tste A C
    jmpf :try_next_function_in_loop

    ; --- MATCH FOUND! ---
    ; I holds the index of the function.

    ; 1. SAVE STATE to the Call Stack
    ; First, save the return address (the instruction *after* this call)
    push I      ; save I
    ldm A $CODE_BUFFER_PTR
    addi A 1
    call @push_return_adres_A

    ; Second, save the current code base pointer
    ldm A $CODE_BUFFER_BASE
    call @push_return_adres_A

    pop I       ; restore I Index of function

    ; 2. SET NEW STATE FOR JUMP
    ; Get the function's start address (which is an offset, e.g., 0)
    ldx B $FUNCTION_ADRES_TABLE_BASE

    ; Set the code pointer to this offset
    sto B $CODE_BUFFER_PTR

    ; Set the code *base* pointer to the function buffer's base
    ldm A $FUNCTION_BUFFER_BASE
    sto A $CODE_BUFFER_BASE

    ; 3. JUMP (by continuing the execution loop with the new pointers)
    jmp :3_execution_loop

:try_next_function_in_loop
    inc I $FUNCTION_HASH_ADRES_PTR
    jmp :search_func_loop

#check the (external) library words from here, otherwise an error is thrown
:check_for_library_word
    ld I Z      ; Start at zero

    :search_libword_loop
        ldm B $LIB_FUNC_HASH_ADRES_PTR
        tstg B I 
        jmpf :unknown_word_error

        ldx C $LIB_FUNC_HASH_TABLE_BASE
        tste A C
        jmpf :check_next_libword

        ## match found
        ldx B $LIB_FUNC_ADRES_TABLE_BASE ; load the execution adres
        ld I B                           ; Load adres in Index register
        callx $start_memory              ; execute the function
    jmp :3_execution_loop

    :check_next_libword
        addi I 1
        jmp :search_libword_loop


:unknown_word_error
    call @errors_unkown_token
    jmp :3_execution_loop




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


# General helpers

# Pushes the value in register A onto the placeholder stack.
# This stack is used by the compiler to store the memory addresses
# of forward-jump placeholders (from IF and DO) that need to be patched later.
@push_placeholder_A
    inc I $PLACEHOLDER_STACK_INDEX
    stx A $PLACEHOLDER_STACK_PTR
    ret

# Pops a value from the placeholder stack into register A.
# This is used by ELSE, END, and DONE to retrieve the address
# of a placeholder that needs to be patched with a jump destination.
@pop_placeholder_A
    dec I $PLACEHOLDER_STACK_INDEX
    ldx A $PLACEHOLDER_STACK_PTR
    ret

# Pushes the value in register A onto the loop stack.
# This stack is used by the compiler to store the starting address
# of a DO..DONE loop, so the DONE handler knows where to jump back to.
@push_loop_A
    inc I $LOOP_STACK_INDEX
    stx A $LOOP_STACK_PTR
    ret

# Pops a value from the loop stack into register A.
# This is used by the DONE handler to retrieve the starting address
# of the loop to create the backward jump.
@pop_loop_A
    dec I $LOOP_STACK_INDEX
    ldx A $LOOP_STACK_PTR
    ret

@push_compilerstate_A
    inc I $COMPILER_STATE_STACK_INDEX
    stx A $COMPILER_STATE_STACK_PTR
    ret

@pop_compilerstate_A
    dec I $COMPILER_STATE_STACK_INDEX
    ldx A $COMPILER_STATE_STACK_PTR
    ret

@push_return_adres_A
    inc I $CALL_STACK_INDEX
    stx A $CALL_STACK_PTR
    ret

@pop_return_adres_A
    dec I $CALL_STACK_INDEX
    ldx A $CALL_STACK_PTR
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

pop Y       ; restore all registers
pop X 
pop M
pop L  
pop K
pop C 
pop B 
pop A 

push I      ; push return adres back to the stack
ret         ; return to main loop
