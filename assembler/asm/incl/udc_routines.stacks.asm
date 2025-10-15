# .CODE

    # Define all registers of the UDC
    MALLOC $udc_channel_register 12248
    MALLOC $udc_status_register  12249
    MALLOC $udc_command_register 12250
    MALLOC $udc_data_register    12251

    MALLOC $udc_device_type_0    12252
    MALLOC $udc_device_type_1    12253
    MALLOC $udc_device_type_2    12254
    MALLOC $udc_device_type_3    12255
    MALLOC $udc_device_type_4    12256
    MALLOC $udc_device_type_5    12257
    MALLOC $udc_device_type_6    12258
    MALLOC $udc_device_type_7    12259

    # Define all CDU controller statussen
    EQU ~UDC_WAITING        0
    EQU ~UDC_CPU_WAITING    1
    EQU ~UDC_UDC_WAITING    2
    EQU ~UDC_ERROR_UDC      3
    EQU ~UDC_ERROR_DEVICE   4

    # Define CDU Controller errors code
    EQU ~DEV_ERROR_UNKNOWN 0
    EQU ~DEV_ERROR_DEVICE  1
    EQU ~DEV_ERROR_VALUE   2
    EQU ~DEV_ERROR_INDEX   3
    EQU ~DEV_ERROR_OFFLINE 4

    # Define the supported device types
    EQU ~GENERIC 0
    EQU ~PLOTTER 1
    EQU ~SENSOR  2
    EQU ~SCREEN  3


    # UDC GENERIC commands
    EQU ~UDC_DEVICE_INIT    0
    EQU ~UDC_DEVICE_ONLINE  1
    EQU ~UDC_DEVICE_OFFLINE 2
    EQU ~UDC_DEVICE_RESET   3

    # # # UDC device commands
    EQU ~UDC_DEVICE_NEW     10
    EQU ~UDC_DEVICE_SEND    11      
    EQU ~UDC_DEVICE_GET     12
    EQU ~UDC_DEVICE_COLOR   13
    EQU ~UDC_DEVICE_MODE    14

    # Define used channels / device_type
    EQU ~CHANNEL_0_DEVICE   2   ; ~SENSOR  type
    EQU ~CHANNEL_1_DEVICE   1   ; ~PLOTTER type
    EQU ~CHANNEL_2_DEVICE   3   ; ~SCREEN  type


    @init_udc
        ldi A 0                         ; Init channel 0
        call @_init_udc_channel
        ldm C $udc_device_type_0
        tst C ~CHANNEL_0_DEVICE         ; check for expected type
        jmpf :udc_wrong_device_error

        ldi A 1                         ; Init channel 1
        call @_init_udc_channel
        ldm C $udc_device_type_1
        tst C ~CHANNEL_1_DEVICE         ; check for expected type
        jmpf :udc_wrong_device_error

        ldi A 2                         ; Init channel 2
        call @_init_udc_channel
        ldm C $udc_device_type_2
        tst C ~CHANNEL_2_DEVICE         ; check for expected type
        jmpf :udc_wrong_device_error

        ; when here, all expected devices fount
    :udc_init_done
    ret


    @_init_udc_channel
        ; expect: A = channel number
        ; B = command UDC_DEVICE_INIT
        ; returns the found devicetype in udc_device_type_registerX

        ldi B ~UDC_DEVICE_INIT
        call @_send_udc_command
        ret


    @_send_udc_command
    ; Send an command to the UDC an wait for ack 
    ; IN: A = channel, B = command, C = data to send
        push A
        push B
        push C
        push M

        ; Store A in channel-register
        sto A $udc_channel_register 
        ; Store B in command-register
        sto B $udc_command_register
        ; Store C in data-register
        sto C $udc_data_register

        ; Trigger the UDC by setting the status register
        ldi M ~UDC_CPU_WAITING
        sto M $udc_status_register

        :udc_send_wait_loop
            ldm M $udc_status_register
            tst M ~UDC_WAITING
            jmpt :send_udc_command_done     ; message succesfull send, return value in data-register when expected
            
            tst M ~UDC_ERROR_UDC
            jmpt :udc_send_error            ; call an fatal error for now
            
            tst M ~UDC_ERROR_DEVICE
            jmpt :udc_send_error            ; call an fatal error for now
            
            jmp :udc_send_wait_loop
        
    :send_udc_command_done
        pop M
        pop C
        pop B
        pop A
    ret



    :udc_send_error
        . $string_udc_send_error 16
        % $string_udc_send_error \U \D \C \space \S \e \n \d \space \e \r \r \o \r \Return \null
        ldi A $string_udc_send_error
        call @print_error_string
        jmp :end_fatal

    :udc_wrong_device_error
        . $string_wrong_device_error 20
        % $string_wrong_device_error \W \r \o \n \g \space \d \e \v \i \c \e  \space \e \r \r \o \r \Return \null
        ldi A $string_wrong_device_error
        call @print_error_string
        jmp :end_fatal


    :end_warning
        ret

    :end_fatal 
        :end_less
            nop
        jmp :end_less


    @print_error_string   
        ; A holds the address of the string
        :loop_print_error_string
            ld I A                ; Load address from A into I (R0)
            ldx C $_start_memory_ ; Load character from memory[start_memory + I] into C
            tst C \null           ; Check for null terminator
            jmpt :end_print_error_string     ; If null, end loop

            call @print_char      ; Directly call print_char routine

            addi A 1              ; Increment string address
            jmp :loop_print_error_string     ; Continue loop
        :end_print_error_string
        ret


