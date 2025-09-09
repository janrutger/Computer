; Kernel Runtime Routines

@push_A
    inc I $DATASTACK_INDEX  ; Load current stack pointer into I 
    stx A $DATASTACK_PTR    ; Store value from A at index I
    ret

@pop_A
    dec I $DATASTACK_INDEX  ; Load current stack pointer into I
    ldx A $DATASTACK_PTR    ; Load value from index I into A
    ret

@push_B
    inc I $DATASTACK_INDEX  ; Load current stack pointer into I 
    stx B $DATASTACK_PTR    ; Store value from B at index I
    ret

@pop_B
    dec I $DATASTACK_INDEX  ; Load current stack pointer into I
    ldx B $DATASTACK_PTR    ; Load value from index I into B
    ret


@rt_add
    call @pop_A
    call @pop_B
    add A B
    call @push_A
ret

@rt_print_tos
    call @pop_A
    ld C A

    ldi I ~SYS_PRINT_NUMBER
    int $INT_VECTORS

    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS
ret

@rt_next                    ; read TOS and update the current linepointer (jump/goto)
    call @pop_A
    sto A $line_to_print    ; update the curent line pointer (line_to_print)
ret 

@rt_store_var               ; ! instruction 
    call @pop_A             ; Read the var-number from the stack
    
    ldi B \@                
    tstg A B                ; From A
    jmpf :store_var_no_var
    ldi B \Z                ; including Z 
    tstg A B
    jmpt :store_var_no_var

    call @pop_B             ; read the value to store
    subi A 65               ; calc the VAR pointer
    ld I A                  ; Pointr to Index register
    stx B $STACKS_VARS_BASE ; Store B at I in VARS
:store_var_no_var    
ret

@rt_restore_var             ; @ instruction 
    call @pop_A             ; Read the var-number from the stack

    ldi B \@                
    tstg A B                ; From A
    jmpf :restore_var_no_var
    ldi B \Z                ; including Z 
    tstg A B
    jmpt :restore_var_no_var

    subi A 65               ; calc the VAR pointer
    ld I A                  ; Pointr to Index register
    ldx B $STACKS_VARS_BASE ; read B from I in VARS
    call @push_B            ; read the value to store
:restore_var_no_var    
ret

#### LIST command
. $line_to_print 1 
@rt_stacks_cmd_list
    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ldm C $PROG_BUFFER_PTR  ; test for empty PROG_BUFFER
    tste C Z    
    jmpt :list_loop_end     ; goto end when nothing to print

    ldi C 1                 ; start line to print
    sto C $line_to_print

:list_loop
    inc L $line_to_print            ; L= current line to print, inc line_to_print
    ld I L
    subi I 1                        ; I = current index
    ldx K $LINE_INDEX_ARRAY_BASE    ; hold lineindex in PROG_BUFFER

    ld C L                          ; first print the line number + \space
    ldi I ~SYS_PRINT_NUMBER
    int $INT_VECTORS

    ldi C \space
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    :print_line_loop
        ld I K                      ; I hold the index to PROG_BUFFER line startx
        ldx C $PROG_BUFFER_BASE     ; C hols char from buffer
        tst C \null                 ; check for line termination 
        jmpt :print_line_end  

        ldi I ~SYS_PRINT_CHAR       ; print the char
        int $INT_VECTORS     
        addi K 1                    ; increment index to next char
        jmp :print_line_loop   

    :print_line_end                 ; print a newline
        ldi C \Return
        ldi I ~SYS_PRINT_CHAR
        int $INT_VECTORS


    ldm M $LINE_NUMBER              ; get the next linenumber off the buffer
    subi M 1                        ; get the right pointer by substracting 1
 
    tste M L                        ; compare if M still grater then the last line printed
    jmpf :list_loop                 ; loop to the last line

:list_loop_end
    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS
    ret


#### RUN command
@rt_stacks_cmd_run
    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ldm C $PROG_BUFFER_PTR  ; test for empty PROG_BUFFER
    tste C Z    
    jmpt :run_loop_end     ; goto end when nothing to print

    ldi C 1
    sto C $line_to_print

