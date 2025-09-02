; Command routine look up table
. $CMD_TABLE 16         ; room for 16 commands,  1 bytes per command
. $CMD_TABLE_BASE 1
% $CMD_TABLE_BASE $CMD_TABLE    

; Command string loop up table 
. $STR_TABLE 16         ; room for 16 commands,  1 bytes per command
. $STR_TABLE_BASE 1
% $STR_TABLE_BASE $STR_TABLE

; Command ID loop up table 
. $ID_TABLE 16         ; room for 16 commands,  1 bytes per command
. $ID_TABLE_BASE 1
% $ID_TABLE_BASE $ID_TABLE

. $LUT_INDEX 1
% $LUT_INDEX 0


EQU ~var_id 98
EQU ~num_id 99
EQU ~cls 100
EQU ~quit 101
EQU ~add 102
EQU ~print 103
EQU ~stacks 104
EQU ~list 105
EQU ~run 106
EQU ~next 107
EQU ~store 108
EQU ~restore 109
EQU ~load 110



. $LUT_LEN 1
% $CMD_TABLE @cli_cmd_cls @cli_cmd_quit @rt_add @rt_print_tos @interpreter_start @rt_stacks_cmd_list @rt_stacks_cmd_run @rt_next @rt_store_var @rt_restore_var @rt_stacks_cmd_load
% $STR_TABLE $CMD_CLS_STR $CMD_QUIT_STR $RT_ADD_STR $RT_PRINT_STR $CMD_STACKS_STR $CMD_LIST_STR $CMD_RUN_STR $RT_NEXT_STR $RT_STORE_VAR $RT_RESTORE_VAR $CMD_LOAD_STR
% $ID_TABLE  ~cls ~quit ~add ~print ~stacks ~list ~run ~next ~store ~restore ~load



EQU ~LUT_LEN 11