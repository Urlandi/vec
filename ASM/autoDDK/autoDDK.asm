;Выполняется сложение в системе ДДК для 7-ми разрядных десятичных чисел, с приминением теории цифровых автоматов.
;Для чисел используются 32-ти разрядные двоичные регистры,старшие два бита 0, затем два бита знак, далее значения тетрад.
;Компиляция в MASM32

ABOUT_BUTTON            equ     102
RUN_BUTTON              equ     101

.386
.model flat,stdcall

includelib kernel32.lib
includelib user32.lib

include windows.inc
include kernel32.inc
include user32.inc

dlg_call PROTO

.data

        dlg             db      "DDK_MAIN",0


        about_message   db      "(c) 2004, PyRE",13,10
                        db      "pmack@mail.ru",0
        about_title     db      "Что-то?",0

        error_title     db      "Внимание!",0


        gets_number     db      2 dup(0)

;Регистры операционного автомата

I                       equ     06666665h               ;Регистр константа инвентор перевода в доп. код
        T               dd      0                       ;Регистр для объмена при переводе в доп. код
        A               dd      0                       ;Регистр операнда A
        B               dd      0                       ;Регистр операнда B
        Cr              dd      0                       ;Регистр результата C
        p               db      0                       ;Регистр с результатами переноса
        R1              db      0                       ;Регистр с результатами коррекции
H                       equ     0110b                   ;Регистр константа 6
        R               db      0                       ;Регистр предварительного сложения тетрад
        kkk             db      0                       ;Регист признаков функционирования автомата
        Cn              db      0                       ;Счётчик


;Данные для управляющего автомата

        Q               db      0                       ;Состояние автомата
        X               db      0                       ;Сигнал на входе
        Y               db      0                       ;Сигнал на выходе

Q0                      equ     0
Q1                      equ     1
Q2                      equ     2
Q3                      equ     3
Q4                      equ     4
Q5                      equ     5
Q6                      equ     6
Q7                      equ     7
Q10                     equ     13
Q11                     equ     9
Q12                     equ     10
Q13                     equ     11
Q16                     equ     12
Q17                     equ     8


termi                   equ     12                      ;Если дошли - выходим


X1                      equ     0
X1_                     equ     14
X2                      equ     28
X2_                     equ     42
X3                      equ     56
X3_                     equ     70
X4                      equ     84
X4_                     equ     98
X5                      equ     112
X6                      equ     126
X7                      equ     140
X8                      equ     154
X9                      equ     168


Y1                      equ     1
Y2                      equ     2
Y3                      equ     3
Y4                      equ     4
Y5                      equ     5
Y6                      equ     6
Y7                      equ     7
Y8                      equ     8
Y9                      equ     9
Y10                     equ     10
Y11                     equ     11
Y12                     equ     12
Y13                     equ     13
Y14                     equ     14
Y15                     equ     15
Y16                     equ     16
Y17                     equ     17
Y18                     equ     18
Y19                     equ     19



;Таблица переходов              Q0 Q1 Q2 Q3 Q4 Q5 Q6,Q7   Q17 Q11 Q12 Q13 Q16 Q10
        Qtt             db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q7,  Q10,Q11, Q0, Q0,Q16,Q17               ;x1
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q7,  Q10,Q11, Q0, Q0,Q16,Q17               ;not x1
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q7,Q7,  Q10,Q11, Q0, Q0,Q16,Q17               ;x2
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q1,Q7,  Q10,Q11, Q0, Q0,Q16,Q17               ;not x2
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q7,  Q12,Q11, Q0, Q0,Q16,Q17               ;x3
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q7,  Q11,Q11, Q0, Q0,Q16,Q17               ;not x3
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q7,  Q10,Q13, Q0, Q0,Q16,Q17               ;x4
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q7,  Q10,Q0,  Q0, Q0,Q16,Q17               ;not x4
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q11, Q10,Q11, Q0, Q0,Q16,Q17               ;x5
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q0,  Q10,Q11, Q0, Q0,Q16,Q17               ;x6
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q0,  Q10,Q11, Q0, Q0,Q16,Q17               ;x7
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q0,  Q10,Q11, Q0, Q0,Q16,Q17               ;x8
                        db      Q1,Q3,Q3,Q4,Q6,Q6,Q6,Q16, Q10,Q11, Q0, Q0,Q16,Q17               ;x9

