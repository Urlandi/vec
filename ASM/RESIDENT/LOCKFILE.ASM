;������ୠ� ࠡ�� #2 �� �।���� "����樮��� ��⥬�" ��ਠ�� ������� #4
;�ணࠬ�� �� ����᪥ ����訢��� ��� 䠩��, ��᫥ 祣� ����頥� ���
;����樨 ��� �⨬ 䠩���, �������  䮭���� �ணࠬ�� ��� �訡��. ������
;����� � ���� ������ �������� 䠩� � ᯨ᮪ ��������. ������ ����� �
;⥬ �� ������ ᭨���� ����� ��� �⮣� 䠩��.

ferk            equ 20 ;���ᨬ��쭮� ������⢮ �����஢����� 䠩���
.model tiny
.data

;����饭�� �� �訡���++++++++++++++++++++++++++++++++++++++++++++++++++++++++
er_mes1         db '��ࠬ���� ������ ����୮!',10,13
                db '�ᯮ����:',10,13
                db '<���_䠩��> ��� �����஢�� \ ���� �����஢�� (����୮).'
                db 10,13,'$'
er_mes2         db '���᮪ �����஢����� �����! �맮� �����஢��!',10,13,'$'

;����饭�� �� ��室� �� �ணࠬ��+++++++++++++++++++++++++++++++++++++++++++
end_mes1        db '�ணࠬ�� �ᯥ譮 ��⠭������ � �����.',10,13
end_mes         db '(c) 2003 SHESS PyRE Std.',10,13,'$'
end_mes3        db '���� �������� � ᯨ᮪ �����஢�����.',10,13,'$'
end_mes5        db '�ணࠬ�� �����⠫�஢��� �� �����.',10,13
end_mes4        db '���� �ᯥ譮 㤠�� �� ᯨ᪠ �����஢�����.',10,13,'$'

.code
.startup
entry_point:    jmp _init       ;���室 �� ���� ���樠����樨

signature       dw 'DO'         ;�⮡� ��।����� �� �� � �����
count_files     db 0            ;���-�� �����஢����� 䠩���
files_buffer    dd ferk dup(0)  ;����� �����஢����� 䠩���
filekod         dd 0            ;������ ��६����� ��� ��ࠡ�⪨ ���� 䠩��
errflag         db 0            ;���� - �ந��諮 ���饭�� � �����஢������

;���� ��ண� ��ࠡ��稪� 33 ���뢠���++++++++++++++++++++++++++++++++++++
i            dw 0h
c            dw 0h

;����� ��� ��࠭���� �ᯮ��㥬�� ॣ���஢ - �⮡� ���ॢ����� ����+++++++
saveDI       dw 0
saveSI       dw 0
saveAX       dw 0
saveCX       dw 0
saveDX       dw 0
saveES       dw 0
saveBX       dw 0

;����塞 ᬥ饭�� ��� ���饭�� �� ����� ���⠫��樨 � १����⭮� �����+++
_signature   equ $-signature
_files_buffer equ $-files_buffer
_count_files  equ $-count_files
_i            equ $-i
_c            equ $-c

;��� ��ࠡ��稪 33 ���뢠���++++++++++++++++++++++++++++++++++++++++++++++++
locked      proc

            cli                         ;����頥� �맮� ���뢠���

;���࠭塞 �ᯮ��㥬� ॣ�����+++++++++++++++++++++++++++++++++++++++++++++
            mov cs:saveDI,di
            mov cs:saveSI,si
            mov cs:saveAX,ax
            mov cs:saveDX,dx
            mov cs:saveCX,cx
            mov cs:saveES,es
            mov cs:saveBX,bx

