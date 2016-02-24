'От нечего делать - "Молния"
CLS
SCREEN 12
RANDOMIZE TIMER
DEFINT A-Z
DIM bumx(550), r(180 TO 360), sm(180 TO 360), xt(100), rt(100)
DO
bumx(1) = INT(RND * 640): bumy = 100
FOR q = 2 TO 550
bumy = bumy + 1
tim = RND * 10 - 5
bumx(q) = bumx(q - 1) + tim
PSET (bumx(q), bumy), 15
NEXT
FOR q = 1 TO 3
FOR ug = 180 TO 360
r(ug) = INT(RND * 150): tim = RND * 10 - 5: IF tim > 0 THEN sm(ug) = bumx(550) - r(ug) ELSE sm(ug) = bumx(550) + r(ug)
x = COS(3.1415926# * ug / 180) * r(ug) + sm(ug): y = SIN(3.1415926# * ug / 180) * r(ug) + 480
PSET (x, y), INT(RND * 15)
NEXT
FOR ug = 180 TO 360
x = COS(3.1415926# * ug / 180) * r(ug) + sm(ug): y = SIN(3.1415926# * ug / 180) * r(ug) + 480
PSET (x, y), 0
NEXT
NEXT

SOUND 37, .1
bumy = 100
FOR q = 2 TO 550
bumy = bumy + 1
PSET (bumx(q), bumy), 0
NEXT
FOR q = 1 TO 100
CIRCLE (xt(q), 1), rt(q), 0
NEXT

FOR q = 1 TO 100
xt(q) = INT(RND * 640): rt(q) = INT(RND * 100)
CIRCLE (xt(q), 1), rt(q), 8
NEXT
LOOP WHILE INKEY$ = ""
CLS : SCREEN 0: LOCATE 1, 1: PRINT "Скоро пойдет дождь.Не промочите ноги."

