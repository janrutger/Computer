DEF screen {
  0 2 1  &io
  0 2 10 &io
  1 2 13 &io
  2 2 14 &io
}

DEF setX {
  2 15 &io
}

DEF setY {
  2 16 &io
}

DEF draw {
  setY
  setX
  RND 15 * 999 / 1 +
  2 17 &io
}

10  A !
10  B !

630 C !
10  D !

320 E !
470 F !

10  X !
10  Y !


DEF select1 {
  A @ K !
  B @ L !
}

DEF select2 {
  C @ K !
  D @ L !
}

DEF select3 {
  E @ K !
  F @ L ! 
}

screen
0 N !

WHILE 50000 N @ > DO
  RND 3 * 999 / R !

  R @ 0 == IF select1 ELSE END
  R @ 1 == IF select2 ELSE END
  R @ 2 == IF select3 ELSE END

  X @ K @ + 2 / X !
  Y @ L @ + 2 / Y !

  X @ Y @ draw

  N @ 1 + N !
  N @ 500 % 0 == IF N @ PRINT 0 2 18 &io ELSE END
DONE
