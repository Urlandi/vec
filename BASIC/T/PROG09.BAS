CLS
COLOR 11
INPUT "‚‚…„ˆ’… ‘‹Ž‚Ž > ", S$
OK = 0
 FOR I = 1 TO LEN(S$) - 1
  IF MID$(S$, I + 1, 1) < MID$(S$, I, 1) THEN OK = 1
 NEXT
 
 COLOR 10
 LOCATE 3, 2
 PRINT "“Š‚› €‘Ž‹Ž†…› "
 COLOR 12
 LOCATE 3, 20
 IF OK = 0 THEN PRINT "Ž €‹”€‚ˆ’“ !" ELSE PRINT "… Ž €‹”€‚ˆ’“ !"

DO
LOOP WHILE INKEY$ = ""

