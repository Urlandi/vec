;Даны два массива 5 и 4 элемента. Если второй положительный элемент первого
;массива больше второго положительного элемента второго массива, то
;переписать оба массива на диск, если нет обменять массивы местами.
.model tiny
.code
org 100h
start:jmp go
mass1 db -1,2,1,-4,5
mass2 db 1,2,3,4
rsrv  db ?
ermsg db 'Произошла ошибка выполнения программы, работа прервана$'
go:   lea si,mass1
      mov di,si
      mov cl,5
      call g2
      cmp al,-1
      je er
      mov ah,al
      lea si,mass2
      mov cl,4
      call g2
      cmp al,-1
      je er
      cmp ah,al
      ja wdisk

      mov cl,5

C:    mov al,[di]
      mov ah,[di+5]
      mov [di],ah
      mov [di+5],al
      inc di
      dec cl
      jnz C
      jmp q

wdisk:mov ax,0301h
      xor dx,dx
      mov cx,01h
      lea bx,mass1
      int 13h ;Запись 0 головка, 0 дорожка, 1 сектор
      jnc q

er:   mov ah,09h
      lea dx,ermsg
      int 21h
q:    int 20h

g2 proc;Вход SI-адрес массива CL-его длина
        XOR CH,CH         ;Обнуляем счетчик положительных элементов
        CLD               ;Адреса возрастают
LC:     LODSB             ;AL=элемент из массива по адресу SI. SI=SI+1
        CMP AL,0          ;Проверка на положительный
        JS NC             ;Прыжок если отрицательный

        INC CH            ;Увеличиваем счетчик положительных
        CMP CH,2          ;Проверяем на второй положительный
        JE  TRUES2        ;Прыжок если второй положительный

NC:     LOOP LC           ;Повторяем пока CX>0
        mov al,-1
trues2: ret
g2 endp;Выход AL-второй положительный элемент, если -1 нет двух положительных
end start