:run_loop
    inc L $line_to_print
    ldm M $LINE_NUMBER
    tste L M                ; by using tste, tstg, iam fixing a bug i hope
    jmpt :run_loop_end

    ld I L
    subi I 1
    ldx A $LINE_INDEX_ARRAY_BASE    ; A cointains the line index 
    addi A $PROG_BUFFER             ; Add start adres of buffer to get linestart adres

    call @init_tokenizer_buffer 
    call @execute_command_buffer   ; to call the old executer

    ## running the new one
    ; ldi A 1         ; set the execution mode to 1 (program mode) in A
    ; call @run_stacks

    jmp :run_loop

:run_loop_end
    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ret

@rt_stacks_cmd_run2         ; this runs the new implementation
    ; First, check if there is any code to run.
    ldm A $PROG_BUFFER_PTR
    tste A Z
    jmpt :rt_run_empty ; If buffer pointer is zero, do nothing.

    ; --- This is the new logic ---
    ; Set mode to 1 (program mode) and call the compiler.
    ; It will handle scanning and compiling the entire buffer at once.
    
    ldm A $PROG_BUFFER_BASE
    ldm B $PROG_BUFFER_PTR
    call @init_tokenizer_buffer

    ldi A 1
    call @run_stacks

:rt_run_empty
    ret


#### LOAD command
@rt_stacks_cmd_load
    . $test_filename 8
    % $test_filename \p \r \o \g \r \a \m \null

    ldi A $test_filename
    
    ##
    ldi I ~SYS_F_OPEN_READ
    int $INT_VECTORS

    ldm A $SYSCALL_RETURN_STATUS
    tste A Z               ; Status is 1 at success
    jmpt :cmd_load_end     ; do nothing when file error, mesage is already printed

    ; File opened successfully, now read the content
    sto Z $PROG_BUFFER_PTR          ; reset progbuffer pointer to 0
    sto Z $PROG_BUFFER_WRITE_PTR
    sto Z $LINE_NUMBER              ; reset line number to 0 (line 1 == index 0)
    sto Z $PROG_BUFFER_TEMP_PTR


:read_loop
    ldi I ~SYS_F_READ_BLOCK
    int $INT_VECTORS

    ldm A $SYSCALL_RETURN_STATUS
    tste A Z
    jmpt :close_and_end ; if error, close file and end

    call @load_block_to_prog_buffer

    ldm A $SYSCALL_RETURN_VALUE ; check if it was the last block
    tste A Z

    jmpt :read_loop ; if not last block, continue reading

    inc I $LINE_NUMBER


:close_and_end
    ldi I ~SYS_F_CLOSE
    int $INT_VECTORS

:cmd_load_end
    ret  ; end of load command


#### SAVE command
@rt_stacks_cmd_save

    ; . $test_filename 8  ; already done in the read command
    ; % $test_filename \p \r \o \g \r \a \m \null

    ldi A $test_filename

    ##
    # first, check if the PROG_BUFFER is maybe empty
    ldm B $PROG_BUFFER_PTR
    tste B Z
    jmpt :cmd_save_end

    ldi I ~SYS_F_OPEN_WRITE ; expect  file pointer in A
    int $INT_VECTORS

    ldm A $SYSCALL_RETURN_STATUS
    tste A Z               ; Status is 1 at success
    jmpt :cmd_save_end     ; do nothing when file error, mesage is already printed

    sto Z $PROG_BUFFER_TEMP_PTR
    call @save_all_blocks_from_prog_buffer
    
;
:close_and_save_end
    ldi I ~SYS_F_CLOSE
    int $INT_VECTORS

:cmd_save_end
ret


EQU ~DISK_BLOCK_SIZE 12
. $byte_to_copy 1

#### Helpers from here
@save_all_blocks_from_prog_buffer   ; save PROG_BUFFER to disk in blocks of 12 bytes

