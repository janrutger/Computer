# .HEADER
. $_start_memory_ 1
. $hello_msg 17
. $str_0 6
. $str_1 5

# .CODE
    ldi A $str_0
    call @push_A
    ldi A $str_1
    call @push_A
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
% $_start_memory_ 0
% $hello_msg \H \e \l \l \o \space \f \r \o \m \space \A \S \M \! \Return \null
% $str_0 \t \e \s \t \1 \null
% $str_1 \t \e \s \t \null
