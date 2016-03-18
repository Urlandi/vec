.model tiny
.code
.startup
             mov ah,00h
             mov al,13h
             int 10h

             mov ax,0a000h
             mov es,ax
             xor di,di

next:
             cmp di,0f8c0h
             jb go
             mov ah,2ch
             int 21h
             xor ax,ax
             mov al,dl
             and di,ax
go:
             inc bx
             cmp bx,1fh
             ja c7
             xor dx,dx
             jmp prun

c7:
             mov dx,0fh
             xor bx,bx

prun:
             mov ax,di
             add ax,140h
run:
             mov es:[di],dx
             inc di
             cmp di,ax
jb run

             in al,60h
             cmp al,128
jbe e
jmp next

e:
             mov ah,00h
             mov al,03h
             int 10h

.exit
end