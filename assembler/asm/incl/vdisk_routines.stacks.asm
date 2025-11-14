# .HEADER
. $error_wrong_vdisk_filename 28
. $fatal_vdisk_error 25

# .CODE


    # Define register of the disk
    MALLOC $status_register 12272
    MALLOC $command_register 12273
    MALLOC $hostbuffer_adres_register 12274
    MALLOC $filehash_register 12275
    MALLOC $last_block_register 12276

    # Define all disk status codes
    EQU ~DISK_IDLE 0
    EQU ~HOST_WAITING 1
    EQU ~DISK_SUCCESS 2
    EQU ~DISK_ERROR 3
    EQU ~FILE_ERROR 4
    EQU ~HOST_BUSY 5

    # Define all disk command codes
    EQU ~CMD_INIT 0
    EQU ~CMD_OPEN_READ 1
    EQU ~CMD_OPEN_WRITE 2
    EQU ~CMD_CREATE_FILE 3
    EQU ~CMD_READ_BLOCK 4
    EQU ~CMD_WRITE_BLOCK 5
    EQU ~CMD_CLOSE 6

    # Define all block status codes
    EQU ~PENDING_BLOCK 0
    EQU ~LAST_BLOCK 1

    # Create an disk buffer of 13,12 chars + \null for termination
    # since position 13 stays 0, its an auto terminiation when full buffer is used
    . $disk_io_buffer 13
    . $disk_io_buffer_base 1
    % $disk_io_buffer_base $disk_io_buffer
    . $disk_io_buffer_ptr 1


    # Hash function vars
    . $modulo 1
    % $modulo 1000000000000   ; 12 decimal digit hash
    . $filename_pointer 1
    . $temp_hash 1


    @init_vdisk
    :disk_init_loop
        ldm M $status_register
        tst M ~DISK_IDLE
        jmpf :disk_init_loop 

        ldi C $disk_io_buffer       ; this must be set only once, otherwise an buffer problem
        sto C $hostbuffer_adres_register

        ldi C ~CMD_INIT
        sto C $command_register
        :disk_init_wait_loop
            ldm C  $status_register
            tst C ~DISK_IDLE
            jmpt :disk_init_wait_loop

        call @_check_return_status  ; returns status = true when succesfull
        jmpt :disk_init_done
        call @error_fatal_disk_error

    :disk_init_done
    ret

    ; -----------------------------------------------------------------------------
    ; OPEN_FILE_READ - Opens a file on the virtual disk for reading.
    ; IN:  A = address of the null-terminated filename string.
    ; OUT: - status is true, when found, status is false when error
    ;      - file HASH returns in A
    ; -----------------------------------------------------------------------------
    @open_file_read
        # A points to filename buffer
        call @hash_filename
        sto A $filehash_register

        # execute file open command on disk
        ldi A ~CMD_OPEN_READ
        sto A $command_register
        ldi A ~HOST_WAITING
        sto A $status_register

        call @_check_return_status  ; returns status = true when succesfull
                                    ; returns false at file error
                                    ; Halts on disk error
        ldi A ~HOST_BUSY
        sto A $status_register

        jmpt :open_read_success
        jmp  :open_read_error


    :open_read_success
        ldm A $filehash_register
        tste A A
        jmp :open_file_read_end

    :open_read_error               ; error messeage is already printed
        ldm A $filehash_register
        tstg A A 
        jmp :open_file_read_end

    :open_file_read_end
    ret

    ; -----------------------------------------------------------------------------
    ; OPEN_FILE_WRITE - Opens a file on the virtual disk for writing.
    ; IN:    A = address of the null-terminated filename string.
    ; OUT: - status is true, when found, status is false when error
    ;      - file HASH returns in A
    ; -----------------------------------------------------------------------------
    @open_file_write
        # A points to filename buffer
        call @hash_filename
        sto A $filehash_register

        # execute file open command on disk
        ldi A ~CMD_OPEN_WRITE
        sto A $command_register
        ldi A ~HOST_WAITING
        sto A $status_register

        call @_check_return_status  ; returns status = true when succesfull
                                    ; returns false at file error
                                    ; Halts on disk error
        ldi A ~HOST_BUSY
        sto A $status_register

        jmpt :open_write_success
        jmp  :open_write_error


    :open_write_success
        ldm A $filehash_register
        tste A A
        jmp :open_file_write_end

    :open_write_error               ; error messeage is already printed
        ldm A $filehash_register
        tstg A A 
        jmp :open_file_write_end

    :open_file_write_end
    ret



    ; -----------------------------------------------------------------------------
    ; READ_FILEBLOCK - read the current block
    ; IN:  - filename_hash_register contains the file hash
    ; OUT: - status is true when succeed, orherwise statu is false
    ;      - Blok is copied to the diskbuffer (by the disk)
    ;      - set last_block_register if needed (by the disk)
    ; -----------------------------------------------------------------------------
    @read_file_block
        ldi A ~CMD_READ_BLOCK   ; Set command buffer
        sto A $command_register
        ldi A ~HOST_WAITING     ; Set status buffer
        sto A $status_register

        call @_check_return_status  ; returns status = true when succesfull
                                    ; returns false at file error
                                    ; Halts on disk error
        ldi A ~HOST_BUSY
        sto A $status_register
        jmpt :read_block_success
        jmp :read_block_error

    :read_block_success
        tste A A 
        jmp :read_block_end

    :read_block_error
        tstg A A 
        jmp :read_block_end

    :read_block_end
    ret

    ; -----------------------------------------------------------------------------
    ; WRITE_FILEBLOCK - write the current block
    ; IN:  - filename_hash_register contains the file hash
    ; OUT: - status is true when succeed, orherwise statu is false
    ;      - Blok is copied from the diskbuffer (by the disk)
    ; -----------------------------------------------------------------------------
    @write_file_block
    
        ldi A ~CMD_WRITE_BLOCK   ; Set command buffer
        sto A $command_register
        ldi A ~HOST_WAITING     ; Set status buffer
        sto A $status_register

        call @_check_return_status  ; returns status = true when succesfull
                                    ; returns false at file error
                                    ; Halts on disk error
        ldi A ~HOST_BUSY
        sto A $status_register
        jmpt :write_block_success
        jmp :write_block_error

    :write_block_success
        tste A A 
        jmp :write_block_end

    :write_block_error
        tstg A A 
        jmp :write_block_end

    :write_block_end
    ret

    ; -----------------------------------------------------------------------------
    ; CLOSE_FILE - Opens a file on the virtual disk for reading.
    ; IN:  - filename_hash_register contains the file hash
    ; OUT: - status is true, when closed, status is false when error
    ; -----------------------------------------------------------------------------
    @close_file
        ldi A ~CMD_CLOSE   ; Set command buffer
        sto A $command_register
        ldi A ~HOST_WAITING     ; Set status buffer
        sto A $status_register

        call @_check_return_status  ; returns status = true when succesfull
                                    ; returns false at file error
                                    ; Halts on disk error       
        ldi A ~HOST_BUSY
        sto A $status_register
        jmpt :close_file_success
        jmp :close_file_error

    :close_file_success
        tste A A 
        jmp :close_file_end

    :close_file_error
        tstg A A 
        jmp :close_file_end

    :close_file_end
    ret


    @hash_filename
    # expects A is the pointer to the filename string
    # Filename is \null terminated
    # return hash in A
    push M
    push K

    sto A $filename_pointer ; save the pointer
    ldi I 0                 ; set the read index to 0
    sto Z $temp_hash        ; set the hash to 0


    :hash_loop
        ldm K $modulo
        ldx A $filename_pointer
        tst A \null
        jmpt :end_hash_return

        # calculate the hash
        ldm M $temp_hash
        muli M 31
        add M A
        dmod M K
        sto K $temp_hash

        addi I 1
        jmp :hash_loop

    :end_hash_return
        ldm A $temp_hash

        pop M
        pop K
    ret 

    ### Helper routines
    @_check_return_status
        ldm M $status_register
        tst M ~DISK_SUCCESS
        jmpt :return_succes_status
        
        tst M ~FILE_ERROR
        jmpt :return_file_error_status

        tst M ~DISK_ERROR
        jmpt :return_disk_error_status

        tst M ~DISK_IDLE
        jmpt :return_disk_error_status

        jmp @_check_return_status



    :return_succes_status
        tste M M 
        ret

    :return_file_error_status
        call @error_wrong_filename
        tstg M M
        ret

    :return_disk_error_status
        call @error_fatal_disk_error
        tstg M M
        ret



