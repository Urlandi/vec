CLS
PRINT "Введите первую строку"
INPUT "", s$
s$ = s$ + " "
s$ = LTRIM$(s$)
PRINT "Введите вторую строку"
INPUT "", d$
d$ = d$ + " "
d$ = LTRIM$(d$)
cd$ = d$

m = 0
result$ = ""

FOR n = 1 TO LEN(s$)
IF MID$(s$, n, 1) = " " THEN
k$ = MID$(s$, 1, n - 1)

l = 1
FOR b = 1 TO LEN(d$)
IF MID$(d$, b, 1) = " " THEN
u$ = MID$(d$, 1, b - 1)

IF LCASE$(u$) = LCASE$(k$) THEN
l = 0: m = 1
END IF

d$ = RIGHT$(d$, LEN(d$) - b)
d$ = LTRIM$(d$)
b = 1
END IF
NEXT
IF l = 1 THEN result$ = result$ + " " + k$
d$ = cd$
s$ = RIGHT$(s$, LEN(s$) - n)
s$ = LTRIM$(s$)
n = 1
END IF
NEXT

IF m = 0 THEN PRINT "Одинаковых слов нет";  ELSE PRINT ; "Первое предложение: " + result$


