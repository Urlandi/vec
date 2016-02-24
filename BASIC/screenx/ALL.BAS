CLS
CLEAR
SCREEN 12
CONST pi = 3.1415926#
RANDOMIZE TIMER
'$DYNAMIC
DIM i(512), e(512), r(512)
FOR q = 1000 TO 100 STEP -10
SOUND q, .1
NEXT
wx = 320: wy = 240: q = 16
PSET (320, 240), q
DO WHILE INKEY$ = ""
x = RND * 1 - .5: y = RND * 1 - .5
IF x < 0 THEN x = -1 ELSE x = 1
IF y < 0 THEN y = -1 ELSE y = 1
CIRCLE STEP(1 * x, 1 * y), 9, q + 1
wx = wx + 1 * x
wy = wy + 1 * y
IF wx > 640 THEN
PSET (1, wy), q
wx = 1
ELSEIF wx < 1 THEN
PSET (640, wy), q
wx = 640
END IF
IF wy > 480 THEN
PSET (wx, 1), q
wy = 1
ELSEIF wy < 1 THEN
PSET (wx, 480), q
wy = 480
END IF
IF POINT(wx, wy) <> 0 THEN q = q + 1
IF q > 14 THEN q = 1
LOOP
FOR q = 1000 TO 2000 STEP 100
SOUND q, .5: SOUND q - 1000, 1.5
NEXT
CLS
DO WHILE INKEY$ = ""
rx = INT(RND * 640): ry = INT(RND * 480)
FOR q = 1 TO 100
FOR o = 0 TO 360 STEP 15
x = COS(pi * o / 180) * q + rx: y = SIN(pi * o / 180) * q + ry
PSET (x, y), INT(RND * 16)

NEXT
NEXT
FOR q = 1 TO 100
FOR o = 0 TO 360 STEP 15
x = COS(pi * o / 180) * q + rx: y = SIN(pi * o / 180) * q + ry
PSET (x, y), 0

NEXT
NEXT
SOUND 37, 2
LOOP
FOR q = 1000 TO 500 STEP -100
SOUND q, .9: SOUND q + 1000, 1.1
NEXT

FOR q = 1 TO 500
i(q) = INT(RND * 640): e(q) = INT(RND * 480): NEXT q
FOR o = 1 TO 500
q = INT(RND * 500): PSET (i(q), e(q)), INT(RND * 16)
NEXT
DO WHILE INKEY$ = ""
q = INT(RND * 500): PSET (i(q), e(q)), 0
e(q) = e(q) + 1: PSET (i(q), e(q)), INT(RND * 16)
IF e(q) > 480 THEN e(q) = 1
LOOP
FOR q = 1000 TO 500 STEP -100
SOUND q, .9
NEXT

DO WHILE INKEY$ = ""
q = INT(RND * 500): PSET (i(q), e(q)), 0
i(q) = i(q) + 1: PSET (i(q), e(q)), INT(RND * 16)
IF i(q) > 640 THEN i(q) = 1
LOOP
FOR q = 1000 TO 500 STEP -100
SOUND q, .9
NEXT

DO WHILE INKEY$ = ""
q = INT(RND * 500): PSET (i(q), e(q)), 0
e(q) = e(q) - 1: PSET (i(q), e(q)), INT(RND * 16)
IF e(q) < 0 THEN e(q) = 480
LOOP
FOR q = 1000 TO 500 STEP -100
SOUND q, .9
NEXT
DO WHILE INKEY$ = ""
q = INT(RND * 500): PSET (i(q), e(q)), 0
i(q) = i(q) - 1: PSET (i(q), e(q)), INT(RND * 16)
IF i(q) < 0 THEN i(q) = 640
LOOP
FOR q = 9000 TO 37 STEP -1000
SOUND q, .1
SOUND 800, .6
NEXT
CLS
FOR q = 1 TO 500
IF i(q) < 320 AND e(q) < 240 THEN
r(q) = SQR((240 - e(q)) ^ 2 + (320 - i(q)) ^ 2)
ELSEIF i(q) < 320 AND e(q) > 240 THEN
r(q) = SQR((e(q) - 240) ^ 2 + (320 - i(q)) ^ 2)
ELSEIF i(q) > 320 AND e(q) < 240 THEN
r(q) = SQR((240 - e(q)) ^ 2 + (i(q) - 320) ^ 2)
ELSEIF i(q) > 320 AND e(q) > 240 THEN
r(q) = SQR((e(q) - 240) ^ 2 + (i(q) - 320) ^ 2)
END IF
NEXT q
DO WHILE INKEY$ = ""
r(q) = r(q) + 1:
IF i(q) >= 640 OR e(q) >= 480 OR i(q) <= 1 OR e(q) <= 1 THEN
LINE (i(q), e(q))-STEP(9, 9), 0, BF
i(q) = INT(RND * 640): e(q) = INT(RND * 480)
IF i(q) < 320 AND e(q) < 240 THEN
r(q) = SQR((240 - e(q)) ^ 2 + (320 - i(q)) ^ 2)
ELSEIF i(q) < 1 AND e(q) > 240 THEN
r(q) = SQR((e(q) - 240) ^ 2 + (320 - i(q)) ^ 2)
ELSEIF i(q) > 320 AND e(q) < 240 THEN
r(q) = SQR((240 - e(q)) ^ 2 + (i(q) - 320) ^ 2)
ELSEIF i(q) > 320 AND e(q) > 240 THEN
r(q) = SQR((e(q) - 240) ^ 2 + (i(q) - 320) ^ 2)
END IF
END IF
q = INT(RND * 20): LINE (i(q), e(q))-STEP(9, 9), 0, BF
IF i(q) > 320 AND e(q) > 240 THEN
i(q) = r(q) / (i(q) - 320) * r(q) + 320: e(q) = r(q) / (e(q) - 240) * r(q) + 240
ELSEIF i(q) > 320 AND e(q) < 240 THEN
i(q) = r(q) / (i(q) - 320) * r(q) + 320: e(q) = -(r(q) / (240 - e(q))) * r(q) + 240
ELSEIF i(q) < 320 AND e(q) > 240 THEN
i(q) = -(r(q) / (320 - i(q))) * r(q) + 320: e(q) = r(q) / (e(q) - 240) * r(q) + 240
ELSEIF i(q) < 320 AND e(q) < 240 THEN
i(q) = -(r(q) / (320 - i(q))) * r(q) + 320: e(q) = -(r(q) / (240 - e(q))) * r(q) + 240
ELSEIF i(q) = 320 AND e(q) < 240 THEN
i(q) = i(q): e(q) = e(q) - 1
ELSEIF i(q) = 320 AND e(q) > 240 THEN
i(q) = i(q): e(q) = e(q) + 1
ELSEIF e(q) = 240 AND i(q) < 320 THEN
i(q) = i(q) - 1: e(q) = e(q)
ELSEIF i(q) > 320 AND e(q) = 240 THEN
i(q) = i(q) + 1: e(q) = e(q)
ELSEIF i(q) = 320 AND e(q) = 240 THEN
i(q) = i(q) + 90: e(q) = e(q) + 90
END IF
LINE (i(q), e(q))-STEP(9, 9), INT(RND * 16), BF
LOOP

