DECLARE SUB mouse (m1%, m2%, m3%, m4%)
'��ࠡ�⠥� � �����
'$INCLUDE: 'interupt.bi'
DEFINT A-Z
SCREEN 12
RANDOMIZE TIMER
DIM word7(0 TO 80, 16), word1(0 TO 64, 16), word2(0 TO 32, 16), word3(0 TO 24, 16), word4(0 TO 120, 16), word5(0 TO 32, 16), word6(0 TO 144, 16), i(200), e(200)
LOCATE 1, 1: PRINT "WEGAdemo "
FOR x = 0 TO 64
FOR y = 0 TO 16
IF POINT(x, y) <> 0 THEN word1(x, y) = 1
NEXT: NEXT
LOCATE 1, 1: PRINT "DEMO "
FOR x = 0 TO 32
FOR y = 0 TO 16
IF POINT(x, y) <> 0 THEN word2(x, y) = 1
NEXT: NEXT
LOCATE 1, 1: PRINT "1st "
FOR x = 0 TO 24
FOR y = 0 TO 16
IF POINT(x, y) <> 0 THEN word3(x, y) = 1
NEXT: NEXT
LOCATE 1, 1: PRINT "HELLO EVERYBODY "
FOR x = 0 TO 120
FOR y = 0 TO 16
IF POINT(x, y) <> 0 THEN word4(x, y) = 1
NEXT: NEXT
LOCATE 1, 1: PRINT "USER "
FOR x = 0 TO 32
FOR y = 0 TO 16
IF POINT(x, y) <> 0 THEN word5(x, y) = 1
NEXT: NEXT
LOCATE 1, 1: PRINT "DOS or WINDOWS ??? "
FOR x = 0 TO 144
FOR y = 0 TO 16
IF POINT(x, y) <> 0 THEN word6(x, y) = 1
NEXT: NEXT
LOCATE 1, 1: PRINT "programmer "
FOR x = 0 TO 80
FOR y = 0 TO 16
IF POINT(x, y) <> 0 THEN word7(x, y) = 1
NEXT: NEXT
start:
CLS
d = 1: delta = 1: xdlt = 10: ydlt = 20
FOR q = 1 TO 1000
PSET (INT(RND * 640), INT(RND * 480)), INT(RND * 15)
NEXT
music: DO WHILE INKEY$ <> CHR$(27)
CALL mouse(1, m2, m3, m4)
m1 = 3
FOR x = 0 TO 64
FOR y = 0 TO 16
IF x / 8 = INT(x / 8) THEN clr = INT(RND * 14)
IF word1(x, y) = 1 THEN LINE (x * 2 + 300, y * 4 + 80)-STEP(1, 3), clr, BF
NEXT: NEXT
FOR x = 32 TO 0 STEP -1
FOR y = 0 TO 16
IF word5(x, y) = 1 THEN CIRCLE (x * 6 + 100, y * 4 + 300), 2, clr
NEXT: NEXT
FOR x = 144 TO 0 STEP -1
FOR y = 16 TO 1 STEP -1
clr = INT(RND * 15)
IF word6(x, y) = 1 THEN CIRCLE (x * 3 + 10, y * 6 + 210), 0, clr
IF word6(x, y) = 1 THEN CIRCLE (x * 3 + 10, y * 6 + 210), 1, clr
IF word6(x, y) = 1 THEN CIRCLE (x * 3 + 10, y * 6 + 210), 2, clr
NEXT: NEXT
delta = delta + d: IF delta > 5 OR delta < 1 THEN d = -d
FOR x = 0 TO 32
FOR y = 16 TO 1 STEP -1
IF word2(x, y) = 1 THEN LINE (x * 6 + 400, y * 7 + 120)-STEP(delta, delta), INT(RND * 15), BF
NEXT: NEXT
FOR x = 0 TO 24
clr = INT(RND * 15)
FOR y = 0 TO 16
IF word3(x, y) = 1 THEN LINE (x * 6, y * 7)-STEP(5, 5), clr, BF
NEXT: NEXT
CALL mouse(m1, m2, m3, m4)
IF m2 <> 0 THEN GOTO speak
LOOP
CLS : SCREEN 0: LOCATE 1, 1: PRINT "A:\>C����!!!": END
speak:
CALL mouse(0, 0, 0, 0)
SELECT CASE m2
CASE 1
IF m3 > 0 AND m3 < 140 AND m4 > 20 AND m4 < 90 THEN
stroka$ = "1st-�� �ணࠬ�� ࠧࠡ�⠭��� �������� � ���� ������ ���� ��ࢮ�� ���� � �����⭮� ������� �� �ணࠬ��஢����.�� ��� ����㯨�� ��⥭���,��祬� � �� ���뢠� ��㣨� �ਧ�஢,"
stroka$ = stroka$ + "� ��⭮�� ���ᠤ�� ���ࣨ� �.�. WEGA.WEGA ����ࠢ��� ⥡� � ����祭��� ����_��� � ����� �ᯥ客 � ���쭥�襩 ࠡ�� �� ���뢠� � ��㣨� �몠�.���� � ��ࠢ�� �訡��"
stroka$ = stroka$ + " � 1st,� �� ������ ������ ����� ���� ࠡ��� � �⮩ �ணࠬ��(���� �������� �� ᭥� � 㢥��祭�� �㪢�),���� ⠪�� ᯨ��� 1stnew �.�.1st ��� ��� �����⮢.       -|-|-|-       � ������� � ����� ������ �����."
ELSEIF m3 > 300 AND m3 < 420 AND m4 > 90 AND m4 < 130 THEN
stroka$ = "W(M)EGADEMO (����� �������� ����� ���室�� ᠬ �� ����) 100% ����ᠭ� �� �몥 �ணࠬ��஢���� QuickBASIC 4.5 ���ᠤ�� ���ࣨ��.WEGA (�� ����� � ⥫�����஬ SONY - WEGA) ᪫���� ������� ᢮� "
stroka$ = stroka$ + "��ࠡ�⪨,����� � ����� ��㭤� � ��������� �ணࠬ�� WEGADEMO � ����稫��� ������ ᭮᭮ ��� ������ �� ��⠢����� �⮩ DEMO ����� �ᯮ�짮���� ᠬ����⥫쭮.�� �� ����� WEGADEMO ����� ����� �� ����."
stroka$ = stroka$ + "WEGADEMO �।�⠢��� �� ᥡ� ��᪮�쪮 ��⥩ � ������ �������� " + CHR$(34) + "����ୠ� ��䨪�" + CHR$(34) + ",ࠡ�� � �����,���⮬ ����������,��몠 � ��㣨� ������� � ᯥ���䥪��"
stroka$ = stroka$ + ".���� WEGA � ������ �� ����� BASIC �� 60%,�� ����� "
stroka$ = stroka$ + "� ��易⥫쭮 �ਮ��⠩� ������ �ணࠬ��,�� ��������,�� ᫮�� ���� � �⭮�� � � ���,� � USER'��...........................................................� ��� �ࠢ���� ��� ���. "
ELSEIF m3 > 400 AND m3 < 600 AND m4 > 140 AND m4 < 200 THEN
stroka$ = "DEMO ᯮᮡ ��।��� �ਢ��� ����� � �������� ᥡ�.DEMO ����� �ணࠬ�� - ���� �஡�� 蠣� �⤥�쭮 ���⮣� �ணࠬ���� � �⤥�쭮 ���⮩ ������.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
stroka$ = stroka$ +  _
" ��।�� �ਢ�� �ᥬ �� ���� �����, �� � ����,� �ᡥ��� ��㯯� ��� 11�:WEGA,VERS,SAMOS,3DVIRUS,ROMEO,�����,������,�����,����,����,������,����,�����,�����,�����,�����,�����,�����,�����,����,����,�����,����,�����,����,������,���,�����,"
stroka$ = stroka$ + "�� � ����筮 ᥡ� �����."
ELSEIF m3 > 10 AND m3 < 440 AND m4 > 225 AND m4 < 280 THEN
stroka$ = "����筮 �� ��訩 �����,�� ����� ��� ᥡ� ��� �蠥� ᠬ.� ����� 祬 DOS ���� WINDOWS ��� OS/2.� ����� ���� �모���� ᢮� ���� �������� � �㯨�� ����ᨯ��."
ELSEIF m3 > 100 AND m3 < 280 AND m4 > 308 AND m4 < 346 THEN
stroka$ = "USER'�� ����� ������ ��ࠩ��� � ᢮� DOOM � �� ���� �㤠 ��� �� �����.� �ᥬ �� USER'�� ����让 �ਢ��."
ELSE
stroka$ = "������� ����� ��� �஢�� ������� ��� �� ᫮��� 1st,WEGADEMO,DEMO,DOS or WINDOWS ???,USER � �⠩�.ESC - ��室.�ணࠬ�� ��⠢���� �� QuickBasic 4.5 � �⠢�� ��। ᮡ�� 楫� �������� ���������� ࠡ��� � ����� � BASIC'�."
END IF
CASE 2
IF m3 > 0 AND m3 < 140 AND m4 > 20 AND m4 < 90 THEN
PLAY "o4t110<c4e8g8>c16c16c16c16c16c16c16c16d16d16d16d16d16d16d16d16e4d4c8c16.c32c8p8"
ELSEIF m3 > 300 AND m3 < 420 AND m4 > 90 AND m4 < 130 THEN
PLAY "t120o2l18g4.p8g>c4<g.ab4e.ea4g.fg4c.cd4d.ef4f.g7": PLAY "t120a4b.>cd2<g>e4d.cd4<g.g>c4<b.ab4e.ea4g.fg4c.c>c4<b.ag2"
ELSEIF m3 > 400 AND m3 < 600 AND m4 > 140 AND m4 < 200 THEN
PLAY "t200n10n20n30n40n50n60"
ELSEIF m3 > 10 AND m3 < 440 AND m4 > 225 AND m4 < 280 THEN
PLAY "t120o1e16e16e16cd16d16d16<b"
ELSEIF m3 > 100 AND m3 < 280 AND m4 > 308 AND m4 < 346 THEN
PLAY "o4mft240aeaeag#g#p4g#eg#eg#aap4": PLAY "aeaeag#g#p4g#eg#eg#ap2"
PLAY "abb8b8b4b4>cc8c8ccc<bag#aap4": PLAY "abb8b8b4b4>cc8c8ccc<bag#ap4"
ELSE
FOR q = 1 TO 3
SOUND 550, 9: SOUND 400, 9: NEXT
END IF
GOTO music
END SELECT
stroka$ = STRING$(35, 32) + stroka$ + STRING$(35, 32)
LINE (100, 49)-STEP(400, 281), 15, B
FOR q = 101 TO 499
LINE (q, 51)-(499, 327), 0, B
NEXT
FOR q = 1 TO 200
i(q) = 500 - INT(RND * 400): e(q) = 329 - INT(RND * 269)
NEXT q
q2 = 1
DO
FOR x = 0 TO 120
FOR y = 0 TO 16
IF word4(x, y) = 1 THEN LINE (x * 2 + 180, y * 2 + 100)-STEP(1, 1), INT(RND * 15)
NEXT
NEXT
FOR y = 0 TO 16
clr = INT(RND * 15)
FOR x = 0 TO 80
IF word7(x, y) = 1 THEN CIRCLE (x * 2 + 220, y * 5 + 150), 2, clr: PAINT (x * 2 + 220, y * 5 + 150), clr
NEXT
NEXT

