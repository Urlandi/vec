.model tiny
.code
.startup

 mov ah,35h
 mov al,21h
 int 21h
 mov c,es
 mov i,bx


 mov ah,25h
 mov al,21h
 mov dx,offset locked
 int 21h

 mov dx,121h
 int 27h



locked proc
 cmp ah,0eh
je n
r:
 jmp dword ptr cs:i
n:
 cmp dl,03h
jne r
 iret
i dw 0h
c dw 0h
locked endp
end