# .HEADER
. $_main_str_0 50
. $_main_str_1 9
. $_main_str_2 2
. $_main_str_3 17
. $_main_str_4 4

# .CODE
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    stack Z $DATASTACK_PTR
    call @TIME.start
    ldi A 24
    stack A $DATASTACK_PTR
    call @fib
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_print_tos
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    stack Z $DATASTACK_PTR
    call @TIME.read
    call @TIME.as_string
    ldi A $_main_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    ret

# .FUNCTIONS
@fib
    call @rt_dup
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_lt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :fib_if_end_0
    jmp :fib_end
:fib_if_end_0
    call @rt_dup
    ldi A 1
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @fib
    call @rt_swap
    ldi A 2
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @fib
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
:fib_end
    ret

# .DATA
% $_main_str_0 \C \a \l \c \u \l \a \t \i \n \g \space \f \i \b \( \2 \4 \) \. \. \. \space \T \h \i \s \space \w \i \l \l \space \t \a \k \e \space \s \o \m \e \space \t \i \m \e \. \Return \null
% $_main_str_1 \R \e \s \u \l \t \: \space \null
% $_main_str_2 \Return \null
% $_main_str_3 \T \o \t \a \l \space \r \u \n \space \t \i \m \e \: \space \null
% $_main_str_4 \! \! \Return \null
