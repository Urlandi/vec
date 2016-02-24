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
    kk$ = ""
    FOR m = 1 TO LEN(k$) - 1
     IF MID$(k$, m, 1) <> MID$(k$, LEN(k$) - 1, 1) THEN kk$ = kk$ + MID$(k$, m, 1)
    NEXT
    kk$ = kk$ + MID$(k$, LEN(k$) - 1, 1)
    PRINT kk$
    r = 1
   END IF
  END IF
  k$ = ""
 END IF
NEXT
IF r = 0 THEN PRINT "Подходящих слов нет!"

