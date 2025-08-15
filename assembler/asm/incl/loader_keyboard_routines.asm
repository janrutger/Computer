@KBD_INIT
    . $KBD_IO_BASE_POINTER 1
    ldi M ~VAR_START
    subi M 8
    sto M $KBD_IO_BASE_POINTER

    # define an circular inputbuffer to place the input in

ret




@KBD_ISR
    ldi I 0                     ; KBD read register is 0
    ldx C $KBD_IO_BASE_POINTER  ; Read register to C

    call @print_char

    # Place the value in buffer, insted of printing it

rti