# .FUNCTIONS
@print_vdisk_error

        # pointer to the string at the datastack
        # Read Pointer in A
        ustack A $DATASTACK_PTR

        :loop_print_vdisk_error
            ld I A                ; Load address from A into I (R0)
            ldx C $_start_memory_ ; Load character from memory[start_memory + I] into C
            tst C \null           ; Check for null terminator
            jmpt :end_print_vdisk_error     ; If null, end loop

            call @print_char      ; Directly call print_char routine

            addi A 1              ; Increment string address
            jmp :loop_print_vdisk_error     ; Continue loop
        :end_print_vdisk_error
        ret
@error_wrong_filename
    ldi A $error_wrong_vdisk_filename
    stack A $DATASTACK_PTR
    call @print_vdisk_error
    ret
@error_fatal_disk_error
    ldi A $fatal_vdisk_error
    stack A $DATASTACK_PTR
    call @print_vdisk_error
:error_fatal_disk_error_while_start_0
    ldi A 1
    tst A 0
    jmpt :error_fatal_disk_error_while_end_0
    jmp :error_fatal_disk_error_while_start_0
:error_fatal_disk_error_while_end_0
    ret

# .DATA
% $error_wrong_vdisk_filename \V \d \i \s \k \: \space \w \r \o \n \g \space \f \i \l \e \n \a \m \e \space \e \r \r \o \r \null
% $fatal_vdisk_error \space \V \d \i \s \k \: \space \f \a \t \a \l \space \d \i \s \k \space \e \r \r \o \r \null
