'Сентябрь 1,вариации на тему
RANDOMIZE TIMER
SCREEN 12
DEFINT A-Z
DIM sen(0 TO 80, 0 TO 16), sx(1024), sy(1024), radius(1024), ugol(1024), cvet(5, 3), cvetd(5, 3)
strok$ = "                             Приветствую я вас снова,да именно вас тех кто сегодня 1 СЕНТЯБРЯ 1998 года впервые переступил порог школы,колледжа,института."
strok$ = strok$ + "Приветствую и вас,выпускники,прошедших огонь и воду вместе со своими друзьями:одноклассниками и однокашниками.Этот день (1 сентября для тех кто уже подзабыл),"
strok$ = strok$ + "я уверен останется у вас в памяти на всю вашу жизнь,счастливую и не очень,полную опасности и приключений или проведенную за письменным столом,"
strok$ = strok$ + "радостную и грустную,но главное в этой жизни помнить о тех кто всегда сможет вам помочь в ту минуту когда помощи уже ждать неоткуда.Всегда,всегда "
strok$ = strok$ + "помните о своих друзьях! -\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/- "
strok$ = strok$ + "Ну а теперь немного об управлении.Если вы читаете это значит программу вы смогли запустить поэтому об этом не будем.Управление же осуществляется с помощью клавиш F1-F9,ESC и F10 "
strok$ = strok$ + "Понажимай(те) их и может быть в чем нибудь разберетесь.До встречи!!!                             "
LOCATE 1, 1: PRINT "1 СЕНТЯБРЯ"
FOR x = 0 TO 80
FOR y = 0 TO 16
IF POINT(x, y) <> 0 THEN sen(x, y) = 1
NEXT: NEXT
1 CLS
DO
FOR x = 0 TO 80
c = 15 - INT(RND * 14): IF x / 8 = CINT(x / 8) THEN c1 = 15 - INT(RND * 14)
FOR y = 0 TO 16
IF sen(x, y) = 1 THEN
LINE (x * 8, y * 18 + 240)-STEP(6, 16), 15 - INT(RND * 14), BF
LINE (x * 6 + 90, y * 12 + 115)-STEP(4, 10), c, BF
LINE (x * 4 + 160, y * 10)-STEP(2, 8), c1, BF
END IF
NEXT: NEXT
s$ = INKEY$
LOOP WHILE s$ = ""
GOTO kodkey
2 CLS : sm = 0: d = 1
DO
FOR x = 0 TO 80
sm = sm + d: IF sm / 5 = CINT(sm / 5) THEN d = -d
IF x / 8 = CINT(x / 8) THEN c = 15 - (INT(RND * 6))
FOR y = 0 TO 16
LINE (x * 8, (y + 1 + sm) * 18 + 50)-STEP(6, 16), 0, BF
IF sen(x, y) = 1 THEN LINE (x * 8, (y + sm) * 18 + 50)-STEP(6, 16), c, BF
NEXT: NEXT
s$ = INKEY$
LOOP WHILE s$ = ""
GOTO kodkey
3 CLS
FOR x = 0 TO 80
FOR y = 0 TO 16
IF sen(x, y) = 1 THEN LINE (x * 7 + 35, y * 30)-STEP(5, 25), 9, BF
NEXT: NEXT
FOR q = 1 TO 1024
sx(q) = INT(RND * 640): sy(q) = INT(RND * 480)
NEXT
DO
q = INT(RND * 1024)
IF POINT(sx(q), sy(q) + 1) <> 0 THEN
 IF POINT(sx(q) + 1, sy(q) + 1) <> 0 AND POINT(sx(q) - 1, sy(q) + 1) <> 0 THEN
 sy(q) = 0: sx(q) = INT(RND * 640)
 ELSEIF POINT(sx(q) + 1, sy(q) + 1) = 0 AND POINT(sx(q) - 1, sy(q) + 1) <> 0 THEN
 PSET (sx(q), sy(q)), 0: sx(q) = sx(q) + 1
 ELSEIF POINT(sx(q) + 1, sy(q) + 1) <> 0 AND POINT(sx(q) - 1, sy(q) + 1) = 0 THEN
 PSET (sx(q), sy(q)), 0: sx(q) = sx(q) - 1
 ELSEIF POINT(sx(q) + 1, sy(q) + 1) = 0 AND POINT(sx(q) - 1, sy(q) + 1) = 0 THEN
 PSET (sx(q), sy(q)), 0: sluch = RND * 10: IF sluch > 5 THEN sx(q) = sx(q) + 1 ELSE sx(q) = sx(q) - 1
 END IF