:next_block_loop
    sto Z $disk_io_buffer_ptr   ; reset buffer pointer for each block

    ldm A $PROG_BUFFER_PTR      ; Points to the next free posssition
    ldm B $PROG_BUFFER_TEMP_PTR ; Hold the current possition while copying


    sub A B                     ; A hold the remaining bytes to copy
    tste A Z                    ; exit it all byte are done

    jmpt :end_of_save_blocks

    ldi B ~DISK_BLOCK_SIZE
    tstg A B                    ; check for partial, or last full block
    sto A $byte_to_copy         ; save the numbers to copy
    jmpf :do_save_this_block
    sto B $byte_to_copy         ; copy a full block

    :do_save_this_block
        ; needs - $PROG_BUFFER_TEMP_PTR (0 at the first block)
        ;       - $disk_io_buffer_base $disk_io_buffer_ptr
        ;       - $byte_to_copy


        :save_inner_loop        ; copy 1 by 1
            inc I $PROG_BUFFER_TEMP_PTR
            ldx M $PROG_BUFFER_BASE     ; M hold the byte from PROG_BUFFER
            
            tst M \null
            jmpf :save_proceed
            ldi M \Return
        :save_proceed
            inc I $disk_io_buffer_ptr
            stx M $disk_io_buffer_base
        
            dec C $byte_to_copy
            tste C Z
            jmpf :save_inner_loop

    # this block is in the disk_io_buffer now
    ldm i $disk_io_buffer_ptr       ; write \null termination, at the end
    stx Z $disk_io_buffer_base      ; at index 13 or ealier, when block incompleet

    ldi I ~SYS_F_WRITE_BLOCK
    int $INT_VECTORS

    ldm A $SYSCALL_RETURN_STATUS
    tste A Z                 ; Status is 1 at success
    jmpt :end_of_save_blocks ; do nothing when file error, mesage is already printed

    jmp :next_block_loop

:end_of_save_blocks

ret

### copy diskblock to programbuffer, disk read operation
. $PROG_BUFFER_WRITE_PTR 1
. $PROG_BUFFER_TEMP_PTR 1

@load_block_to_prog_buffer
    push A
    push B
    ; push I        ; is not nessesery, you never can trust I

   ; ldm K $PROG_BUFFER_WRITE_PTR ; K is the write pointer for PROG_BUFFER
    ldi B $disk_io_buffer        ; I is the read pointer for disk_io_buffer

:copy_loop
    ld I B
    ldx A $start_memory         ; read from disk_io_buffer (I is index)
    tste A Z                     ; check for null terminator
    jmpt :copy_loop_end

    tst A \Return
    jmpt :write_line_number

    inc I $PROG_BUFFER_WRITE_PTR ; load I and increments $PROG_BUFFER_WRITE_PTR for PROG_BUFFER
    stx A $PROG_BUFFER_BASE      ; write to PROG_BUFFER

:read_next
    addi B 1
    jmp :copy_loop

:copy_loop_end
    ldm A $PROG_BUFFER_WRITE_PTR ; load the last buffer adres
    sto A $PROG_BUFFER_PTR       ; update the size of prog buffer

    ;ldm A $PROG_BUFFER_WRITE_PTR
    ;sto A $PROG_BUFFER_TEMP_PTR

    ldm I $LINE_NUMBER          
    stx Z $LINE_INDEX_ARRAY_BASE ; terminate line index

    pop B
    pop A
    ret

:write_line_number
    ldi A \null                  ; Line termination
    inc I $PROG_BUFFER_WRITE_PTR ; load I and increments $PROG_BUFFER_WRITE_PTR for PROG_BUFFER
    stx A $PROG_BUFFER_BASE      ; write to PROG_BUFFER

    inc I $LINE_NUMBER           ; Load I and increments $LINE_NUMBER
    ldm A $PROG_BUFFER_TEMP_PTR  ; load the last used start pointer
    stx A $LINE_INDEX_ARRAY_BASE ; Store pointer inn line index

    ldm A $PROG_BUFFER_WRITE_PTR
    sto A $PROG_BUFFER_TEMP_PTR  ; update the new start point for the next line
    jmp :read_next

