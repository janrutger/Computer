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
. $start_kernel_str_9 5
. $start_kernel_str_10 20
. $start_kernel_str_11 9
. $start_kernel_str_12 2
. $token_string 17
. $start_kernel_str_13 22
. $start_kernel_str_14 10

# .CODE

# .FUNCTIONS

@_read_disk_block

        ldi I ~SYS_F_READ_BLOCK
        int $INT_VECTORS
        # After read block 12 (or less) bytes from the file are loaded in $disk_io_buffer
        # \null terminated

        # reset Disk_io_buffer_prt
        sto Z $disk_io_buffer_ptr

        # Check for error
        ldm A $SYSCALL_RETURN_STATUS
        tste A Z
        ret
@_check_last_block

        ldm A $SYSCALL_RETURN_VALUE ; check if it was the last block
        tst A 1
        ret
@_read_next_block

        call @_check_last_block
        jmpt :close_and_end
        call @_read_disk_block
        jmpt :close_and_end

        ret
        ret
@load_bin_file

        # Pointer to File_name_string on the stack (kernel_stacks.asm)
        ustack A $DATASTACK_PTR     ; Pop filename pointer into A
        
        ##
        ldi I ~SYS_F_OPEN_READ      ; Open the file for read
        int $INT_VECTORS

        ldm A $SYSCALL_RETURN_STATUS
        tste A Z               ; Status is 1 at success
        jmpt :cmd_load_end     ; do nothing when file error, mesage is already printed

        . $mem_adres 1
        . $mem_val 1

        # read the first disk block
        call @_read_disk_block
        jmpt :close_and_end ; if error, close file and end

        :read_disk_loop
            # 1 find the adres from the input buffer
            #   an number seperated by an space (32)
            #   2 blocks can be needed

            # reset adres and value
            sto Z $mem_adres
            sto Z $mem_val

        :adres_lookup_loop
            inc I $disk_io_buffer_ptr
            ldx C $disk_io_buffer_base
            tst C \null
            jmpf :skip_next0                     ; End of input buffer
                call @_read_next_block
                inc I $disk_io_buffer_ptr
                ldx C $disk_io_buffer_base

            :skip_next0

            tst C \space                    ; check for adres delimiter
            jmpt :value_lookup_loop         ; $mem_adres containts the adres

            ldm A $mem_adres
            muli A 10                       ; shift result by 10
            subi C 48                       ; Substract ascci offset
            add A C 
            sto A $mem_adres

            jmp :adres_lookup_loop
            
        # 2 Find the value of that adres from the input buffer
        #   an number seperated by Return (13)
        #   2 block van be needed
        :value_lookup_loop  
            inc I $disk_io_buffer_ptr
            ldx C $disk_io_buffer_base
            tst C \null                     ; End of input buffer
            jmpf :skip_next1 
                call @_read_next_block
                inc I $disk_io_buffer_ptr
                ldx C $disk_io_buffer_base

            :skip_next1

            tst C \Return                   ; check for value delimiter
            jmpt :store_adres_value_pair

            ldm A $mem_val
            muli A 10                       ; shift result by 10
            subi C 48                       ; Substract ascci offset
            add A C 
            sto A $mem_val

            jmp :value_lookup_loop

        # 3 Write found value on found adres
        :store_adres_value_pair
            ldm I $mem_adres
            ldm A $mem_val

            stx A $_start_memory_

        # 4 Repeat till last block found
        jmp :read_disk_loop


        :close_and_end
            ldi I ~SYS_F_CLOSE
            int $INT_VECTORS
            pop K               ; Drop return adres, due to jump outside the routine
            
        :cmd_load_end
        ret

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
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TOKENIZE_if_end_0
    ldi A 0
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
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
    ldm A $_strtok_s
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :TOKENIZE_if_end_2
    ldm A $_strtok_s
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
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
    ldi A 0
    ld B A
    ldm I $_strtok_p
    stx B $_start_memory_
    ldm A $_strtok_s
    stack A $DATASTACK_PTR
    ldm A $_strtok_p
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    stack B $DATASTACK_PTR
    jmp :strtok_end
:TOKENIZE_if_end_3
    ldm A $_strtok_p
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldm A $bytecode_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $bytecode_ptr
    ldm A $current_value
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm A $bytecode_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldm A $bytecode_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $bytecode_ptr
    ldm A $current_value
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm A $bytecode_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldm A $bytecode_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $bytecode_ptr
    ldm A $current_value
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm A $bytecode_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $bytecode_ptr
    jmp :write_to_bytecode_end
