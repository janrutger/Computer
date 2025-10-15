# .HEADER
. $_strtok_s 1
. $_strtok_d 1
. $_strtok_p 1
. $_strtok_c 1
MALLOC $bytecode_buffer 4096
. $bytecode_ptr 1
. $current_opcode 1
. $current_value 1
. $bytecode_execution_ptr 1
. $ErrorMessage 40
. $rpn_input_ptr 1
. $start_kernel_str_0 59
. $start_kernel_str_1 4
. $start_kernel_str_2 2
. $char_pointer 1
. $start_kernel_str_3 2
. $start_kernel_str_4 20
. $start_kernel_str_5 6
. $start_kernel_str_6 21
. $start_kernel_str_7 4
. $start_kernel_str_8 19
. $start_kernel_str_9 9
. $start_kernel_str_10 2
. $start_kernel_str_11 29
. $start_kernel_str_12 10

# .CODE

# .FUNCTIONS

@TOKENIZE
    call @pop_A
    sto A $_strtok_d
    call @pop_A
    sto A $_strtok_s
    ldm A $_strtok_s
    call @push_A
    call @pop_A
    sto A $_strtok_p
:strtok_loop
    ldm I $_strtok_p
    ldx A $_start_memory_
    call @push_A
    call @pop_A
    sto A $_strtok_c
    ldm A $_strtok_c
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TOKENIZE_if_end_0
    ldm A $_strtok_s
    call @push_A
    ldi A 0
    call @push_A
    jmp :strtok_end
:TOKENIZE_if_end_0
    ldm A $_strtok_c
    call @push_A
    ldm A $_strtok_d
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :TOKENIZE_if_end_1
    ldi A 0
    call @push_A
    call @pop_B
    ldm I $_strtok_p
    stx B $_start_memory_
    ldm A $_strtok_s
    call @push_A
    ldm A $_strtok_p
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    jmp :strtok_end
:TOKENIZE_if_end_1
    ldm A $_strtok_p
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $_strtok_p
    jmp :strtok_loop
:strtok_end
    ret
@WRITE_TO_BYTECODE
    call @pop_A
    sto A $current_opcode
    ldm A $current_opcode
    call @push_A
    ldi A 1
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :WRITE_TO_BYTECODE_if_end_2
    call @pop_A
    sto A $current_value
    ldm A $current_opcode
    call @push_A
    call @pop_B
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm A $bytecode_ptr
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $bytecode_ptr
    ldm A $current_value
    call @push_A
    call @pop_B
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm A $bytecode_ptr
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $bytecode_ptr
    jmp :write_to_bytecode_end
:WRITE_TO_BYTECODE_if_end_2
    ldm A $current_opcode
    call @push_A
    ldi A 4
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :WRITE_TO_BYTECODE_if_end_3
    call @pop_A
    sto A $current_value
    ldm A $current_opcode
    call @push_A
    call @pop_B
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm A $bytecode_ptr
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $bytecode_ptr
    ldm A $current_value
    call @push_A
    call @pop_B
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm A $bytecode_ptr
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $bytecode_ptr
    jmp :write_to_bytecode_end
:WRITE_TO_BYTECODE_if_end_3
    ldm A $current_opcode
    call @push_A
    call @pop_B
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm A $bytecode_ptr
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $bytecode_ptr
:write_to_bytecode_end
    ret
@EXECUTE_BYTECODE
    call @pop_A
    sto A $bytecode_execution_ptr
:execution_loop
    ldm I $bytecode_execution_ptr
    ldx A $_start_memory_
    call @push_A
    call @pop_A
    sto A $current_opcode
    ldm A $bytecode_execution_ptr
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $bytecode_execution_ptr
    ldm A $current_opcode
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_4
    jmp :execution_end
:EXECUTE_BYTECODE_if_end_4
    ldm A $current_opcode
    call @push_A
    ldi A 1
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_5
    ldm I $bytecode_execution_ptr
    ldx A $_start_memory_
    call @push_A
    call @pop_A
    sto A $current_value
    ldm A $bytecode_execution_ptr
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $bytecode_execution_ptr
    ldm A $current_value
    call @push_A
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_5
    ldm A $current_opcode
    call @push_A
    ldi A 5
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_6

                call @pop_A
                ld I A
                callx $_start_memory_
                jmp :execution_loop
:EXECUTE_BYTECODE_if_end_6
    ldm A $current_opcode
    call @push_A
    ldi A 2
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_7
    call @rt_add
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_7
    ldm A $current_opcode
    call @push_A
    ldi A 3
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_8
    call @rt_print_tos
    ldi A 13
    call @push_A
    call @PRTchar
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_8
    ldm A $current_opcode
    call @push_A
    ldi A 4
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_9
    ldi A $ErrorMessage
    call @push_A
    call @PRTstring
    ldm A $bytecode_execution_ptr
    call @push_A
    ldi A 1
    call @push_A
    call @rt_add
    call @pop_A
    sto A $bytecode_execution_ptr
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_9
    ldi A $ErrorMessage
    call @push_A
    call @PRTstring
    jmp :execution_end
