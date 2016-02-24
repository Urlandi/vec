DIM result$(32)
CLS
PRINT "Введите первую строку строчных латинских символов и пробелов"
INPUT "", s$
s$ = s$ + " "
s$ = LTRIM$(s$)
PRINT "Введите вторую строку строчных латинских символов и пробелов"
INPUT "", d$
d$ = d$ + " "
d$ = LTRIM$(d$)
cd$ = d$
FOR n = 1 TO LEN(s$)
IF (MID$(s$, n, 1) < "a" OR MID$(s$, n, 1) > "z") AND MID$(s$, n, 1) <> " " THEN
PRINT "Не выполнено условие ввода"
END
END IF
NEXT

FOR n = 1 TO LEN(d$)
IF (MID$(d$, n, 1) < "a" OR MID$(d$, n, 1) > "z") AND MID$(d$, n, 1) <> " " THEN
PRINT "Не выполнено условие ввода"
END
END IF
NEXT

l = 1

FOR n = 1 TO LEN(s$)
IF MID$(s$, n, 1) = " " THEN
k$ = MID$(s$, 1, n - 1)

FOR b = 1 TO LEN(d$)
IF MID$(d$, b, 1) = " " THEN
u$ = MID$(d$, 1, b - 1)
IF LCASE$(u$) = LCASE$(k$) THEN
result$(l) = u$
l = l + 1
END IF
d$ = RIGHT$(d$, LEN(d$) - b)
d$ = LTRIM$(d$)
b = 1
END IF
NEXT
d$ = cd$
s$ = RIGHT$(s$, LEN(s$) - n)
s$ = LTRIM$(s$)
n = 1
END IF
NEXT

DO
FOR q = 1 TO l - 2
IF result$(q) > result$(q + 1) THEN
SWAP result$(q), result$(q + 1)
q = 0
END IF
NEXT
EXIT DO
LOOP WHILE 0 = 0


IF l = 1 THEN
PRINT "Одинаковых слов нет"
ELSE
PRINT "Повторяющиеся слова:"
FOR q = 2 TO l
IF result$(q) <> result$(q - 1) THEN PRINT result$(q - 1)
NEXT
END IF