:WRITE_TO_BYTECODE_if_end_6
    ldm A $current_opcode
    ld B A
    ldm I $bytecode_ptr
    stx B $_start_memory_
    ldm A $bytecode_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldm A $bytecode_execution_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $bytecode_execution_ptr
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 0
    stack A $DATASTACK_PTR
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
    ldm A $bytecode_execution_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    ldm A $bytecode_execution_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
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
    call @PRTstring
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
    ldi A 13
    stack A $DATASTACK_PTR
    call @PRTchar
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_13
    ldm A $current_opcode
    stack A $DATASTACK_PTR
    ldi A 4
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :EXECUTE_BYTECODE_if_end_14
    ldi A $ErrorMessage
    stack A $DATASTACK_PTR
    call @PRTstring
    ldm A $bytecode_execution_ptr
    stack A $DATASTACK_PTR
    ldi A 1
    ustack B $DATASTACK_PTR
    add B A
    ld A B
    sto A $bytecode_execution_ptr
    jmp :execution_loop
:EXECUTE_BYTECODE_if_end_14
    ldi A $ErrorMessage
    stack A $DATASTACK_PTR
    call @PRTstring
    jmp :execution_end
:execution_end
    ret

@start_kernel
    ldi A $start_kernel_str_0
    stack A $DATASTACK_PTR
    call @PRTstring
:main_loop
    ldi A $start_kernel_str_1
    stack A $DATASTACK_PTR
    call @PRTstring
    call @READline
    call @rt_dup
    ldi A $start_kernel_str_2
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
    ldi A 0
    stack A $DATASTACK_PTR
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
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_2
    ldi A 0
    stack A $DATASTACK_PTR
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
    ldi A 0
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_3
    call @rt_drop
    jmp :parser_loop
:start_kernel_if_end_3
    call @rt_dup
    ldi A $start_kernel_str_3
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_4
    ldi A $start_kernel_str_4
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_drop
    ldi A 2
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_4
    call @rt_dup
    ldi A $start_kernel_str_5
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_5
    ldi A $start_kernel_str_6
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_drop
    ldi A 3
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_5
    call @rt_dup
    ldi A $start_kernel_str_7
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_6
    ldi A $start_kernel_str_8
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_drop
    ldi A 5
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_6
    call @rt_dup
    ldi A $start_kernel_str_9
    stack A $DATASTACK_PTR
    call @STRcmp
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_end_7
    ldi A $start_kernel_str_10
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_drop
    ldi A 7
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :parser_loop
:start_kernel_if_end_7
    call @STRatoi
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :start_kernel_if_else_8
    ldi A $start_kernel_str_11
    stack A $DATASTACK_PTR
    call @PRTstring
    call @rt_dup
    call @rt_print_tos
    ldi A $start_kernel_str_12
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 1
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
    jmp :start_kernel_if_end_8
:start_kernel_if_else_8
    ldi A $token_string
    stack A $DATASTACK_PTR
    call @STRcopy
    ldi A $token_string
    stack A $DATASTACK_PTR
    ldi A $start_kernel_str_13
    stack A $DATASTACK_PTR
    call @PRTstring
    ldi A 6
    stack A $DATASTACK_PTR
    call @WRITE_TO_BYTECODE
:start_kernel_if_end_8
    jmp :parser_loop
:end_kernel
    ldi A $start_kernel_str_14
    stack A $DATASTACK_PTR
    call @PRTstring
    ret
@STRcopy

        push A 
        push B
        push C

        ustack B $DATASTACK_PTR     ; pointer to to_string in B
        ustack A $DATASTACK_PTR     ; pointer to from_string in A

        :string_copy_loop
            ld I A 
            ldx C $_start_memory_    ; read char from source

            ld I B 
            stx C $_start_memory_    ; write char to dest

            tst C \null
            jmpt :string_copy_end   ; end of string to copy

            addi A 1
            addi B 1
            jmp :string_copy_loop

        :string_copy_end            ; copy is done

        pop C 
        pop B 
        pop A

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
% $start_kernel_str_9 \L \O \A \D \null
% $start_kernel_str_10 \F \o \u \n \d \space \L \O \A \D \space \c \o \m \m \a \n \d \Return \null
% $start_kernel_str_11 \N \u \m \b \e \r \: \space \null
% $start_kernel_str_12 \Return \null
% $start_kernel_str_13 \F \o \u \n \d \space \a \n \space \s \t \r \i \n \g \space \t \o \k \e \n \null
% $start_kernel_str_14 \E \x \i \t \i \n \g \. \Return \null
