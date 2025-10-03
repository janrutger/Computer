# .HEADER
. $_start_memory_ 1

# .CODE
    ldi A 42
    call @push_A
    call @rt_print_tos

# .DATA
% $_start_memory_ 0
