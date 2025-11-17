# .HEADER
. $_main_str_0 31

# .CODE
    call @TOS.check
    call @rt_print_tos
    ldi A 1
    stack A $DATASTACK_PTR
    call @TOS.check
    call @rt_print_tos
    ldi A 2
    stack A $DATASTACK_PTR
    call @TOS.check
    call @rt_print_tos
    ldi A 3
    stack A $DATASTACK_PTR
    call @TOS.check
    call @rt_print_tos
    ldi A 4
    stack A $DATASTACK_PTR
    call @TOS.check
    call @rt_print_tos
    call @TOS.check
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_print_tos
    ret

# .DATA
% $_main_str_0 \R \e \m \a \i \n \i \n \g \space \i \t \e \m \s \space \o \n \space \t \h \e \space \s \t \a \c \k \: \space \null
