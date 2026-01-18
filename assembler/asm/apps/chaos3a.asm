# .HEADER
. $_snt_n 1
. $_snt_ptr 1
. $_snt_i 1
. $error_mesg9 29
. $error_mesg10 29
. $_sn_type_ptr 1
. $_sn_n 1
. $_sn_inst_ptr 1
. $_sn_i 1
. $_sp_inst_ptr 1
. $_sp_hash 1
. $_sp_val 1
. $_sp_type_ptr 1
. $_sp_n 1
. $_sp_i 1
. $_sp_found 1
. $_sg_inst_ptr 1
. $_sg_hash 1
. $_sg_type_ptr 1
. $_sg_n 1
. $_sg_i 1
. $_sg_found 1
. $self 1
. $iter 1
. $r 1
. $target 1
. $t_point 1
. $v1 1
. $v2 1
. $v3 1
. $cursor 1
. $_main_str_0 17
. $_main_str_1 4

# .CODE
    call @HEAP.free
    ldi A 177693
    stack A $DATASTACK_PTR
    ldi A 177694
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @STRUCT.new_type
    ustack A $DATASTACK_PTR
    sto A $t_point
    call @Screen.init
    stack Z $DATASTACK_PTR
    call @TIME.start
    ldm A $t_point
    stack A $DATASTACK_PTR
    call @STRUCT.new
    ustack A $DATASTACK_PTR
    sto A $v1
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $v1
    stack A $DATASTACK_PTR
    call @Point.set
    ldm A $t_point
    stack A $DATASTACK_PTR
    call @STRUCT.new
    ustack A $DATASTACK_PTR
    sto A $v2
    ldi A 630
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $v2
    stack A $DATASTACK_PTR
    call @Point.set
    ldm A $t_point
    stack A $DATASTACK_PTR
    call @STRUCT.new
    ustack A $DATASTACK_PTR
    sto A $v3
    ldi A 320
    stack A $DATASTACK_PTR
    ldi A 470
    stack A $DATASTACK_PTR
    ldm A $v3
    stack A $DATASTACK_PTR
    call @Point.set
    ldm A $t_point
    stack A $DATASTACK_PTR
    call @STRUCT.new
    ustack A $DATASTACK_PTR
    sto A $cursor
    ldi A 10
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @Point.set
:_main_while_start_0
    ldi A 50000
    stack A $DATASTACK_PTR
    ldm A $iter
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
    call @rt_rnd
    ldi A 3
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 999
    ustack B $DATASTACK_PTR
    dmod B A
    ld A B
    sto A $r
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_0
    ldm A $v1
    sto A $target
:_main_if_end_0
    ldm A $r
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_1
    ldm A $v2
    sto A $target
:_main_if_end_1
    ldm A $r
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_2
    ldm A $v3
    sto A $target
:_main_if_end_2
    ldi A 177693
    stack A $DATASTACK_PTR
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @STRUCT.get
    ldi A 177693
    stack A $DATASTACK_PTR
    ldm A $target
    stack A $DATASTACK_PTR
    call @STRUCT.get
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldi A 177694
    stack A $DATASTACK_PTR
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @STRUCT.get
    ldi A 177694
    stack A $DATASTACK_PTR
    ldm A $target
    stack A $DATASTACK_PTR
    call @STRUCT.get
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @Point.set
    ldm A $cursor
    stack A $DATASTACK_PTR
    call @Point.draw
    ldm B $iter
    ldi A 1
    add A B
    sto A $iter
    ld B A
    ldi A 500
    dmod B A
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_3
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    stack Z $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A 32
    stack A $DATASTACK_PTR
    call @PRTchar
    ldm A $iter
    stack A $DATASTACK_PTR
    call @rt_print_tos
:_main_if_end_3
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_4
    call @rt_drop
    jmp :end_of_chaos
:_main_if_end_4
    jmp :_main_while_start_0
:_main_while_end_0
:end_of_chaos
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    stack Z $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ret

# .FUNCTIONS

@STRUCT.new_type
    ustack A $DATASTACK_PTR
    sto A $_snt_n
    ld B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_snt_ptr
    ldm A $_snt_n
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_snt_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm A $_snt_n
    sto A $_snt_i
:STRUCT.new_type_while_start_0
    ldm A $_snt_i
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRUCT.new_type_while_end_0
    ldm A $_snt_i
    stack A $DATASTACK_PTR
    ldm A $_snt_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_snt_i
    ldi A 1
    sub B A
    ld A B
    sto A $_snt_i
    jmp :STRUCT.new_type_while_start_0
:STRUCT.new_type_while_end_0
    ldm A $_snt_ptr
    stack A $DATASTACK_PTR
    ret
@STRUCT.new
    ustack A $DATASTACK_PTR
    sto A $_sn_type_ptr
    stack Z $DATASTACK_PTR
    ldm A $_sn_type_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_sn_n
    ld B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @NEW.list
    ustack A $DATASTACK_PTR
    sto A $_sn_inst_ptr
    ldm A $_sn_type_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    ldm A $_sn_inst_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldi A 1
    sto A $_sn_i
:STRUCT.new_while_start_1
    ldm A $_sn_i
    stack A $DATASTACK_PTR
    ldm B $_sn_n
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRUCT.new_while_end_1
    stack Z $DATASTACK_PTR
    ldm A $_sn_i
    stack A $DATASTACK_PTR
    ldm A $_sn_inst_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_sn_i
    ldi A 1
    add A B
    sto A $_sn_i
    jmp :STRUCT.new_while_start_1
:STRUCT.new_while_end_1
    ldm A $_sn_inst_ptr
    stack A $DATASTACK_PTR
    ret