;Таблица выходов                Q0 Q1 Q2 Q3 Q4 Q5 Q6 Q7   Q17 Q11 Q12 Q13 Q16 Q10
        Ytt             db      Y1,Y2,Y3,Y4,Y5,Y6,00,00,   00, 00,Y12,Y14, 00,Y10               ;x1
                        db      Y1,Y2,Y3,Y9,Y5,Y6,00,00,   00, 00,Y12,Y14, 00,Y10               ;not x1
                        db      Y1,Y2,Y3,00,Y5,Y6,Y8,00,   00, 00,Y12,Y14, 00,Y10               ;x2
                        db      Y1,Y2,Y3,00,Y5,Y6,Y7,00,   00, 00,Y12,Y14, 00,Y10               ;not x2
                        db      Y1,Y2,Y3,00,Y5,Y6,00,00,  Y11, 00,Y12,Y14, 00,Y10               ;x3
                        db      Y1,Y2,Y3,00,Y5,Y6,00,00,  Y19, 00,Y12,Y14, 00,Y10               ;not x3
                        db      Y1,Y2,Y3,00,Y5,Y6,00,00,   00,Y13,Y12,Y14, 00,Y10               ;x4
                        db      Y1,Y2,Y3,00,Y5,Y6,00,00,   00, 00,Y12,Y14, 00,Y10               ;not x4
                        db      Y1,Y2,Y3,00,Y5,Y6,00,Y16,  00, 00,Y12,Y14, 00,Y10               ;x5
                        db      Y1,Y2,Y3,00,Y5,Y6,00,Y15,  00, 00,Y12,Y14, 00,Y10               ;x6
                        db      Y1,Y2,Y3,00,Y5,Y6,00,Y17,  00, 00,Y12,Y14, 00,Y10               ;x7
                        db      Y1,Y2,Y3,00,Y5,Y6,00,Y18,  00, 00,Y12,Y14, 00,Y10               ;x8
                        db      Y1,Y2,Y3,00,Y5,Y6,00, 00,  00, 00,Y12,Y14, 00,Y10               ;x9


.code

_WMain:

                        xor     ebx,ebx

                invoke  GetModuleHandle,ebx

                invoke  DialogBoxParam,eax,offset dlg,ebx,offset dlg_call,ebx

                invoke  ExitProcess,ebx


dlg_call                proc    near

                        push    ebp
                        mov     ebp,esp

hWndDlg                 equ     dword ptr ss:[ebp+08h]
uMsg                    equ     dword ptr ss:[ebp+0Ch]
wParam                  equ     dword ptr ss:[ebp+10h]
lParam                  equ     dword ptr ss:[ebp+14h]

                        push    ebx

                        mov     ebx,hWndDlg
                        mov     eax,uMsg


                        cmp     eax,WM_CLOSE
                        jne     execs


                invoke  EndDialog,ebx,0

                        jmp     out_this


execs:                  cmp     eax,WM_COMMAND
                        jne     def_run
                        mov     eax,wParam
                        cmp     eax,ABOUT_BUTTON
                        jne     ADDER

                invoke  MessageBox,ebx,offset about_message,offset about_title,MB_ICONINFORMATION

                        jmp     out_this


ADDER:                  cmp     eax,RUN_BUTTON
                        jne     def_run

                        mov     ecx,110

re1:                    push    ecx

                invoke  IsDlgButtonChecked,ebx,ecx

                        pop     ecx
                        inc     ecx
                        xor     edx,edx

                        cmp     eax,BST_CHECKED
                        jne     trs
                        mov     edx,3


trs:                    shl     edx,4

                        push    ecx
                        push    edx

                invoke  GetDlgItemInt,ebx,ecx,0,0

                        pop     edx
                        pop     ecx
                        or      edx,eax

                        inc     ecx

                        cmp     ecx,118

                        je      o1
                        cmp     ecx,126
                        je      o1

                        jmp     trs

o1:                     cmp     ecx,125
                        ja      get_all_data
                        mov     A,edx
                        jmp     re1

get_all_data:           mov     B,edx

                        call    YA

                        mov     ecx,133
                        mov     edx,Cr

resout:                 push    ecx
                        push    edx

                        xor     eax,eax
                        mov     eax,edx
                        and     eax,0Fh

                invoke  SetDlgItemInt,ebx,ecx,eax,0

                        pop     edx
                        pop     ecx

                        shr     edx,4
                        dec     ecx
                        cmp     ecx,126
                        ja      resout

                        test    edx,2
                        push    edx
                        jnz     nuller

               invoke CheckDlgButton,ebx,ecx,BST_UNCHECKED

                        jmp     carr

nuller:        invoke CheckDlgButton,ebx,ecx,BST_CHECKED

carr:                   pop     edx
                        mov     eax,edx
                        and     eax,1
                        and     edx,2
                        shr     edx,1
                        xor     eax,edx
                        jz      fine

overlock:       invoke CheckDlgButton,ebx,134,BST_CHECKED

                        jmp     out_this

