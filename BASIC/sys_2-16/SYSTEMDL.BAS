DECLARE SUB perevoddop (aq$, a1$, a2$, a3$)
DECLARE SUB perevodhex (a$, a1$, a2$, a3$)
DECLARE SUB perevodoct (a$, a1$, a2$, a3$)
DECLARE SUB perevodbin (a$, a1$, a2$, a3$)
DECLARE SUB kod (b%)
DECLARE SUB perevoddec (a$, a1$, a2$, a3$)
'$DYNAMIC
'системы счисления
CLEAR
CLS
SCREEN 0
VIEW PRINT 1 TO 25
DEFINT B, D-Z
DIM ah$(9, 7), alks$(256), uch$(1)
n = 1: g = 1
start: r = 1
FOR q = 1 TO 25: LOCATE q, 1: COLOR , 3: PRINT STRING$(80, 32): NEXT
LOCATE 1, 2: COLOR 2, 5: PRINT STRING$(78, 205): LOCATE 1, 1: PRINT CHR$(201): LOCATE 1, 80: PRINT CHR$(187)
FOR q = 2 TO 19
LOCATE q, 1: PRINT CHR$(186): LOCATE q, 80: PRINT CHR$(186): LOCATE q, 2: PRINT STRING$(78, 32)
NEXT
LOCATE 20, 2: PRINT STRING$(78, 205): LOCATE 20, 1: PRINT CHR$(200): LOCATE 20, 80: PRINT CHR$(188)
COLOR 14, 5: LOCATE 1, 19
PRINT "ВАС ПРИВЕТСТВУЕТ программа " + CHR$(34) + "Oт 0 до F" + CHR$(34)
LOCATE 2, 3: PRINT "Сейчас вы запустили программу " + CHR$(34) + "От 0 до F" + CHR$(34) + ",которая является программой пере-"
LOCATE 3, 3: PRINT "водчиком чисел из одной системы счисления в другую.Она позволяет переводить  "
LOCATE 4, 3: PRINT "целые числа из десятичной системы,(9 цифр),из двоичной, (20 цифр),из восми-"
LOCATE 5, 3: PRINT "ричной(10 цифр),из шестнадцатиричной(7 цифр).Программа предназначена для ис-"
LOCATE 6, 3: PRINT "пользования начинающими професcионалами. "
LOCATE 7, 3: PRINT CHR$(34) + "От 0 до F" + CHR$(34) + "полностью написана на языке программирования BASIC."
LOCATE 8, 3: PRINT "Распространяется из рук в руки,и полностью бесплатна."
LOCATE 10, 68: PRINT "24/05-1998"
LOCATE 24, 2: COLOR 10, 3: PRINT "[РАБОТАЕМ]": LOCATE 24, 15: COLOR 1, 3: PRINT "[ИНФО]    [ВЫХОД]                     "
LOCATE 22, 2: COLOR 15, 3: PRINT "Программа будет переводить числа из одной системы счисления в другую."
DO
CALL kod(b)
LOCATE 24, 2: COLOR 1, 3: PRINT "[РАБОТАЕМ]   [ИНФО]    [ВЫХОД] ": COLOR 10, 3
SELECT CASE b
CASE 77
r = r + 1
IF r > 3 THEN r = 1
IF r = 1 THEN
LOCATE 24, 2: PRINT "[РАБОТАЕМ]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Программа будет переводить числа из одной системы счисления в другую."
ELSEIF r = 2 THEN
LOCATE 24, 15: PRINT "[ИНФО]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Что это вообще такое:системы счисления?                              "
ELSEIF r = 3 THEN
LOCATE 24, 25: PRINT "[ВЫХОД]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Выход из програмы.                                                   "
END IF
CASE 75
r = r - 1
IF r < 1 THEN r = 3
IF r = 1 THEN
LOCATE 24, 2: PRINT "[РАБОТАЕМ]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Программа будет переводить числа из одной системы счисления в другую."
ELSEIF r = 2 THEN
LOCATE 24, 15: PRINT "[ИНФО]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Что это вообще такое:системы счисления?                               "
ELSEIF r = 3 THEN
LOCATE 24, 25: PRINT "[ВЫХОД]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Выход из програмы.                                                   "
END IF
CASE 13
IF r = 3 THEN
GOTO w4
ELSEIF r = 2 THEN
GOTO w2
ELSE
GOTO w1
END IF
CASE ELSE
r = 3
LOCATE 24, 25: PRINT "[ВЫХОД]": LOCATE 22, 2: COLOR 15, 3: PRINT "Используйте клавиши перемещения курсора                             "
END SELECT
LOOP WHILE b <> 27
'-----------------------------------------------------------------------------
w4: COLOR , 10: FOR q = 7 TO 11: LOCATE q, 24: PRINT STRING$(30, 32): NEXT q: COLOR 7, 0: FOR q = 25 TO 54: LOCATE 12, q: a$ = CHR$(SCREEN(12, q)): PRINT a$: NEXT q
FOR q = 8 TO 12: LOCATE q, 54: a$ = CHR$(SCREEN(q, 54)): PRINT a$: NEXT q: LOCATE 8, 29: COLOR 4, 10: PRINT "Хотите покинуть МЕНЯ?!": LOCATE 10, 33: PRINT "ДА"
COLOR 25, 10: LOCATE 10, 40: PRINT "НЕТ"
r = 2
DO
CALL kod(b)
COLOR 4, 10: LOCATE 10, 33: PRINT "ДА     НЕТ"
COLOR 25, 10
SELECT CASE b
CASE 77
r = r + 1
IF r > 2 THEN r = 1
IF r = 1 THEN
LOCATE 10, 33: PRINT "ДА"
ELSEIF r = 2 THEN
LOCATE 10, 40: PRINT "НЕТ"
END IF
CASE 75
r = r - 1
IF r < 1 THEN r = 2
IF r = 1 THEN
LOCATE 10, 33: PRINT "ДА"
ELSEIF r = 2 THEN
LOCATE 10, 40: PRINT "НЕТ"
END IF
CASE 13
IF r = 1 THEN
CLS : COLOR 7, 0: FOR q = 1 TO 25: LOCATE q, 1: PRINT STRING$(80, 32): NEXT q: LOCATE 1, 1: PRINT "Привет проффесору": END
END IF
IF r = 2 THEN GOTO start
CASE 27
GOTO start
END SELECT
LOOP
'----------------------------------------------------------------------------
w2: COLOR , 5
FOR q = 2 TO 19: LOCATE q, 2: PRINT STRING$(78, 32): NEXT
LOCATE 24, 2: COLOR 10, 3: PRINT "[СЛЕДУЮЩАЯ СТРАНИЦА]": LOCATE 24, 22: COLOR 1, 3: PRINT "    [ПРЕДЫДУЩАЯ СТРАНИЦА]    [НАЗАД]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Cмотрим дальше                                                   "
OPEN "my_progr\sys_2-16\system.lks" FOR INPUT AS #1
q = 1
DO WHILE NOT EOF(1)
INPUT #1, alks$(q)
q = q + 1
LOOP
CLOSE #1
COLOR 14, 5
FOR q = 2 TO 19
LOCATE q, 3: PRINT alks$(q)
NEXT
r1 = 1
DO
CALL kod(b)
COLOR 1, 3: LOCATE 24, 2: PRINT "[СЛЕДУЮЩАЯ СТРАНИЦА]    [ПРЕДЫДУЩАЯ СТРАНИЦА]    [НАЗАД]"
SELECT CASE b
CASE 77
r1 = r1 + 1: IF r1 > 3 THEN r1 = 1
IF r1 = 1 THEN
COLOR 10, 3: LOCATE 24, 2: PRINT "[СЛЕДУЮЩАЯ СТРАНИЦА]"
COLOR 15, 3: LOCATE 22, 2: PRINT "Смотрим дальше.                         "
ELSEIF r1 = 2 THEN
COLOR 10, 3: LOCATE 24, 22: PRINT "    [ПРЕДЫДУЩАЯ СТРАНИЦА]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Вернемся на страницу назад.             "
ELSEIF r1 = 3 THEN
LOCATE 24, 47: COLOR 10, 3: PRINT "    [НАЗАД]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Желаю удачи в дальнейшей учебе.         "
END IF
CASE 75
r1 = r1 - 1: IF r1 < 1 THEN r1 = 3
IF r1 = 1 THEN
COLOR 10, 3: LOCATE 24, 2: PRINT "[СЛЕДУЮЩАЯ СТРАНИЦА]"
COLOR 15, 3: LOCATE 22, 2: PRINT "Смотрим дальше.                         "
ELSEIF r1 = 2 THEN
COLOR 10, 3: LOCATE 24, 22: PRINT "    [ПРЕДЫДУЩАЯ СТРАНИЦА]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Вернемся на страницу назад.             "
ELSEIF r1 = 3 THEN
LOCATE 24, 47: COLOR 10, 3: PRINT "    [НАЗАД]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Желаю удачи в дальнейшей учебе.         "
END IF
CASE 13
COLOR , 5
FOR q = 2 TO 19: LOCATE q, 2: PRINT STRING$(78, 32): NEXT
IF r1 = 3 THEN
GOTO start
ELSEIF r1 = 1 THEN
LOCATE 24, 2: COLOR 10, 3: PRINT "[СЛЕДУЮЩАЯ СТРАНИЦА]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Смотрим дальше.                    "
g = g + 18: IF alks$(g) = "" THEN g = g - 18
FOR q = 2 TO 19
LOCATE q, 3: COLOR 14, 5: PRINT alks$(q + g - 1)
NEXT
ELSEIF r1 = 2 THEN
LOCATE 24, 22: COLOR 10, 3: PRINT "    [ПРЕДЫДУЩАЯ СТРАНИЦА]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Вернемся на страницу назад.        "
g = g - 18: IF g < 1 THEN g = g + 18
FOR q = 2 TO 19
LOCATE q, 3: COLOR 14, 5: PRINT alks$(g + q - 1)
NEXT
END IF
CASE 27
PRINT alks$(3): GOTO start
CASE ELSE
r1 = 3
LOCATE 24, 47: COLOR 10, 3: PRINT "    [НАЗАД]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Желаю удачи в дальнейшей учебе         "
END SELECT
LOOP


