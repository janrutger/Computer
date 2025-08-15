. $start_memory 1
% $start_memory 0

EQU ~SCREEN_WIDTH 80
EQU ~SCREEN_HEIGHT 24
EQU ~SCREEN_POINTER_END 1920
EQU ~SCREEN_LAST_ADRES 16256    ; ~VIDEO_MEM + ~SCREEN_POINTER_END


; Define memory constants
EQU ~KERNEL_START 1024
EQU ~INT_VECTORS 3072
EQU ~PROG_START 4096
EQU ~VAR_START 12288
EQU ~VIDEO_MEM 14336
EQU ~STACK_TOP 14335

; define memory adresses
. $VIDEO_MEM 1
% $VIDEO_MEM ~VIDEO_MEM

. $INT_VECTORS 1
% $INT_VECTORS ~INT_VECTORS



##########
call @init_interrupt_vector_table
call @KBD_INIT

ei


; ldi I ~KERNEL_START
; callx $start_memory

:loader_loop
    nop
    jmp :loader_loop


halt
##########
INCLUDE interrupt_vector_table
INCLUDE loader_screen_routines 
INCLUDE loader_keyboard_routines 

