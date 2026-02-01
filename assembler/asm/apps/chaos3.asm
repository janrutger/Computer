# .HEADER
. $A 1
. $B 1
. $C 1
. $D 1
. $E 1
. $F 1
. $X 1
. $Y 1
. $K 1
. $L 1
. $N 1
. $R 1
. $_main_str_0 17
. $_main_str_1 4

# .CODE
    stack Z $DATASTACK_PTR
    ldm A $p_watch_list
    ustack B $DATASTACK_PTR
    add A B
    sto A $current_watch
    ldm I $p_currentime
    ldx A $_start_memory_
    ld B A
    ldm I $current_watch
    stx B $_start_memory_
    call @screen
:_main_while_start_0
    ldi A 20000
    stack A $DATASTACK_PTR
    ldm A $N
    stack A $DATASTACK_PTR
    call @rt_gt
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_while_end_0
    call @rt_rnd
    ldi A 3
    ustack B $DATASTACK_PTR
    mul B A
    ldi A 999
    dmod B A
    ld A B
    sto A $R
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_0
    call @select1
:_main_if_end_0
    ldm A $R
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_1
    call @select2
:_main_if_end_1
    ldm A $R
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_2
    call @select3
:_main_if_end_2
    ldm B $X
    ldm A $K
    add B A
    ldi A 2
    dmod B A
    ld A B
    sto A $X
    ldm B $Y
    ldm A $L
    add B A
    ldi A 2
    dmod B A
    ld A B
    sto A $Y
    ldm A $X
    stack A $DATASTACK_PTR
    ldm A $Y
    stack A $DATASTACK_PTR
    call @draw
    ldm B $N
    ldi A 1
    add A B
    sto A $N
    ld B A
    ldi A 500
    dmod B A
    stack A $DATASTACK_PTR
    stack Z $DATASTACK_PTR
    call @rt_eq
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_3
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 18
    stack A $DATASTACK_PTR
    call @rt_udc_control
    stack Z $DATASTACK_PTR
    ldm A $p_watch_list
    ustack B $DATASTACK_PTR
    add A B
    sto A $current_watch
    ldm I $p_currentime
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm I $current_watch
    ldx A $_start_memory_
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @TIME.as_string
    ldi A 32
    stack A $DATASTACK_PTR
    call @PRTchar
    ldm A $N
    stack A $DATASTACK_PTR
    call @rt_print_tos
:_main_if_end_3
    call @KEYpressed
    ustack A $DATASTACK_PTR
    tst A 0
    jmpt :_main_if_end_4
    call @rt_drop
    jmp :end_of_chaos3
:_main_if_end_4
    jmp :_main_while_start_0
:_main_while_end_0
:end_of_chaos3
    ldi A $_main_str_0
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
    stack Z $DATASTACK_PTR
    ldm A $p_watch_list
    ustack B $DATASTACK_PTR
    add A B
    sto A $current_watch
    ldm I $p_currentime
    ldx A $_start_memory_
    stack A $DATASTACK_PTR
    ldm I $current_watch
    ldx A $_start_memory_
    ustack B $DATASTACK_PTR
    sub B A
    stack B $DATASTACK_PTR
    call @TIME.as_string
    ldi A $_main_str_1
    stack A $DATASTACK_PTR

        ustack A $DATASTACK_PTR  ; Pop pointer from stack into A register for the syscall
        ldi I ~SYS_PRINT_STRING
        int $INT_VECTORS         ; Interrupt to trigger the syscall
        ret

# .FUNCTIONS
@screen
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 1
    stack A $DATASTACK_PTR
    call @rt_udc_control
    stack Z $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 10
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 1
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 13
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 14
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@setX
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 15
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@setY
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 16
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret
@select1
    ldm A $A
    sto A $K
    ldm A $B
    sto A $L
    ret
@select2
    ldm A $C
    sto A $K
    ldm A $D
    sto A $L
    ret
@select3
    ldm A $E
    sto A $K
    ldm A $F
    sto A $L
    ret
@draw
    call @setY
    call @setX
    call @rt_rnd
    ldi A 15
    ustack B $DATASTACK_PTR
    mul B A
    ldi A 999
    dmod B A
    ldi A 1
    add B A
    stack B $DATASTACK_PTR
    ldi A 2
    stack A $DATASTACK_PTR
    ldi A 17
    stack A $DATASTACK_PTR
    call @rt_udc_control
    ret

# .DATA
% $A 10
% $B 10
% $C 630
% $D 10
% $E 320
% $F 470
% $X 10
% $Y 10
% $K 0
% $L 0
% $N 0
% $R 0
% $_main_str_0 \T \o \t \a \l \space \r \u \n \space \t \i \m \e \: \space \null
% $_main_str_1 \! \! \Return \null
