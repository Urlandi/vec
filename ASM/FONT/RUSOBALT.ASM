.model tiny
.data


oldcode db 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
newcode db 'АБКДЕФГХИЖКЛМНОПУРСТЮВВХУЗабкдефгхижклмнопурстюввхуз'
lengthstr  equ $-newcode

np      db '(c) 2001-2003 PyRE STD.,Shes AKA Mirck',10,13
        db 'P.S. VGA or higher ONLY',10,13,'$'

.code
.startup

        mov ah,09h
        mov dx,offset np
        int 21h

        xor ax,ax
        int 16h

rtrnd:  mov ah,11h
        mov al,30h
        mov bh,03h      ;Замена 6
        int 10h

        push es
        push bp

        mov ax,es
        mov ds,ax

        mov bx,lengthstr-1

cr:     mov cl,3        ;Замена 4

        xor ax,ax
        mov al,cs:oldcode[bx]
        shl ax,cl
        mov di,bp
        add di,ax

        xor ax,ax
        mov al,cs:newcode[bx]
        shl ax,cl
        mov si,bp
        add si,ax

        mov cx,4        ;Замена 8

        cld
rep     movsw

        dec bx
        jnz cr

        pop bp
        pop es

        mov ax,1100h
        mov cx,256
        xor dx,dx
        mov bx,0800h    ;Замена 10h
        int 10h

        mov si,110h
        mov cs:[si],byte ptr 6
        mov si,11Dh
        mov cs:[si],byte ptr 4
        mov si,139h
        mov cs:[si],byte ptr 8
        mov si,14Dh
        mov cs:[si],byte ptr 10h
        cmp bx,0800h
        je rtrnd

        ret

end