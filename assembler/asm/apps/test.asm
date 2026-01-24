# .HEADER
. $_main_str_0 12
. $my_array 1
. $_main_str_1 17
. $_main_str_2 13
. $_main_str_3 12

# .CODE
    ldi A $_main_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 5
    stack A $DATASTACK_PTR
    call @NEW.array
    ustack A $DATASTACK_PTR
    sto A $my_array
    ldi A $_main_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 10
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 20
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 30
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 40
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A 50
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.append
    ldi A $_main_str_2
    stack A $DATASTACK_PTR
    call @PRTstring
    stack Z $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @rt_print_tos
    ldi A 1
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @rt_print_tos
    ldi A 2
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @rt_print_tos
    ldi A 3
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @rt_print_tos
    ldi A 4
    stack A $DATASTACK_PTR
    ldm A $my_array
    stack A $DATASTACK_PTR
    call @ARRAY.get
    call @rt_print_tos
:break
    ldi A $_main_str_3
    stack A $DATASTACK_PTR
    call @PRTstring
    ret

# .DATA
% $_main_str_0 \M \a \k \e \space \a \r \r \a \y \Return \null
% $_main_str_1 \A \p \p \e \n \d \space \t \o \space \a \r \r \a \y \Return \null
% $_main_str_2 \P \r \i \n \t \space \a \r \r \a \y \Return \null
% $_main_str_3 \D \o \n \e \space \. \. \. \. \space \Return \null