'----------------------------------------------------------------------------
w1: LOCATE 1, 19: COLOR 2, 5: PRINT STRING$(40, 205): LOCATE 1, 32: COLOR 14: PRINT " РАБОТАЕМ "
FOR q = 2 TO 19: LOCATE q, 2: PRINT STRING$(78, 32): NEXT q
FOR q = 2 TO 12 STEP 3
FOR q1 = 5 TO 50 STEP 45
LOCATE q, q1: PRINT "┌" + STRING$(20, 196) + "┐": LOCATE q + 2, q1: PRINT "└" + STRING$(20, 196) + "┘"
LOCATE q + 1, q1: PRINT "│                    │"
NEXT q1
NEXT q
COLOR 31, 5: LOCATE 3, 7: PRINT "_": COLOR 14, 5: LOCATE 3, 32: PRINT "Десятичная": LOCATE 6, 33: PRINT "Двоичная": LOCATE 9, 29: PRINT "Шестнадцатиричная": LOCATE 12, 32: PRINT "Восьмиричная"
LOCATE 14, 10: COLOR 14, 5: PRINT "Дополнительные коды отрицательных чисел.": LOCATE 16, 3: PRINT "Двоичная": LOCATE 17, 3: PRINT "Шестнадцатиричная": LOCATE 18, 3: PRINT "Восьмиричная"
LOCATE 16, 40: PRINT "[                 ]": LOCATE 17, 40: PRINT "[                 ]": LOCATE 18, 40: PRINT "[                 ]"
LOCATE 24, 2: COLOR 10, 3: PRINT "[НАЧАЛИ]    ": LOCATE 24, 14: COLOR 1, 3: PRINT " [ИСТОРИЯ]     [ГЛАВНОЕ МЕНЮ]       "
LOCATE 22, 2: COLOR 15, 3: PRINT "Начнем перевод чисел.                                                "
r1 = 1: r = 1
DO
CALL kod(b)
LOCATE 24, 2: COLOR 1, 3: PRINT "[НАЧАЛИ]     [ИСТОРИЯ]     [ГЛАВНОЕ МЕНЮ]"
SELECT CASE b
CASE 72
COLOR , 5: LOCATE 3, 6: PRINT "              ": LOCATE 6, 6: PRINT "                    ": LOCATE 9, 6: PRINT "                ": LOCATE 12, 6: PRINT "                 "
r = 1: LOCATE 24, 2: COLOR 10, 3: PRINT "[НАЧАЛИ]": LOCATE 22, 2: COLOR 15, 3: PRINT "Начнем перевод чисел.                   "
r1 = r1 - 1
IF r1 < 1 THEN r1 = 4
IF r1 = 1 THEN
COLOR 5, 5: FOR q = 3 TO 12 STEP 3: LOCATE q, 7: PRINT "_": NEXT:
COLOR 31, 5: LOCATE 3, 7: PRINT "_": LOCATE 3, 6
ELSEIF r1 = 2 THEN
COLOR 5, 5: FOR q = 3 TO 12 STEP 3: LOCATE q, 7: PRINT "_": NEXT:
COLOR 31, 5: LOCATE 6, 7: PRINT "_"
ELSEIF r1 = 3 THEN
COLOR 5, 5: FOR q = 3 TO 12 STEP 3: LOCATE q, 7: PRINT "_": NEXT:
COLOR 31, 5: LOCATE 9, 7: PRINT "_"
ELSEIF r1 = 4 THEN
COLOR 5, 5: FOR q = 3 TO 12 STEP 3: LOCATE q, 7: PRINT "_": NEXT:
COLOR 31, 5: LOCATE 12, 7: PRINT "_"
END IF
CASE 80
COLOR , 5: LOCATE 3, 6: PRINT "              ": LOCATE 6, 6: PRINT "                    ": LOCATE 9, 6: PRINT "                ": LOCATE 12, 6: PRINT "                 "
r = 1: LOCATE 24, 2: COLOR 10, 3: PRINT "[НАЧАЛИ]": LOCATE 22, 2: COLOR 15, 3: PRINT "Начнем перевод чисел.                   "
r1 = r1 + 1
IF r1 > 4 THEN r1 = 1
IF r1 = 1 THEN
COLOR 5, 5: FOR q = 3 TO 12 STEP 3: LOCATE q, 7: PRINT "_": NEXT:
COLOR 31, 5: LOCATE 3, 7: PRINT "_"
ELSEIF r1 = 2 THEN
COLOR 5, 5: FOR q = 3 TO 12 STEP 3: LOCATE q, 7: PRINT "_": NEXT:
COLOR 31, 5: LOCATE 6, 7: PRINT "_"
ELSEIF r1 = 3 THEN
COLOR 5, 5: FOR q = 3 TO 12 STEP 3: LOCATE q, 7: PRINT "_": NEXT:
COLOR 31, 5: LOCATE 9, 7: PRINT "_"
ELSEIF r1 = 4 THEN
COLOR 5, 5: FOR q = 3 TO 12 STEP 3: LOCATE q, 7: PRINT "_": NEXT:
COLOR 31, 5: LOCATE 12, 7: PRINT "_"
END IF
CASE 77
r = r + 1: COLOR 10, 3
IF r > 3 THEN r = 1
IF r = 1 THEN
LOCATE 24, 2: PRINT "[НАЧАЛИ]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Начнем перевод чисел.                    "
ELSEIF r = 2 THEN
LOCATE 24, 15: PRINT "[ИСТОРИЯ]": LOCATE 22, 2: COLOR 15, 3: PRINT "Можно просмотреть ранее введенные числа. "
ELSEIF r = 3 THEN
LOCATE 24, 29: PRINT "[ГЛАВНОЕ МЕНЮ]": LOCATE 22, 2: COLOR 15, 3: PRINT "Вернемся к первому экрану.               "
END IF
CASE 75
r = r - 1: COLOR 10, 3
IF r < 1 THEN r = 3
IF r = 1 THEN
LOCATE 24, 2: PRINT "[НАЧАЛИ]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Начнем перевод чисел.                    "
ELSEIF r = 2 THEN
LOCATE 24, 15: PRINT "[ИСТОРИЯ]": LOCATE 22, 2: COLOR 15, 3: PRINT "Можно просмотреть ранее введенные числа. "
ELSEIF r = 3 THEN
LOCATE 24, 29: PRINT "[ГЛАВНОЕ МЕНЮ]": LOCATE 22, 2: COLOR 15, 3: PRINT "Вернемся к первому экрану.               "
END IF
CASE 32
FOR q = 1 TO 7
ah$(9, q) = ""
NEXT q
COLOR , 5: LOCATE 3, 6: PRINT "               ": LOCATE 6, 6: PRINT "                    ": LOCATE 9, 6: PRINT "                ": LOCATE 12, 6: PRINT "                 "
r = 1: LOCATE 24, 2: COLOR 10, 3: PRINT "[НАЧАЛИ]": LOCATE 22, 2: COLOR 15, 3: PRINT "Начнем перевод чисел.                    "
COLOR 14, 5
DO
oshibka: DO: a$ = INKEY$: LOCATE 20, 72: COLOR 14, 5: PRINT TIME$: LOOP WHILE a$ = ""
IF ab$ <> "" AND a$ = CHR$(32) THEN
COLOR 15, 3: LOCATE 22, 2: PRINT "Нажмите клавишу ввода [ENTER].            "
END IF
IF a$ = CHR$(13) THEN GOTO nachali
IF r1 = 1 THEN
IF ASC(a$) > 57 OR ASC(a$) < 47 THEN
COLOR 15, 3: LOCATE 22, 2: PRINT "Используйте цифры 0-9.         "
GOTO oshibka
END IF
ah$(n, 1) = ah$(n, 1) + a$
IF LEN(ah$(n, 1)) > 9 THEN
ah$(n, 1) = MID$(ah$(n, 1), 1, 9)
GOTO oshibka
END IF
LOCATE 3, 6: PRINT ah$(n, 1): ab$ = ah$(n, 1)
ELSEIF r1 = 2 THEN
IF ASC(a$) > 49 OR ASC(a$) < 48 THEN
COLOR 15, 3: LOCATE 22, 2: PRINT "Используйте цифры 0-1.          "
GOTO oshibka
END IF
ah$(n, 2) = ah$(n, 2) + a$
IF LEN(ah$(n, 2)) > 20 THEN
ah$(n, 2) = MID$(ah$(n, 2), 1, 20)
GOTO oshibka
END IF
LOCATE 6, 6: PRINT ah$(n, 2): ab$ = ah$(n, 2)
ELSEIF r1 = 3 THEN
IF ASC(UCASE$(a$)) < 48 OR ASC(UCASE$(a$)) > 70 THEN
COLOR 15, 3: LOCATE 22, 2: PRINT "Используйте цифры 0-9 и буквы A-F.  "
GOTO oshibka
END IF
IF ASC(a$) > 57 AND ASC(a$) < 65 THEN
COLOR 15, 3: LOCATE 22, 2: PRINT "Используйте цифры 0-9 и буквы A-F.   "
GOTO oshibka
END IF
ah$(n, 4) = ah$(n, 4) + a$
IF LEN(ah$(n, 4)) > 7 THEN
ah$(n, 4) = MID$(ah$(n, 4), 1, 7)
GOTO oshibka
END IF
LOCATE 9, 6: PRINT UCASE$(ah$(n, 4)): ab$ = ah$(n, 4)
ELSE
IF ASC(a$) > 55 OR ASC(a$) < 47 THEN
COLOR 15, 3: LOCATE 22, 2: PRINT "Используйте цифры 0-7.         "
GOTO oshibka
END IF
ah$(n, 3) = ah$(n, 3) + a$
IF LEN(ah$(n, 3)) > 10 THEN
ah$(n, 3) = MID$(ah$(n, 3), 1, 10)
GOTO oshibka
END IF
LOCATE 12, 6: PRINT ah$(n, 3): ab$ = ah$(n, 3)
END IF
LOOP
CASE 13
COLOR , 5: LOCATE 3, 6: PRINT "                    ": LOCATE 6, 6: PRINT "                    ": LOCATE 9, 6: PRINT "                ": LOCATE 12, 6: PRINT "                 "
COLOR 14, 5
nachali:
LOCATE 14, 50: COLOR 14: PRINT "[-]              ": LOCATE 16, 41: PRINT "                ": LOCATE 17, 41: PRINT "                ": LOCATE 18, 41: PRINT "                "
IF r = 1 THEN
IF ah$(n, 1) = "" AND ah$(n, 2) = "" AND ah$(n, 3) = "" AND ah$(n, 4) = "" THEN
LOCATE 22, 2: COLOR 15, 3: PRINT "Заполните поле для ввода.                "
r = 1: LOCATE 24, 2: COLOR 10, 3: PRINT "[НАЧАЛИ]"
GOTO oshibka
END IF
LOCATE 3, 51: PRINT "                  ": LOCATE 6, 51: PRINT "                    ": LOCATE 9, 51: PRINT "                 ": LOCATE 12, 51: PRINT "                  "
SELECT CASE r1
CASE 1
CALL perevoddec(ah$(n, 1), ah$(n, 2), ah$(n, 3), ah$(n, 4))
IF LEN(ah$(n, 2)) > 20 THEN
LOCATE 6, 51: PRINT "Cлишком большое"
ELSE
LOCATE 6, 51: PRINT ah$(n, 2)
END IF
IF LEN(ah$(n, 4)) > 20 THEN
LOCATE 9, 51: PRINT "Cлишком большое"
ELSE
LOCATE 9, 51: PRINT ah$(n, 4)
END IF
IF LEN(ah$(n, 3)) > 20 THEN
LOCATE 12, 51: PRINT "Cлишком большое"
ELSE
LOCATE 12, 51: PRINT ah$(n, 3)
END IF
CALL perevoddop(ah$(n, 2), ah$(n, 5), ah$(n, 6), ah$(n, 7))
LOCATE 16, 41: PRINT ah$(n, 5): LOCATE 18, 41: PRINT ah$(n, 6): LOCATE 17, 41: PRINT ah$(n, 7): LOCATE 14, 50: PRINT "[-" + ah$(n, 1) + "]"
CASE 2
CALL perevodbin(ah$(n, 2), ah$(n, 1), ah$(n, 3), ah$(n, 4))
IF LEN(ah$(n, 1)) > 20 THEN
LOCATE 3, 51: PRINT "Cлишком большое"
ELSE
LOCATE 3, 51: PRINT ah$(n, 1)
END IF
IF LEN(ah$(n, 4)) > 20 THEN
LOCATE 9, 51: PRINT "Cлишком большое"
ELSE
LOCATE 9, 51: PRINT ah$(n, 4)
END IF
IF LEN(ah$(n, 3)) > 20 THEN
LOCATE 12, 51: PRINT "Cлишком большое"
ELSE
LOCATE 12, 51: PRINT ah$(n, 3)
END IF
CALL perevoddop(ah$(n, 2), ah$(n, 5), ah$(n, 6), ah$(n, 7))
LOCATE 16, 41: PRINT ah$(n, 5): LOCATE 18, 41: PRINT ah$(n, 6): LOCATE 17, 41: PRINT ah$(n, 7): LOCATE 14, 50: PRINT "[-" + ah$(n, 1) + "]"

