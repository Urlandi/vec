CLS
COLOR 11
INPUT "������� ����� > ", S$
OK = 0
 FOR I = 1 TO LEN(S$) - 1
  IF MID$(S$, I + 1, 1) < MID$(S$, I, 1) THEN OK = 1
 NEXT
 
 COLOR 10
 LOCATE 3, 2
 PRINT "����� ����������� "
 COLOR 12
 LOCATE 3, 20
 IF OK = 0 THEN PRINT "�� �������� !" ELSE PRINT "�� �� �������� !"

DO
LOOP WHILE INKEY$ = ""

