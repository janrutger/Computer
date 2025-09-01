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
