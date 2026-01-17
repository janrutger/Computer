# .HEADER
. $_main_str_0 14
. $_main_str_1 13
. $name 1
. $age 1
. $_main_str_2 4

# .CODE
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @STRhash
    call @rt_print_tos
    ldi A 8978712370216473075906
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A 6385503302
    sto A $name
    ldi A 193486130
    sto A $age
    ldm A $name
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldm A $age
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @rt_print_tos
    ret

# .DATA
% $_main_str_0 \H \e \l \l \o \space \W \o \r \l \d \! \Return \null
% $_main_str_1 \H \e \l \l \o \space \W \o \r \l \d \! \null
% $_main_str_2 \A \B \C \null
