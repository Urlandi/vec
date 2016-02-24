DECLARE SUB er ()
DECLARE SUB answ (t%, ob0$, qs0$, fp0%)
DECLARE SUB aprint (s$, t%)
DECLARE FUNCTION inpstr$ (x%, y%, l%)
DECLARE FUNCTION keykod$ ()

'Animal
'$INCLUDE: 'interupt.bi'
'$DYNAMIC
DEFINT A-Z
RANDOMIZE TIMER


TYPE um
 ob AS STRING * 16
 qs AS STRING * 48
END TYPE
r& = (FRE(-1) * .9) \ 64
DIM SHARED main(1 TO r&) AS um
CLS
VIEW PRINT
COLOR 15, 1
LOCATE 1, 1: PRINT "’"; STRING$(78, 205); "∏"
LOCATE 24, 1: PRINT "‘"; STRING$(78, 205); "æ"
FOR q = 2 TO 23
LOCATE q, 1: PRINT "≥"; STRING$(78, 32); "≥"
NEXT q

OPEN "c:\source\my_prgs\basic\a\help.dat" FOR INPUT AS #1
q = 2
DO WHILE NOT EOF(1)
INPUT #1, f$
LOCATE q, 2: PRINT f$
q = q + 1
LOOP
CLOSE #1

COLOR 9, 0
FOR q = 17 TO 64
LOCATE 13, q: PRINT CHR$(SCREEN(13, q))
NEXT q
FOR q = 11 TO 12
LOCATE q, 64: PRINT CHR$(SCREEN(q, 64))
NEXT q

COLOR 4, 3
LOCATE 10, 16: PRINT "⁄"; STRING$(46, 196); "ø"
LOCATE 12, 16: PRINT "¿"; STRING$(46, 196); "Ÿ"
LOCATE 11, 16: PRINT "≥"; STRING$(46, 32); "≥"


c& = 1




OPEN "c:\source\my_prgs\basic\a\object.dat" FOR RANDOM AS #1 LEN = 64

DO
fs& = LOF(1) / 64: IF fs& = 0 THEN fs& = 1
w& = (fs& + 1) * 2 + 1
IF w& > r& THEN CALL er
REDIM main(w&)


FOR q& = 1 TO fs&
GET #1, q&, main(q&)
NEXT q&


DO
inte$ = LEFT$(main(c&).ob, 1)
IF inte$ = CHR$(0) THEN

IF fp0 = 0 THEN ob0$ = main(c& + 1).ob ELSE ob0$ = main(c& - 1).ob
'CALL answ(0, main(c&).ob, "", 0)
'EXIT DO
ELSE
ob0$ = main(c&).ob
LOCATE 10, 17: PRINT STRING$(46, 196)
LOCATE 10, 17: PRINT "ùTO"
LOCATE 11, 17: PRINT STRING$(46, 32)
LOCATE 11
CALL aprint(main(c&).ob, 0)
DO
SELECT CASE UCASE$(keykod$)
CASE "Y", "Ñ", "§"
LOCATE 10, 17: PRINT STRING$(46, 196)
LOCATE 11, 20: PRINT "åéÜÖíÖ åÖçü èéáÑêÄÇàíú çÖ íÄä ìÜ à èãéïé": k$ = keykod$
k$ = CHR$(27)
EXIT DO
CASE "N", "ç", "≠"
k$ = "‡"
EXIT DO
CASE ELSE
 k$ = " "
END SELECT
LOOP WHILE k$ = " "
IF k$ = CHR$(27) THEN EXIT DO
END IF


inte$ = LEFT$(main(c&).qs, 2)
IF inte$ = "  " OR inte$ = CHR$(0) + CHR$(0) THEN
CALL answ(1, ob0$, qs0$, fp0)
                                                                                        'LOCATE 10, 17: PRINT "C§†Ó·Ï! ä‚Æ Ì‚Æ": ob0$ = inpstr$(40, 11, 16)
                                                                                        'INPUT "E£Æ Æ‚´®Á®•"; qs0$
                                                                                     'INPUT "é≠Æ ¢•‡≠Æ•"; fp0
main(c&).qs = qs0$
c& = c& * 2 + fp0

IF c& > r& THEN
LOCATE 10, 17: PRINT STRING$(46, 196)
LOCATE 11, 17: PRINT "çÖ åéÉì ÅéãúòÖ çàóÖÉé áÄèéåçàíú,Çõ ìÜ àáÇàçàíÖ"
k$ = keykod$
CALL er
END IF

main(c&).ob = ob0$
EXIT DO

ELSE
                                                                                        'PRINT main(c&).qs; "? Y/N": IF UCASE$(keykod$) = "Y" THEN i = 1 ELSE i = 0