fine:           invoke CheckDlgButton,ebx,134,BST_UNCHECKED


                        jmp     out_this


def_run:                xor     ebx,ebx


out_this:               mov     eax,ebx
                        pop     ebx
                        leave
                        ret     16


dlg_call                endp


;Операционный автомат здесь раскрываются все действия по алгоритму
;Просто очень большой SWITCH (CASE)

OA                      proc

                        mov     ah,Y

;Инициализируем все наши данные

                        cmp     ah,Y1
                        jne     switch1

                        xor     eax,eax
                        mov     R,al
                        mov     p,al
                        mov     Cr,eax
                        mov     Cn,8

                        jmp     switchend

;Выполняем сложение тетрад и сохраняем перенос

switch1:                cmp     ah,Y2
                        jne     switch2

                        mov     dl,X1_
                        mov     X,dl

                        mov     eax,A
                        shl     al,4
                        mov     edx,B
                        shl     dl,4
                        mov     p,0
                        add     al,dl
                        jnc     no_carry1

                        mov     p,1
                        mov     dl,X1
                        mov     X,dl

no_carry1:              shr     al,4
                        mov     R,al

                        mov     ah,Y3

                        ;jmp     switchend

;Продолжаем выполнять сложение фактически учитываем перенос с предыдущего
;разряда, не выделяется как состояние, подразумеваем использование полного
;4-х разрядного двоичного сумматора с входящими и выходящими переносами

switch2:                cmp     ah,Y3
                        jne     switch3

                        mov     al,R
                        shl     al,4
                        mov     ah,R1
                        shl     ah,4
                        add     al,ah
                        jnc     no_carry3

                        mov     dl,p
                        or      dl,1
                        mov     p,dl

                        mov     dl,X1
                        mov     X,dl

no_carry3:              shr     al,4
                        mov     R,al

                        cmp     al,9
                        jna     goto1

                        mov     al,kkk
                        test    al,0111b
                        jnz     goto1

                        mov     dl,X1
                        mov     X,dl

goto1:                  jmp     switchend

;Заносим в регистр коррекции требуемую коррекцию +6

switch3:                cmp     ah,Y4
                        jne     switch4

                        mov     R1,H

                        jmp     switchend

;Выполняем сложение промежуточного результата и коррекции учитывая перенос

switch4:                cmp     ah,Y5
                        jne     switch5

                        xor     eax,eax

                        mov     al,R
                        shl     al,4
                        mov     ah,R1
                        shl     ah,4
                        mov     R1,0
                        add     al,ah
                        jnc     no_carry2

                        mov     R1,1

no_carry2:              shl     eax,24
                        mov     edx,Cr
                        or      eax,edx
                        mov     Cr,eax

                        mov     ah,Y6

                        ;jmp     switchend

;Продолжаем сложение сохраняя значимы перенос (1)

switch5:                cmp     ah,Y6
                        jne     switch6

                        mov     dl,X2_
                        mov     X,dl

                        mov     ah,R1
                        mov     al,p

                        or      ah,al

                        ;add     ah,al
                        mov     R1,ah


                        mov     al,Cn
                        dec     al
                        jnz     CrA

                        mov     dl,X2
                        mov     X,dl

CrA:                    mov     Cn,al

                        jmp     switchend

;Циклически сдвигаем регистры операнды для доступа к следующей тетраде

switch6:                cmp     ah,Y7
                        jne     switch7

                        mov     eax,A
                        ror     eax,4
                        mov     A,eax

                        mov     eax,B
                        ror     eax,4
                        mov     B,eax

                        mov     eax,Cr
                        ror     eax,4
                        mov     Cr,eax

                        jmp     switchend

;Циклически сдвигаем регистры операнды для восстановления иходных значений
;Сохраняем окончательный результат

switch7:                cmp     ah,Y8
                        jne     switch8

                        mov     eax,A
                        ror     eax,4
                        mov     A,eax

                        mov     eax,B
                        ror     eax,4
                        mov     B,eax

                        mov     eax,Cr
                        and     eax,3FFFFFFFh
                        mov     Cr,eax

                        mov     al,kkk

                        test    al,1000b
                        jz      k4

                        mov     dl,X9
                        mov     X,dl

                        jmp     switchend

k4:                     test    al,0001b
                        jz      k1

                        mov     dl,X5
                        mov     X,dl
                        jmp     switchend

k1:                     test    al,0010b
                        jz      k2

                        mov     dl,X6
                        mov     X,dl
                        jmp     switchend

k2:                     test    al,0100b
                        jz      k3

                        mov     dl,X8
                        mov     X,dl
                        jmp     switchend

