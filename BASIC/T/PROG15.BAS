CLS
INPUT s$
s$ = s$ + " "
k$ = "": nm = 0: r = 0
FOR n = 1 TO LEN(s$)
 a$ = MID$(s$, n, 1)
 k$ = k$ + a$
 IF a$ = " " THEN
  IF nm = 0 THEN
   z$ = k$: nm = 1
  ELSE
   IF k$ <> z$ THEN
    nn = 0
    FOR m = 1 TO LEN(k$) - 2
     IF nn = 0 AND MID$(k$, m, 1) = MID$(k$, LEN(k$) - 1, 1) THEN
     nn = 1
     kk$ = LEFT$(k$, m - 1) + MID$(k$, m + 1)
     END IF
    NEXT
    IF nn = 0 THEN kk$ = k$
    PRINT kk$
    r = 1
   END IF
  END IF
  k$ = ""
 END IF
NEXT
IF r = 0 THEN PRINT "Подходящих слов нет!"

