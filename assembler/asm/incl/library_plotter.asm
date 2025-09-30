. $plot.online_str 11
% $plot.online_str \p \l \t \. \o \n \l \i \n \e \null

. $plot.offline_str 12
% $plot.offline_str \p \l \t \. \o \f \f \l \i \n \e \null

. $plot.draw_str 9
% $plot.draw_str \p \l \t \. \d \r \a \w \null

. $plot.color_str 10
% $plot.color_str \p \l \t \. \c \o \l \o \r \null




@plotlib_init
    ldi A $plot.online_str  ; A points to the string to hash
    call @hash_filename     ; After hashing A contains hash value
    ldi B @plt.online      ; B points to start adres of method/function
    call @add_method_to_stacks  ; is not here yet, expects A and B to register


    ldi A $plot.offline_str  ; A points to the string to hash
    call @hash_filename      ; After hashing A contains hash value
    ldi B @plt.offline 
    call @add_method_to_stacks
    
    ldi A $plot.draw_str  ; A points to the string to hash
    call @hash_filename   ; After hashing A contains hash value
    ldi B @plt.draw 
    call @add_method_to_stacks

    ldi A $plot.color_str
    call @hash_filename
    ldi B @plt.color
    call @add_method_to_stacks
ret


@plt.online
    ldi A ~plotter
    ldi B ~online
    ldi C 0
    ldi I ~SYS_UDC_CONTROL
    int $INT_VECTORS
    ret

@plt.offline
    ldi A ~plotter
    ldi B ~offline
    ldi C 0
    ldi I ~SYS_UDC_CONTROL
    int $INT_VECTORS
    ret

@plt.draw
    call @pop_A
    ld C A
    ldi A ~plotter
    ldi B ~send
    ldi I ~SYS_UDC_CONTROL
    int $INT_VECTORS
    ret

@plt.color
    call @pop_A
    ld C A
    ldi A ~plotter
    ldi B ~deviceColor
    ldi I ~SYS_UDC_CONTROL
    int $INT_VECTORS
    ret



