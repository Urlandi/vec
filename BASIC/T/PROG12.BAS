CLS
INPUT s$
s$ = s$ + " "
ka = 0
FOR n = 1 TO LEN(s$)
 IF MID$(s$, n, 2) = "��" OR MID$(s$, n, 2) = "KA" THEN ka = 1: s$ = LEFT$(s$, n) + "��" + MID$(s$, n + 2)
 IF MID$(s$, n, 2) = "��" OR MID$(s$, n, 2) = "ka" THEN ka = 1: s$ = LEFT$(s$, n) + "��" + MID$(s$, n + 2)
NEXT
PRINT s$
IF ka = 0 THEN PRINT "����� '��' � �।������� ���!"


