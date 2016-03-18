.model tiny
.code
.startup
jmp star
beep proc
NUMBER_CYCLES  EQU   16
FREQUENCY      EQU   16384
PORT_B         EQU   61H

               CLI                 ;запрет прерываний
               push ax
               push dx
               push cx

               in al,60h
               cmp al,58
je da
               cmp al,69
je da
               cmp al,70
je da
jmp net
da:
               MOV   DX,NUMBER_CYCLES  ;длительность тона в DX
               IN    AL,PORT_B     ;получаем значение из порта B
               AND   AL,11111110B  ;отключаем динамик от таймера
NEXT_CYCLE:    OR    AL,00000010B  ;включаем динамик
               OUT   PORT_B,AL     ;посылаем команду в порт B
               MOV   CX,FREQUENCY  ;задержка на пол-цикла в CX
FIRST_HALF:    LOOP  FIRST_HALF    ;делаем задержку
               AND   AL,11111101B  ;выключаем динамик
               OUT   PORT_B,AL     ;посылаем команду в порт B
               MOV   CX,FREQUENCY  ;задержка на пол-цикла в CX
SECOND_HALF:   LOOP  SECOND_HALF   ;делаем задержку
               DEC   DX            ;вычитаем единицу из счетчика
               JNZ   NEXT_CYCLE    ;если 0, то надо кончать


net:           STI                 ;разрешаем прерывания
               pop cx
               pop dx
               pop ax

               jmp dword ptr cs:i

i dw 0
c dw 0
beep endp
star:
 mov ah,35h
 mov al,09h
 int 21h
 mov c,es
 mov i,bx

 mov ah,25h
 mov al,09h
 mov dx,offset beep
 int 21h

 mov dx,352
 int 27h
end