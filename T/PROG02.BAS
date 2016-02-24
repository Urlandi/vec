INPUT "Введите слово четной длины ", s$
IF LEN(s$) MOD 2 <> 0 THEN
PRINT "Слово не четное"
END
END IF
co1 = 0: co2 = 0
FOR n = 1 TO LEN(s$) / 2
IF MID$(s$, n, 1) = "k" OR MID$(s$, n, 1) = "K" OR MID$(s$, n, 1) = "к" OR MID$(s$, n, 1) = "К" THEN co1 = co1 + 1
NEXT n

FOR n = LEN(s$) / 2 + 1 TO LEN(s$)
IF MID$(s$, n, 1) = "k" OR MID$(s$, n, 1) = "K" OR MID$(s$, n, 1) = "к" OR MID$(s$, n, 1) = "К" THEN co2 = co2 + 1
NEXT
IF co1 = 0 AND co2 = 0 THEN
PRINT "Букв k в слове нет"
END
END IF
IF co1 > co2 THEN
PRINT "Слева больше"
ELSEIF co1 < co2 THEN
PRINT "Справа больше"
ELSE
PRINT "Одинаково"
END IF