CALL answ(2, main(c&).qs, "", fp0)
c& = c& * 2 + fp0
END IF

LOOP

FOR q& = 1 TO c&
IF main(q&).ob = main(c&).ob AND q& <> c& THEN
LOCATE 10, 17: PRINT STRING$(46, 196)
LOCATE 11, 22: PRINT "ÇêÖòú! åÖçü çÖ èêéÇÖÑÖòú! èéòÖã Çéç!"
k$ = keykod$
CALL er
END IF
NEXT q&

LOCATE 10, 17: PRINT STRING$(46, 196)
LOCATE 11, 17: PRINT "ïéíàíÖ èêéÑéãÜàíú (ANY KEY) àãà Çõâíà (ENTER) "
FOR q& = 1 TO c&
PUT #1, q&, main(q&)
NEXT q&
IF keykod$ = CHR$(13) THEN CALL er ELSE c& = 1
LOOP

REM $STATIC
SUB answ (t, ob0$, qs0$, fp0)
s$ = ob0$
LOCATE 10, 17: PRINT STRING$(46, 196)
LOCATE 10, 17: PRINT "CÑÄûëú! äíé ùíé!?"
SELECT CASE t
CASE 0
ob0$ = inpstr(40, 11, 15)
CASE 1, 2
 IF t = 1 THEN
  ob0$ = inpstr$(40, 11, 15)
  LOCATE 10, 17: PRINT STRING$(46, 196)
  IF LEFT$(s$, 1) = CHR$(0) THEN
   LOCATE 10, 17: PRINT "óÖå éíÑàóÄÖíëü ùíéí "; : CALL aprint(ob0$, 1)
  ELSE
  LOCATE 10, 17: PRINT "óÖå éíãàóÄûíëü "; : CALL aprint(ob0$, 1): PRINT " à";
  LOCATE 12, 63 - ASC(LEFT$(s$, 1)): CALL aprint(s$, 1)
  END IF
  qs0$ = inpstr$(40, 11, 46)
  
 ELSEIF t = 2 THEN
 CALL aprint(ob0$, 0)
 END IF
 LOCATE 10, 17: PRINT STRING$(46, 196): LOCATE 12, 17: PRINT STRING$(46, 196)
 LOCATE 10, 17: PRINT "éÅöÖäí ëééíÇÖíëíÇìÖí ùíéåì?"
 DO
  SELECT CASE UCASE$(keykod$)
   CASE "Y", "Ñ", "§"
    fp0 = 1
    EXIT DO
   CASE "N", "ç", "≠"
    fp0 = 0
    EXIT DO
  END SELECT
 LOOP
END SELECT
END SUB

SUB aprint (s$, t%)
k$ = LEFT$(s$, 1)
i$ = MID$(s$, 2, ASC(k$))
SELECT CASE t
CASE 0
LOCATE 11, 17: PRINT STRING$(46, 32)
LOCATE 11, 40 - LEN(i$) \ 2
CASE 1
END SELECT
PRINT UCASE$(i$);
END SUB

SUB er
COLOR 7, 0
CLS
PRINT "(c) 1999 Michael"
CLOSE #1
END
END SUB

FUNCTION inpstr$ (x, y, l)
q = 0: s$ = ""
LOCATE 11, 17: PRINT STRING$(46, 32)
DO
k$ = ""
k$ = keykod$
SELECT CASE k$
CASE " " TO "Ô"
  q = q + 1
  IF q > l THEN
   q = q - 1
   EXIT DO
  END IF
  s$ = s$ + UCASE$(k$)
CASE CHR$(13)
 IF q <> 0 THEN EXIT DO
CASE CHR$(8)
 q = q - 1
 IF q >= 0 THEN s$ = LEFT$(s$, q) ELSE q = 0
 END SELECT
LOCATE y, x - l \ 2: PRINT STRING$(l, 32)
LOCATE y, x - LEN(s$) \ 2: PRINT s$
LOOP
s$ = CHR$(q) + s$
inpstr$ = s$
END FUNCTION

FUNCTION keykod$


n = &H16
x = POS(0): y = CSRLIN
COLOR 15, 1
DO
LOCATE 24, 70: PRINT "["; TIME$; "]"

INREG.AX = 256: CALL INTERRUPT(n, INREG, OUTREG)

IF (OUTREG.FLAGS AND 64) = 0 THEN
INREG.AX = 0: CALL INTERRUPT(n, INREG, OUTREG)
l = OUTREG.AX MOD 256: h = OUTREG.AX \ 256
k$ = CHR$(l): IF l = 0 THEN k$ = k$ + CHR$(h)
END IF

LOOP WHILE k$ = ""
LOCATE y, x
IF k$ = CHR$(27) THEN CALL er
keykod$ = k$
COLOR 4, 3
END FUNCTION