CASE 3
CALL perevodhex(ah$(n, 4), ah$(n, 2), ah$(n, 3), ah$(n, 1))
IF LEN(ah$(n, 1)) > 20 THEN
LOCATE 3, 51: PRINT "Cлишком большое"
ELSE
LOCATE 3, 51: PRINT ah$(n, 1)
END IF
IF LEN(ah$(n, 2)) > 20 THEN
LOCATE 6, 51: PRINT "Cлишком большое"
ELSE
LOCATE 6, 51: PRINT ah$(n, 2)
END IF
IF LEN(ah$(n, 3)) > 20 THEN
LOCATE 12, 51: PRINT "Cлишком большое"
ELSE
LOCATE 12, 51: PRINT ah$(n, 3)
END IF
CALL perevoddop(ah$(n, 2), ah$(n, 5), ah$(n, 6), ah$(n, 7))
LOCATE 16, 41: PRINT ah$(n, 5): LOCATE 18, 41: PRINT ah$(n, 6): LOCATE 17, 41: PRINT ah$(n, 7): LOCATE 14, 50: PRINT "[-" + ah$(n, 1) + "]"

CASE 4
CALL perevodoct(ah$(n, 3), ah$(n, 2), ah$(n, 1), ah$(n, 4))
IF LEN(ah$(n, 1)) > 20 THEN
LOCATE 3, 51: PRINT "Cлишком большое"
ELSE
LOCATE 3, 51: PRINT ah$(n, 1)
END IF
IF LEN(ah$(n, 2)) > 20 THEN
LOCATE 6, 51: PRINT "Cлишком большое"
ELSE
LOCATE 6, 51: PRINT ah$(n, 2)
END IF
IF LEN(ah$(n, 4)) > 20 THEN
LOCATE 9, 51: PRINT "Cлишком большое"
ELSE
LOCATE 9, 51: PRINT ah$(n, 4)
END IF
CALL perevoddop(ah$(n, 2), ah$(n, 5), ah$(n, 6), ah$(n, 7))
LOCATE 16, 41: PRINT ah$(n, 5): LOCATE 18, 41: PRINT ah$(n, 6): LOCATE 17, 41: PRINT ah$(n, 7): LOCATE 14, 50: PRINT "[-" + ah$(n, 1) + "]"
END SELECT
n = n + 1
IF n > 9 THEN
FOR q = 1 TO 8
FOR q1 = 1 TO 7
ah$(q, q1) = ah$(q + 1, q1)
NEXT q1
NEXT q
n = 9
END IF
ELSEIF r = 3 THEN GOTO start
ELSEIF r = 2 THEN
LOCATE 24, 2: COLOR 10, 3: PRINT "[СЛЕДУЮЩИЙ]": LOCATE 24, 14: COLOR 1, 3: PRINT "    [ПРЕДЫДУЩИЙ]      [НАЗАД]            "
LOCATE 22, 2: COLOR 15, 3: PRINT "Просмотр следующего введенного числа.            "
r2 = 1
DO
CALL kod(b)
LOCATE 24, 2: COLOR 1, 3: PRINT "[СЛЕДУЮЩИЙ]     [ПРЕДЫДУЩИЙ]      [НАЗАД]"
SELECT CASE b
CASE 77
r2 = r2 + 1
IF r2 > 3 THEN r2 = 1
IF r2 = 1 THEN
LOCATE 24, 2: COLOR 10, 3: PRINT "[СЛЕДУЮЩИЙ]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Просмотр следующего введенного числа.   "
ELSEIF r2 = 2 THEN
LOCATE 24, 18: COLOR 10, 3: PRINT "[ПРЕДЫДУЩИЙ]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Просмотр предыдущего введенного числа.  "
ELSEIF r2 = 3 THEN
LOCATE 24, 36: COLOR 10, 3: PRINT "[НАЗАД]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Вернемся в режим набора чисел.          "
END IF
CASE 75
r2 = r2 - 1
IF r2 < 1 THEN r2 = 3
IF r2 = 1 THEN
LOCATE 24, 2: COLOR 10, 3: PRINT "[СЛЕДУЮЩИЙ]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Просмотр следующего введенного числа.  "
ELSEIF r2 = 2 THEN
LOCATE 24, 18: COLOR 10, 3: PRINT "[ПРЕДЫДУЩИЙ]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Просмотр предыдущего введенного числа.  "
ELSEIF r2 = 3 THEN
LOCATE 24, 36: COLOR 10, 3: PRINT "[НАЗАД]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Вернемся в режим набора чисел.          "
END IF
CASE 27
GOTO w1
CASE 13
LOCATE 14, 50: COLOR 14, 5: PRINT "[-]                            "
COLOR , 5: LOCATE 3, 51: PRINT "                    ": LOCATE 6, 51: PRINT "                    ": LOCATE 9, 51: PRINT "                ": LOCATE 12, 51: PRINT "                 "
LOCATE 16, 41: PRINT "                ": LOCATE 17, 41: PRINT "               ": LOCATE 18, 41: PRINT "                "
IF r2 = 3 THEN
GOTO w1
ELSEIF r2 = 1 THEN
LOCATE 24, 2: COLOR 10, 3: PRINT "[СЛЕДУЮЩИЙ]"
COLOR 14, 5
u = u + 1: IF u > 9 THEN u = 1
IF ah$(u, 1) = "" THEN u = 1
IF LEN(ah$(u, 1)) > 20 THEN
LOCATE 3, 51: PRINT "Cлишком большое"
ELSE
LOCATE 3, 51: PRINT ah$(u, 1)
END IF
IF LEN(ah$(u, 2)) > 20 THEN
LOCATE 6, 51: PRINT "Cлишком большое"
ELSE
LOCATE 6, 51: PRINT ah$(u, 2)
END IF
IF LEN(ah$(u, 4)) > 20 THEN
LOCATE 9, 51: PRINT "Cлишком большое"
ELSE
LOCATE 9, 51: PRINT UCASE$(ah$(u, 4))
END IF
IF LEN(ah$(u, 3)) > 20 THEN
LOCATE 12, 51: PRINT "Слишком большое"
ELSE
LOCATE 12, 51: PRINT ah$(u, 3)
END IF
LOCATE 16, 41: PRINT ah$(u, 5): LOCATE 18, 41: PRINT ah$(u, 6): LOCATE 17, 41: PRINT ah$(u, 7): LOCATE 14, 50: PRINT "[-" + ah$(u, 1) + "]"
ELSEIF r2 = 2 THEN
LOCATE 24, 18: COLOR 10, 3: PRINT "[ПРЕДЫДУЩИЙ]"
COLOR 14, 5
u = u - 1: IF u < 1 THEN u = 9
IF ah$(u, 1) = "" THEN u = n - 1
IF LEN(ah$(u, 1)) > 20 THEN
LOCATE 3, 51: PRINT "Cлишком большое"
ELSE
LOCATE 3, 51: PRINT ah$(u, 1)
END IF
IF LEN(ah$(u, 2)) > 20 THEN
LOCATE 6, 51: PRINT "Cлишком большое"
ELSE
LOCATE 6, 51: PRINT ah$(u, 2)
END IF
IF LEN(ah$(u, 4)) > 20 THEN
LOCATE 9, 51: PRINT "Cлишком большое"
ELSE
LOCATE 9, 51: PRINT UCASE$(ah$(u, 4))
END IF
IF LEN(ah$(u, 3)) > 20 THEN
LOCATE 12, 51: PRINT "Слишком большое"
ELSE
LOCATE 12, 51: PRINT ah$(u, 3)
END IF
LOCATE 16, 41: PRINT ah$(u, 5): LOCATE 18, 41: PRINT ah$(u, 6): LOCATE 17, 41: PRINT ah$(u, 7): LOCATE 14, 50: PRINT "[-" + ah$(u, 1) + "]"
END IF
CASE ELSE
r2 = 3
LOCATE 24, 36: COLOR 10, 3: PRINT "[НАЗАД]"
LOCATE 22, 2: COLOR 15, 3: PRINT "Вернемся в режим набора чисел.          "
END SELECT
LOOP
END IF
CASE 27
GOTO start
CASE ELSE
r = 1: LOCATE 24, 2: COLOR 10, 3: PRINT "[НАЧАЛИ]": LOCATE 22, 2: COLOR 15, 3: PRINT "Начнем перевод чисел.                   "
LOCATE 22, 2: COLOR 15, 3: PRINT "Нажмите клавишу ввода [ENTER] или пробел."
END SELECT
LOOP

