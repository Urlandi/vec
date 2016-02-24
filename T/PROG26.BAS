CLS
PRINT "Введите строку строчных латинских символов и пробелов"
INPUT "", s$
s$ = s$ + " "
s$ = LTRIM$(s$)
FOR n = 1 TO LEN(s$)
IF (MID$(s$, n, 1) < "a" OR MID$(s$, n, 1) > "z") AND MID$(s$, n, 1) <> " " THEN
PRINT "Не выполнено условие ввода"
END
END IF
NEXT

l = 0
FOR n = 1 TO LEN(s$)
IF MID$(s$, n, 1) = " " THEN
k$ = MID$(s$, 1, n - 1)
FOR i = 1 TO LEN(k$) - 1
IF MID$(k$, i, 1) >= MID$(k$, i + 1, 1) THEN EXIT FOR
NEXT
IF i = LEN(k$) THEN
ki$ = ""
FOR q = LEN(k$) TO 1 STEP -1
ki$ = ki$ + MID$(k$, q, 1)
NEXT
PRINT ki$
l = l + 1
END IF
s$ = RIGHT$(s$, LEN(s$) - n)
s$ = LTRIM$(s$)
n = 1
END IF
NEXT
IF l = 0 THEN PRINT "Слов удовлетворяющих условию не обнаружено"












