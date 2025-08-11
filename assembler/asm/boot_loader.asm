; Simple Bootloader for Stern-XT
; Initializes Keyboard Interrupt and enters an infinite loop

. $VIDEO_MEM 1
% $VIDEO_MEM 14336

. $VIDEO_SIZE 1
# 2k - 1 = 2047
% $VIDEO_SIZE 2047

. $INT_VECTORS 1
% $INT_VECTORS 3072

. $mem_start 1
% $mem_start 0

# Prog_start adres = 4608
. $prog_start 1
% $prog_start 4608

:init_stern
    ; Initialize Interrupt Vector Table (IVT)
    ; Store the address of keyboard_isr at MEM_INT_VECTORS_START + 0
    ldi I 0
    ldi M @KBD_ISR
    stx M $INT_VECTORS

    ; Enable Interrupts
    ; Default the CPU starts with disabled interrupts
    ei
    
    ; Loop indefinitely
:loop
    jmp :loop

; Keyboard Interrupt Service Routine (ISR)
@KBD_ISR
    ; For now, just return from interrupt
    nop
    rti
