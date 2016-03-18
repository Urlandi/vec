.model tiny
.data
 n db '1st.1x1',0
.code
.startup
mov ah,3dh
mov dx,offset n
xor al,al
int 21h

mov bx,ax
mov ah,42h
xor cx,cx
xor dx,dx
xor al,al
int 21h

mov ax,0b800h
mov ds,ax
xor dx,dx
mov ah,3fh
mov cx,0fa0h
int 21h

mov ah,3eh
int 21h




xor ah,ah
int 16h
.exit
end