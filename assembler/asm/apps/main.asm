# .HEADER
. $hello_msg 34

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
% $hello_msg \P \L \E \A \S \E \space \l \o \a \d \space \a \n \space \p \r \o \g \r \a \m \space \t \o \space \r \u \n \! \! \space \Return \null
