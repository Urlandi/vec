CLS
DIM result$(32)
PRINT "Введите первую строку"
INPUT "", s$
s$ = s$ + " "
s$ = LTRIM$(s$)
PRINT "Введите вторую строку"
INPUT "", d$
d$ = d$ + " "
d$ = LTRIM$(d$)
cd$ = d$

l = 1
FOR n = 1 TO LEN(s$)
IF MID$(s$, n, 1) = " " THEN
k$ = MID$(s$, 1, n - 1)

FOR b = 1 TO LEN(d$)
IF MID$(d$, b, 1) = " " THEN
u$ = MID$(d$, 1, b - 1)

IF LCASE$(u$) = LCASE$(k$) THEN
te$ = ""
FOR q = LEN(u$) \ 2 TO 1 STEP -1
te$ = te$ + MID$(LEFT$(u$, LEN(u$) \ 2), q, 1)
NEXT
IF te$ = RIGHT$(u$, LEN(u$) \ 2) THEN
result$(l) = u$
l = l + 1
END IF
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


IF l > 1 THEN
te$ = result$(1)
PRINT "Общeе симметричное слово:"
FOR q = 1 TO l - 1
IF LEN(te$) > LEN(result$(q)) THEN te$ = result$(q)
NEXT
PRINT te$
ELSE
PRINT "Общих слов нет"
END IF

