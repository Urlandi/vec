;���� ��� ���ᨢ� 5 � 4 �������. �᫨ ��ன ������⥫�� ������� ��ࢮ��
;���ᨢ� ����� ��ண� ������⥫쭮�� ������� ��ண� ���ᨢ�, �
;��९���� ��� ���ᨢ� �� ���, �᫨ ��� �������� ���ᨢ� ���⠬�.
.model tiny
.code
org 100h
start:jmp go
mass1 db -1,2,1,-4,5
mass2 db 1,2,3,4
rsrv  db ?
ermsg db '�ந��諠 �訡�� �믮������ �ணࠬ��, ࠡ�� ��ࢠ��$'
go:   lea si,mass1
      mov di,si
      mov cl,5
      call g2
      cmp al,-1
      je er
      mov ah,al
      lea si,mass2
      mov cl,4
      call g2
      cmp al,-1
      je er
      cmp ah,al
      ja wdisk

      mov cl,5

C:    mov al,[di]
      mov ah,[di+5]
      mov [di],ah
      mov [di+5],al
      inc di
      dec cl
      jnz C
      jmp q

wdisk:mov ax,0301h
      xor dx,dx
      mov cx,01h
      lea bx,mass1
      int 13h ;������ 0 �������, 0 ��஦��, 1 ᥪ��
      jnc q

er:   mov ah,09h
      lea dx,ermsg
      int 21h
q:    int 20h

g2 proc;�室 SI-���� ���ᨢ� CL-��� �����
        XOR CH,CH         ;����塞 ���稪 ������⥫��� ������⮢
        CLD               ;���� ��������
LC:     LODSB             ;AL=������� �� ���ᨢ� �� ����� SI. SI=SI+1
        CMP AL,0          ;�஢�ઠ �� ������⥫��
        JS NC             ;��릮� �᫨ ����⥫��

        INC CH            ;�����稢��� ���稪 ������⥫���
        CMP CH,2          ;�஢��塞 �� ��ன ������⥫��
        JE  TRUES2        ;��릮� �᫨ ��ன ������⥫��

NC:     LOOP LC           ;�����塞 ���� CX>0
        mov al,-1
trues2: ret
g2 endp;��室 AL-��ன ������⥫�� �������, �᫨ -1 ��� ���� ������⥫���
end start