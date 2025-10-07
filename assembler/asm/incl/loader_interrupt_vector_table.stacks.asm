# .CODE

# .FUNCTIONS
@init_interrupt_vector_table

        ldi I 0             ; Interrupt vector (0 is keyboard)
        ldi M @KBD_ISR      ; ISR start adres
        stx M $INT_VECTORS  ; Store ISR adres as pointer

        # Next interrupt vector
        ret