:execution_end
    ret

@start_kernel
    ldi A $start_kernel_str_0
    call @push_A
    call @PRTstring
:main_loop
    ldi A $start_kernel_str_1
    call @push_A
    call @PRTstring
    call @READline
    call @rt_dup
    ldi A $start_kernel_str_2
    call @push_A
    call @STRcmp
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_0
    call @rt_drop
    jmp :end_kernel
:start_kernel_if_end_0
    call @rt_dup
    call @pop_A
    sto A $char_pointer
    ldm I $char_pointer
    ldx A $_start_memory_
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_1
    call @rt_drop
    jmp :main_loop
:start_kernel_if_end_1
    ldi A $bytecode_buffer
    call @push_A
    call @pop_A
    sto A $bytecode_ptr
    call @pop_A
    sto A $rpn_input_ptr
:parser_loop
    ldm A $rpn_input_ptr
    call @push_A
    ldi A 0
    call @push_A
    call @rt_eq
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_2
    ldi A 0
    call @push_A
    call @WRITE_TO_BYTECODE
    ldi A $bytecode_buffer
    call @push_A
    call @EXECUTE_BYTECODE
    jmp :main_loop
:start_kernel_if_end_2
    ldm A $rpn_input_ptr
    call @push_A
    ldi A 32
    call @push_A
    call @TOKENIZE
    call @pop_A
    sto A $rpn_input_ptr
    call @rt_dup
    ldi A $start_kernel_str_3
    call @push_A
    call @STRcmp
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_3
    ldi A $start_kernel_str_4
    call @push_A
    call @PRTstring
    call @rt_drop
    ldi A 2
    call @push_A
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_3
    call @rt_dup
    ldi A $start_kernel_str_5
    call @push_A
    call @STRcmp
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_4
    ldi A $start_kernel_str_6
    call @push_A
    call @PRTstring
    call @rt_drop
    ldi A 3
    call @push_A
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_4
    call @rt_dup
    ldi A $start_kernel_str_7
    call @push_A
    call @STRcmp
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_end_5
    ldi A $start_kernel_str_8
    call @push_A
    call @PRTstring
    call @rt_drop
    ldi A 5
    call @push_A
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_5
    call @STRatoi
    call @pop_A
    tst A 0
    jmpt :start_kernel_if_else_6
    ldi A $start_kernel_str_9
    call @push_A
    call @PRTstring
    call @rt_dup
    call @rt_print_tos
    ldi A $start_kernel_str_10
    call @push_A
    call @PRTstring
    ldi A 1
    call @push_A
    call @WRITE_TO_BYTECODE
    jmp :start_kernel_if_end_6
:start_kernel_if_else_6
    ldi A $start_kernel_str_11
    call @push_A
    call @PRTstring
    ldi A 4
    call @push_A
    call @WRITE_TO_BYTECODE
:start_kernel_if_end_6
    jmp :parser_loop
:end_kernel
    ldi A $start_kernel_str_12
    call @push_A
    call @PRTstring
    ret

# .DATA

% $_strtok_s 0
% $_strtok_d 0
% $_strtok_p 0
% $_strtok_c 0
% $bytecode_ptr 4096
% $current_opcode 1
% $current_value 1
% $bytecode_execution_ptr 4096
% $ErrorMessage \F \a \t \a \l \space \e \r \r \o \r \: \space \f \o \r \space \n \o \w \, \a \n \space \i \n \v \a \l \i \d \space \t \o \k \e \n \space \Return \null
% $rpn_input_ptr 0
% $start_kernel_str_0 \N \e \w \space \K \e \r \n \e \l \space \C \o \m \m \a \n \d \space \L \i \n \e \: \space \E \n \t \e \r \space \e \x \p \r \e \s \s \i \o \n \space \o \r \space \' \q \' \space \t \o \space \q \u \i \t \. \Return \null
% $start_kernel_str_1 \> \> \space \null
% $start_kernel_str_2 \q \null
% $start_kernel_str_3 \+ \null
% $start_kernel_str_4 \F \o \u \n \d \space \A \D \D \space \o \p \e \r \a \t \o \r \Return \null
% $start_kernel_str_5 \P \R \I \N \T \null
% $start_kernel_str_6 \F \o \u \n \d \space \P \R \I \N \T \space \c \o \m \m \a \n \d \Return \null
% $start_kernel_str_7 \U \S \R \null
% $start_kernel_str_8 \F \o \u \n \d \space \U \S \R \space \c \o \m \m \a \n \d \Return \null
% $start_kernel_str_9 \N \u \m \b \e \r \: \space \null
% $start_kernel_str_10 \Return \null
% $start_kernel_str_11 \S \y \n \t \a \x \space \E \r \r \o \r \: \space \I \n \v \a \l \i \d \space \t \o \k \e \n \Return \null
% $start_kernel_str_12 \E \x \i \t \i \n \g \. \Return \null
