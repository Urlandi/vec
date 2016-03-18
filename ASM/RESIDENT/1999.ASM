.model tiny
.code
.startup

 mov al,1ch
 mov ah,35h
 int 21h

 mov al,es:[bx]
 cmp al,0cfh
 jne ext

 mov ax,cs
 mov ds,ax
 mov dx,offset ny
 mov ah,25h
 mov al,1ch
 int 21h

 mov dx,210h
 int 27h
ext:
.exit
ny proc
 push es
 push si
 push di
 push ax

 xor di,di
 mov ax,0b800h
 mov es,ax

next:
    mov al,es:[di]
    mov n99[0],al

    mov al,es:[di+2]
    mov n99[1],al

    mov al,n99[0]
    cmp al,39h
jne error

    mov al,n99[1]
    cmp al,38h
jne error

    mov al,es:[di+4]
    mov es:[di+2],'9'
    mov es:[di+3],1eh
    mov es:[di+4],al
    add di,04h

    xor si,si
go:
    add di,02h
    mov al,cs:stroka[si]
    mov es:[di],al
    mov es:[di+1],1eh
    inc si
    cmp si,08h
jbe go
error:
   add di,02h
   cmp di,0fa0h
jbe next

 pop ax
 pop di
 pop si
 pop es
iret
stroka db 'NEW year!'
n99    db 02h dup(?)
ny endp
end