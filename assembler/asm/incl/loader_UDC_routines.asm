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

# UDC GENERIC commands
EQU ~UDC_DEVICE_INIT    0
EQU ~UDC_DEVICE_ONLINE  1
EQU ~UDC_DEVICE_OFFLINE 2
EQU ~UDC_DEVICE_RESET   3

# UDC device commands
EQU ~UDC_DEVICE_NEW     10
EQU ~UDC_DEVICE_SEND    11      
EQU ~UDC_DEVICE_GET     12
EQU ~UDC_DEVICE_COLOR   13
EQU ~UDC_DEVICE_MODE    14

# Define used channels / device_type
EQU ~CHANNEL_0_DEVICE   2   ; ~SENSOR  type
EQU ~CHANNEL_1_DEVICE   1   ; ~PLOTTER type


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

    ; when here, all expected devices fount
:udc_init_done
ret

; @udc_channel_online
;     ; expect: A = channel number
;     ; B = command UDC_DEVICE_ONLINE
;     ; return nothing
;     ldi B ~UDC_DEVICE_ONLINE
;     call @_send_udc_command
; ret

; @udc_channel_offline
;     ; expect: A = channel number
;     ; B = command UDC_DEVICE_OFFLINE
;     ; return nothing
;     ldi B ~UDC_DEVICE_OFFLINE
;     call @_send_udc_command
; ret

; @udc_channel_reset
;     ; expect: A = channel number
;     ; B = command UDC_DEVICE_RESET
;     ; return nothing
;     ldi B ~UDC_DEVICE_RESET
;     call @_send_udc_command
; ret

; @udc_device_new
;     ; expect: A = channel number
;     ; B = command UDC_DEVICE_NEW
;     ; return nothing
;     ldi B ~UDC_DEVICE_NEW
;     ldi C 0                 ; actually no data to send
;     call @_send_udc_command
; ret

; @udc_device_send
;     ; expect: A = channel number, C = value to send
;     ; B = command UDC_DEVICE_SEND
;     ; return nothing
;     ldi B ~UDC_DEVICE_SEND
;     call @_send_udc_command
; ret

; @udc_device_get
;     ; expect: A = channel number, 
;     ; B = command UDC_DEVICE_GET
;     ; returns C = value to get
;     ldi B ~UDC_DEVICE_GET
;     ldi C 0                 ; actually no data to send
;     call @_send_udc_command
;     ldm C $udc_data_register    ; Load the return value into C
; ret

; @udc_device_color
;     ; expect: A = channel number, C = value (color) to send
;     ; B = command UDC_DEVICE_COLOR
;     ; return nothing
;     ldi B ~UDC_DEVICE_COLOR
;     call @_send_udc_command
; ret

; @udc_device_mode
;     ; expect: A = channel number, C = value (mode) to send
;     ; B = command UDC_DEVICE_MODE
;     ; return nothing
;     ldi B ~UDC_DEVICE_MODE
;     call @_send_udc_command
; ret



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
    call @error_udc_send_error
    ; its an fatal error for now, you never this point

:udc_wrong_device_error
    call @error_wrong_device_error
    ; its an fatal error for now, you never reach this point

