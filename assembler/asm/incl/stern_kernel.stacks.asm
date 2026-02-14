# .HEADER
. $_strtok_s 1
. $_strtok_d 1
. $_strtok_p 1
. $_strtok_c 1
MALLOC $bytecode_buffer 8704
. $bytecode_ptr 1
. $current_opcode 1
. $current_value 1
. $bytecode_execution_ptr 1
. $ErrorMessage 32
. $InfoMessage0 27
. $InfoMessage1 27
. $rpn_input_ptr 1
. $start_kernel_str_0 29
. $start_kernel_str_1 38
. $start_kernel_str_2 2
. $start_kernel_str_3 6
. $start_kernel_str_4 2
. $char_pointer 1
. $start_kernel_str_5 2
. $start_kernel_str_6 20
. $start_kernel_str_7 6
. $start_kernel_str_8 21
. $start_kernel_str_9 5
. $start_kernel_str_10 20
. $start_kernel_str_11 4
. $start_kernel_str_12 19
. $start_kernel_str_13 5
. $start_kernel_str_14 20
. $start_kernel_str_15 9
. $token_string 17
. $start_kernel_str_16 23
. $start_kernel_str_17 10

# .CODE

# .FUNCTIONS

@TOKENIZE
    ustack A $DATASTACK_PTR
    sto A $_strtok_d
    ustack A $DATASTACK_PTR
    sto A $_strtok_s
:skip_delimiters_loop
    ldm I $_strtok_s
    ldx A $_start_memory_
    sto A $_strtok_c
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TOKENIZE_if_end_0
    stack Z $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    jmp :strtok_end
:TOKENIZE_if_end_0
    ldm A $_strtok_c
    stack A $DATASTACK_PTR
    ldm A $_strtok_d
    stack A $DATASTACK_PTR
    call @rt_neq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TOKENIZE_if_end_1
    jmp :find_end_of_token
:TOKENIZE_if_end_1
    ldm B $_strtok_s
    ldi A 1
    add A B
    sto A $_strtok_s
    jmp :skip_delimiters_loop
:find_end_of_token
    ldm A $_strtok_s
    sto A $_strtok_p
:scan_loop
    ldm I $_strtok_p
    ldx A $_start_memory_
    sto A $_strtok_c
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TOKENIZE_if_end_2
    ldm A $_strtok_s
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    jmp :strtok_end
:TOKENIZE_if_end_2
    ldm A $_strtok_c
    stack A $DATASTACK_PTR
    ldm A $_strtok_d
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TOKENIZE_if_end_3
    ld B Z
    ldm I $_strtok_p
    stx B $_start_memory_
    ldm A $_strtok_s
    stack A $DATASTACK_PTR
    ldm B $_strtok_p
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    jmp :strtok_end
:TOKENIZE_if_end_3
    ldm B $_strtok_p
    ldi A 1
    add A B
    sto A $_strtok_p
    jmp :scan_loop
:strtok_end
    ret
@WRITE_TO_BYTECODE
    ustack A $DATASTACK_PTR
    sto A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :WRITE_TO_BYTECODE_if_end_4
    ustack A $DATASTACK_PTR
    sto A $current_value
    ldm A $current_opcode
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm B $bytecode_ptr
    ldi A 1
    add A B
    sto A $bytecode_ptr
    ldm A $current_value
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm B $bytecode_ptr
    ldi A 1
    add A B
    sto A $bytecode_ptr
    jmp :write_to_bytecode_end
:WRITE_TO_BYTECODE_if_end_4
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :WRITE_TO_BYTECODE_if_end_5
    ustack A $DATASTACK_PTR
    sto A $current_value
    ldm A $current_opcode
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm B $bytecode_ptr
    ldi A 1
    add A B
    sto A $bytecode_ptr
    ldm A $current_value
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm B $bytecode_ptr
    ldi A 1
    add A B
    sto A $bytecode_ptr
    jmp :write_to_bytecode_end
