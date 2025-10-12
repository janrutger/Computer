# .HEADER
. $test1 1
. $test 9
. $_strtok_s 1
. $_strtok_d 1
. $_strtok_p 1
. $_strtok_c 1
. $rpn_input_ptr 1
. $str_0 50
. $str_1 4
. $str_2 2
. $str_3 2
. $str_4 20
. $str_5 6
. $str_6 21
. $str_7 9
. $str_8 2
. $str_9 29
. $str_10 10

# .CODE

# .FUNCTIONS


@testing
    ret

@TOKENIZE
    call @pop_A
    sto A $_strtok_d
    call @pop_A
    sto A $_strtok_s
    ldm A $_strtok_s
    call @push_A
    call @pop_A
    sto A $_strtok_p
:strtok_loop
    ldm I $_strtok_p
    ldx A $_start_memory_
    call @push_A
    call @pop_A
    sto A $_strtok_c
    ldm A $_strtok_c
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TOKENIZE_if_end_0
    ldm A $_strtok_s
    call @push_A
    ldi A 0
    call @push_A
    jmp :strtok_end
:TOKENIZE_if_end_0
    ldm A $_strtok_c
    call @push_A
    ldm A $_strtok_d
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TOKENIZE_if_end_1
    ldi A 0
    call @push_A
    call @pop_B
    ldm I $_strtok_p
    stx B $_start_memory_
    ldm A $_strtok_s
    call @push_A
    ldm A $_strtok_p
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    jmp :strtok_end
:TOKENIZE_if_end_1
    ldm A $_strtok_p
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $_strtok_p
    jmp :strtok_loop
:strtok_end
    ret

@start_kernel
    ldi A $str_0
    call @push_A
    call @PRTstring
:main_loop
    ldi A $str_1
    call @push_A
    call @PRTstring
    call @READline
    call @rt_dup
    ldi A $str_2
    call @push_A
    call @STRcmp
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_0
    call @rt_drop
    jmp :end_app
:start_kernel_if_end_0
    call @pop_A
    sto A $rpn_input_ptr
:parser_loop
    ldm A $rpn_input_ptr
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_1
    jmp :main_loop
:start_kernel_if_end_1
    ldm A $rpn_input_ptr
    call @push_A
    ldi A 32
    call @push_A
    call @TOKENIZE
    call @pop_A
    sto A $rpn_input_ptr
    call @rt_dup
    ldi A $str_3
    call @push_A
    call @STRcmp
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_2
    ldi A $str_4
    call @push_A
    call @PRTstring
    call @rt_drop
    jmp :parser_loop
:start_kernel_if_end_2
    call @rt_dup
    ldi A $str_5
    call @push_A
    call @STRcmp
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_3
    ldi A $str_6
    call @push_A
    call @PRTstring
    call @rt_drop
    jmp :parser_loop
:start_kernel_if_end_3
    call @STRatoi
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_else_4
    ldi A $str_7
    call @push_A
    call @PRTstring
    call @rt_print_tos
    ldi A $str_8
    call @push_A
    call @PRTstring
    jmp :start_kernel_if_end_4
:start_kernel_if_else_4
    call @rt_drop
    ldi A $str_9
    call @push_A
    call @PRTstring
:start_kernel_if_end_4
    jmp :parser_loop
:end_app
    ldi A $str_10
    call @push_A
    call @PRTstring
    ret

# .DATA


% $test1 10
% $test \M \y \S \t \r \i \n \g \null
% $_strtok_s 0
% $_strtok_d 0
% $_strtok_p 0
% $_strtok_c 0
% $rpn_input_ptr 0
% $str_0 \R \P \N \space \C \a \l \c \u \l \a \t \o \r \. \space \E \n \t \e \r \space \e \x \p \r \e \s \s \i \o \n \space \o \r \space \' \q \' \space \t \o \space \q \u \i \t \. \Return \null
% $str_1 \> \> \space \null
% $str_2 \q \null
% $str_3 \+ \null
% $str_4 \F \o \u \n \d \space \A \D \D \space \o \p \e \r \a \t \o \r \Return \null
% $str_5 \P \R \I \N \T \null
% $str_6 \F \o \u \n \d \space \P \R \I \N \T \space \c \o \m \m \a \n \d \Return \null
% $str_7 \N \u \m \b \e \r \: \space \null
% $str_8 \Return \null
% $str_9 \S \y \n \t \a \x \space \E \r \r \o \r \: \space \I \n \v \a \l \i \d \space \t \o \k \e \n \Return \null
% $str_10 \E \x \i \t \i \n \g \. \Return \null
