;-------------------------------------------------------------------------------
; loader_keyboard_routines.asm
;
; Routines for handling buffered keyboard input for the OS Kernel.
;-------------------------------------------------------------------------------

EQU ~KBD_BUFFER_SIZE 64
EQU ~KEY_RETURN 13
EQU ~KEY_BACKSPACE 8

; --- Keyboard Buffer Data ---
. $KBD_READ_PNTR 1          ; buffer read pointer
. $KBD_WRITE_PNTR 1         ; buffer write pointer
. $KBD_BUFFER 16            ; buffer reservation 16 bytes
. $KBD_BUFFER_ADRES 1       ; pointer to buffer adres
% $KBD_BUFFER_ADRES $KBD_BUFFER     ; adres -> buffer




; base adrs for the IO registers
. $KBD_IO_BASE_POINTER 1        ; IO memory base adres

@KBD_INIT
    ; Initialize IO memory register
    ldi M ~VAR_START
    subi M 8
    sto M $KBD_IO_BASE_POINTER  ; set KBD IO base adres in memory

    ; Initialize buffer pointers
    sto Z $KBD_READ_PNTR
    sto Z $KBD_WRITE_PNTR
    ret

;-------------------------------------------------------------------------------
; Keyboard Interrupt Service Routine (@KBD_ISR)
;
; Reads a character from the keyboard device, echoes it to the screen,
; and places it in a circular buffer. Handles backspace.
;-------------------------------------------------------------------------------
@KBD_ISR
    ; --- Get character from keyboard ---
    ldi I 0                     ; KBD read register is 0
    ldx C $KBD_IO_BASE_POINTER  ; Read character from device into C
    ; C holds the input character

    # \backspace \Return must be stored in the input buffer
    # the kernel/program knows the meaning, not the KBD 
    ##################
    ; check for full buffer
    ldm M $KBD_WRITE_PNTR   ; get the write pointer
    addi M 1                ; incr pointer
    andi M 15               ; check roll over
    ldm L $KBD_READ_PNTR    ; get the read pointer
    tste M L                ; if eql, then buffer full
    jmpt :end_kbd_isr       ; jump to end, if buffer full

    # Store in buffer
    inc I $KBD_WRITE_PNTR
    stx C $KBD_BUFFER_ADRES

    # check for full buffer
    ldm M $KBD_WRITE_PNTR
    andi M 15
    tste M Z               ; Z contains zero
    jmpf :end_kbd_isr

    sto Z $KBD_WRITE_PNTR

:end_kbd_isr



    ################

    ; --- Echo character to screen ---
    ; C must hold the char to print
    call @print_char

:isr_done
    rti                         ; Return from interrupt