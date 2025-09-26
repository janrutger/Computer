DEF screen {
  0 2 1  &io
  0 2 10 &io
  3 2 13 &io
  3 2 14 &io
}

DEF setX {
  X @ 2 15 &io
}

DEF setY {
  Y @ 2 16 &io
}

screen 

0 X !
0 Y !


WHILE 60 Y @ > DO
  WHILE 80 X @ > DO

    RND 2 * 999 / 0 ==
    IF
        129 2 17 &io
    ELSE
        130 2 17 &io
    END

    X @ 1 + X !
    X @ 2 15 &io
  DONE
  
  0 2 18 &io
  0 X !
  X @ 2 15 &io
  Y @ 1 + Y !
  Y @ 2 16 &io
DONE
