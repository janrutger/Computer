# .CODE
    ldi A 12
    call @push_A
    call @rt_print_tos
    ldi A 42
    call @push_A
    call @rt_print_tos
