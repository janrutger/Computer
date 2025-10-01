# .CODE
    ldi A 10
    call @push_A
    ldi A 20
    call @push_A
    call @rt_add
    call @rt_print_tos
ret