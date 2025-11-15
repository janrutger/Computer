# .HEADER
. $B 1

# .CODE
    ldi A 1
    stack A $DATASTACK_PTR
    call @negate
    ustack A $DATASTACK_PTR
    sto A $B
    ret

# .DATA
% $B 0
