.model tiny
.code
.startup
jmp gop
modf proc
       push es
       push di
       push si
       push ax

       mov ax,0b800h
       mov es,ax
       xor di,di
next1:
       mov al,es:[di]
       xor si,si
next2:
       cmp al,cs:angl[si]
jne n
       mov al,cs:russ[si]
       mov es:[di],al
       jmp r
n:
       inc si
       cmp si,51
jbe next2
r:
       inc di
       inc di
       cmp di,4000
jbe next1

       pop ax
       pop si
       pop di
       pop es
iret
angl db 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
russ db '€–„…”ƒ•†‹“‘’‚‚•“‡ ΅ζ¤¥δ£ε¨¦ª«¬­®―γΰαβξΆΆεγ§'
modf endp
gop:
   mov ah,35h
   mov al,1ch
   int 21h

   mov al,es:[bx]
   cmp al,0cfh

je t
.exit 1
t:

   mov ah,25h
   mov al,1ch
   mov dx,offset modf
   int 21h

   mov dx,191h
   int 27h

.exit 0h
end