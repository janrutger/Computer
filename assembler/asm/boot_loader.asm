; Simple Bootloader for Stern-XT
; Initializes Keyboard Interrupt and enters an infinite loop

. $VIDEO_MEM 1
% $VIDEO_MEM 14336

# $VIDEO_MEM + ~SCREEN_WIDTH * ~SCREEN_HEIGHT ; Check if R0 > end of video memory
EQU ~VIDEO_MEM_END 16256


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
    ldi A ~SCREEN_WIDTH  ; (coloms)
    subi A ~BOOT_MSG_LEN ; A = SCREEN_WIDTH - BOOT_MSG_LEN
    divi A 2             ; A = (SCREEN_WIDTH - BOOT_MSG_LEN) / 2 (start column)

    ldi B ~SCREEN_HEIGHT ; (rows)
    divi B 2             ; B = SCREEN_HEIGHT / 2 (start row)

    # A = (80 - 20) / 2 = 35 (start position X)
    # B = 24 / 2 = 12 (start position Y)
    # calculate memory adres of A B (x,y)
    # Calculate starting video memory address for message
    muli B ~SCREEN_WIDTH  ; B = row * SCREEN_WIDTH
    add B A             ; B = (row * SCREEN_WIDTH) + col
    ldi C $VIDEO_MEM     ; Load $VIDEO_MEM into C
    add B C             ; B = B + C (B now holds $VIDEO_MEM + offset)

    ; Call print_string subroutine
    ldi A $BOOT_MSG      ; R1 = address of boot message
    ld C B               ; C = start position in dispaly memory
    # Start of the String is in A, C is video start adres
    call :print_string

    ; --- Delay ---
    ;ldi A 10000          ; Delay count
    ;call :delay

    ; --- Clear Screen ---
    ;call :clear_screen

    ; --- Delay again (optional) ---
    ;ldi A 5000           ; Shorter delay
    ;call :delay

    ; Loop indefinitely
:loop
    ; jmp :loop ;stop here to make sure the code ends

; --- Subroutines ---

; print_string(A=string_address, C=video_mem_address)
; Prints a null-terminated string from R1 to video memory starting at C
:print_string
    push I ; Save R0
    push A ; Save R1
    push C ; Save R3

    . $string_pointer 1
    . $video_pointer 1

    sto A $string_pointer
    sto C $video_pointer

    . $cursor 1
    % $cursor 0

:print_loop

    inc I $cursor           ; load I, inc $cursor

    ldx B $string_pointer   ; load char in B
    tst B \null             ; test for last char
    jmpt :print_end

    stx B $video_pointer   ; store char in video memory

    jmp :print_loop


:print_end
    pop C ; Restore R3
    pop A ; Restore R1
    pop I ; Restore R0
    ret

; delay(R1=count)
. $delay_count 1
:delay
    sto A $delay_count ; Save R1
:delay_loop
    dec A $delay_count
    tst A 0
    jmpt :delay_end
    jmp :delay_loop

:delay_end
    ret

; clear_screen()
:clear_screen
    push I ; Save R0
    push A ; Save R1
    push B ; save R2

    ldi Z 0              ; Load Z with zero
    sto Z $cursor        ; Set startpoint of cursor
    ldi A \space         ; R1 = ASCII value for space
    ldi B ~VIDEO_MEM_END ; R2 = end of video memory


:clear_loop
    inc I $cursor       ; Increment cursor

    tstg I B            ; Check if R0 > end of video memory
    jmpt :clear_end     ; If R0 is past end, end clear

    stx A $VIDEO_MEM    ; Store space to clear video memory
    jmp :clear_loop

:clear_end
    pop B ; Restore R2
    pop A ; Restore R1
    pop I ; Restore R0
    ret

; Keyboard Interrupt Service Routine (ISR)
@KBD_ISR
    ; For now, just return from interrupt
    nop
    rti
