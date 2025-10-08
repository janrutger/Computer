# .CODE

    @KBD_ISR
        # ; --- Get character from keyboard ---
        # ldi I 0                     ; KBD read register is 0
        # ldx C $KBD_IO_BASE_POINTER  ; Read character from device into C
        # ; C holds the input character

        # # \backspace \Return must be stored in the input buffer
        # # the kernel/program knows the meaning, not the KBD 
        # ##################
        # ; check for full buffer
        # ldm M $KBD_WRITE_PNTR   ; get the write pointer
        # addi M 1                ; incr pointer
        # andi M 15               ; check roll over
        # ldm L $KBD_READ_PNTR    ; get the read pointer
        # tste M L                ; if eql, then buffer full
        # jmpt :end_kbd_isr       ; jump to end, if buffer full

        # # Store in buffer
        # inc I $KBD_WRITE_PNTR
        # stx C $KBD_BUFFER_ADRES

        # # check for full buffer
        # ldm M $KBD_WRITE_PNTR
        # andi M 15
        # tste M Z               ; Z contains zero
        # jmpf :end_kbd_isr

        # sto Z $KBD_WRITE_PNTR

    :end_kbd_isr
        rti                         ; Return from interrupt