:WRITE_TO_BYTECODE_if_end_5
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :WRITE_TO_BYTECODE_if_end_6
    ustack A $DATASTACK_PTR
    sto A $current_value
    ldm A $current_opcode
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm B $bytecode_ptr
    ldi A 1
    add A B
    sto A $bytecode_ptr
    ldm A $current_value
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm B $bytecode_ptr
    ldi A 1
    add A B
    sto A $bytecode_ptr
    jmp :write_to_bytecode_end
:WRITE_TO_BYTECODE_if_end_6
    ldm A $current_opcode
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm B $bytecode_ptr
    ldi A 1
    add A B
    sto A $bytecode_ptr
:write_to_bytecode_end
    ret
@EXECUTE_BYTECODE
    ustack A $DATASTACK_PTR
    sto A $bytecode_execution_ptr
:execution_loop
    ldm I $bytecode_execution_ptr
    ldx A $_start_memory_
    sto A $current_opcode
    ldm B $bytecode_execution_ptr
    ldi A 1
    add A B
    sto A $bytecode_execution_ptr
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_7
    jmp :execution_end
:EXECUTE_BYTECODE_if_end_7
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_8
    ldm I $bytecode_execution_ptr
    ldx A $_start_memory_
    sto A $current_value
    ldm B $bytecode_execution_ptr
    ldi A 1
    add A B
    sto A $bytecode_execution_ptr
    ldm A $current_value
    stack A $DATASTACK_PTR
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_8
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 6
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_9
    ldm I $bytecode_execution_ptr
    ldx A $_start_memory_
    sto A $current_value
    ldm B $bytecode_execution_ptr
    ldi A 1
    add A B
    sto A $bytecode_execution_ptr
    ldm A $current_value
    stack A $DATASTACK_PTR
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_9
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 5
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_10

                ustack A $DATASTACK_PTR
                ld I A
                callx $_start_memory_
                jmp :execution_loop
:EXECUTE_BYTECODE_if_end_10
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 7
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_11
    call @rt_dup

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 13
    stack A $DATASTACK_PTR
    call @PRTchar
    call @load_bin_file
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_11
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_12
    ustack A $DATASTACK_PTR
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_12
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 3
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_13
    call @rt_print_tos
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_13
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 8
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_14
    call @TOS.check
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_else_15
    call @TOS.check
    ldi A $InfoMessage0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @rt_print_tos
    call @rt_dup
    ldi A $InfoMessage1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @rt_print_tos
    jmp :EXECUTE_BYTECODE_if_end_15
:EXECUTE_BYTECODE_if_else_15
    stack Z $DATASTACK_PTR
    ldi A $InfoMessage0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @rt_print_tos
:EXECUTE_BYTECODE_if_end_15
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_14
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_16
    ldi A $ErrorMessage
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    ldm B $bytecode_execution_ptr
    ldi A 1
    add A B
    sto A $bytecode_execution_ptr
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_16
    ldi A $ErrorMessage
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        jmp :execution_end
:execution_end
    ret

@start_kernel
    ldi A $start_kernel_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A $start_kernel_str_1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    :main_loop
    ldi A $start_kernel_str_2
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @TOS.check
    call @PRTnum
    ldi A $start_kernel_str_3
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @READline
    call @rt_dup
    ldi A $start_kernel_str_4
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_0
    call @rt_drop
    jmp :end_kernel
:start_kernel_if_end_0
    call @rt_dup
    ustack A $DATASTACK_PTR
    sto A $char_pointer
    ldm I $char_pointer
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_1
    call @rt_drop
    jmp :main_loop
:start_kernel_if_end_1
    ldi A $bytecode_buffer
    sto A $bytecode_ptr
    ustack A $DATASTACK_PTR
    sto A $rpn_input_ptr
:parser_loop
    ldm A $rpn_input_ptr
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_2
    stack Z $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    ldi A $bytecode_buffer
    stack A $DATASTACK_PTR
    call @EXECUTE_BYTECODE
    jmp :main_loop
:start_kernel_if_end_2
    ldm A $rpn_input_ptr
    stack A $DATASTACK_PTR
    ldi A 32
    stack A $DATASTACK_PTR
    call @TOKENIZE
    ustack A $DATASTACK_PTR
    sto A $rpn_input_ptr
    call @rt_dup
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_3
    call @rt_drop
    jmp :parser_loop
