# .HEADER
. $_main_str_0 40
. $_main_str_1 37
. $_main_str_2 16

# .CODE
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
:test_loop
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_0
    call @rt_dup
    call @rt_dup
    call @PRTchar
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_print_tos
    ldi A 32
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_1
    jmp :test_end_loop
:_main_if_end_1
:_main_if_end_0
    jmp :test_loop
:test_end_loop
    ret

# .DATA
% $_main_str_0 \P \r \e \s \s \space \a \n \space \k \e \y \space \a \n \d \space \s \e \e \space \t \h \e \space \A \S \C \C \I \space \v \a \l \u \e \! \space \Return \null
% $_main_str_1 \P \r \e \s \s \space \s \p \a \c \e \b \a \r \space \t \o \space \e \n \d \space \t \h \e \space \p \r \o \g \r \a \m \. \space \Return \null
% $_main_str_2 \space \i \s \space \p \r \e \s \s \e \d \! \space \: \space \null
