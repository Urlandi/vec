.model tiny
.data
     rx dw 0
     ry dw 0
.code
.startup
             mov ax,03h
             int 33h
             mov rx,cx
             mov ry,dx

             mov ah,00h
             mov al,13h
             int 10h

             mov ax,0a000h
             mov es,ax
next:
             mov ax,64000
             call random
             mov di,ax
             push di
             mov ax,04h
             call random
             cmp ax,03h
je w
             mov dx,00h
jmp g
w:
             mov dx,0fh
g:
             pop di
             mov ax,di
             add ax,140h
run:
             mov es:[di],dl
             inc di
             cmp di,ax
jb run
             in al,60h
             cmp al,128
jbe e
             mov ax,03h
             int 33h
             cmp rx,cx
jne e
             cmp ry,dx
jne e
jmp next

e:
             xor ah,ah
             mov al,03h
             int 10h

.exit
RandSeed        dd       0
Random          proc
                mov      cx,ax
                mov      ax,Word ptr cs:[RandSeed+2]
                mov      bx,Word ptr cs:[RandSeed]
                mov      si,ax
                mov      di,bx
                mov      dl,ah
                mov      ah,al
                mov      al,bh
                mov      bh,bl
                xor      bl,bl
                rcr      dl,1
                rcr      ax,1
                rcr      bx,1
                add      bx,di
                adc      ax,si
                add      bx,62e9h
                adc      ax,3619h
                mov      word ptr cs:[RandSeed],bx
                mov      word ptr cs:[RandSeed+2],ax
                xor      dx,dx
                div      cx
                mov      ax,dx
                ret
Random          EndP
end