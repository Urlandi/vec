'
INPUT "Введите слово четной длины ", s$
IF LEN(s$) MOD 2 <> 0 THEN
PRINT "Слово не четное"
END
END IF
o$ = RIGHT$(s$, LEN(s$) / 2)
s$ = ""
FOR n = LEN(o$) TO 1 STEP -1
s$ = s$ + MID$(o$, n, 1)
NEXT n
PRINT s$

