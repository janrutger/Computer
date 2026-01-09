. $start_memory 1
% $start_memory 0
# Since the Stacks Compiler is using _start_memory we need this also
. $_start_memory_ 1
% $_start_memory_ 0

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
## is REPLACED TO KERNEL_STACKS.ASM 
## And placed it back for better Stacks compiler support
. $DATASTACK 32
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

. $init_library_support 1   ; the value will be set on compiletime when library.asm is compiled

##########
call @KBD_INIT
call @init_vdisk
call @init_udc
call @init_interrupt_vector_table   

ldm I $init_library_support     
callx $start_memory

ei

# start the kernel by calling the kernel entry point
# at KERNEL_START in memory, where @init_kernel is located
ldi I ~KERNEL_START
callx $start_memory

halt
########## 


INCLUDE loader_all_defaults
INCLUDE loader_interrupt_vector_table.stacks
INCLUDE loader_errors.stacks
INCLUDE loader_screen_routines
INCLUDE loader_keyboard_routines
INCLUDE loader_vdisk_routines
INCLUDE loader_udc_routines


