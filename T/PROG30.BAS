CLS
PRINT "Введите строку "
INPUT "", s$
s$ = s$ + " "
s$ = LTRIM$(s$)
PRINT "Сиволы берутся 1 раз"

FOR n = 1 TO LEN(s$)
IF MID$(s$, n, 1) = " " THEN
k$ = MID$(s$, 1, n - 1)

FOR dn = 1 TO LEN(k$)
FOR i = 1 TO LEN(k$)
IF LCASE$(MID$(k$, dn, 1)) = LCASE$(MID$(k$, i, 1)) AND dn <> i THEN
k$ = MID$(k$, 1, i - 1) + MID$(k$, i + 1, LEN(k$))
i = 0
END IF
NEXT
NEXT
PRINT k$ + " ";
l = l + 1
s$ = RIGHT$(s$, LEN(s$) - n)
s$ = LTRIM$(s$)
n = 1
END IF
NEXT












