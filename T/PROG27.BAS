CLS
PRINT "Введите строку"
INPUT "", s$
s$ = s$ + " "
s$ = LTRIM$(s$)

FOR n = 1 TO LEN(s$)
IF (MID$(s$, n, 1) < "a" OR MID$(s$, n, 1) > "z") AND MID$(s$, n, 1) <> " " THEN
PRINT "Не выполнено условие ввода"
END
END IF
NEXT



l = 0: ki$ = ""
FOR n = 1 TO LEN(s$)
IF MID$(s$, n, 1) = " " THEN
k$ = MID$(s$, 1, n - 1)
FOR i = 1 TO LEN(k$) - 1
IF ASC(MID$(k$, i + 1, 1)) - ASC(MID$(k$, i, 1)) = 1 AND LCASE$(MID$(k$, i, 1)) = "a" THEN EXIT FOR
NEXT
IF i = LEN(k$) THEN
ki$ = ki$ + k$ + " "
l = l + 1
END IF
s$ = RIGHT$(s$, LEN(s$) - n)
s$ = LTRIM$(s$)
n = 1
END IF
NEXT
PRINT ki$




