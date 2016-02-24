CLS
INPUT "‚‚…„…’… ‹žŽ… ‘‹Ž‚Ž > ", S$
I = 0
A1:
B$ = LEFT$(S$, I) + MID$(S$, LEN(S$))
I = I + 1
IF I <= LEN(S$) - 2 THEN GOTO A1
COLOR 11
LOCATE 3, 2
PRINT "€ ‚Ž’ ˆ …‡“‹œ’€’ …‡ …„Ž‘‹‹…„…‰ “Š‚› "
COLOR 12
LOCATE 4, 2
PRINT B$

