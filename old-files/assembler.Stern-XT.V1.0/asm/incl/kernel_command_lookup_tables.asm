
; per c
@init_command_lookup_tables
    . $table_pointer 1
    sto Z $table_pointer

    ## add all instructions

    ## CLS
    inc I $table_pointer
    ldi A @cli_cmd_cls
    stx A $CMD_TABLE_BASE
    ldi A $CMD_CLS_STR
    stx A $STR_TABLE_BASE
    ldi A ~cls
    stx A $ID_TABLE_BASE

    ## QUIT
    inc I $table_pointer
    ldi A @cli_cmd_quit
    stx A $CMD_TABLE_BASE
    ldi A $CMD_QUIT_STR
    stx A $STR_TABLE_BASE
    ldi A ~quit
    stx A $ID_TABLE_BASE
    
    ## ADD
    inc I $table_pointer
    ldi A @rt_add
    stx A $CMD_TABLE_BASE
    ldi A $RT_ADD_STR
    stx A $STR_TABLE_BASE
    ldi A ~add
    stx A $ID_TABLE_BASE

    ## SUB
    inc I $table_pointer
    ldi A @rt_sub
    stx A $CMD_TABLE_BASE
    ldi A $RT_SUB_STR
    stx A $STR_TABLE_BASE
    ldi A ~sub
    stx A $ID_TABLE_BASE

    ## MUL
    inc I $table_pointer
    ldi A @rt_mul
    stx A $CMD_TABLE_BASE
    ldi A $RT_MUL_STR
    stx A $STR_TABLE_BASE
    ldi A ~mul
    stx A $ID_TABLE_BASE

    ## DIV
    inc I $table_pointer
    ldi A @rt_div
    stx A $CMD_TABLE_BASE
    ldi A $RT_DIV_STR
    stx A $STR_TABLE_BASE
    ldi A ~div
    stx A $ID_TABLE_BASE

    ## MOD
    inc I $table_pointer
    ldi A @rt_mod
    stx A $CMD_TABLE_BASE
    ldi A $RT_MOD_STR
    stx A $STR_TABLE_BASE
    ldi A ~mod
    stx A $ID_TABLE_BASE

    ## DOT
    inc I $table_pointer
    ldi A @rt_print_tos
    stx A $CMD_TABLE_BASE
    ldi A $RT_DOT_STR
    stx A $STR_TABLE_BASE
    ldi A ~dot
    stx A $ID_TABLE_BASE

    ## STACKS
    inc I $table_pointer
    ldi A @interpreter_start
    stx A $CMD_TABLE_BASE
    ldi A $CMD_STACKS_STR
    stx A $STR_TABLE_BASE
    ldi A ~stacks
    stx A $ID_TABLE_BASE

    ## LIST
    inc I $table_pointer
    ldi A @rt_stacks_cmd_list
    stx A $CMD_TABLE_BASE
    ldi A $CMD_LIST_STR
    stx A $STR_TABLE_BASE
    ldi A ~list
    stx A $ID_TABLE_BASE

    ## RUN
    inc I $table_pointer
    ldi A @rt_stacks_cmd_run2
    stx A $CMD_TABLE_BASE
    ldi A $CMD_RUN_STR
    stx A $STR_TABLE_BASE
    ldi A ~run
    stx A $ID_TABLE_BASE

    ## MAIN
    inc I $table_pointer
    ldi A 7170              ; hardcode start adres of main, for now
    stx A $CMD_TABLE_BASE
    ldi A $CMD_MAIN_STR
    stx A $STR_TABLE_BASE
    ldi A ~main
    stx A $ID_TABLE_BASE

    ## STORE
    inc I $table_pointer
    ldi A @rt_store_var
    stx A $CMD_TABLE_BASE
    ldi A $RT_STORE_VAR
    stx A $STR_TABLE_BASE
    ldi A ~store
    stx A $ID_TABLE_BASE

    ## RESTORE
    inc I $table_pointer
    ldi A @rt_restore_var
    stx A $CMD_TABLE_BASE
    ldi A $RT_RESTORE_VAR
    stx A $STR_TABLE_BASE
    ldi A ~restore
    stx A $ID_TABLE_BASE

    ## LOAD
    inc I $table_pointer
    ldi A @rt_stacks_cmd_load
    stx A $CMD_TABLE_BASE
    ldi A $CMD_LOAD_STR
    stx A $STR_TABLE_BASE
    ldi A ~load
    stx A $ID_TABLE_BASE

    ## SAVE
    inc I $table_pointer
    ldi A @rt_stacks_cmd_save
    stx A $CMD_TABLE_BASE
    ldi A $CMD_SAVE_STR
    stx A $STR_TABLE_BASE
    ldi A ~save
    stx A $ID_TABLE_BASE

    ## USE
    inc I $table_pointer
    ldi A @_stub_handler  
    stx A $CMD_TABLE_BASE
    ldi A $PROG_USE_LIB_STR
    stx A $STR_TABLE_BASE
    ldi A ~use
    stx A $ID_TABLE_BASE


    # PRINT
    inc I $table_pointer
    ldi A @rt_print_tos
    stx A $CMD_TABLE_BASE
    ldi A $PROG_PRINT_STR
    stx A $STR_TABLE_BASE
    ldi A ~print
    stx A $ID_TABLE_BASE

    ## GOTO
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_GOTO_STR
    stx A $STR_TABLE_BASE
    ldi A ~goto
    stx A $ID_TABLE_BASE

    ## EQ
    inc I $table_pointer
    ldi A @rt_eq
    stx A $CMD_TABLE_BASE
    ldi A $PROG_EQ_STR
    stx A $STR_TABLE_BASE
    ldi A ~eq
    stx A $ID_TABLE_BASE

    ## NEQ
    inc I $table_pointer
    ldi A @rt_neq
    stx A $CMD_TABLE_BASE
    ldi A $PROG_NEQ_STR
    stx A $STR_TABLE_BASE
    ldi A ~neq
    stx A $ID_TABLE_BASE

    ## GT
    inc I $table_pointer
    ldi A @rt_gt
    stx A $CMD_TABLE_BASE
    ldi A $PROG_GT_STR
    stx A $STR_TABLE_BASE
    ldi A ~gt
    stx A $ID_TABLE_BASE

    ## LT
    inc I $table_pointer
    ldi A @rt_lt
    stx A $CMD_TABLE_BASE
    ldi A $PROG_LT_STR
    stx A $STR_TABLE_BASE
    ldi A ~lt
    stx A $ID_TABLE_BASE

    ## DUP
    inc I $table_pointer
    ldi A @rt_dup
    stx A $CMD_TABLE_BASE
    ldi A $PROG_DUP_STR
    stx A $STR_TABLE_BASE
    ldi A ~dup
    stx A $ID_TABLE_BASE

    ## SWAP
    inc I $table_pointer
    ldi A @rt_swap
    stx A $CMD_TABLE_BASE
    ldi A $PROG_SWAP_STR
    stx A $STR_TABLE_BASE
    ldi A ~swap
    stx A $ID_TABLE_BASE

    ## DROP
    inc I $table_pointer
    ldi A @rt_drop
    stx A $CMD_TABLE_BASE
    ldi A $PROG_DROP_STR
    stx A $STR_TABLE_BASE
    ldi A ~drop
    stx A $ID_TABLE_BASE

    ## OVER
    inc I $table_pointer
    ldi A @rt_over
    stx A $CMD_TABLE_BASE
    ldi A $PROG_OVER_STR
    stx A $STR_TABLE_BASE
    ldi A ~over
    stx A $ID_TABLE_BASE

    ## IF
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_IF_STR
    stx A $STR_TABLE_BASE
    ldi A ~if
    stx A $ID_TABLE_BASE

    ## ELSE
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_ELSE_STR
    stx A $STR_TABLE_BASE
    ldi A ~else
    stx A $ID_TABLE_BASE

    ## END
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_END_STR
    stx A $STR_TABLE_BASE
    ldi A ~end
    stx A $ID_TABLE_BASE

    ## WHILE
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_WHILE_STR
    stx A $STR_TABLE_BASE
    ldi A ~while
    stx A $ID_TABLE_BASE

    ## DO
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_DO_STR
    stx A $STR_TABLE_BASE
    ldi A ~do
    stx A $ID_TABLE_BASE

    ## DONE
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_DONE_STR
    stx A $STR_TABLE_BASE
    ldi A ~done
    stx A $ID_TABLE_BASE

    ## DEF
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_DEF_STR
    stx A $STR_TABLE_BASE
    ldi A ~def
    stx A $ID_TABLE_BASE

    ## {
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_O_CURLY_STR
    stx A $STR_TABLE_BASE
    ldi A ~open-curly
    stx A $ID_TABLE_BASE

    ## }
    inc I $table_pointer
    ldi A @_stub_handler
    stx A $CMD_TABLE_BASE
    ldi A $PROG_C_CURLY_STR
    stx A $STR_TABLE_BASE
    ldi A ~close-curly
    stx A $ID_TABLE_BASE

    ## &io
    inc I $table_pointer
    ldi A @rt_udc_control
    stx A $CMD_TABLE_BASE
    ldi A $PROG_IO_STR
    stx A $STR_TABLE_BASE
    ldi A ~io
    stx A $ID_TABLE_BASE

    ## RND
    inc I $table_pointer
    ldi A @rt_rnd
    stx A $CMD_TABLE_BASE
    ldi A $PROG_RND_STR
    stx A $STR_TABLE_BASE
    ldi A ~rnd
    stx A $ID_TABLE_BASE




    ### DO NOT FORGET UPDATE ~LUT_LEN AFTER ADDING OR DELETING COMMANDS
    EQU ~LUT_LEN 38

ret

; Command routine look up table
. $CMD_TABLE 40         ; room for commands,  1 bytes per command
. $CMD_TABLE_BASE 1
% $CMD_TABLE_BASE $CMD_TABLE    

; Command string loop up table 
. $STR_TABLE 40         ; room for commands,  1 bytes per command
. $STR_TABLE_BASE 1
% $STR_TABLE_BASE $STR_TABLE

; Command ID loop up table 
. $ID_TABLE 40         ; room for commands,  1 bytes per command
. $ID_TABLE_BASE 1
% $ID_TABLE_BASE $ID_TABLE

. $LUT_INDEX 1
% $LUT_INDEX 0


@_stub_handler
    nop         ; will never be executed
    ret