;�������� �㭪�� ��� �㭪�� ���७��� ��ࠡ�⪨ �訡�� - ��ࠡ�⪠+++++++
            cmp ah,3ch
            je lockF
            cmp ah,3dh
            je lockF
            cmp ah,5bh
            je lockF
            cmp ah,6ch
            je lockF1
            cmp ah,41h
            je lockF
            cmp ax,4b00h
            je lockF
            cmp ax,4b01h
            je lockF
            cmp ax,4b03h
            je lockF
            cmp ah,4eh
            je lockF
            cmp ah,43h
            je lockF
            cmp ah,56h
            je lockF
            cmp ah,59h

;��뢠�� �⠭����� ��ࠡ��稪 33 ���뢠���+++++++++++++++++++++++++++++++
            jne Lfakeerror
            jmp fakeerror
Lfakeerror: jmp std33

;���� �஢�ન �� ᮮ⢥��⢨� �����஢������ � �맢������ 䠩���++++++++++++
lockF:      mov si,dx
lockF1:     mov ax,cs
            mov es,ax
            mov di,offset filekod
            call cs:name_to_int         ;����砥� ���-��� �맢������ 䠩��

            mov cl,cs:count_files       ;���뢠�� ���-�� �����஢�����
            xor di,di                   ;����ࠨ���� ᬥ饭�� ��� �⥭��


;��⠥� ���-��� ��।���� 䠩�� �� ᯨ᪠ � �ࠢ������ � �맢����
repoF:      mov ax,word ptr cs:files_buffer[di]
            mov dx,word ptr cs:filekod
            cmp ax,dx
            jne notyetF

            mov ax,word ptr cs:files_buffer[di+2]
            mov dx,word ptr cs:filekod[2]
            cmp ax,dx
            je ZergoNaftF   ;����������

notyetF:    add di,4
            dec cl
            jnz repoF
            jmp  std33      ;��� ᮢ�������



ZergoNaftF: pop ax              ;�� ������ �������� �ணࠬ�� CF=1, ��
            pop dx              ;������� iret ���ࠥ� ��� 䫠��, ���⮬�
            pop cx              ;����뢠�� �� ����� 3-� ᫮�� - 䫠��
            or cx,1             ;�맢��襩 ��� �ணࠬ�� � ��⠭�������� CF=1
            push cx             ;��᫥ 祣� ��� �����頥� �� ����
            push dx
            push ax

;����⠭�������� �ᯮ��㥬� ॣ�����+++++++++++++++++++++++++++++++++++++++
            mov di,cs:saveDI
            mov si,cs:saveSI
            mov ax,cs:saveAX
            mov dx,cs:saveDX
            mov cx,cs:saveCX
            mov es,cs:saveES
            mov bx,cs:saveBX

            mov cs:errflag,1    ;����蠥� 59h �� � ��� �뫠 �訡��
            mov ax,5            ;�����頥� ��� �訡�� - �����஢��
            sti                 ;����蠥� ���뢠���
            iret                ;��室�� �� ���뢠���

;����⠭�������� �ᯮ��㥬� ॣ�����+++++++++++++++++++++++++++++++++++++++
std33:      mov di,cs:saveDI
            mov si,cs:saveSI
            mov ax,cs:saveAX
            mov dx,cs:saveDX
            mov cx,cs:saveCX
            mov es,cs:saveES
            mov bx,cs:saveBX

            sti                 ;����蠥� ���뢠���
            jmp dword ptr cs:i  ;��뢠�� �⠭���⭮�

;��ࠡ��뢠�� ���뢠��� 59h - ���७��� ᮮ�饭�� �� �訡��+++++++++++++++
fakeerror:  mov al,cs:errflag
            and al,al
            jz std33
            mov cs:errflag,0            ;�᫨ 䫠� �訡�� �������
            mov ax,33                   ;�����頥� ���७��� ᮮ�饭��
            mov bx,0201h                ;�� �訡�� ���譥� �ணࠬ��
            mov ch,2

;����⠭�������� �ᯮ��㥬� ॣ�����+++++++++++++++++++++++++++++++++++++++
            mov di,cs:saveDI
            mov si,cs:saveSI
            mov dx,cs:saveDX
            mov bx,cs:saveBX

            sti                ;����蠥� ���뢠���
            iret               ;��室�� �� ���뢠���

