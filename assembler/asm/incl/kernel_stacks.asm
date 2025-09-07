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
. $LABEL_STR_TABLE 64
. $LABEL_STR_TABLE_PTR 1
. $LABEL_STR_TABLE_INDEX 1
% $LABEL_STR_TABLE_INDEX 0
% $LABEL_STR_TABLE_PTR $LABEL_STR_TABLE

. $LABEL_ADRES_TABLE 32
. $LABEL_ADRES_TABLE_PTR 1
. $LABEL_ADRES_TABLE_INDEX 1
% $LABEL_ADRES_TABLE_INDEX 0
% $LABEL_ADRES_TABLE_PTR $LABEL_ADRES_TABLE

# Lookup function addresses
. $FUNCTION_STR_TABLE 64
. $FUNCTION_STR_TABLE_PTR 1
. $FUNCTION_STR_TABLE_INDEX 1
% $FUNCTION_STR_TABLE_INDEX 0
% $FUNCTION_STR_TABLE_PTR $FUNCTION_STR_TABLE  

. $FUNCTION_ADRES_TABLE 32
. $FUNCTION_ADRES_TABLE_PTR 1
. $FUNCTION_ADRES_TABLE_INDEX 1
% $FUNCTION_ADRES_TABLE_INDEX 0
% $FUNCTION_ADRES_TABLE_PTR $FUNCTION_ADRES_TABLE

# And some buffer
MALLOC $CODE_BUFFER 5120         ; prog_start + PROG_BUFFER_SIZE
MALLOC $FUNCTION_BUFFER 5632     ; + 512




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
        ldm A $TOKEN_ID
        

ret

@_1_scan_phase
    nop
ret

@_2_compile_phase
    nop
ret

@_3_execution_phase
    nop
ret


##### HELPERS

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