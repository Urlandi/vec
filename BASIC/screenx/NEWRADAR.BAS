DECLARE SUB initpalette ()
'After write
CONST cx = 160, cy = 100, m = 100
DEFINT A-Z
SCREEN 13
CLS
CALL initpalette
c = 256
DO
 angle = angle + 1
 IF angle = 360 THEN angle = 0
 x = CINT(COS(angle * 3.14 / 180) * m)
 y = CINT(SIN(angle * 3.14 / 180) * m)
 c = c - 1
 IF c < 0 THEN
  c = 255
  angle = angle - 254
  IF angle < 0 THEN angle = 360 + angle
 END IF
 LINE (cx, cy)-(cx + x, cy + y), c
LOOP WHILE INKEY$ = ""
END

DEFSNG A-Z
SUB initpalette
k = 63
FOR q = 1 TO 255
 IF q MOD 6 = 0 THEN k = k - 1
 OUT &H3C8, q
 OUT &H3C9, 0
 OUT &H3C9, k
 OUT &H3C9, 0
NEXT

END SUB

