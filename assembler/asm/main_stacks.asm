# .HEADER
. $hello_msg 18

# .CODE
    call @hello_from_asm
    ret

# .FUNCTIONS
@hello_from_asm

        ; This is just the body of the function.
        ldi A $hello_msg            ; Load the address of our message into register A
        ldi I ~SYS_PRINT_STRING     ; Load I with the syscall Vector
        int $INT_VECTORS            ; Call the syscall to print the message
        ret

# .DATA
% $hello_msg \H \e \l \l \o \space \f \r \o \m \space \A \S \M \! \space \Return \null
