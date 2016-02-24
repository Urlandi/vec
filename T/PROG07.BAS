CLS
INPUT "Введите слово: ", s$
FOR n = 1 TO LEN(s$)
FOR i = 1 TO LEN(s$)
IF LCASE$(MID$(s$, n, 1)) = LCASE$(MID$(s$, i, 1)) AND n <> i THEN
s$ = MID$(s$, 1, i - 1) + MID$(s$, i + 1, LEN(s$))
i = 0
END IF
NEXT
NEXT

PRINT "Символы берутся 1 раз: " + s$

