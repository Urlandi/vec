CLS
max = 100
DIM lastname$(max), number(max), dish$(max)

INPUT "Сколько человек проживает в отеле? ", maxman
FOR n = 1 TO maxman
 PRINT "Жилец №"; n
 DO
  INPUT "Введите его фамилию: ", lastname$(n)
  ok = 1:
  FOR m = 1 TO n - 1
   IF lastname$(n) = lastname$(m) THEN PRINT "Такой уже есть!": ok = 0
  NEXT
 LOOP WHILE ok = 0
 DO
  INPUT "Введите номер, где он проживает: ", number(n)
  ok = 1:
  FOR m = 1 TO n - 1
   IF number(n) = number(m) THEN PRINT "Этот номер уже занят!": ok = 0
  NEXT
 LOOP WHILE ok = 0
 INPUT "Какое блюдо он заказал? ", dish$(n)
NEXT
CLS
FOR n = 1 TO maxman
 FOR m = n + 1 TO maxman
  IF dish$(m) > dish$(n) THEN SWAP dish$(m), dish$(n): SWAP number(m), number(n): SWAP lastname$(m), lastname$(n)
 NEXT
NEXT

n = 1
DO
 PRINT "Блюдо "; dish$(n); " заказали: "
 PRINT "Номер комнаты", "Фамилия постояльца"
 k = n
 DO
  PRINT number(k), lastname$(k)
  k = k + 1
 LOOP WHILE (dish$(k) = dish$(n)) AND (k <= maxman)
 n = k
LOOP WHILE k <= maxman