ELSE
PSET (sx(q), sy(q)), 0
END IF
sy(q) = sy(q) + 1
PSET (sx(q), sy(q)), 15 - INT(RND * 14)
s$ = INKEY$
LOOP WHILE s$ = ""
GOTO kodkey
4 CLS : dx = 4: dy = 2: zx = INT(RND * 320): zy = INT(RND * 292)
DO
zxd = zx: zyd = zy
zx = zx + dx: IF zx < 0 OR zx > 320 THEN dx = -dx
zy = zy + dy: IF zy < -20 OR zy > 320 THEN dy = -dy
FOR y = 0 TO 16
clr = 15 - INT(RND * 14)
FOR x = 0 TO 80
IF sen(x, y) = 1 THEN
CIRCLE (x * 4 + zxd, y * 12 + zyd), 2, 0
CIRCLE (x * 4 + zx, y * 12 + zy), 2, clr
END IF
NEXT: NEXT
s$ = INKEY$
LOOP WHILE s$ = ""
GOTO kodkey
5 CLS : col = 20: sx = 280: sy = 232: bx = 0: by = 0
DO
delxdbl = deltax: delydbl = deltay: dbx = bx: dby = by
deltax = bx * 40: deltay = by * 8
bx = bx + 1: by = by + 1: col = col + 1: IF col > 63 THEN col = 63
IF by > 100 THEN
bx = 1: by = 1: col = 20: sx = 500 - INT(RND * 400): sy = 400 - INT(RND * 300): CLS
END IF
PALETTE 9, 65536 * CINT(col)
FOR x = 0 TO 80
FOR y = 0 TO 16
IF sen(x, y) = 1 THEN CIRCLE (x * dbx - delxdbl + sx, y * dby - delydbl + sy), 2, 0
IF sen(x, y) = 1 THEN CIRCLE (x * bx - deltax + sx, y * by - deltay + sy), 2, 9
NEXT: NEXT
s$ = INKEY$
LOOP WHILE s$ = ""
PALETTE
GOTO kodkey
6 CLS
FOR q = 1 TO 1024
ugol(q) = INT(RND * 360): radius(q) = 700 - INT(RND * 650): sy(q) = 0
NEXT
CIRCLE (320, 240), 48, 4: PAINT (320, 240), 4
FOR x = 0 TO 80
FOR y = 0 TO 16
IF sen(x, y) = 1 THEN LINE (x + 280, y * 3 + 215)-STEP(1, 2), 9, BF
NEXT: NEXT
PALETTE 8, 4144959
DO
FOR q = 1 TO 1024
PSET (sx(q), sy(q)), 0
radius(q) = radius(q) + 3
IF radius(q) > 700 THEN
radius(q) = 50: ugol(q) = INT(RND * 360)
END IF
sx(q) = INT(COS(3.1415926# * ugol(q) / 180) * radius(q) + 320)
sy(q) = INT(SIN(3.1415926# * ugol(q) / 180) * radius(q) + 240)
PSET (sx(q), sy(q)), 8
NEXT
s$ = INKEY$
LOOP WHILE s$ = ""
PALETTE
GOTO kodkey
7 CLS
FOR x = 0 TO 80
FOR y = 0 TO 16
IF sen(x, y) = 1 THEN
LINE (x * 7, y * 15 + 100)-STEP(11, 21), 1, BF
LINE (x * 3 + 300, y * 5 + 50)-STEP(4, 6), 2, BF
LINE (x * 4 + 30, y * 7)-STEP(5, 8), 3, BF
LINE (x * 2, y * 2 + 300)-STEP(3, 3), 4, BF
LINE (x * 5 + 200, y * 15 + 280)-STEP(6, 16), 5, BF
END IF
NEXT: NEXT
FOR q = 1 TO 5
cvet(q, 1) = INT(RND * 63): cvet(q, 2) = cvet(q, 1): cvet(q, 3) = cvet(q, 1)
cvetd(q, 1) = 1: cvetd(q, 2) = cvetd(q, 1): cvetd(q, 3) = cvetd(q, 1)
NEXT
DO
FOR paus& = 1 TO 50000: NEXT
FOR q = 1 TO 5
SELECT CASE q
CASE 1
cvet(q, 1) = cvet(q, 1) + cvetd(q, 1): IF cvet(q, 1) > 62 OR cvet(q, 1) < 2 THEN cvetd(q, 1) = -cvetd(q, 1)
PALETTE 1, 65536 * cvet(q, 1)
CASE 2
cvet(q, 2) = cvet(q, 2) + cvetd(q, 2): IF cvet(q, 2) > 62 OR cvet(q, 2) < 2 THEN cvetd(q, 2) = -cvetd(q, 2)
PALETTE 2, 256 * cvet(q, 2)
CASE 3
cvet(q, 2) = cvet(q, 2) + cvetd(q, 2): cvet(q, 1) = cvet(q, 1) + cvetd(q, 1)
IF cvet(q, 2) > 62 OR cvet(q, 2) < 2 THEN
cvetd(q, 2) = -cvetd(q, 2): cvetd(q, 1) = -cvetd(q, 1)
END IF
PALETTE 3, 65536 * cvet(q, 1) + 256 * cvet(q, 2)
CASE 4
cvet(q, 3) = cvet(q, 3) + cvetd(q, 3)
IF cvet(q, 3) > 62 OR cvet(q, 3) < 2 THEN cvetd(q, 3) = -cvetd(q, 3)
PALETTE 4, cvet(q, 3)
CASE 5
cvet(q, 3) = cvet(q, 3) + cvetd(q, 3): cvet(q, 1) = cvet(q, 1) + cvetd(q, 1)
IF cvet(q, 3) > 62 OR cvet(q, 3) < 2 THEN
cvetd(q, 3) = -cvetd(q, 3): cvetd(q, 1) = -cvetd(q, 1)
END IF
PALETTE 5, 65536 * cvet(q, 1) + cvet(q, 3)
END SELECT
NEXT
s$ = INKEY$
LOOP WHILE s$ = ""
PALETTE
GOTO kodkey
8 CLS : steper! = .09: B! = 0: lor! = 62: lord! = .144
DO
lor! = lor! + lord!: IF lor! > 62 OR lor! < 30 THEN lord! = -lord!
PALETTE 15, 256 * INT(lor!)
B! = B! + steper!: IF B! > 10 OR B! < -10 THEN steper! = -steper!
FOR x = 0 TO 80
FOR y = 0 TO 16
IF sen(x, y) = 1 THEN PSET (x * 7 + 40, y * (B! - steper!) + 240 - (B! - steper!) * 16), 0
IF sen(x, y) = 1 THEN PSET (x * 7 + 40, y * B! + 240 - B! * 16), 15
NEXT: NEXT
s$ = INKEY$
LOOP WHILE s$ = ""
PALETTE
GOTO kodkey
9 CLS : pol = 0
DO
pol = pol + 1: IF pol > LEN(strok$) THEN pol = 1
strokout$ = MID$(strok$, pol, 29)
LOCATE 1, 1: COLOR 15 - INT(RND * 14): PRINT strokout$
FOR x = 0 TO 232
IF x / 8 = INT(x / 8) THEN cl = cl + 1
IF cl > 15 THEN cl = 1
FOR y = 0 TO 16
IF POINT(x, y) <> 0 THEN
LINE (x * 2 + 10, y * 2 + 15)-STEP(2, 2), cl
LINE (x * 4 + 30, y * 4 + 40)-STEP(2, 2), cl
LINE (x * 6 + 60, y * 6 + 100)-STEP(2, 2), cl
LINE (x * 8 + 120, y * 8 + 200)-STEP(2, 2), cl
LINE (x * 10 + 240, y * 10 + 300)-STEP(2, 2), cl
ELSE
LINE (x * 2 + 10, y * 2 + 15)-STEP(2, 2), 0
LINE (x * 4 + 30, y * 4 + 40)-STEP(2, 2), 0
LINE (x * 6 + 60, y * 6 + 100)-STEP(2, 2), 0
LINE (x * 8 + 120, y * 8 + 200)-STEP(2, 2), 0
LINE (x * 10 + 240, y * 10 + 300)-STEP(2, 2), 0
END IF
NEXT: NEXT
s$ = INKEY$
LOOP WHILE s$ = ""
GOTO kodkey
10 CLS : SCREEN 0: LOCATE 1, 1: PRINT "Дерзай салага":   END
kodkey:
s = ASC(RIGHT$(s$, 1))
SELECT CASE s
CASE 59
GOTO 1
CASE 60
GOTO 2
CASE 61
GOTO 3
CASE 62
GOTO 4
CASE 63
GOTO 5
CASE 64
GOTO 6
CASE 65
GOTO 7
CASE 66
GOTO 8
CASE 68, 27
GOTO 10
CASE ELSE
GOTO 9
END SELECT