locked      endp

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;�室 DS:[SI] - ���� ��ப� ������ ��� 䠩�� ASCIIZ
;��室 ES:[SI] ������� ᫮�� - ��� 䠩��
name_to_int proc

            mov bx,si                   ;���࠭塞

;��室�� ��᫥���� ᨬ��� ��ப�+++++++++++++++++++++++++++++++++++++++++++++
while0:     mov al,ds:[si]
            inc si
            and al,al
            jnz while0
            xor cl,cl
            dec si
            dec si

;����塞 �ਥ����+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            mov word ptr es:[di],0
            mov word ptr es:[di+2],0

;��ॢ���� ��ப� �� ��ப����� �।�⠢����� � ��஢��+++++++++++++++++++++
dig128:     xor ah,ah
            mov al,ds:[si]      ;��⠥� ��।��� ᨬ���

;�᫨ ��� 䠩�� ᮤ�ন� ���� �� ���� � ��ᥪ��� �� ��譥�+++++++++++++++++
            cmp al,'\'
            je result
            cmp al,':'
            je result
            cmp al,' '
            je result


;��ॢ���� ��ப� � ��� ᫥���騬 ��ࠧ�� F=sn*2^n+...+s2*2^2+s1*2^1+s0*2^0
            mov dx,ax
            shl ax,cl
            mov ch,16
            sub ch,cl
            xchg cl,ch
            shr dx,cl
            add es:[di],ax
            jnc zer_good
            inc dx
zer_good:   add es:[di+2],dx
            mov cl,ch
            inc cl
            cmp bx,si
            je result
            dec si
            jmp dig128

result:     ret
name_to_int endp
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
tsr_length      equ $-entry_point     ;����� १����⭮� ���

_init:          mov si,80h             ;�롨ࠥ� ��ࠬ���� �� PSP
                mov cl,[si]            ;�᫨ ��������� ��ப� ����
                inc si
                and cl,cl              ;� �� �४�頥� ��ࠡ��� �
                jne mem_install        ;�室�� �� ��ࠡ���
                mov dx,offset er_mes1  ;��ࢮ� �訡��
                jmp error


;��� ��⠭���� १����� � ������++++++++++++++++++++++++++++++++++++++++++++
mem_install:    mov di,si                 ;�������� ��ப� ��ࠬ��஢
                xor ch,ch                 ;��ॢ���� � ASCIIZ ��ப�
                add di,cx
                mov byte ptr [di],0

                mov ax,3521h              ;� ������� �㭪樨 ��� ����砥�
                int 21h                   ;���� ����� ���뢠��� 33
                mov ax,signature          ;�஢��塞 ���� �� �� �⮬� �����
                cmp ax,es:[bx-_signature] ;��� �������
                je  filesblock            ;�᫨ ���� � �室�� �� �஢���
                                          ;�����஢����� 䠩���

;��⠭�������� ���-��� 䠩�� � ���� ��� ����஬ 1+++++++++++++++++++++++++++
                push es
                mov ax,ds
                mov es,ax
                mov di,offset files_buffer
                push bx
                call name_to_int
                pop bx
                pop es

                mov i,bx               ;���࠭塞 ���祭�� ���� �����塞��
                mov c,es               ;��楤��� ���뢠���

                mov si,2Ch             ;����砥� ���祭�� ���� ���� �
                mov ax,[si]            ;��६���묨 ���㦥��� ��� ��� ��襩
                mov es,ax              ;�ணࠬ��
                mov ah,49h             ;�᢮������� ���������� ���஬ ����
                int 21h

                mov ax,2521h            ;��⠭�������� ���� ��ࠡ��稪
                mov dx,offset locked    ;���뢠��� 33
                int 21h

                mov ah,09h              ;�����쭮� ᮮ�饭��
                mov dx,offset end_mes1
                int 21h

                mov cl,count_files      ;�����稢��� ���稪 �����஢�����
                inc cl                  ;�� 1
                mov count_files,cl

                mov dx,100h+tsr_length  ;��室�� � ��⠥��� १����⭮
                int 27h
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
filesblock:     push es
                mov ax,ds
                mov es,ax
                mov di,offset filekod
                push bx
                call name_to_int             ;����塞 ���-��� ����� 䠩��
                pop bx
                pop es

                mov cl,es:[bx-_count_files]  ;���稪=���-�� ���� 䠩���

                mov di,bx                    ;di=������ ���� ��� ���

