DECLARE SUB initpalette ()
'cool
CONST maxdot = 1000, c = 9, k = .5, addx = 150, addy = 100, bm = 100
DEFINT A-C, I, M
SCREEN 13
col = 1
FOR i = 1 TO maxdot
 COLOR col
 LINE -(CINT(SIN(c * i + t) * bm) + addx, CINT(SIN(c * i * k + t) * bm) + addy)
 col = col + 1
 IF col > 255 THEN col = 1
NEXT
CALL initpalette
DO
OUT &H3C7, 255
r = INP(&H3C9)
g = INP(&H3C9)
b = INP(&H3C9)
FOR i = 254 TO 1 STEP -1
OUT &H3C7, i
 r1 = INP(&H3C9)
 g1 = INP(&H3C9)
 b1 = INP(&H3C9)
 OUT &H3C8, i + 1
 OUT &H3C9, r1
 OUT &H3C9, g1
 OUT &H3C9, b1
NEXT
OUT &H3C8, 1
OUT &H3C9, r
OUT &H3C9, g
OUT &H3C9, b
LOOP UNTIL INKEY$ <> ""
END

DEFSNG A-C, I, M
SUB initpalette
FOR q = 1 TO 255
 OUT &H3C8, q
 OUT &H3C9, 0
 OUT &H3C9, q
 OUT &H3C9, q
NEXT
END SUB

