CLS
INPUT s$
s$ = s$ + " "
k$ = "": ss$ = "": nm = 0
FOR N = 1 TO LEN(s$)
 a$ = MID$(s$, N, 1)
 k$ = k$ + a$
 IF a$ = " " THEN
  nn = 0
  FOR m = 1 TO LEN(k$)
   IF nn = 0 AND MID$(k$, m, 1) = "N" THEN k$ = LEFT$(k$, m - 1) + MID$(k$, m + 1) + " ": nn = 1: nm = 1
   IF nn = 0 AND MID$(k$, m, 1) = "n" THEN k$ = LEFT$(k$, m - 1) + MID$(k$, m + 1) + " ": nn = 1: nm = 1
  NEXT
  ss$ = ss$ + k$: k$ = ""
 END IF
NEXT
PRINT ss$
IF nm = 0 THEN PRINT "Слова с буквой 'N' не найдены!"

