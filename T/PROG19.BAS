CLS
INPUT "Введите количество домохозяек ", max
DIM f$(max), s$(max), rn$(max * 2), r(max * 2)
FOR q = 1 TO max * 2
rn$(q) = "": r(q) = 0
NEXT
FOR n = 1 TO max
PRINT "Введите марку первого пылесоса для "; n; " домохозяйки"
INPUT "", f$(n)
PRINT "Введите марку второго пылесоса для "; n; " домохозяйки"
INPUT "", s$(n)
NEXT
l = 0

FOR q = 1 TO max

FOR n = 1 TO max * 2
IF f$(q) = rn$(n) THEN
r(n) = r(n) + 1
EXIT FOR
END IF
NEXT

IF n = max * 2 + 1 THEN
l = l + 1
rn$(l) = f$(q)
r(l) = 1
END IF
NEXT

FOR q = 1 TO max
FOR n = 1 TO max * 2
IF s$(q) = rn$(n) THEN
r(n) = r(n) + 1
EXIT FOR
END IF
NEXT

IF n = max * 2 + 1 THEN
l = l + 1
rn$(l) = s$(q)
r(l) = 1
END IF
NEXT

DO
FOR q = 1 TO l - 1
IF r(q) < r(q + 1) THEN
SWAP r(q), r(q + 1)
SWAP rn$(q), rn$(q + 1)
q = 0
END IF
NEXT
EXIT DO
LOOP WHILE 0 = 0
PRINT "Самые популярные пылесосы"
FOR q = 1 TO l
PRINT rn$(q), r(q)
NEXT



