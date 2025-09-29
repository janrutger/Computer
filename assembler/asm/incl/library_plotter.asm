. $plot.online_str 12
% $plot.online_str \p \l \o \t \. \o \n \l \i \n \e \null

. $plot.offline_str 13
% $plot.offline_str \p \l \o \t \. \o \f \f \l \i \n \e \null

. $plot.send_str 10
% $plot.send_str \p \l \o \t \. \s \e \n \d \null

. $plot.color_str 11
% $plot.color_str \p \l \o \t \. \c \o \l \o \r \null




@plotlib_init
    ldi A $plot.online_str  ; A points to the string to hash
    call @hash_filename     ; After hashing A contains hash value
    ldi B @plot.online      ; B points to start adres of method/function
    call @add_method_to_stacks  ; is not here yet, expects A and B to register


    ldi A $plot.offline_str  ; A points to the string to hash
    call @hash_filename      ; After hashing A contains hash value
    ldi B @plot.offline 
    call @add_method_to_stacks
    
    ldi A $plot.send_str  ; A points to the string to hash
    call @hash_filename   ; After hashing A contains hash value
    ldi B @plot.send 
    call @add_method_to_stacks

    ldi A $plot.color_str
    call @hash_filename
    ldi B @plot.color
    call @add_method_to_stacks
ret


@plot.online
    ldi A ~plotter
    ldi B ~online
    ldi C 0
    ldi I 33
    int $INT_VECTORS
    ret

@plot.offline
    ldi A ~plotter
    ldi B ~offline
    ldi C 0
    ldi I 33
    int $INT_VECTORS
    ret

@plot.send
    call @pop_A
    ld C A
    ldi A ~plotter
    ldi B ~send
    ldi I 33
    int $INT_VECTORS
    ret

@plot.color
    call @pop_A
    ld C A
    ldi A ~plotter
    ldi B ~deviceColor
    ldi I 33
    int $INT_VECTORS
    ret