REM $STATIC
DEFINT C
SUB kod (b)
DO: a$ = INKEY$: LOCATE 20, 72: COLOR 14, 5: PRINT TIME$: LOOP WHILE a$ = ""
b = ASC(RIGHT$(a$, 1))
END SUB

SUB perevodbin (a$, a1$, a2$, a3$)
cq# = LEN(a$)
FOR q = 1 TO LEN(a$)
c# = VAL(MID$(a$, q, 1)) * 2 ^ (cq# - 1) + c#
cq# = cq# - 1
NEXT
a1$ = LTRIM$(STR$(c#))
cc# = c#
DO WHILE cc# >= 8
ch# = cc# MOD 8
a2$ = LTRIM$(STR$(ch#)) + a2$
cc# = INT(cc# / 8)
LOOP
a2$ = LTRIM$(STR$(cc#)) + a2$
cc# = c#
DO WHILE cc# >= 16
ch# = cc# MOD 16
SELECT CASE ch#
CASE 10
a3$ = "A" + a3$
CASE 11
a3$ = "B" + a3$
CASE 12
a3$ = "C" + a3$
CASE 13
a3$ = "D" + a3$
CASE 14
a3$ = "E" + a3$
CASE 15
a3$ = "F" + a3$
CASE ELSE
a3$ = LTRIM$(STR$(ch#)) + a3$
END SELECT
cc# = INT(cc# / 16)
LOOP
SELECT CASE cc#
CASE 10
a3$ = "A" + a3$
CASE 11
a3$ = "B" + a3$
CASE 12
a3$ = "C" + a3$
CASE 13
a3$ = "D" + a3$
CASE 14
a3$ = "E" + a3$
CASE 15
a3$ = "F" + a3$
CASE ELSE
a3$ = LTRIM$(STR$(cc#)) + a3$
END SELECT
END SUB

SUB perevoddec (a$, a1$, a2$, a3$)
c# = VAL(a$)
DO WHILE c# >= 2
ch# = c# MOD 2
a1$ = LTRIM$(STR$(ch#)) + a1$
c# = INT(c# / 2)
LOOP
a1$ = LTRIM$(STR$(c#)) + a1$
c# = VAL(a$)
DO WHILE c# >= 8
ch# = c# MOD 8
a2$ = LTRIM$(STR$(ch#)) + a2$
c# = INT(c# / 8)
LOOP
a2$ = LTRIM$(STR$(c#)) + a2$
c# = VAL(a$)
DO WHILE c# >= 16
ch# = c# MOD 16
SELECT CASE ch#
CASE 10
a3$ = "A" + a3$
CASE 11
a3$ = "B" + a3$
CASE 12
a3$ = "C" + a3$
CASE 13
a3$ = "D" + a3$
CASE 14
a3$ = "E" + a3$
CASE 15
a3$ = "F" + a3$
CASE ELSE
a3$ = LTRIM$(STR$(ch#)) + a3$
END SELECT
c# = INT(c# / 16)
LOOP
SELECT CASE c#
CASE 10
a3$ = "A" + a3$
CASE 11
a3$ = "B" + a3$
CASE 12
a3$ = "C" + a3$
CASE 13
a3$ = "D" + a3$
CASE 14
a3$ = "E" + a3$
CASE 15
a3$ = "F" + a3$
CASE ELSE
a3$ = LTRIM$(STR$(c#)) + a3$
END SELECT
END SUB

DEFSNG C
SUB perevoddop (aq$, a1$, a2$, a3$)
FOR q = 1 TO 15
amid$ = MID$(aq$, q, 1)
IF amid$ = "" THEN GOTO pusto
IF amid$ = "0" THEN
amid$ = "1"
ELSEIF amid$ = "1" THEN
amid$ = "0"
END IF
a$ = a$ + amid$
NEXT q
pusto: FOR q1 = q TO 15
amid$ = MID$(aq$, q, 1)
IF amid$ = "" THEN amid$ = "0"
IF amid$ = "0" THEN
amid$ = "1"
ELSEIF amid$ = "1" THEN
amid$ = "0"
END IF
a$ = amid$ + a$
NEXT q1
cq# = LEN(a$)
FOR q = 1 TO LEN(a$)
c# = VAL(MID$(a$, q, 1)) * 2 ^ (cq# - 1) + c#
cq# = cq# - 1
NEXT
c# = c# + 1
cc# = c#
DO WHILE cc# >= 2
ch# = cc# MOD 2
a1$ = LTRIM$(STR$(ch#)) + a1$
cc# = INT(cc# / 2)
LOOP
a1$ = LTRIM$(STR$(cc#)) + a1$
cc# = c#
DO WHILE cc# >= 8
ch# = cc# MOD 8
a2$ = LTRIM$(STR$(ch#)) + a2$
cc# = INT(cc# / 8)
LOOP
a2$ = LTRIM$(STR$(cc#)) + a2$ + "            "
cc# = c#
DO WHILE cc# >= 16
ch# = cc# MOD 16
SELECT CASE ch#
CASE 10
a3$ = "A" + a3$
CASE 11
a3$ = "B" + a3$
CASE 12
a3$ = "C" + a3$
CASE 13
a3$ = "D" + a3$
CASE 14
a3$ = "E" + a3$
CASE 15
a3$ = "F" + a3$
CASE ELSE
a3$ = UCASE$(LTRIM$(STR$(ch#)) + a3$)
END SELECT
cc# = INT(cc# / 16)
LOOP
SELECT CASE c#
CASE 10
a3$ = "A" + a3$
CASE 11
a3$ = "B" + a3$
CASE 12
a3$ = "C" + a3$
CASE 13
a3$ = "D" + a3$
CASE 14
a3$ = "E" + a3$
CASE 15
a3$ = "F" + a3$
CASE ELSE
a3$ = LTRIM$(STR$(c#)) + a3$ + "        "
END SELECT
IF LEN(aq$) > 14 THEN
a1$ = "Слишком большое"
a2$ = a1$: a3$ = a1$
ELSEIF aq$ = "0" THEN a1$ = "0"
a2$ = a1$: a3$ = a1$
END IF
END SUB

DEFINT C
SUB perevodhex (a$, a1$, a2$, a3$)
cq# = LEN(a$)
FOR q = 1 TO LEN(a$)
ab$ = MID$(a$, q, 1)
SELECT CASE ab$
CASE "a"
c# = 10 * 16 ^ (cq# - 1) + c#
CASE "b"
c# = 11 * 16 ^ (cq# - 1) + c#
CASE "c"
c# = 12 * 16 ^ (cq# - 1) + c#
CASE "d"
c# = 13 * 16 ^ (cq# - 1) + c#
CASE "e"
c# = 14 * 16 ^ (cq# - 1) + c#
CASE "f"
c# = 15 * 16 ^ (cq# - 1) + c#
CASE ELSE
c# = VAL(ab$) * 16 ^ (cq# - 1) + c#
END SELECT
cq# = cq# - 1
NEXT
a3$ = LTRIM$(STR$(c#))
cc# = c#
DO WHILE cc# >= 2
ch# = cc# MOD 2
a1$ = LTRIM$(STR$(ch#)) + a1$
cc# = INT(cc# / 2)
LOOP
a1$ = LTRIM$(STR$(cc#)) + a1$
cc# = c#
DO WHILE cc# >= 8
ch# = cc# MOD 8
a2$ = LTRIM$(STR$(ch#)) + a2$
cc# = INT(cc# / 8)
LOOP
a2$ = LTRIM$(STR$(cc#)) + a2$
END SUB

SUB perevodoct (a$, a1$, a2$, a3$)
cq# = LEN(a$)
FOR q = 1 TO LEN(a$)
c# = VAL(MID$(a$, q, 1)) * 8 ^ (cq# - 1) + c#
cq# = cq# - 1
NEXT
a2$ = LTRIM$(STR$(c#))
cc# = c#: ch# = 2: q = 1
DO WHILE cc# >= 2
ch# = cc# MOD 2
a1$ = LTRIM$(STR$(ch#)) + a1$
cc# = INT(cc# / 2)
LOOP
a1$ = LTRIM$(STR$(cc#)) + a1$
cc# = c#
DO WHILE cc# >= 16
ch# = cc# MOD 16
SELECT CASE ch#
CASE 10
a3$ = "A" + a3$
CASE 11
a3$ = "B" + a3$
CASE 12
a3$ = "C" + a3$
CASE 13
a3$ = "D" + a3$
CASE 14
a3$ = "E" + a3$
CASE 15
a3$ = "F" + a3$
CASE ELSE
a3$ = LTRIM$(STR$(ch#)) + a3$
END SELECT
cc# = INT(cc# / 16)
LOOP
SELECT CASE cc#
CASE 10
a3$ = "A" + a3$
CASE 11
a3$ = "B" + a3$
CASE 12
a3$ = "C" + a3$
CASE 13
a3$ = "D" + a3$
CASE 14
a3$ = "E" + a3$
CASE 15
a3$ = "F" + a3$
CASE ELSE
a3$ = LTRIM$(STR$(cc#)) + a3$
END SELECT

END SUB

