'Supper I
SCREEN 12
RANDOMIZE TIMER
CONST pi = 3.2425926#
DEFINT A-Z
'$DYNAMIC
KEY 10, "": KEY(10) ON
ON KEY(10) GOSUB f10
DIM mat(72, 16), mat1(160, 16), mat2(80, 16), mat3(64, 16), i(512), e(512), mat4(72, 16)
a$ = "Hello my name is Michael.I was born in Volgograd.Welcom to Volgograd.I learn in colledg.Ну ладно xopoш кривляться давай займемся делом.Сегодня 29.05.98 Я занял 1?!!! место в областом конкурсе по программированию.Ура!!!."
b$ = "И в честь этого радостного события я написал эту демку.Если тебе, USER, не слабо повторить это, то дерзай Q_BASIC 4.5 в твоем распоряжении.Начинай с небольшого и все должно получиться.Или ты считаешь что лучше всю жизнь провести играясь в": k$ _
 = " DOOM, BLOOD, ROTT, STRIF, REDNECR, DUKE or WOLF."
c$ =  _
"Если это так то ты конченный человек,хотя бы, потому,что уже давно есть DOOM2 русский HEXEN для Windows и многое другое еще более навороченное.Так что не теряй времени даром и берись за ум. ******************************************************* "
d$ = "КАК?! Ты еще здесь жми ENTER и вперед,а то тебя могут опередить.To be or not to be.I wish you to become ferst programmer last me.Ha - ha - ha.Boy  and  girl.Don't see.Ha - ha - ha.Let's go,go,go If you can run then run. "
a$ = STRING$(35, 32) + a$ + b$ + k$ + c$ + d$ + STRING$(35, 32)
LOCATE 1, 1: PRINT "1st plase  "
FOR x = 1 TO 72
FOR y = 1 TO 16
IF POINT(x, y) <> 0 THEN mat(x, y) = 1
NEXT
NEXT
LOCATE 1, 1: PRINT "in programmer's game       "
FOR x = 1 TO 160
FOR y = 1 TO 16
IF POINT(x, y) <> 0 THEN mat1(x, y) = 1
NEXT
NEXT
LOCATE 1, 1: PRINT "Who is he?      "
FOR x = 1 TO 80
FOR y = 1 TO 16
IF POINT(x, y) <> 0 THEN mat2(x, y) = 1
NEXT
NEXT
LOCATE 1, 1: PRINT "Michael  "
FOR x = 1 TO 64
FOR y = 1 TO 16
IF POINT(x, y) <> 0 THEN mat3(x, y) = 1
NEXT
NEXT
LOCATE 1, 1: PRINT "Volgograd "
FOR x = 1 TO 72
FOR y = 1 TO 16
IF POINT(x, y) <> 0 THEN mat4(x, y) = 1
NEXT
NEXT
CLS
Q2 = 1
DO WHILE INKEY$ = ""
w = w + 1: IF w = 1012 THEN EXIT DO
LINE (147, 350)-STEP(290, 19), 10, B
LOCATE INT(RND * 27 + 1), INT(RND * 79 + 1): PRINT "1'st"
FOR q = 1 TO 72
FOR q1 = 1 TO 16
IF mat(q, q1) = 1 THEN LINE (q * 8 + 25, q1 * 20 + 30)-STEP(15, 15), INT(RND * 16), BF
NEXT
NEXT
h$ = MID$(a$, Q2, 35)
LOCATE 23, 20: COLOR INT(RND * 16): PRINT h$
Q2 = Q2 + 1: IF Q2 > LEN(a$) - 35 THEN Q2 = 1
FOR q = 1 TO 64
FOR q1 = 1 TO 16
clr = 15 - INT(RND * 6)
IF mat3(q, q1) = 1 THEN CIRCLE (q * 3 + 240, q1 * 3 + 20), 2, clr, BF: PAINT (q * 3 + 240, q1 * 3 + 20), clr
NEXT
NEXT
LOOP
CLS
Q2 = 1
w = 1
FOR q = 1 TO 1000
PSET (INT(RND * 640), INT(RND * 480)), INT(RND * 16)
NEXT
DO WHILE INKEY$ = ""
w = w + 1: IF w > 1000 THEN EXIT DO
clr = clr + 1: IF clr > 16 THEN clr = 1
FOR y = 1 TO 16
FOR x = 160 TO 1 STEP -1
IF mat1(x, y) = 1 THEN CIRCLE (x * 4, y * 10 + 100), 4, clr: PAINT (x * 4, y * 10 + 100), clr
NEXT
NEXT
FOR q = 1 TO 72
FOR q1 = 1 TO 16
IF mat(q, q1) = 1 THEN LINE (q * 5 + 150, q1 * 4 + 40)-STEP(3, 3), 16 - INT(RND * 9)
NEXT
NEXT
FOR y1 = 1 TO 16
FOR x1 = 1 TO 72
IF mat4(x1, y1) = 1 THEN LINE (x1 * 6 + 85, y1 * 9 + 250)-STEP(10, 10), INT(RND * 16), BF
NEXT
NEXT
FOR o = 1 TO 360
x = COS(pi * o / 180) * 800 + 640: y = SIN(pi * o / 180) * 800 + 480
LINE (640, 480)-(x, y), INT(RND * 16)
NEXT
LOOP
CLS
FOR x = 1 TO 80
FOR y = 1 TO 16
IF mat2(x, y) = 1 THEN
FOR q = 1 TO 72
LINE (x * 8, y * 8 + 100)-STEP(7, 7), 11, BF
NEXT
END IF
NEXT
NEXT
FOR q = 1 TO 500
i(q) = INT(RND * 640): e(q) = INT(RND * 480): NEXT q
FOR o = 1 TO 500
q = INT(RND * 500): PSET (i(q), e(q)), 15
NEXT

