CLS
INPUT s$
DIM sl(255)
FOR n = 1 TO LEN(s$): sl(n) = 0: NEXT
FOR n = 1 TO LEN(s$)
sl(ASC(MID$(s$, n, 1))) = sl(ASC(MID$(s$, n, 1))) + 1
NEXT
f = 0
FOR n = 1 TO 255
IF sl(n) <> 0 AND sl(n) < 3 THEN f = 1
NEXT
PRINT (f)

