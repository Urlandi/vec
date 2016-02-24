CLS
INPUT s$
s$ = s$ + " "
ka = 0
FOR n = 1 TO LEN(s$)
 IF MID$(s$, n, 2) = "КА" OR MID$(s$, n, 2) = "KA" THEN ka = 1: s$ = LEFT$(s$, n) + "ОН" + MID$(s$, n + 2)
 IF MID$(s$, n, 2) = "ка" OR MID$(s$, n, 2) = "ka" THEN ka = 1: s$ = LEFT$(s$, n) + "он" + MID$(s$, n + 2)
NEXT
PRINT s$
IF ka = 0 THEN PRINT "Слога 'КА' в предложении нет!"


