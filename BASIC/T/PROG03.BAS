CLS
o$ = ""
INPUT "������ ᫮�� - ", s$
FOR n = 1 TO LEN(s$)
IF n MOD 2 = 0 THEN
ELSE
o$ = o$ + MID$(s$, n, 1)
END IF
NEXT n
PRINT "�����: ", o$