FOR q1 = 1 TO 500
q = INT(RND * 200): PSET (i(q), e(q)), 0
e(q) = e(q) + 1
IF POINT(i(q), e(q)) = 16 THEN
i(q) = 500 - INT(RND * 400)
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
e(q) = 50: i(q) = 500 - INT(RND * 400)
END IF
ignor: PSET (i(q), e(q)), 15
NEXT q1
h$ = MID$(stroka$, q2, 35)
LOCATE 18, 22: COLOR INT(RND * 16):
PRINT h$
q2 = q2 + 1: IF q2 > LEN(stroka$) - 35 THEN q2 = 1
m1 = 5: m2 = 0
CALL mouse(m1, m2, m3, m4)
IF m1 = 1 OR m1 = 2 THEN GOTO start
LOOP WHILE INKEY$ <> CHR$(27)
LOCATE 1, 1: CLS : SCREEN 0: PRINT "A:\>C����!!!"

SUB mouse (m1, m2, m3, m4)
INREG.AX = m1
INREG.BX = m2
INREG.CX = m3
INREG.DX = m4
CALL INTERRUPT(&H33, INREG, OUTREG)
m1 = OUTREG.AX
m2 = OUTREG.BX
m3 = OUTREG.CX
m4 = OUTREG.DX
END SUB

