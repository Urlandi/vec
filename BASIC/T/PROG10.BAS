CLS
K$ = " ": m$ = SPACE$(255)
COLOR (10)
INPUT s$
s$ = s$ + " "
FOR n = 1 TO LEN(s$)
 IF MID$(s$, n, 1) = " " THEN
  IF LEN(K$) < LEN(m$) AND K$ <> " " THEN
   ok = 0
   FOR K = 1 TO LEN(K$)
    IF MID$(K$, K, 1) = "Ä" OR MID$(K$, K, 1) = "A" THEN ok = 1
   NEXT K
   COLOR (5)
   IF ok = 0 THEN m$ = K$
   K$ = " "
  END IF
 ELSE
 K$ = K$ + MID$(s$, n, 1)
 END IF
NEXT
IF m$ <> SPACE$(255) THEN PRINT m$ ELSE PRINT "íÄäàï ëãéÇ çÖí!"


