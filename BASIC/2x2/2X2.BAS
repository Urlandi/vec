DECLARE SUB summa ()
DECLARE SUB por ()
DECLARE SUB n1 ()
DECLARE SUB n2 ()
DECLARE SUB x10 ()
DECLARE SUB sluch ()
DECLARE SUB pi ()
DECLARE SUB exg ()
DECLARE SUB krg ()
DECLARE SUB osta ()
DECLARE SUB cel ()
DECLARE SUB kste ()
DECLARE SUB sinus ()
DECLARE SUB cosinus ()
DECLARE SUB tanges ()
DECLARE SUB ko ()
DECLARE SUB nut ()
DECLARE SUB ex ()
DECLARE SUB obr ()
DECLARE SUB proc1 ()
DECLARE SUB summ (s$())
DECLARE SUB ste ()
DECLARE SUB kvd ()
DECLARE SUB korkvd ()
DECLARE SUB cha ()
DECLARE SUB proz (p$())
DECLARE SUB raz ()
DECLARE SUB absol ()
DECLARE SUB proc ()
DECLARE SUB innum (is$, x#, y#)
DECLARE SUB diskr ()
DECLARE SUB scroll (x%, y%, x1%, y1%, lines%, back%, dir%)
DECLARE SUB kodkey (KOD%)
'� ��⠪� ��� 誮�쭨���
'$DYNAMIC
'$INCLUDE: 'interupt.bi'
CLEAR
DIM text$(256), sum$(9)
VIEW PRINT
OPEN "c:\source\my_prgs\basic\2x2\speak.tll" FOR RANDOM AS #1 LEN = 77
FIELD #1, 77 AS tmp$
DO WHILE NOT EOF(1)
q = q + 1
GET #1, q
text$(q) = tmp$
LOOP
CLOSE #1
CLS
COLOR , 9
FOR q = 1 TO 25
PRINT STRING$(80, 32)
NEXT
COLOR 10, 9: LOCATE 3, 2: PRINT STRING$(78, 205): LOCATE 24, 2: PRINT STRING$(78, 205)
LOCATE 3, 1: PRINT "�": LOCATE 3, 80: PRINT "�": LOCATE 24, 1: PRINT "�": LOCATE 24, 80: PRINT "�"
FOR q = 4 TO 23
LOCATE q, 1: PRINT "�": LOCATE q, 80: PRINT "�"
NEXT
COLOR 14, 9: LOCATE 2, 2: PRINT "������": LOCATE 2, 18: PRINT "�����"
COLOR 10: LOCATE 3, 66: PRINT "1988 -> 1997": LOCATE 3, 65: COLOR 10: PRINT "[": LOCATE 3, 78: PRINT "]"
COLOR 6: LOCATE 2, 55: PRINT "������ ������� �� ������"
COLOR 14
ps = 1: kursor = 4: psit = 1
start: k = 3: COLOR 14, 1
FOR q = psit TO psit + 19
 k = k + 1
 LOCATE k, 3: PRINT text$(q)
NEXT
IF kursor > 23 THEN kursor = 23
LOCATE kursor, 3: COLOR 15, 2: PRINT text$(ps)
DO
CALL kodkey(KOD)
SELECT CASE KOD
CASE 32
 p = 1: FOR q = 1 TO 4: SOUND 1195, .4: SOUND 2571, .4: NEXT
 COLOR 10, 6: LOCATE 2, 2: PRINT "������"
 DO
  CALL kodkey(KOD)
  COLOR 14, 1: LOCATE 2, 2: PRINT "������          �����"
  SELECT CASE KOD
  CASE 77
  SOUND 600, .1
  p = p + 1: IF p > 2 THEN p = 1
  IF p = 1 THEN
  COLOR 10, 6: LOCATE 2, 2: PRINT "������"
  ELSE
  COLOR 10, 6: LOCATE 2, 18: PRINT "�����"
  END IF
  CASE 75
  SOUND 600, .1
  p = p - 1: IF p < 1 THEN p = 2
  IF p = 1 THEN
  COLOR 10, 6: LOCATE 2, 2: PRINT "������"
  ELSE
  COLOR 10, 6: LOCATE 2, 18: PRINT "�����"
  END IF
  CASE 13
  IF p = 2 THEN
  LOCATE 2, 18: PRINT "�����": GOTO v
  ELSE
hlp:  PLAY "t255l64mlo1cdefgab>cdefgabp16<bagfedc<bagfedcp32"
  LOCATE 4, 10: COLOR 5, 3: PRINT STRING$(59, 205): LOCATE 22, 10: PRINT STRING$(59, 205)
  LOCATE 4, 9: PRINT "�": LOCATE 4, 69: PRINT "�": LOCATE 22, 9: PRINT "�": LOCATE 22, 69: PRINT "�"
  FOR q = 5 TO 21: LOCATE q, 9: PRINT "�                                                           �": NEXT
  FOR q = 5 TO 23
  COLOR 8, 0: LOCATE q, 70: PRINT CHR$(SCREEN(q, 70))
  NEXT
  FOR q = 11 TO 69
  LOCATE 23, q: PRINT CHR$(SCREEN(23, q))
  NEXT
  COLOR 5, 3
  LOCATE 5, 11: PRINT "��ࠢ���� ����� �� ��� ����� � � ���� � ��� �ᥣ��"
  LOCATE 6, 11: PRINT "� �।�⠢��� ᢮� ����� ���ࠬ�� �����,�㬠�, �㤥�"
  LOCATE 7, 11: PRINT "������� �� ⮫쪮 ���.������ �ணࠬ��(� ������ �� 2�2)"
  LOCATE 8, 11: PRINT "�।��⠢��� ����������� ������ ������� �� ��࠭�� ��-"
  LOCATE 9, 11: PRINT "������ ���� ��㫮�.�뫨 �ᯮ�짮���� �������� 㯮�ॡ-"
  LOCATE 10, 11: PRINT "�塞� ���� ��⥬�⨪�.�ணࠬ�� �।�����祭�� ��� "
  LOCATE 11, 11: PRINT "�������� �����⮢,�� ��ਭ樯� �᫨ ��� �祭� �㦭� �"
  LOCATE 12, 11: PRINT "� ����� ᫮��� �ਬ��� ����� ������� �ᯮ���� 2�2"
  LOCATE 13, 11: PRINT "� ⥯��� �� �ࠢ�����(���஡�� ᬮ�� 2�2.doc) - � �ண-"
  LOCATE 14, 11: PRINT "ࠬ�� ������⢮���� ������ �ࠢ����� ����஬ � �������"
  LOCATE 15, 11: PRINT "������ �ந�室�� �롮� �㭪⮢ ���� � ���.ESC - ��室"
  LOCATE 16, 11: PRINT "�� �ணࠬ�� ��� ०���� ࠡ��� �ணࠬ��.ENTER - �����"
  LOCATE 17, 11: PRINT "�����ன ���� �� �ᯮ������ ��� �뢮� ���ଠ樨 ����"
  LOCATE 18, 11: PRINT "�� ��࠭.�஡�� �室 � ���孥� ����.��� � �� �� ��� ��-"
  LOCATE 19, 11: PRINT "�� ����� �� �ࠢ�����. !��������! �ண���� �।��������"
  LOCATE 20, 11: PRINT "�� ���짮��⥫� �������� �᭮��묨 ��⥬���᪨�� ����-"
  LOCATE 21, 11: PRINT "��."
  q$ = INPUT$(1)
  GOTO start
  END IF
  CASE 27
  FOR q = 1 TO 4
  SOUND 1000, .1: SOUND 2000, .2
  NEXT
  GOTO start
  CASE ELSE
  p = 2: COLOR 10, 6: LOCATE 2, 18: PRINT "�����"
  SOUND 1000, .5
  END SELECT
 LOOP
CASE 27, 68
v: FOR q = 1000 TO 100 STEP -50
   SOUND q, .1
   NEXT
 LOCATE 8, 28: COLOR 15, 4: PRINT STRING$(25, 205): LOCATE 14, 28: PRINT STRING$(25, 205)
 LOCATE 8, 27: PRINT "�": LOCATE 8, 53: PRINT "�": LOCATE 14, 27: PRINT "�": LOCATE 14, 53: PRINT "�"
 FOR q = 9 TO 13: LOCATE q, 27: PRINT "�                         �": NEXT
 LOCATE 10, 35: PRINT "�� �������? ": LOCATE 12, 38: PRINT "[Y/N]"
 FOR q = 9 TO 15
 COLOR 8, 0: LOCATE q, 54: PRINT CHR$(SCREEN(q, 54))
 NEXT
 FOR q = 28 TO 53
 LOCATE 15, q: PRINT CHR$(SCREEN(15, q))
 NEXT
 DO
 CALL kodkey(KOD)
 IF KOD = 89 OR KOD = 121 THEN
 FOR q = 100 TO 2000 STEP 100
 SOUND q, .2
 NEXT
 GOTO kon
 ELSEIF KOD = 78 OR KOD = 110 OR KOD = 27 THEN
 FOR q = 1000 TO 5000 STEP 500
 SOUND q, .2
 NEXT
 GOTO start
 ELSE SOUND 1000, .5
 END IF
 LOOP
CASE 80
 SOUND 0, .1
 ps = ps + 1: kursor = kursor + 1
 IF text$(ps) = "" THEN ps = ps - 1
 IF kursor > 23 AND text$(ps + 1) <> "" THEN
 LOCATE 23, 3: COLOR 14, 1: PRINT text$(ps - 1): COLOR 15, 2
 CALL scroll(4, 1, 23, 79, 1, 1, 6): LOCATE 23, 3: PRINT text$(ps)
 psit = psit + 1
 ELSEIF kursor > 23 AND text$(ps + 1) = "" THEN
 LOCATE 23, 3: COLOR 15, 2: PRINT text$(ps - 1)
 ps = ps - 1
 ELSE
 COLOR 14, 1: LOCATE kursor - 1, 3: PRINT text$(ps - 1)
 COLOR 15, 2: LOCATE kursor, 3: PRINT text$(ps)
 END IF
 CASE 72
 SOUND 0, .1
 IF kursor > 23 THEN kursor = 23
 ps = ps - 1: kursor = kursor - 1
 IF ps < 1 THEN
 ps = 1
 kursor = 4
 END IF
 IF kursor < 4 THEN
 LOCATE 4, 3: COLOR 14, 1: PRINT text$(ps + 1): COLOR 15, 2
 CALL scroll(4, 1, 23, 79, 1, 1, 7): LOCATE 4, 3: PRINT text$(ps)
 psit = psit - 1
 kursor = 4
 ELSEIF kursor < 4 AND ps < 1 THEN
 COLOR 15, 2: LOCATE 4, 3: PRINT text$(1)
 ELSE
 COLOR 14, 1: LOCATE kursor + 1, 3: PRINT text$(ps + 1)
 COLOR 15, 2: LOCATE kursor, 3: PRINT text$(ps)
 END IF
 CASE 59
 GOTO hlp
CASE 13
  FOR q = 1500 TO 100 STEP -400
  SOUND 1000, .9: SOUND q, 1
  NEXT
  LOCATE 7, 15: COLOR 15, 7: PRINT STRING$(49, 205): LOCATE 20, 15: PRINT STRING$(49, 205)
  LOCATE 7, 14: PRINT "�": LOCATE 7, 64: PRINT "�": LOCATE 20, 14: PRINT "�": LOCATE 20, 64: PRINT "�"
  FOR q = 8 TO 19: LOCATE q, 14: PRINT "�                                                 �": NEXT
  FOR q = 8 TO 21
  COLOR 8, 0: LOCATE q, 65: PRINT CHR$(SCREEN(q, 65))
  NEXT
  FOR q = 16 TO 65
  LOCATE 21, q: PRINT CHR$(SCREEN(21, q))
  NEXT
 IF ps = 1 THEN
 CALL summ(sum$())
 ELSEIF ps = 2 THEN
 CALL raz
 ELSEIF ps = 3 THEN
 CALL proz(sum$())
 ELSEIF ps = 4 THEN
 CALL cha
 ELSEIF ps = 5 THEN
 CALL absol
 ELSEIF ps = 6 THEN
 CALL obr
 ELSEIF ps = 7 THEN
 CALL proc
 ELSEIF ps = 8 THEN
 CALL proc1
 ELSEIF ps = 9 THEN
 CALL korkvd
 ELSEIF ps = 10 THEN
 CALL kvd
 ELSEIF ps = 11 THEN
 CALL ste
 ELSEIF ps = 12 THEN
 CALL kste
 ELSEIF ps = 13 THEN
 CALL diskr
 ELSEIF ps = 14 THEN
 CALL sinus
 ELSEIF ps = 15 THEN
 CALL cosinus
 ELSEIF ps = 16 THEN
 CALL tanges
 ELSEIF ps = 17 THEN
 CALL ko
 ELSEIF ps = 18 THEN
 CALL nut
 ELSEIF ps = 19 THEN
 CALL ex
 ELSEIF ps = 20 THEN
 CALL x10
 ELSEIF ps = 21 THEN
 CALL sluch
 ELSEIF ps = 22 THEN
 CALL pi
 ELSEIF ps = 23 THEN
 CALL exg
 ELSEIF ps = 24 THEN
 CALL krg
 ELSEIF ps = 25 THEN
 CALL osta
 ELSEIF ps = 26 THEN
 CALL cel
 ELSEIF ps = 27 THEN
 CALL summa
 ELSEIF ps = 28 THEN
 CALL por
 ELSEIF ps = 29 THEN
 CALL n2
 ELSEIF ps = 30 THEN
 CALL n1
 END IF
 PLAY "t150l64mso4bgec<afl16d"
 GOTO start
 END SELECT
LOOP
kon: COLOR 7, 0: CLS : PRINT "����� �ப� "

REM $STATIC
DEFDBL A-Z
SUB absol
LOCATE 7, 33: COLOR 13, 7: PRINT " ����� �᫠ ": COLOR 10
LOCATE 10, 17: PRINT "������ �᫮. � = "
CALL innum(a$, 37, 10): a = VAL(a$)
a = ABS(a)
LOCATE 13, 17: PRINT "����� �᫠.  /�/ = "; a
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB cel
LOCATE 7, 32: COLOR 13, 7: PRINT " ����� ��⭮� ": COLOR 10
LOCATE 10, 17: PRINT "������ �e����� "
CALL innum(w2$, 34, 10)
pvt2: e2$ = "": LOCATE 12, 17: PRINT "������ ����⥫�        "
CALL innum(e2$, 35, 12)
IF e2$ = "0" OR e2$ = "" OR e2$ = "-0" THEN GOTO pvt2
ch2 = VAL(w2$) \ VAL(e2$)
LOCATE 14, 17: PRINT "���⭮� ࠢ��"; ch2
DO: LOOP WHILE INKEY$ = ""

END SUB

SUB cha
LOCATE 7, 35: COLOR 13, 7: PRINT " ���⭮� ": COLOR 10
LOCATE 10, 17: PRINT "������ �e����� "
CALL innum(w$, 34, 10)
pvt: e$ = "": LOCATE 12, 17: PRINT "������ ����⥫�        "
CALL innum(e$, 35, 12)
IF e$ = "0" OR e$ = "" OR e$ = "-0" THEN GOTO pvt
ch = VAL(w$) / VAL(e$)
LOCATE 14, 17: PRINT "���⭮� ࠢ��"; ch
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB cosinus
LOCATE 7, 34: COLOR 13, 7: PRINT " ��ᨭ�� ": COLOR 10
LOCATE 10, 17: PRINT "������ �ࠤ�� "
CALL innum(as11$, 37, 10): ast1 = VAL(as11$)
ast1 = COS(3.141592653# * ast1 / 180)
LOCATE 13, 17: PRINT "��ᨭ�� " + as11$ + " �ࠤ�ᮢ ࠢ��"; ast1
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB diskr
LOCATE 7, 28: COLOR 13, 7: PRINT " �����⭮� �ࠢ����� "
LOCATE 9, 17: COLOR 10: PRINT "������ ���� ����樥��. a= "
CALL innum(a$, 48, 9)
LOCATE 10, 17: COLOR 10: PRINT "������ ��ன ����樥��. b= "
CALL innum(b$, 48, 10)
LOCATE 11, 17: COLOR 10: PRINT "������ ��⨩ ����樥��. c= "
CALL innum(c$, 48, 11)
a = VAL(a$): b = VAL(b$): c = VAL(c$)
d = b ^ 2 - 4 * a * c
IF d < 0 OR a = 0 THEN
LOCATE 13, 17: PRINT "���e��� ���"
ELSEIF d = 0 THEN
o = -b / 2 * a
LOCATE 13, 17: PRINT "���ਬ����� ࠢ��  "; d
LOCATE 14, 17: PRINT "�ࠢ����� ����� ���� ��७�  "; o
ELSE
x = -b + SQR(d) / 2 * a
y = -b - SQR(d) / 2 * a
LOCATE 13, 17: PRINT "���ਬ����� ࠢ��  "; d
LOCATE 14, 17: PRINT "�ࠢ����� ����� ��� ����:"
LOCATE 16, 17: PRINT "x= "; x: LOCATE 17, 17: PRINT "y= "; y
END IF
DO: LOOP WHILE INKEY$ = ""
END SUB




SUB ex
LOCATE 7, 32: COLOR 13, 7: PRINT " C⥯��� � ": COLOR 10
pet: ss$ = "": LOCATE 10, 17: PRINT "������ �⥯���                        "
CALL innum(ss$, 37, 10): at = VAL(ss$): IF LEN(ss$) > 2 THEN GOTO pet
at = EXP(at)
LOCATE 13, 17: PRINT STR$(EXP(1)) + " � �⥯��� " + ss$ + " ࠢ��": LOCATE 14, 30: PRINT at
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB exg
LOCATE 7, 38: COLOR 13, 7: PRINT " � ": COLOR 10
LOCATE 13, 31: PRINT "� = " + STR$(EXP(1))
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB innum (is$, x, y)
e = 0: w = 0: is$ = ""
DO
mst: q$ = INPUT$(1): IF q$ = CHR$(13) OR LEN(is$) > 14 THEN EXIT DO
IF q$ < ":" AND q$ > "/" OR q$ = "-" OR q$ = "." THEN
IF q$ = "-" AND w = 1 THEN
GOTO mst
ELSE
w = 1
END IF
IF q$ = "." AND e = 1 THEN
GOTO mst
ELSEIF q$ = "." AND e <> 1 THEN
e = 1
END IF
is$ = is$ + q$: LOCATE y, x: PRINT is$
ELSE
GOTO mst
END IF
LOOP
END SUB

SUB ko
LOCATE 7, 32: COLOR 13, 7: PRINT " ��⠭��� ": COLOR 10
LOCATE 10, 17: PRINT "������ �ࠤ�� "
CALL innum(a1ss$, 37, 10): a1st = VAL(a1ss$)
a1st = 1 / TAN(3.141592653# * a1st / 180)
LOCATE 13, 17: PRINT "��⠭��� " + a1ss$ + " �ࠤ�ᮢ ࠢ��"; a1st
DO: LOOP WHILE INKEY$ = ""
END SUB

DEFINT A-Z
SUB kodkey (KOD)
DO: q$ = INKEY$: LOOP WHILE q$ = ""
KOD = ASC(RIGHT$(q$, 1))
END SUB

DEFDBL A-Z
SUB korkvd
LOCATE 7, 30: COLOR 13, 7: PRINT " ���e�� ������� ": COLOR 10
po: q$ = "": LOCATE 10, 17: PRINT "������ �᫮                     "
CALL innum(q$, 32, 10): IF VAL(q$) < 0 THEN GOTO po
a = SQR(VAL(q$))
LOCATE 12, 17: PRINT "��७� ������� �� " + q$ + " ࠢ��"
LOCATE 13, 30: PRINT a
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB krg
LOCATE 7, 30: COLOR 13, 7: PRINT " ���㣫���� ": COLOR 10
LOCATE 10, 17: PRINT "������ �᫮   "
CALL innum(ss2$, 37, 10): at2 = VAL(ss2$)
at2 = CINT(at2)
LOCATE 13, 17: PRINT "��᫮ " + ss2$ + " ��᫥ ���㣫���� ࠢ��"
LOCATE 14, 37: PRINT at2
DO: LOOP WHILE INKEY$ = ""

END SUB

SUB kste
LOCATE 7, 35: COLOR 13, 7: PRINT " ��७� ": COLOR 10
LOCATE 10, 16: PRINT "������ ������⥫� �⥯��� ����               "
CALL innum(s1$, 49, 10)
p17: f1$ = "": LOCATE 12, 16: PRINT "������ �᫮                         "
CALL innum(f1$, 32, 12)
IF VAL(f1$) < 0 THEN GOTO p17
ks = EXP(LOG(VAL(f1$)) / VAL(s1$))
LOCATE 14, 16: PRINT "��७� �⥯��� " + s1$ + " �� �᫠ " + f1$ + " ࠢ��:"
LOCATE 15, 30: PRINT ks
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB kvd
LOCATE 7, 35: COLOR 13, 7: PRINT " ������ ": COLOR 10
LOCATE 10, 17: PRINT "������ �᫮ "
CALL innum(x$, 32, 10)
k = VAL(x$) ^ 2
LOCATE 13, 17: PRINT "��᫮ " + x$ + " � ������ ࠢ��"
LOCATE 14, 30: PRINT k
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB n1
LOCATE 7, 26: COLOR 13, 7: PRINT " ��������᪠� �ண���� "
LOCATE 9, 17: COLOR 10: PRINT "������ ���� 童� �ண��ᨨ "
CALL innum(a21$, 48, 9)
m12: b21$ = "": LOCATE 10, 17: PRINT "������ ����� 童�� �ண��ᨨ                "
CALL innum(b21$, 48, 10): IF VAL(b21$) < 2 OR LEN(b21$) > 2 THEN GOTO m12
m120: c21$ = "": LOCATE 11, 17: PRINT "������ �������⥫� �ண��ᨨ                "
CALL innum(c21$, 48, 11): IF LEN(b21$) > 2 THEN GOTO m120
a21 = VAL(a21$): b21 = VAL(b21$): c21 = VAL(c21$)
n12 = a21 * c21 ^ (b21 - 1)
LOCATE 13, 17: PRINT b21$ + " 童� �ண��ᨨ ࠢ�� " + STR$(n12)
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB n2
LOCATE 7, 26: COLOR 13, 7: PRINT " ��䬥��᪠� �ண���� "
LOCATE 9, 17: COLOR 10: PRINT "������ ���� 童� �ண��ᨨ "
CALL innum(a213$, 48, 9)
m123: b213$ = "": LOCATE 10, 17: PRINT "������ ����� 童�� �ண��ᨨ          "
CALL innum(b213$, 48, 10): IF VAL(b213$) < 2 THEN GOTO m123
LOCATE 11, 17: PRINT "������ ࠧ����� �ண��ᨨ           "
CALL innum(c213$, 48, 11)
a213 = VAL(a213$): b213 = VAL(b213$): c213 = VAL(c213$)
n123 = a213 + c213 * (b213 - 1)
LOCATE 13, 17: PRINT b213$ + " 童� �ண��ᨨ ࠢ�� ": LOCATE 14, 30: PRINT STR$(n123)
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB nut
LOCATE 7, 28: COLOR 13, 7: PRINT " ����ࠫ�� ������ ": COLOR 10
op: l$ = "": LOCATE 10, 17: PRINT "������ ������⥫�                    "
CALL innum(l$, 37, 10): al = VAL(l$): IF al <= 0 THEN GOTO op
al = LOG(al)
LOCATE 13, 17: PRINT "����ࠫ�� ������ ࠢ��"; al
DO: LOOP WHILE INKEY$ = ""

END SUB

SUB obr
LOCATE 7, 32: COLOR 13, 7: PRINT " ����� ���� ": COLOR 10
LOCATE 10, 17: PRINT "������ �᫮                     "
CALL innum(o$, 32, 10)
ob = VAL(o$) * -1
LOCATE 12, 17: PRINT "��᫮ " + q$ + " � ����� ������ ࠢ�� "
LOCATE 13, 32: PRINT ob
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB osta
LOCATE 7, 35: COLOR 13, 7: PRINT " ���⮪ ": COLOR 10
LOCATE 10, 17: PRINT "������ �e����� "
CALL innum(w1$, 34, 10)
pvt1: e1$ = "": LOCATE 12, 17: PRINT "������ ����⥫�        "
CALL innum(e1$, 35, 12)
IF e1$ = "0" OR e1$ = "" OR e1$ = "-0" THEN GOTO pvt1
ch1 = VAL(w1$) MOD VAL(e1$)
LOCATE 14, 17: PRINT "���⮪  ࠢe�"; ch1
DO: LOOP WHILE INKEY$ = ""
END SUB

DEFINT A-Z
SUB pi
LOCATE 7, 38: COLOR 13, 7: PRINT " �� ": COLOR 10
LOCATE 13, 31: PRINT "pi = 3.141592653..."
DO: LOOP WHILE INKEY$ = ""
END SUB

DEFDBL A-Z
SUB por
LOCATE 7, 26: COLOR 13, 7: PRINT " ��������᪠� �ண���� "
LOCATE 9, 17: COLOR 10: PRINT "������ ���� 童� �ண��ᨨ "
CALL innum(a2$, 48, 9)
m1: b2$ = "": LOCATE 10, 17: PRINT "������ ������⢮ 童���                     "
CALL innum(b2$, 48, 10): IF VAL(b2$) < 2 OR LEN(b2$) > 2 THEN GOTO m1
m: c2$ = "": LOCATE 11, 17: PRINT "������ �������⥫� �ண��ᨨ                 "
CALL innum(c2$, 48, 11): IF VAL(c2$) = 1 OR LEN(c2$) > 2 THEN GOTO m
a2 = VAL(a2$): b2 = VAL(b2$): c2 = VAL(c2$)
se = a2 * (c2 ^ b2 - 1) / (c2 - 1)
LOCATE 14, 17: PRINT "�㬬� " + b2$ + " 童��� ��������᪮� �ண��ᨨ ࠢ��"
LOCATE 15, 30: PRINT se
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB proc
LOCATE 7, 30: COLOR 13, 7: PRINT " ��業� �� �᫠ ": COLOR 10
LOCATE 9, 17: PRINT "������ �᫮. a = "
CALL innum(a$, 37, 9)
LOCATE 10, 17: PRINT "������ ������⢮ ��業⮢ "
CALL innum(p$, 48, 10)
a = VAL(a$): p = VAL(p$)
pt = a * p / 100: LOCATE 13, 17: PRINT p$ + "% �� �᫠ " + a$ + " ࠢ�� " + STR$(pt)
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB proc1
LOCATE 7, 28: COLOR 13, 7: PRINT " ��業⭮� ᮤ�ঠ��� ": COLOR 10
LOCATE 9, 17: PRINT "������ ��ࢮ� �᫮ "
CALL innum(a1$, 45, 9)
LOCATE 10, 17: PRINT "������ ��஥ �᫮ "
CALL innum(p1$, 45, 10)
a1 = VAL(a1$): p1 = VAL(p1$)
pt1 = (p1 / a1) * 100: LOCATE 13, 17: PRINT "��業⭮� ᮤ�ঠ��� 稫� " + p1$ + " � �᫥ " + a1$
LOCATE 14, 17: PRINT "�����     " + STR$(pt1) + "%"
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB proz (p$())
pro = 1
LOCATE 7, 33: COLOR 13, 7: PRINT " �ந�������� ": COLOR 10
povt: k$ = "": LOCATE 9, 17: PRINT "������ ������⢮ �����⥫�� 2-9           "
CALL innum(k$, 52, 9)
IF VAL(k$) > 9 OR VAL(k$) < 2 THEN GOTO povt
FOR q = 1 TO VAL(k$)
LOCATE 11, 17: PRINT "������ �����⥫�"; q; "               "
CALL innum(p$(q), 39, 11)
NEXT
FOR q = 1 TO VAL(k$)
pro = pro * VAL(p$(q))
NEXT
LOCATE 13, 17: PRINT "�ந�������� " + k$ + " �����⥫�� ࠢ��"; pro
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB raz
LOCATE 7, 35: COLOR 13, 7: PRINT " �������� ": COLOR 10
LOCATE 9, 17: PRINT "������ 㬥��蠥��� "
CALL innum(u$, 38, 9)
LOCATE 11, 17: PRINT "������ ���⠥��� "
CALL innum(v$, 38, 11)
ch = VAL(u$) - VAL(v$)
LOCATE 13, 17: PRINT "���⭮� ࠢ�� "; ch
DO: LOOP WHILE INKEY$ = ""
END SUB

DEFINT A-Z
SUB scroll (x, y, x1, y1, lines, back, dir)
n = &H10
INREG.AX = dir * 256 + lines
INREG.BX = 4096 * back
INREG.CX = (x - 1) * 256 + y + 1
INREG.DX = (x1 - 1) * 256 + y1 - 1
CALL INTERRUPT(n, INREG, OUTREG)
END SUB

DEFDBL A-Z
SUB sinus
LOCATE 7, 36: COLOR 13, 7: PRINT " ����� ": COLOR 10
LOCATE 10, 17: PRINT "������ �ࠤ�� "
CALL innum(ass$, 37, 10): ast = VAL(ass$)
ast = SIN(3.141592653# * ast / 180)
LOCATE 13, 17: PRINT "����� " + ass$ + " �ࠤ�ᮢ ࠢ��"; ast
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB sluch
RANDOMIZE TIMER
LOCATE 7, 31: COLOR 13, 7: PRINT " C��砩��� �᫮ ": COLOR 10
LOCATE 13, 17: PRINT "���砩��� �᫮ ࠢ��"; RND
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB ste
LOCATE 7, 35: COLOR 13, 7: PRINT " �⥯��� ": COLOR 10
p: s$ = "": LOCATE 10, 17: PRINT "������ ������⥫� �⥯���                "
CALL innum(s$, 44, 10)
IF LEN(s$) > 2 THEN GOTO p
p1: f$ = "": LOCATE 12, 17: PRINT "������ �᫮                         "
CALL innum(f$, 32, 12)
IF LEN(f$) > 3 THEN GOTO p1
stepen = VAL(f$) ^ VAL(s$)
LOCATE 14, 17: PRINT "��᫮ " + f$ + " � �⥯��� " + s$ + " ࠢ��:"
LOCATE 15, 30: PRINT stepen
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB summ (s$())
LOCATE 7, 35: COLOR 13, 7: PRINT " �㬬� ": COLOR 10
pov: k$ = "": LOCATE 9, 17: PRINT "������ ������⢮ ᫠������ 2-9               "
CALL innum(k$, 51, 9)
IF VAL(k$) > 9 OR VAL(k$) < 2 THEN GOTO pov
FOR q = 1 TO VAL(k$)
LOCATE 11, 17: PRINT "������ ᫠������"; q; "                         "
CALL innum(s$(q), 38, 11)
NEXT
FOR q = 1 TO VAL(k$)
su = VAL(s$(q)) + su
NEXT
LOCATE 13, 17: PRINT "�㬬� " + k$ + " ᫠������ ࠢ��"; su
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB summa
LOCATE 7, 26: COLOR 13, 7: PRINT " ��䬥��᪠� �ண���� "
LOCATE 9, 17: COLOR 10: PRINT "������ ���� 童� �ண��ᨨ "
CALL innum(a1$, 48, 9)
y: b1$ = "": LOCATE 10, 17: PRINT "������ ������⢮ 童���             "
CALL innum(b1$, 48, 10): IF VAL(b1$) < 2 THEN GOTO y
LOCATE 11, 17: PRINT "������ ࠧ����� �ண��ᨨ "
CALL innum(c1$, 48, 11)
a1 = VAL(a1$): b1 = VAL(b1$): c1 = VAL(c1$)
sun = (2 * a1 + c1 * (b1 - 1)) * b1 / 2
LOCATE 14, 17: PRINT "�㬬� " + b1$ + " 童��� ��䬥��᪮� �ண��ᨨ ࠢ��"
LOCATE 15, 30: PRINT sun
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB tanges
LOCATE 7, 34: COLOR 13, 7: PRINT " ������ ": COLOR 10
LOCATE 10, 17: PRINT "������ �ࠤ�� "
CALL innum(s$, 37, 10): t = VAL(s$)
t = TAN(3.141592653# * t / 180)
LOCATE 13, 17: PRINT "������ " + s$ + " �ࠤ�ᮢ ࠢ��"; t
DO: LOOP WHILE INKEY$ = ""
END SUB

SUB x10
LOCATE 7, 32: COLOR 13, 7: PRINT " C⥯��� 10 ": COLOR 10
pet1: ss1$ = "": LOCATE 10, 17: PRINT "������ �⥯���                        "
CALL innum(ss1$, 37, 10): at1 = VAL(ss1$): IF LEN(ss1$) > 2 THEN GOTO pet1
at1 = 10 ^ at1
LOCATE 13, 17: PRINT "10" + " � �⥯��� " + ss1$ + " ࠢ��"; at1
DO: LOOP WHILE INKEY$ = ""
END SUB

