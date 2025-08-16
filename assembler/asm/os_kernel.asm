

@kernel_entry       ; must be at KERNEL_START in memory
    ; Initialize the kernel systems
    call @KBD_INIT      ; Initialize keyboard buffer

    ; More init calls would go here...

    ; Jump to the main kernel loop
    jmp @main_loop

@main_loop
    ; The main loop of the kernel.
    ; Later, this will read from the buffer and process commands.
    
    ; For now, just loop forever.
    jmp @main_loop