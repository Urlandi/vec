CLS

INPUT "Введите количество команд: ", max
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

FOR n = 1 TO max
FOR i = 1 TO max
IF n <> i AND f(n, i) = 0 THEN
PRINT "Введите счет игры между командами: "; name$(n); " "; name$(i)
INPUT "Счет в виде <X,X>: ", f, s
a = f - s
IF a <> 0 THEN
f(n, i) = f - s
f(i, n) = s - f
ELSE
f(n, i) = .1
f(i, n) = .1
END IF
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



