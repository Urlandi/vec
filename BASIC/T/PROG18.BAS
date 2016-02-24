CLS
INPUT "Введите количество участников ", max
DIM tr(6), name$(max), trn(max * 6), g(4)
RANDOMIZE TIMER
FOR q = 1 TO 6
INPUT "Введите выигравшие шары:", tr(q)
NEXT
l = 0
FOR q = 1 TO 4
g(q) = 2
NEXT
FOR n = 1 TO max
PRINT "Введите названные участником "; n; "  шары"
FOR i = 1 TO 6
l = l + 1
INPUT ""; trn(l)
NEXT
NEXT

CLS
PRINT "6x6", "5x6", "4x6", "3x6"


l = 1
FOR q = 1 TO max
k = 0
FOR n = 1 TO 6
FOR i = l TO l + 5
IF tr(n) = trn(i) THEN
k = k + 1
EXIT FOR
END IF
NEXT
NEXT
SELECT CASE k
CASE 6
LOCATE g(1), 1: PRINT "Уч #"; q: g(1) = g(1) + 1
CASE 5
LOCATE g(2), 15: PRINT "Уч #"; q: g(2) = g(2) + 1
CASE 4
LOCATE g(3), 29: PRINT "Уч #"; q: g(3) = g(3) + 1
CASE 3
LOCATE g(4), 43: PRINT "Уч #"; q: g(4) = g(4) + 1
END SELECT
l = l + 5
NEXT

