CLS
DIM result$(32)
PRINT "Введите строку"
INPUT "", s$
s$ = s$ + " "
s$ = LTRIM$(s$)

l = 1
FOR n = 1 TO LEN(s$)
IF MID$(s$, n, 1) = " " THEN
k$ = MID$(s$, 1, n - 1)

te$ = ""
FOR q = LEN(k$) \ 2 TO 1 STEP -1
te$ = te$ + MID$(LEFT$(k$, LEN(k$) \ 2), q, 1)
NEXT
IF te$ = RIGHT$(k$, LEN(k$) \ 2) THEN
result$(l) = k$
l = l + 1
END IF

s$ = RIGHT$(s$, LEN(s$) - n)
s$ = LTRIM$(s$)
n = 1
END IF
NEXT



DO
FOR q = 1 TO l - 1
IF result$(q) < result$(q + 1) THEN
SWAP result$(q), result$(q + 1)
q = 0
END IF
NEXT
EXIT DO
LOOP WHILE 0 = 0



IF l = 1 THEN
PRINT "Таких слов нет"
ELSE
PRINT "Нужные вам слова"
FOR q = 2 TO l
IF result$(q) <> result$(q - 1) THEN PRINT result$(q - 1)
NEXT
END IF



