.model tiny
.code
.startup
;�஢��� ���� �� �� ����� �� 1�h
        mov al,1ch
        mov ah,35h
        int 21h
        mov ah,es:[bx]
        cmp ah,0cfh
        jne endmy_program
;���塞 ����� 1�h � ��⠢�塞 ��ப� १����⭮
        mov ax,cs
        mov ds,ax
        mov dx,offset stroka
        mov ah,25h
        mov al,1ch
        int 21h
        mov dx,384h
        int 27h
endmy_program:
.exit 0
;��楤�� ��ࠡ�⪨ 1�h
 stroka proc
        mov tempax,ax
        mov tempbx,bx
        mov tempes,es
        mov tempbp,bp
        mov tempsi,si
        inc speed
        cmp speed,2h
 jb     rungo
        mov speed,00h
        mov ax,0b800h
        mov es,ax
        mov si,teknach
        xor bp,bp
 elsego:
        mov bh,cs:symbols[si]
        mov es:[bp],bh
        mov es:[bp+1h],1fh
        add bp,2h
        inc si
        mov ax,teknach
        add ax,4fh
        cmp si,ax
 jbe elsego
        inc teknach
        cmp teknach,19ah
 jbe rungo
        mov teknach,00h
 rungo:
        mov es,tempes
        mov bp,tempbp
        mov ax,tempax
        mov si,tempsi
        mov bx,tempbx
        iret
 speed           db ?
 tempbx          dw ?
 tempax          dw ?
 tempes          dw ?
 tempbp          dw ?
 tempsi          dw ?
 teknach         dw ?
 symbols         db '                                                                                '
                 db '�ਢ��,�ਢ��,�ਢ��!!!��㦥�� �� � ᤥ���?!�� ��� �� �'
                 db '�࠭��!!!��� �ࠢ���� ��!!!��� ⮦�!!!�ࠢ�� ����� ���'
                 db '����� ��������,�� ��祣� ���������� ���� �� �뫮 �� ��'
                 db '��� �����.� � ���� ���殢 �� ����� �� ��.����� 18.0'
                 db '0 5 ������ 1998 ���� �������� ��� ���� ��ᯮ�� �������'
                 db '��� �த,஦������ �����,����� ����� ������ ���...'
                 db '                                                                                '
 stroka endp
end
