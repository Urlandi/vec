CLS
CONST max = 18
DIM f(max, max), name$(max), summa(max)

FOR n = 1 TO max
summa(n) = 0
FOR i = 1 TO max
f(n, i) = 0
NEXT
NEXT

FOR q = 1 TO max
INPUT "Введите название команды:", name$(q)
NEXT
PRINT "Победа 3, ничья 2, поражение 0"
FOR n = 1 TO max
FOR i = 1 TO max
IF n <> i AND f(n, i) = 0 THEN
DO
PRINT "Введите очки команды "; name$(n); " игравшей с  "; name$(i)
INPUT "", a
IF a = 3 THEN
f(n, i) = 3
f(i, n) = .1
EXIT DO
ELSEIF a = 1 THEN
f(n, i) = 1
f(i, n) = 1
EXIT DO
ELSEIF a = 0 THEN
f(n, i) = .1
f(i, n) = 3
EXIT DO
ELSE
PRINT "Ошибка ввода"
END IF
LOOP WHILE 0 = 0
END IF
NEXT
NEXT
FOR n = 1 TO max
FOR i = 1 TO max
IF f(n, i) = .1 THEN f(n, i) = 0
summa(n) = summa(n) + f(n, i)
NEXT
NEXT

DO

FOR i = 1 TO max - 1
IF summa(i + 1) < summa(i) THEN
SWAP summa(i), summa(i + 1)
SWAP name$(i), name$(i + 1)
i = 0
END IF
NEXT

EXIT DO
LOOP WHILE 0 = 0

FOR i = 1 TO max \ 2
SWAP name$(i), name$(max - i + 1)
SWAP summa(i), summa(max - i + 1)
NEXT


PRINT "Турнирная таблица"
FOR n = 1 TO max
IF summa(n) >= 0 THEN PRINT name$(n), summa(n)
NEXT

