; Simple Bootloader for Stern-XT
; Initializes Keyboard Interrupt and enters an infinite loop

. $VIDEO_MEM 1
% $VIDEO_MEM 14336

. $INT_VECTORS 1
% $INT_VECTORS 3072

. $MEM_START 1
% $MEM_START  0

# Prog_start adres = 4608
. $prog_start 1
% $prog_start 4608

; --- New Constants for Display ---
EQU ~SCREEN_WIDTH 80
EQU ~SCREEN_HEIGHT 24
EQU ~ASCII_SPACE \space
EQU ~ASCII_CR \Return  ; Carriage Return
EQU ~ASCII_LF \Newline ; Line Feed

; --- Data Section for Boot Message ---
. $BOOT_MSG 20
EQU ~BOOT_MSG_LEN 20


; Define the boot message characters
% $BOOT_MSG \S \T \E \R \N \- \X \T \space \B \O \O \T \I \N \G \. \. \. \null


; --- Main Bootloader Code ---
:init_stern
    ; Initialize Interrupt Vector Table (IVT)
    ; Store the address of keyboard_isr at MEM_INT_VECTORS_START + 0
    ldi I 0
    ldi M @KBD_ISR
    stx M $INT_VECTORS

    ; Enable Interrupts
    ; Default the CPU starts with disabled interrupts
    ei
    
    ; --- Display Boot Message ---
    ; Calculate center position for message
    ldi A ~SCREEN_WIDTH (coloms)
    subi A ~BOOT_MSG_LEN ; A = SCREEN_WIDTH - BOOT_MSG_LEN
    divi A 2             ; A = (SCREEN_WIDTH - BOOT_MSG_LEN) / 2 (start column)

    ldi B ~SCREEN_HEIGHT (rows)
    divi B 2             ; B = SCREEN_HEIGHT / 2 (start row)

    ; Calculate starting video memory address for message
    mul R2 ~SCREEN_WIDTH  ; R2 = row * SCREEN_WIDTH
    add R2 R1             ; R2 = (row * SCREEN_WIDTH) + col
    add R2 $VIDEO_MEM     ; R2 = $VIDEO_MEM + offset

    ; Call print_string subroutine
    ldi R1 $BOOT_MSG      ; R1 = address of boot message
    ldi R3 R2             ; R3 = video memory start address for message
    call :print_string

    ; --- Delay ---
    ldi R1 10000          ; Delay count
    call :delay

    ; --- Clear Screen ---
    call :clear_screen

    ; --- Delay again (optional) ---
    ldi R1 5000           ; Shorter delay
    call :delay

    ; Loop indefinitely
:loop
    jmp :loop

; --- Subroutines ---

; print_string(R1=string_address, R3=video_mem_address)
; Prints a null-terminated string from R1 to video memory starting at R3
:print_string
    push R0 ; Save R0
    push R1 ; Save R1
    push R3 ; Save R3

    move R0 R1 ; R0 = string_address (index register)
    move R1 R3 ; R1 = video_mem_address (destination)

:print_loop
    ldx R2 R0 ; Load character from string (R2 = char)
    brz :print_end ; If char is null, end of string

    stx R2 R1 ; Store character to video memory
    inc R0    ; Next character in string
    inc R1    ; Next position in video memory
    jmp :print_loop

:print_end
    pop R3 ; Restore R3
    pop R1 ; Restore R1
    pop R0 ; Restore R0
    ret

; delay(R1=count)
:delay
    push R1 ; Save R1
:delay_loop
    deci R1 ; Decrement R1
    brz :delay_end ; If R1 is zero, end delay
    jmp :delay_loop
:delay_end
    pop R1 ; Restore R1
    ret

; clear_screen()
:clear_screen
    push R0 ; Save R0
    push R1 ; Save R1

    ldi R0 $VIDEO_MEM ; R0 = start of video memory (index register)
    ldi R1 ~ASCII_SPACE ; R1 = ASCII value for space

:clear_loop
    stx R1 R0 ; Store space to video memory
    inc R0    ; Next video memory address
    tstg R0 $VIDEO_MEM + ~SCREEN_WIDTH * ~SCREEN_HEIGHT ; Check if R0 > end of video memory
    jmpt :clear_end ; If R0 is past end, end clear
    jmp :clear_loop

:clear_end
    pop R1 ; Restore R1
    pop R0 ; Restore R0
    ret

; Keyboard Interrupt Service Routine (ISR)
@KBD_ISR
    ; For now, just return from interrupt
    nop
    rti