. $kernel_prompt 4
% $kernel_prompt \> \> \space \null         ; Dear Gemini, do not mess with this line

# This is/must be the first line of code of the kernel
@init_kernel
    call @init_kernel_syscalls
    ; Print welcome message
    ldi A $WELCOME_MESSAGE  ; Load address of welcome message into A
    ldi I ~SYS_PRINT_STRING ; Syscall for print_string
    int $INT_VECTORS

    ### init the command lookup tables
    call @init_command_lookup_tables

    # start the kernel after init is done
    call @main_loop

ret


@main_loop
    ldi A $kernel_prompt        ; print the prompt
    ldi I ~SYS_PRINT_STRING
    int $INT_VECTORS

    ; Print initial cursor
    ldi I ~SYS_PRINT_CURSOR
    int $INT_VECTORS

    call @cli_main_loop
    ret

INCLUDE kernel_syscalls
INCLUDE kernel_cliV4
INCLUDE kernel_runtime.stacks
INCLUDE kernel_rt_random.stacks
INCLUDE kernel_interpreter
INCLUDE kernel_tokenizer1
INCLUDE kernel_command_definitions
INCLUDE kernel_command_lookup_tables
INCLUDE kernel_stacks



