DECLARE SUB defl (n AS INTEGER)
DECLARE SUB lc (n AS INTEGER)
'What is the MATRIX
'I's TRUE
DEFINT A-Z
CONST my = 49, ma = 60, mx = 50, aspd = 3
TYPE leave
 l AS STRING * 1
 y AS INTEGER
 c AS INTEGER
END TYPE
SCREEN 0
WIDTH 80, 50
DIM SHARED mm(1 TO mx, 1 TO ma) AS leave, s(1 TO mx) AS INTEGER, lnm(1 TO mx) AS INTEGER
RANDOMIZE TIMER
FOR k = 1 TO mx
CALL defl(80 + k)
NEXT k
COLOR 2
FOR q = 1 TO 49
LOCATE q, 51: PRINT "³"
NEXT q
COLOR 14
LOCATE 1, 53: PRINT "Œ âà¨æ ,-ë,¦ (á¯¥æ.). "
LOCATE 2, 53: PRINT "- 1.‡¥àª «ì­ ï ª®¯¨ï"
LOCATE 3, 53: PRINT "¯¥ç â­®© ä®à¬ë, á«ã¦ é ï"
LOCATE 4, 53: PRINT "¤«ï ®â«¨¢ª¨ áâ¥à¥®â¨¯®¢."
LOCATE 6, 53: PRINT "Matrix (« â.)."
LOCATE 7, 53: PRINT "- ¯¥à¢®¯à¨ç¨­ , ¨áâ®ç­¨ª."

DO
 FOR k = 1 TO mx
  FOR h = 1 TO s(k)
   FOR q = 1 TO lnm(k)
    mm(k, q).y = mm(k, q).y + 1
    IF mm(k, q).y > 0 AND mm(k, q).y < my THEN
     LOCATE mm(k, q).y, k
     COLOR mm(k, q).c
     PRINT mm(k, q).l

    END IF
    IF mm(k, q).c = 10 AND INT(RND * 3) = 1 AND q <> 1 THEN
     mm(k, q).c = 2
     IF q > 1 AND q < ma - 1 THEN mm(k, q + 1 - INT(RND * 2)).c = 10
    ELSE
     IF INT(RND * 3000) = 0 THEN mm(k, q).c = 10
    END IF
    IF mm(k, q).l = " " THEN
     IF mm(k, q).y = my THEN defl (k)
     EXIT FOR
    END IF
   NEXT q
  NEXT h
  CALL lc(k)
 NEXT k
LOOP WHILE INKEY$ = ""
CLS
WIDTH 80, 25
COLOR 7

DEFSNG A-Z
SUB defl (d AS INTEGER)
DEFINT A-Z
n = RND * (ma - 3) + 3
IF d > 80 THEN
 k = RND * my
 d = d - 80
ELSE
 k = 0
END IF
FOR q = 1 TO n
 mm(d, q).l = CHR$(RND * (255 - 33) + 33)
 mm(d, q).y = k
 mm(d, q).c = 2
 IF q = 1 AND INT(RND * 5) = 3 THEN mm(d, q).c = 10
 k = k - 1
NEXT q
mm(d, n).l = " "
s(d) = RND * aspd + 1
lnm(d) = n
END SUB

DEFSNG A-Z
SUB lc (n AS INTEGER)
DEFINT A-Z
z$ = mm(n, lnm(n) - 1).l
FOR q = lnm(n) - 1 TO 2 STEP -1
 mm(n, q).l = mm(n, q - 1).l
NEXT q
mm(n, 1).l = z$

END SUB

