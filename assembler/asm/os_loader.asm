. $start_memory 1
% $start_memory 0

EQU ~KERNEL_START 1024

ldi I ~KERNEL_START
callx $start_memory

halt