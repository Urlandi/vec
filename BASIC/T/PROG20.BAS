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
INPUT "������ �������� �������:", name$(q)
NEXT
PRINT "������ 3, ����� 2, ��ࠦ���� 0"
FOR n = 1 TO max
FOR i = 1 TO max
IF n <> i AND f(n, i) = 0 THEN
DO
PRINT "������ �窨 ������� "; name$(n); " ��ࠢ襩 �  "; name$(i)
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
PRINT "�訡�� �����"
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


PRINT "��୨ୠ� ⠡���"
FOR n = 1 TO max
IF summa(n) >= 0 THEN PRINT name$(n), summa(n)
NEXT

