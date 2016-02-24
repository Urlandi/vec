CLS
INPUT s$
FOR n = 1 TO LEN(s$)
 FOR m = n + 1 TO LEN(s$)
  k$ = MID$(s$, m, 1): l$ = MID$(s$, n, 1)
  IF k$ < l$ THEN
   s$ = LEFT$(s$, m - 1) + l$ + MID$(s$, m + 1)
   s$ = LEFT$(s$, n - 1) + k$ + MID$(s$, n + 1)
  END IF
 NEXT
NEXT
PRINT s$

