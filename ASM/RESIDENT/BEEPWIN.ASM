.model tiny
.code
.startup
jmp star
beep proc
NUMBER_CYCLES  EQU   16
FREQUENCY      EQU   16384
PORT_B         EQU   61H

               CLI                 ;����� ���뢠���
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
               MOV   DX,NUMBER_CYCLES  ;���⥫쭮��� ⮭� � DX
               IN    AL,PORT_B     ;����砥� ���祭�� �� ���� B
               AND   AL,11111110B  ;�⪫�砥� ������� �� ⠩���
NEXT_CYCLE:    OR    AL,00000010B  ;����砥� �������
               OUT   PORT_B,AL     ;���뫠�� ������� � ���� B
               MOV   CX,FREQUENCY  ;����প� �� ���-横�� � CX
FIRST_HALF:    LOOP  FIRST_HALF    ;������ ����প�
               AND   AL,11111101B  ;�몫�砥� �������
               OUT   PORT_B,AL     ;���뫠�� ������� � ���� B
               MOV   CX,FREQUENCY  ;����প� �� ���-横�� � CX
SECOND_HALF:   LOOP  SECOND_HALF   ;������ ����প�
               DEC   DX            ;���⠥� ������� �� ���稪�
               JNZ   NEXT_CYCLE    ;�᫨ 0, � ���� ������


net:           STI                 ;ࠧ�蠥� ���뢠���
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