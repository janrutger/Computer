# .HEADER
. $_start_memory_ 1
. $hello_msg 16

# .CODE
    call @hello_from_asm
    ret

# .FUNCTIONS
@hello_from_asm

        ; This is just the body of the function.
        ldi A $hello_msg    ; Load the address of our message into register A
        ldi ~SYS_PRINT_STRING        ; Push the address onto the stack
        int $INT_VECTORS  ; Call the runtime routine that prints a string
        ret

# .DATA
% $_start_memory_ 0
% $hello_msg \H \e \l \l \o \space \f \r \o \m \space \A \S \M \! \null
