

# Configure the command ID numbers
EQU ~ident 96       ; General indentifier ID, tokentype = unknown, 
                    ; token value can be an Label or an function or really unkown
EQU ~label 97       ; token is label, toeken value points to label-array +\ null
EQU ~var 98         ; Token is var, token value is var-index [0 ..26]
EQU ~num 99         ; Token is number, token value is number

# Keyword Commands [100 ... 199]
EQU ~cls 100        ; Clear screen
EQU ~quit 101       ; Quit/Exit the computer (turn off)
EQU ~dot 102        ; a . prints TOS to screen
EQU ~stacks 103     ; Start the Stacks editor (called interpreter.py)
EQU ~list 104       ; List/shows current programbuffer
EQU ~run 105        ; Run/execute current programbuffer

EQU ~load 107       ; Load a file from disk to PROG_BUFFER
EQU ~save 108       ; Save the PROG_BUFFER to disk


# Keyword operations [200 ... 299]
EQU ~store 200      ; Store TOS to var [A .. Z]
EQU ~restore 201    ; Restore var [A .. Z] to TOS
EQU ~add 202        ; tos + tos[-1] = tos
EQU ~sub 203        ; tos - tos[-1] = tos
EQU ~mul 204        ; tos * tos[-1] = tos
EQU ~div 205        ; tos / tos[-1] = tos
EQU ~mod 206        ; tos % tos[-1] = tos
EQU ~eq 207         ; tos == tos[-1] = tos
EQU ~neq 208        ; tos != tos[-1] = tos
EQU ~gt 209         ; tos > tos[-1] = tos
EQU ~lt 210         ; tos < tos[-1] = tos
EQU ~dup 211        ; t1 -> t1 t1
EQU ~swap 212       ; t1 t2 -> t2 t1
EQU ~drop 213       ; t1 -> 
EQU ~over 214       ; t1 t2 -> t1 t2 t1      

# keyword Stacks keyword commands [300 ... 399]
EQU ~print 300
EQU ~goto 301


# Configure the lookup tables
# don forget to update the LUT_LEN after adding or deleting commands
## MOVED OUT TO INIT ROUTINE WHEN STARTING THE KERNEL
; EQU ~LUT_LEN 13
; ;. $LUT_LEN 1
; % $CMD_TABLE @cli_cmd_cls @cli_cmd_quit @rt_add @rt_print_tos @interpreter_start @rt_stacks_cmd_list @rt_stacks_cmd_run2  @rt_store_var @rt_restore_var @rt_stacks_cmd_load @rt_stacks_cmd_save @rt_print_tos @_stub_handler
; % $STR_TABLE $CMD_CLS_STR $CMD_QUIT_STR $RT_ADD_STR $RT_DOT_STR $CMD_STACKS_STR $CMD_LIST_STR $CMD_RUN_STR $RT_STORE_VAR $RT_RESTORE_VAR $CMD_LOAD_STR $CMD_SAVE_STR $PROG_PRINT_STR $PROG_GOTO_STR
; % $ID_TABLE  ~cls ~quit ~add ~dot ~stacks ~list ~run ~store ~restore ~load ~save ~print ~goto





# Define the command strings
. $CMD_CLS_STR 4
% $CMD_CLS_STR \c \l \s \null

. $CMD_QUIT_STR 5
% $CMD_QUIT_STR \q \u \i \t \null 

. $CMD_STACKS_STR 7
% $CMD_STACKS_STR \s \t \a \c \k \s \null

. $CMD_LIST_STR 5
% $CMD_LIST_STR \l \i \s \t \null

. $CMD_RUN_STR 4
% $CMD_RUN_STR \r \u \n \null

. $CMD_LOAD_STR 5
% $CMD_LOAD_STR \l \o \a \d \null

. $CMD_SAVE_STR 5
% $CMD_SAVE_STR \s \a \v \e \null

. $RT_ADD_STR 2
% $RT_ADD_STR \+ \null

. $RT_SUB_STR 2
% $RT_SUB_STR \- \null

. $RT_MUL_STR 2
% $RT_MUL_STR \* \null

. $RT_DIV_STR 2
% $RT_DIV_STR \/ \null

. $RT_MOD_STR 2
% $RT_MOD_STR \% \null

. $RT_DOT_STR 2
% $RT_DOT_STR \. \null

. $RT_STORE_VAR 2
% $RT_STORE_VAR \! \null

. $RT_RESTORE_VAR 2
% $RT_RESTORE_VAR \@ \null

. $PROG_PRINT_STR 6
% $PROG_PRINT_STR \P \R \I \N \T \null

. $PROG_GOTO_STR 5
% $PROG_GOTO_STR \G \O \T \O \null

. $PROG_EQ_STR 3
% $PROG_EQ_STR \= \= \null

. $PROG_NEQ_STR 3
% $PROG_NEQ_STR \! \= \null

. $PROG_GT_STR 2
% $PROG_GT_STR \> \null

. $PROG_LT_STR 2
% $PROG_LT_STR \< \null

. $PROG_DUP_STR 4
% $PROG_DUP_STR \D \U \P \null

. $PROG_SWAP_STR 5
% $PROG_SWAP_STR \S \W \A \P \null

. $PROG_DROP_STR 5
% $PROG_DROP_STR \D \R \O \P \null

. $PROG_OVER_STR 5
% $PROG_OVER_STR \O \V \E \R \null






