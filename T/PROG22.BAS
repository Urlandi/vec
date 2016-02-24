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

te$ = ""
FOR q = LEN(k$) \ 2 TO 1 STEP -1
te$ = te$ + MID$(LEFT$(k$, LEN(k$) \ 2), q, 1)
NEXT
IF te$ = RIGHT$(k$, LEN(k$) \ 2) THEN

result$(l) = k$
l = l + 1


FOR q = 1 TO LEN(k$)
IF MID$(k$, q, 1) = "A" OR MID$(k$, q, 1) = "А" THEN EXIT FOR
NEXT
IF q <> LEN(k$) + 1 THEN

FOR b = 1 TO LEN(d$)
IF MID$(d$, b, 1) = " " THEN
u$ = MID$(d$, 1, b - 1)

IF LCASE$(u$) = LCASE$(k$) THEN
l = l - 1
IF l < 1 THEN l = 1
END IF

d$ = RIGHT$(d$, LEN(d$) - b)
d$ = LTRIM$(d$)
b = 1
END IF
NEXT
ELSE
l = l - 1
IF l < 1 THEN l = 1
END IF

END IF

d$ = cd$
s$ = RIGHT$(s$, LEN(s$) - n)
s$ = LTRIM$(s$)
n = 1
END IF
NEXT

IF l > 1 THEN
te$ = result$(1)
PRINT "Уникальное симметричное слово c 'A':"
FOR q = 1 TO l - 1
IF LEN(te$) > LEN(result$(q)) THEN te$ = result$(q)
NEXT
PRINT te$
ELSE
PRINT "Таких слов нет"
END IF