@STRUCT.put
    ustack A $DATASTACK_PTR
    sto A $_sp_inst_ptr
    ustack A $DATASTACK_PTR
    sto A $_sp_hash
    ustack A $DATASTACK_PTR
    sto A $_sp_val
    stack Z $DATASTACK_PTR
    ldm A $_sp_inst_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_sp_type_ptr
    stack Z $DATASTACK_PTR
    ldm A $_sp_type_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_sp_n
    ld A Z
    sto A $_sp_found
    ldi A 1
    sto A $_sp_i
:STRUCT.put_while_start_2
    ldm A $_sp_i
    stack A $DATASTACK_PTR
    ldm B $_sp_n
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRUCT.put_while_end_2
    ldm A $_sp_i
    stack A $DATASTACK_PTR
    ldm A $_sp_type_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_sp_hash
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRUCT.put_if_else_0
    ldm A $_sp_val
    stack A $DATASTACK_PTR
    ldm A $_sp_i
    stack A $DATASTACK_PTR
    ldm A $_sp_inst_ptr
    stack A $DATASTACK_PTR
    call @LIST.put
    ldm B $_sp_n
    ldi A 1
    add A B
    sto A $_sp_i
    ldi A 1
    sto A $_sp_found
    jmp :STRUCT.put_if_end_0
:STRUCT.put_if_else_0
    ldm B $_sp_i
    ldi A 1
    add A B
    sto A $_sp_i
:STRUCT.put_if_end_0
    jmp :STRUCT.put_while_start_2
:STRUCT.put_while_end_2
    ldm A $_sp_found
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRUCT.put_if_end_1
    ldi A $error_mesg10
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:STRUCT.put_if_end_1
    ret
@STRUCT.get
    ustack A $DATASTACK_PTR
    sto A $_sg_inst_ptr
    ustack A $DATASTACK_PTR
    sto A $_sg_hash
    stack Z $DATASTACK_PTR
    ldm A $_sg_inst_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_sg_type_ptr
    stack Z $DATASTACK_PTR
    ldm A $_sg_type_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ustack A $DATASTACK_PTR
    sto A $_sg_n
    ld A Z
    sto A $_sg_found
    ldi A 1
    sto A $_sg_i
:STRUCT.get_while_start_3
    ldm A $_sg_i
    stack A $DATASTACK_PTR
    ldm B $_sg_n
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRUCT.get_while_end_3
    ldm A $_sg_i
    stack A $DATASTACK_PTR
    ldm A $_sg_type_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm A $_sg_hash
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRUCT.get_if_else_2
    ldm A $_sg_i
    stack A $DATASTACK_PTR
    ldm A $_sg_inst_ptr
    stack A $DATASTACK_PTR
    call @LIST.get
    ldm B $_sg_n
    ldi A 1
    add A B
    sto A $_sg_i
    ldi A 1
    sto A $_sg_found
    jmp :STRUCT.get_if_end_2
:STRUCT.get_if_else_2
    ldm B $_sg_i
    ldi A 1
    add A B
    sto A $_sg_i
:STRUCT.get_if_end_2
    jmp :STRUCT.get_while_start_3
:STRUCT.get_while_end_3
    ldm A $_sg_found
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :STRUCT.get_if_end_3
    ldi A $error_mesg9
    stack A $DATASTACK_PTR
    call @PRTstring
    call @HALT
:STRUCT.get_if_end_3
    ret

@Point.set
    ustack A $DATASTACK_PTR
    sto A $self
    ldi A 177694
    stack A $DATASTACK_PTR
    ldm A $self
    stack A $DATASTACK_PTR
    call @STRUCT.put
    ldi A 177693
    stack A $DATASTACK_PTR
    ldm A $self
    stack A $DATASTACK_PTR
    call @STRUCT.put
    ret
@Point.draw
    ustack A $DATASTACK_PTR
    sto A $self
    ldi A 177694
    stack A $DATASTACK_PTR
    ldm A $self
    stack A $DATASTACK_PTR
    call @STRUCT.get
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 177693
    stack A $DATASTACK_PTR
    ldm A $self
    stack A $DATASTACK_PTR
    call @STRUCT.get
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    call @rt_rnd
    ldi A 15
    ustack B $DATASTACK_PTR
    mul B A
    stack B $DATASTACK_PTR
    ldi A 999
    ustack B $DATASTACK_PTR
    dmod B A
    stack B $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@Screen.init
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_udc_control
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret

# .DATA

% $_snt_n 0
% $_snt_ptr 0
% $_snt_i 0
% $error_mesg9 \S \T \R \U \C \T \. \g \e \t \: \space \F \i \e \l \d \space \n \o \t \space \f \o \u \n \d \Return \null
% $error_mesg10 \S \T \R \U \C \T \. \p \u \t \: \space \F \i \e \l \d \space \n \o \t \space \f \o \u \n \d \Return \null
% $_sn_type_ptr 0
% $_sn_n 0
% $_sn_inst_ptr 0
% $_sn_i 0
% $_sp_inst_ptr 0
% $_sp_hash 0
% $_sp_val 0
% $_sp_type_ptr 0
% $_sp_n 0
% $_sp_i 0
% $_sp_found 0
% $_sg_inst_ptr 0
% $_sg_hash 0
% $_sg_type_ptr 0
% $_sg_n 0
% $_sg_i 0
% $_sg_found 0
% $self 0
% $iter 0
% $r 0
% $target 0
% $_main_str_0 \T \o \t \a \l \space \r \u \n \space \t \i \m \e \: \space \null
% $_main_str_1 \! \! \Return \null