:start_kernel_if_end_3
    call @rt_dup
    ldi A $start_kernel_str_5
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_4
    ldi A $start_kernel_str_6
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @rt_drop
    ldi A 2
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_4
    call @rt_dup
    ldi A $start_kernel_str_7
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_5
    ldi A $start_kernel_str_8
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @rt_drop
    ldi A 3
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_5
    call @rt_dup
    ldi A $start_kernel_str_9
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_6
    ldi A $start_kernel_str_10
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @rt_drop
    ldi A 8
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_6
    call @rt_dup
    ldi A $start_kernel_str_11
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_7
    ldi A $start_kernel_str_12
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @rt_drop
    ldi A 5
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_7
    call @rt_dup
    ldi A $start_kernel_str_13
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_8
    ldi A $start_kernel_str_14
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @rt_drop
    ldi A 7
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_8
    call @STRatoi
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_else_9
    ldi A $start_kernel_str_15
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        call @rt_dup
    call @rt_print_tos
    ldi A 1
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :start_kernel_if_end_9
:start_kernel_if_else_9
    ldi A $token_string
    stack A $DATASTACK_PTR
    call @STRcopy
    ldi A $token_string
    stack A $DATASTACK_PTR
    ldi A $start_kernel_str_16
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ldi A 6
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
:start_kernel_if_end_9
    jmp :parser_loop
:end_kernel
    ldi A $start_kernel_str_17
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ret

# .DATA

% $_strtok_s 0
% $_strtok_d 0
% $_strtok_p 0
% $_strtok_c 0
% $bytecode_ptr 8704
% $current_opcode 1
% $current_value 1
% $bytecode_execution_ptr 3584
% $ErrorMessage \F \a \t \a \l \space \e \r \r \o \r \: \space \a \n \space \i \n \v \a \l \i \d \space \t \o \k \e \n \space \Return \null
% $InfoMessage0 \T \o \t \a \l \space \i \t \e \m \s \space \o \n \space \t \h \e \space \s \t \a \c \k \: \space \null
% $InfoMessage1 \F \i \r \s \t \space \v \a \l \u \e \space \o \n \space \t \h \e \space \s \t \a \c \k \: \space \null
% $rpn_input_ptr 0
% $start_kernel_str_0 \W \E \L \C \O \M \E \space \a \t \space \S \t \e \r \n \space \K \e \r \n \e \l \space \2 \4 \K \Return \null
% $start_kernel_str_1 \Return \E \n \t \e \r \space \i \n \s \t \r \u \c \t \i \o \n \s \space \o \r \space \' \q \' \space \t \o \space \q \u \i \t \. \Return \Return \null
% $start_kernel_str_2 \[ \null
% $start_kernel_str_3 \] \space \> \> \space \null
% $start_kernel_str_4 \q \null
% $start_kernel_str_5 \+ \null
% $start_kernel_str_6 \F \o \u \n \d \space \A \D \D \space \o \p \e \r \a \t \o \r \Return \null
% $start_kernel_str_7 \P \R \I \N \T \null
% $start_kernel_str_8 \F \o \u \n \d \space \P \R \I \N \T \space \c \o \m \m \a \n \d \Return \null
% $start_kernel_str_9 \I \N \F \O \null
% $start_kernel_str_10 \F \o \u \n \d \space \I \N \F \O \space \c \o \m \m \a \n \d \Return \null
% $start_kernel_str_11 \U \S \R \null
% $start_kernel_str_12 \F \o \u \n \d \space \U \S \R \space \c \o \m \m \a \n \d \Return \null
% $start_kernel_str_13 \L \O \A \D \null
% $start_kernel_str_14 \F \o \u \n \d \space \L \O \A \D \space \c \o \m \m \a \n \d \Return \null
% $start_kernel_str_15 \N \u \m \b \e \r \: \space \null
% $start_kernel_str_16 \F \o \u \n \d \space \a \n \space \s \t \r \i \n \g \space \t \o \k \e \n \Return \null
% $start_kernel_str_17 \E \x \i \t \i \n \g \. \Return \null
