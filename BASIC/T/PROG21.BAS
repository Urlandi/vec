CLS
max = 100
DIM lastname$(max), number(max), dish$(max)

INPUT "����쪮 祫���� �஦����� � �⥫�? ", maxman
FOR n = 1 TO maxman
 PRINT "����� �"; n
 DO
  INPUT "������ ��� 䠬����: ", lastname$(n)
  ok = 1:
  FOR m = 1 TO n - 1
   IF lastname$(n) = lastname$(m) THEN PRINT "����� 㦥 ����!": ok = 0
  NEXT
 LOOP WHILE ok = 0
 DO
  INPUT "������ �����, ��� �� �஦�����: ", number(n)
  ok = 1:
  FOR m = 1 TO n - 1
   IF number(n) = number(m) THEN PRINT "��� ����� 㦥 �����!": ok = 0
  NEXT
 LOOP WHILE ok = 0
 INPUT "����� �� �� �������? ", dish$(n)
NEXT
CLS
FOR n = 1 TO maxman
 FOR m = n + 1 TO maxman
  IF dish$(m) > dish$(n) THEN SWAP dish$(m), dish$(n): SWAP number(m), number(n): SWAP lastname$(m), lastname$(n)
 NEXT
NEXT

n = 1
DO
 PRINT "�� "; dish$(n); " ��������: "
 PRINT "����� �������", "������� �������"
 k = n
 DO
  PRINT number(k), lastname$(k)
  k = k + 1
 LOOP WHILE (dish$(k) = dish$(n)) AND (k <= maxman)
 n = k
LOOP WHILE k <= maxman

