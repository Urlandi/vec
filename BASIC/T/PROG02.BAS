INPUT "������ ᫮�� �⭮� ����� ", s$
IF LEN(s$) MOD 2 <> 0 THEN
PRINT "����� �� �⭮�"
END
END IF
co1 = 0: co2 = 0
FOR n = 1 TO LEN(s$) / 2
IF MID$(s$, n, 1) = "k" OR MID$(s$, n, 1) = "K" OR MID$(s$, n, 1) = "�" OR MID$(s$, n, 1) = "�" THEN co1 = co1 + 1
NEXT n

FOR n = LEN(s$) / 2 + 1 TO LEN(s$)
IF MID$(s$, n, 1) = "k" OR MID$(s$, n, 1) = "K" OR MID$(s$, n, 1) = "�" OR MID$(s$, n, 1) = "�" THEN co2 = co2 + 1
NEXT
IF co1 = 0 AND co2 = 0 THEN
PRINT "�㪢 k � ᫮�� ���"
END
END IF
IF co1 > co2 THEN
PRINT "����� �����"
ELSEIF co1 < co2 THEN
PRINT "��ࠢ� �����"
ELSE
PRINT "���������"
END IF

