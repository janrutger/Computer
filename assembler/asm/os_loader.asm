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

. $SYSCALL_RETURN_VALUE 1
. $SYSCALL_RETURN_STATUS 1

; Data Stack for Stacks
. $DATASTACK 16
. $DATASTACK_PTR 1
. $DATASTACK_INDEX 1
% $DATASTACK_INDEX 0
% $DATASTACK_PTR $DATASTACK

# Welcomes message
. $WELCOME_MESSAGE  20
% $WELCOME_MESSAGE \W \e \l \c \o \m \e \space \t \o \space \S \t \e \r \n \! \Return \Return \null


## this is the first line of code of the loader at mem_start
ldi Z 0     ; Start of loader at mem_start
            ; Z is zero and must retain zero all the time



##########
call @KBD_INIT
call @init_vdisk
call @init_interrupt_vector_table   
ei

# start the kernel by calling the kernel entry point
# at KERNEL_START in memory, where @init_kernel is located
ldi I ~KERNEL_START
callx $start_memory

halt
########## 


INCLUDE loader_interrupt_vector_table
INCLUDE loader_errors
INCLUDE loader_screen_routines
INCLUDE loader_keyboard_routines
INCLUDE loader_vdisk_routines



