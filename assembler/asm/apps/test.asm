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
. $name 1
. $age 1
. $city 1
. $none 1
. $t_person 1
. $person1 1
. $_main_str_0 4
. $person2 1
. $_main_str_1 10
. $_main_str_2 2
. $_main_str_3 10
. $Person.greet_str_4 19
. $Person.greet_str_5 8
. $Person.greet_str_6 3

# .CODE
    ldi A 6385503302
    sto A $name
    ldi A 193486130
    sto A $age
    ldi A 6385116958
    sto A $city
    ldi A 6385518581
    sto A $none
    ldm A $name
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldm A $age
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldm A $name
    stack A $DATASTACK_PTR
    ldm A $age
    stack A $DATASTACK_PTR
    ldm A $city
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @STRUCT.new_type
    ustack A $DATASTACK_PTR
    sto A $t_person
    stack A $DATASTACK_PTR
    call @STRUCT.new
    ustack A $DATASTACK_PTR
    sto A $person1
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    ldm A $name
    stack A $DATASTACK_PTR
    ldm A $person1
    stack A $DATASTACK_PTR
    call @STRUCT.put
    ldi A 58
    stack A $DATASTACK_PTR
    ldm A $age
    stack A $DATASTACK_PTR
    ldm A $person1
    stack A $DATASTACK_PTR
    call @STRUCT.put
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $city
    stack A $DATASTACK_PTR
    ldm A $person1
    stack A $DATASTACK_PTR
    call @STRUCT.put
    ldm A $t_person
    stack A $DATASTACK_PTR
    call @STRUCT.new
    ustack A $DATASTACK_PTR
    sto A $person2
    ldi A 42
    stack A $DATASTACK_PTR
    ldm A $age
    stack A $DATASTACK_PTR
    ldm A $person2
    stack A $DATASTACK_PTR
    call @STRUCT.put
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $city
    stack A $DATASTACK_PTR
    ldm A $person2
    stack A $DATASTACK_PTR
    call @STRUCT.put
:debug
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $name
    stack A $DATASTACK_PTR
    ldm A $person1
    stack A $DATASTACK_PTR
    call @STRUCT.get
    call @rt_dup
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_0
    call @PRTstring
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    jmp :_main_if_end_0
:_main_if_else_0
    call @rt_drop
:_main_if_end_0
    ldm A $age
    stack A $DATASTACK_PTR
    ldm A $person1
    stack A $DATASTACK_PTR
    call @STRUCT.get
    call @rt_print_tos
    ldm A $city
    stack A $DATASTACK_PTR
    ldm A $person1
    stack A $DATASTACK_PTR
    call @STRUCT.get
    call @rt_print_tos
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $name
    stack A $DATASTACK_PTR
    ldm A $person2
    stack A $DATASTACK_PTR
    call @STRUCT.get
    call @rt_dup
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_else_1
    call @PRTstring
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    jmp :_main_if_end_1
:_main_if_else_1
    call @rt_drop
:_main_if_end_1
    ldm A $age
    stack A $DATASTACK_PTR
    ldm A $person2
    stack A $DATASTACK_PTR
    call @STRUCT.get
    call @rt_print_tos
    ldm A $city
    stack A $DATASTACK_PTR
    ldm A $person2
    stack A $DATASTACK_PTR
    call @STRUCT.get
    call @rt_print_tos
    ldm A $person1
    stack A $DATASTACK_PTR
    call @Person.greet
    ldm A $person2
    stack A $DATASTACK_PTR
    call @Person.greet
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

@Person.greet
    ustack A $DATASTACK_PTR
    sto A $self
    ldi A $Person.greet_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $name
    stack A $DATASTACK_PTR
    ldm A $self
    stack A $DATASTACK_PTR
    call @STRUCT.get
    call @rt_dup
    stack Z $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :Person.greet_if_else_2
    call @PRTstring
    jmp :Person.greet_if_end_2
:Person.greet_if_else_2
    call @rt_drop
    ldi A $Person.greet_str_5
    stack A $DATASTACK_PTR
    call @PRTstring
:Person.greet_if_end_2
    ldi A $Person.greet_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
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
% $_main_str_0 \J \a \n \null
% $_main_str_1 \p \e \r \s \o \n \space \1 \Return \null
% $_main_str_2 \Return \null
% $_main_str_3 \p \e \r \s \o \n \space \2 \Return \null
% $Person.greet_str_4 \H \e \l \l \o \, \space \m \y \space \n \a \m \e \space \i \s \space \null
% $Person.greet_str_5 \U \n \k \n \o \w \n \null
% $Person.greet_str_6 \. \Return \null