k3:                     mov     dl,X9
                        mov     X,dl

                        shr     eax,28
                        and     eax,2
                        jz      Cg

                        mov     dl,X7
                        mov     X,dl

Cg:                     jmp     switchend

;Заносим в регистр корректор 0

switch8:                cmp     ah,Y9
                        jne     switch9

                        mov     R1,0

                        jmp     switchend

;Инициализируем начальное состояние автомата

switch9:                cmp     ah,Y10
                        jne     switch10

                        mov     kkk,0

                        mov     edx,A

                        mov     dl,X3_
                        mov     X,dl

                        shr     edx,28
                        and     edx,2
                        jz      Ag

                        mov     dl,X3
                        mov     X,dl

Ag:                     jmp     switchend

;Сохраняем регистр B для перевода A в дополнительный код

switch10:               cmp     ah,Y11
                        jne     switch11

                        mov     eax,B
                        mov     T,eax
                        mov     al,kkk
                        or      al,0001b
                        mov     kkk,al

                        jmp     switchend

;Заносим в B значение I

switch11:               cmp     ah,Y12
                        jne     switch12

                        mov     B,I

                        jmp     switchend

;Сохраняем регистр A для перевода B в дополнительный код

switch12:               cmp     ah,Y13
                        jne     switch13

                        mov     eax,A
                        mov     T,eax
                        mov     al,kkk
                        or      al,0010b
                        mov     kkk,al

                        jmp     switchend

;Заносим в A значение I

switch13:               cmp     ah,Y14
                        jne     switch14

                        mov     A,I

                        jmp     switchend

;Восстанавливаем A. В B значение отрицательного цисла в дополнительном коде

switch14:               cmp     ah,Y15
                        jne     switch15

                        mov     eax,Cr
                        mov     edx,eax
                        and     edx,0F0000000h
                        shl     eax,4
                        not     eax
                        shr     eax,4
                        or      eax,edx
                        mov     B,eax
                        mov     eax,T
                        mov     A,eax

                        mov     al,kkk
                        and     al,1101b
                        mov     kkk,al

                        jmp     switchend

;Восстанавливаем B. В A значение отрицательного цисла в дополнительном коде

switch15:               cmp     ah,Y16
                        jne     switch16

                        mov     eax,Cr
                        mov     edx,eax
                        and     edx,0F0000000h
                        shl     eax,4
                        not     eax
                        shr     eax,4
                        or      eax,edx
                        mov     A,eax
                        mov     eax,T
                        mov     edx,eax
                        mov     B,eax

                        mov     al,kkk
                        and     al,1110b
                        mov     kkk,al

                        mov     dl,X4_
                        mov     X,dl

                        shr     edx,28
                        and     edx,2
                        jz      Bg

                        mov     dl,X4
                        mov     X,dl

Bg:                     jmp     switchend

;Подготавливаем регистры для перевода результата в прямой код

switch16:               cmp     ah,Y17
                        jne     switch17

                        mov     eax,Cr
                        mov     A,eax
                        mov     B,I
                        mov     al,kkk
                        or      al,0100b
                        mov     kkk,al

                        jmp     switchend


;Результат в прямом коде исходные значения операндов потеряны

switch17:               cmp     ah,Y18
                        jne     switch18

                        mov     eax,Cr
                        mov     edx,eax
                        and     edx,0F0000000h
                        shl     eax,4
                        not     eax
                        shr     eax,4
                        or      eax,edx

                        mov     A,eax
                        mov     B,0

                        mov     al,kkk
                        and     al,1011b
                        or      al,1000b
                        mov     kkk,al

                        jmp     switchend

;Фиктивное состояние используется только для вычисления условий,
;в реальном автомате не требуется

switch18:               cmp     ah,Y19
                        jne     switchend

                        mov     edx,B

                        mov     dl,X4_
                        mov     X,dl

                        shr     edx,28
                        and     edx,2
                        jz      switchend

                        mov     dl,X4
                        mov     X,dl

switchend:              ret

OA                      endp

;Управляющий автомат. Происходит изменение значения переменной-состояния Q
;по её текущему значению и сигналам условию Х в цикле из таблицы Qtt.
;Выход из цикла по достижении состояния term
;Операционный автомат вызывается в цикле и реагирует на сигналы Y,
;выбираемые по тем же принципам что и Q, но из таблицы Ytt

YA                      proc

                        mov     al,Q10
                        mov     Q,al

ND:                     xor     eax,eax
                        mov     al,X
                        add     al,Q
                        mov     cl,Qtt[eax]
                        mov     ch,Ytt[eax]
                        mov     Q,cl
                        mov     Y,ch
                        call    OA
                        cmp     cl,termi
                        je      gluk
                        jmp     ND
gluk:                   ret

YA                      endp

end _WMain
