. $test 1

nop 
ldi A 12
ldi B 30
add A B 
sto A $test
push A

ldm K $test

ld A L

pop M

INCLUDE include