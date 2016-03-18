.model tiny
.data
 er_mes1        db 'Не заданы параметры',10,13
                db 'Используйте:',10,13
                db '-i для установки',10,13,'-r для выгрузки из памяти',10,13,'$'
 er_mes2        db 'Программа уже находится в памяти',10,13,'$'
 er_mes3        db 'Не могу удалить программу из памяти',10,13,'$'
 end_mes        db 5 dup(9),'(c) 1999,Screen text grabber by Michael',10,13,'$'
 sv             db '\screen'
.code
.startup
jmp star
t               db 0
o_ip            dw 0
o_cs            dw 0
ok_ip           dw 0
ok_cs           dw 0
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mainactiv       proc
                push ax
                push ds
                push bx
                push dx
                push cx
                push es


                cmp cs:t,0ffh
jne ioe
                mov cs:t,0h
ns:
                mov si,cs:sm
                xor ax,ax
                mov al,cs:c
                mov bh,10
                div bh
                add al,48
                mov cs:[si],al
                add ah,48
                mov cs:[si+1],ah

                mov cs:[si+2],'s.'
                mov cs:[si+4],'va'
stra:
                mov ax,cs
                mov ds,ax
                mov dx,offset namef
                mov ah,5bh
                xor cx,cx
                pushf
                call dword ptr cs:o_ip
jc nn
                push ax

                mov bx,ax
                mov ax,0b800h
                mov ds,ax
                xor dx,dx
                mov cx,4000
                mov ah,40h
                pushf
                call dword ptr cs:o_ip

                pop ax
                mov bx,ax
                mov ah,3eh
                pushf
                call dword ptr cs:o_ip

                add cs:c,1
ioe:
                pop es
                pop cx
                pop dx
                pop bx
                pop ds
                pop ax

                cmp ax,3030h
jne eall
                cmp bx,ax
jne eall
                cmp cx,bx
jne eall
                cmp dx,cx
jne eall
                mov ax,'mi'
                mov bx,offset o_ip
                mov dx,cs
iret
eall:
                clc
jmp dword ptr cs:o_ip

nn:
                add cs:c,1
                cmp cs:c,99
jbe t5
jmp o5
t5:
jmp ns
o5:
jmp ioe
namef           db 80 dup(0)
c               db 0
sm              dw 0
mainactiv       endp
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rmg             proc
                in al,60h
                cmp al,88
jne o
                mov cs:t,0ffh
o:
jmp dword ptr cs:ok_ip
rmg             endp
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

star:
                mov si,82h
                mov al,es:[si]
                cmp al,00h
                je t1
jmp o1
t1:
jmp er1
o1:
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
n1:
                mov al,es:[si]
                cmp al,'-'
je che1
                inc si
                cmp si,100h
jbe n1
                cmp ah,00
je t2
jmp o2
t2:
jmp er1
o2:
jmp f1

che1:
                inc si
                mov al,es:[si]
                cmp al,'i'
jne m1
jmp f1
m1:
                cmp al,'r'
jne t3
jmp o3
t3:
jmp er1
o3:
                mov ax,3030h
                mov bx,ax
                mov cx,bx
                mov dx,cx
                int 21h
                cmp ax,'mi'
jne er2
                push dx
                push bx

                mov ah,35h
                mov al,21h
                int 21h
                mov ax,es
                cmp ax,dx
jne er2
                mov ah,35h
                mov al,09h
                int 21h
                mov ax,es
                cmp ax,dx
jne er2
                pop bx
                pop dx
                mov es,dx
                mov dx,es:[bx]
                mov ds,es:[bx+2]
                mov al,21h
                mov ah,25h
                int 21h

                mov dx,es:[bx+4]
                mov ds,es:[bx+6]
                mov al,09h
                mov ah,25h
                int 21h

                push es
                mov bx,2ch
                mov es,es:[bx]
                mov ah,49h
                int 21h

                pop es
                mov ah,49h
                int 21h
jmp en
er2:
                mov ax,cs
                mov ds,ax
                mov ah,09h
                mov dx,offset er_mes3
                int 21h
jmp en

f1:
                mov ax,3030h
                mov bx,ax
                mov cx,bx
                mov dx,cx
                int 21h

                cmp ax,'mi'
je er3

                mov ah,19h
                int 21h

                add al,65
                mov namef,al
                mov si,offset namef
                mov ds:[si+1],'\:'

                add si,3
                mov dl,0
                mov ah,47h
                int 21h

                mov si,offset namef
n3:
                mov al,ds:[si]
                cmp al,0
je che3
                inc si
jmp n3
che3:
                mov di,si
                mov si,offset sv
                mov cx,7
                cld
rep             movsb
                mov sm,di

                mov ah,35h
                mov al,21h
                int 21h
                mov o_cs,es
                mov o_ip,bx

                mov ah,25h
                mov al,21h
                mov dx,offset mainactiv
                int 21h



                mov ah,35h
                mov al,09h
                int 21h
                mov ok_cs,es
                mov ok_ip,bx

                mov ah,25h
                mov al,09h
                mov dx,offset rmg
                int 21h

                mov ah,09h
                mov dx,offset end_mes
                int 21h

                mov dx,220h
                int 27h

er3:
                mov ah,09h
                mov dx,offset er_mes2
                int 21h
jmp en
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
er1:
                mov ah,09h
                mov dx,offset er_mes1
                int 21h
en:
                mov ax,cs
                mov ds,ax
                mov ah,09h
                mov dx,offset end_mes
                int 21h

.exit 0
end