;Даны две строки символов в которых есь один общий. Найти его индексы в
;первом и втором массивах. Если в первом массиве он имеет бнольший индекс -
;вывести на экран. Если во втором - записать на диск.
        .model tiny
        .code
        org 100h
start:  jmp go
mass1   db '3ро45'
mass2   db '13678'
symb    db ?
outmsg  db 'Не могу произвести запись на диск$'
go:     lea di,mass2
        lea si,mass1
        mov cl,5
c1:     mov ah,[si]
        mov ch,5
c2:         mov al,[di]
            cmp ah,al
            je ec
            inc di
            dec ch
            jnz c2
            sub di,5
        inc si
        dec cl
        jnz c1
ec:     cmp cl,ch
        jb ps
        ja wd
        jmp q
ps:     mov ah,09h
        xor bh,bh
        mov bl,07h
        mov cx,1
        int 10h
        jmp q
wd:     mov symb,al
        mov ax,0301h
        xor dx,dx
        mov cx,01h
        lea bx,symb
        int 13h ;Запись 0 головка, 0 дорожка, 1 сектор
        jnc q
        mov ah,09h
        lea dx,outmsg
        int 21h
q:      int 20h
end     start