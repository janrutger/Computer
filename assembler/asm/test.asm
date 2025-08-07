ldi B 0

:lus
    ldi A 5
    addi B 1
    sub A B
    tst A 0
jmpf :lus




INCLUDE include