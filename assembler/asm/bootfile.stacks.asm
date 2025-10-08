# .CODE

    ldi Z 0                 ; init Z register to 0
    call @init_interrupt_vector_table
    ldi A 12
    call @push_A
    ldi A 34
    call @push_A
    call @rt_add

    :HALT    ; Breakpointg before halt
    halt

    INCLUDE hardware_config.stacks
    INCLUDE keyboard_routines.stacks
    ret
