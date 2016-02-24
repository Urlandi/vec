SCREEN 12
CLS
INPUT "Введите строку > ", s$
s$ = s$ + " "
p = 1
PRINT ""
w = 0
FOR x = 1 TO LEN(s$)
IF MID$(s$, x, 1) = " " THEN
u = 0
a$ = MID$(s$, p, x - p)
FOR d = 1 TO LEN(a$)
l = 0
FOR c = 1 TO LEN(a$)
IF MID$(a$, d, 1) = MID$(a$, c, 1) THEN l = l + 1
NEXT
IF l < 2 THEN
u = 1
END IF
NEXT
IF u = 0 THEN
PRINT a$
w = 1
END IF
p = x + 1
END IF
NEXT
IF w = 0 THEN PRINT "Повторений нет !!!"


