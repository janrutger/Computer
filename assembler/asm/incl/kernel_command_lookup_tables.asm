
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

    ### DO NOT FORGET UPDATE ~LUT_LEN AFTER ADDING OR DELETING COMMANDS
    EQU ~LUT_LEN 13

ret