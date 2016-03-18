.model tiny
.data
 krest db 0,10h,10h,10h,10h,07ch,10h,10h,50h,30h,18h,14h,10h,10h,10h,00h
 np    db '(c) 1999 Michael',10,13,'$'
.code
.startup

xor ah,ah
mov al,03h
int 10h

mov ah,11h
mov al,30h
mov bh,06h
int 10h

push es
push bp
xor bx,bx

c:
mov di,bp
add di,0b30h
add di,bx
mov si,offset krest
mov cx,10h
cld
rep movsb

add bx,10h
cmp bx,280h
jb  c

pop bp
pop es

mov ah,11h
mov al,10h
mov cx,256
xor dx,dx
xor bl,bl
mov bh,10h
int 10h

mov ah,09h
mov dx,offset np
int 21h

ret
end