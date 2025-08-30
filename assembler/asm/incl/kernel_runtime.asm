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
:debug
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
    tstg L M
    jmpt :run_loop_end

    ld I L
    subi I 1
    ldx A $LINE_INDEX_ARRAY_BASE    ; A cointains the line index 
    addi A $PROG_BUFFER             ; Add start adres of buffer to get linestart adres

    call @init_tokenizer_buffer 
    call @execute_command_buffer

    jmp :run_loop

:run_loop_end
    ldi C \Return
    ldi I ~SYS_PRINT_CHAR
    int $INT_VECTORS

    ret