;��⠥� ���� 䠩��� �� ����� � �ࠢ������ � ������� � ���. ��ப�+++++++++
repo:           mov ax,es:[di-_files_buffer]
                mov dx,word ptr filekod
                cmp ax,dx
                jne notyet

                mov ax,es:[di-_files_buffer+2]
                mov dx,word ptr filekod[2]
                cmp ax,dx
                je ZergoNaft                 ;����������

notyet:         add di,4
                dec cl
                jnz repo

                mov cl,es:[bx-_count_files] ;��� ᮢ�������
                cmp cl,ferk                 ;�᫨ ���� �� �����
                jne set_file                ;�믮����� ��⠭���� 䠩��
                mov dx,offset er_mes2       ;���� �맢��� �訡��
                jmp error

set_file:       mov ax,word ptr filekod             ;�����뢠�� 䠩� � ����
                mov es:[di-_files_buffer],ax        ;�� ��᫥���� ����
                mov ax,word ptr filekod[2]
                mov es:[di-_files_buffer+2],ax
                inc cl                              ;�����稢��� ���-��
                mov es:[bx-_count_files],cl         ;�����஢����� 䠩���

                mov dx,offset end_mes3              ;�����蠥� �믮������
                jmp error

ZergoNaft:      xor cx,cx                         ;�����뢠�� ᬥ饭��
                mov cl,es:[bx-_count_files]       ;��᫥����� ����
                mov si,cx
                shl si,1
                shl si,1
                add si,bx
                sub si,4
                mov ax,es:[si-_files_buffer]     ;��७�ᨬ ��� �� ⥪�騩
                mov es:[di-_files_buffer],ax
                mov ax,es:[si-_files_buffer+2]
                mov es:[di-_files_buffer+2],ax

                mov word ptr es:[si-_files_buffer],0   ;����塞 ��᫥����
                mov word ptr es:[si-_files_buffer+2],0

                mov cl,es:[bx-_count_files]          ;�����蠥� ���稪
                dec cl                               ;�����஢�����
                mov es:[bx-_count_files],cl
                and cx,cx                            ;�᫨ ��� �����஢�����
                jz mem_deinstall                     ;� �����⠫��㥬
                mov dx,offset end_mes4
                jmp error



;��� 㤠����� १����� �� �����++++++++++++++++++++++++++++++++++++++++++++
mem_deinstall:  mov ax,3521h            ;����砥� ����� ���뢠��� 33
                int 21h


                push ds                 ;���࠭塞 �� �६�

                mov ax,es:[bx-_c]       ;����⠭�������� ���� ���祭��
                mov ds,ax               ;����� ���뢠���
                mov dx,es:[bx-_i]
                mov ax,2521h
                int 21h

                pop ds                  ;����⠭��������

                mov ah,49h              ;�᢮������� ������ ����������
                int 21h                 ;��訬 ��ࠡ��稪��

                mov ax,ds               ;����⠭�������� ES
                mov es,ax

                                        ;�뢮��� ᮮ�饭�� �� �ᯥ譮�
                mov dx,offset end_mes5  ;���㧪�

error:          mov ah,09h              ;����饭�� �� �訡���
                int 21h

end_prg:        mov ah,09h              ;�����쭮� ᮮ�饭��
                mov dx,offset end_mes
                int 21h

.exit                                   ;��室
end

