@main_loop
    call @cli_main_loop
    ret

INCLUDE kernel_cliV2


#@main_loop              ; Kernel main loop
#    ; The main loop of the kernel.
#    ; Later, this will read from the buffer and process commands.
#    
#    call @KBD_GET_CHAR   ; Call the routine to get a character
#    jmpt :char_available ; Branch if Status flag is set (character available)
#    jmp @main_loop       ; If no character, loop again
#
#:char_available
#    call @print_char     ; Print the character (it's in C from GET_KBD_CHAR)
#    jmp @main_loop       ; Continue looping 