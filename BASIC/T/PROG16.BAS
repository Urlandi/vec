CLS : SCREEN 12
DIM n$(100)
COLOR 10: INPUT "Введите количество игроков - ", a

COLOR (11)
n = 1
DO
PRINT "Вводите фамилию"; n; "- го игрока - ";
INPUT "", n$(n)
n = n + 1
LOOP UNTIL n = a + 1
i = 1: j = 1
DO
IF j = 1 THEN COLOR 12: PRINT "Игрок номер"; i; ": "; : COLOR 11: PRINT n$(i)
IF i = j THEN f(i, j) = 0
IF i <> j THEN IF j > i THEN PRINT "Введите результат игры c"; j; "- ым игроком - "; : INPUT "", f(i, j)
IF i <> j THEN
 IF j < i THEN
  IF f(j, i) = 1 THEN f(i, j) = 0
  IF f(j, i) = 0 THEN f(i, j) = 1
  IF f(j, i) = .5 THEN f(i, j) = .5

  PRINT "Результат с"; j; "- ым игроком равен -"; f(i, j)
 END IF
END IF
j = j + 1
IF j > n - 1 THEN j = 1: i = i + 1:
LOOP UNTIL i = n
PRINT





i = 1: j = 1

DO
s(i) = s(i) + f(i, j)
j = j + 1
IF j > n - 1 THEN i = i + 1: j = 1
LOOP UNTIL i > n

COLOR 4: PRINT "Результат:"

FOR i = 1 TO n: ss(i) = s(i): NEXT

FOR i = 1 TO n
FOR j = i + 1 TO n
IF ss(i) < ss(j) THEN SWAP ss(i), ss(j)
NEXT: NEXT

first = 0: second = 0: thrid = 0
FOR i = 1 TO n
IF first = 0 AND s(i) = ss(1) THEN first = i
IF second = 0 AND s(i) = ss(2) THEN second = i
IF third = 0 AND s(i) = ss(3) THEN third = i
NEXT

PRINT "Первое место - "; n$(first); " очки -"; ss(1)
PRINT "Второе место - "; n$(second); " очки -"; ss(2)
PRINT "Третие место - "; n$(third); " очки -"; ss(3)