e = e + 1
FOR x = 1 TO 80
FOR y = 1 TO 16
IF mat2(x, y) = 1 THEN
LINE (x * 8 + 10, y * 8 + 120)-STEP(7, 7), 8, BF
END IF
NEXT
NEXT
FOR x = 1 TO 80
FOR y = 1 TO 16
IF mat2(x, y) = 1 THEN
LINE (x * 8, y * 8 + 100)-STEP(7, 7), INT(RND * 16), BF
END IF
NEXT
NEXT
DO WHILE INKEY$ = ""
q = INT(RND * 512): PSET (i(q), e(q)), 0
e(q) = e(q) + 1
IF POINT(i(q), e(q)) = 16 THEN
i(q) = INT(RND * 640)
GOTO ignor
END IF
IF POINT(i(q), e(q)) <> 0 THEN
IF POINT(i(q) + 1, e(q)) = 0 THEN
i(q) = i(q) + 1
GOTO ignor
ELSEIF POINT(i(q) - 1, e(q)) = 0 THEN
i(q) = i(q) - 1
GOTO ignor
ELSEIF POINT(i(q) - 1, e(q)) = 0 AND POINT(i(q) + 1, e(q)) = 0 THEN
h = RND - .5
IF h < 0 THEN
i(q) = i(q) + 1
ELSE
i(q) = i(q) - 1
END IF
END IF
e(q) = e(q) - 1
PSET (i(q), e(q)), 12
e(q) = 0: i(q) = INT(RND * 640)
END IF
ignor: PSET (i(q), e(q)), 15
LOOP

CLS
FOR q = 1 TO 500
i(q) = INT(RND * 640): e(q) = INT(RND * 480)
PSET (i(q), e(q)), INT(RND * 15)
NEXT

FOR q = 1 TO 10
FOR x = 1 TO 64
FOR y = 1 TO 16
IF mat3(x, y) = 1 THEN LINE (x * q + (140 - 8 * q), y * q + (290 - 16 * q))-STEP(q, q), , BF
NEXT
NEXT
IF q = 9 THEN EXIT FOR
FOR x = 1 TO 64
FOR y = 1 TO 16
IF mat3(x, y) = 1 THEN LINE (x * q + (140 - 8 * q), y * q + (290 - 16 * q))-STEP(q, q), 0, BF
NEXT
NEXT
NEXT
d = 1: w = 1
DO WHILE INKEY$ = ""
IF w > 100 THEN EXIT DO
raz = raz + d: IF raz > 9 OR raz < 1 THEN d = -d
FOR y = 16 TO 1 STEP -1
FOR x = 1 TO 64
IF mat3(x, y) = 1 THEN LINE (x * 9 + 68, y * 9 + 146)-STEP(raz, raz), INT(RND * 15), BF
NEXT
NEXT
FOR y = 16 TO 1 STEP -1
FOR x = 1 TO 64
IF mat3(x, y) = 1 THEN LINE (x * 9 + 68, y * 9 + 146)-STEP(raz, raz), 0, BF
NEXT
NEXT
LOOP
f10: CLS
SCREEN 0
LOCATE 1, 1: PRINT "C:\>USER!!!": LOCATE 2, 1: PRINT "C:\>I'll be back"

