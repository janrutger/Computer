# .HEADER
. $_main_str_0 11

# .CODE
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @STRhash
    call @rt_print_tos
    ldi A 8246906014375474365
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ret

# .DATA
% $_main_str_0 \s \b \c \_ \c \h \a \o \s \3 \null
