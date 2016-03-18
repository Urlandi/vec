;Лабораторная работа #2 по предмету "Операционные системы" вариант задания #4
;Программа при запуске запрашивает имя файла, после чего запрещает любые
;операции над этим файлом, возвращая  фоновой программе код ошибки. Повторный
;запуск с новым именем добавляет файл в список закрытых. Повторный запуск с
;тем же именем снимает запрет для этого файла.

ferk            equ 20 ;Максимальное количество блокированных файлов
.model tiny
.data

;Сообщения об ошибках++++++++++++++++++++++++++++++++++++++++++++++++++++++++
er_mes1         db 'Параметры заданы неверно!',10,13
                db 'Используйте:',10,13
                db '<имя_файла> для блокировки \ снятия блокировки (повторно).'
                db 10,13,'$'
er_mes2         db 'Список блокированных полон! Вызов игнорирован!',10,13,'$'

;Сообщение при выходе из программы+++++++++++++++++++++++++++++++++++++++++++
end_mes1        db 'Программа успешно установлена в памяти.',10,13
end_mes         db '(c) 2003 SHESS PyRE Std.',10,13,'$'
end_mes3        db 'Файл добавлен в список блокированных.',10,13,'$'
end_mes5        db 'Программа деинсталирована из памяти.',10,13
end_mes4        db 'Файл успешно удалён из списка блокированных.',10,13,'$'

.code
.startup
entry_point:    jmp _init       ;Переход на блок инициализации

signature       dw 'DO'         ;Чтобы определить что мы в памяти
count_files     db 0            ;Кол-во блокированных файлов
files_buffer    dd ferk dup(0)  ;Буффер блокированных файлов
filekod         dd 0            ;Текущая переменная для обработки тэга файла
errflag         db 0            ;Флаг - произошло обращение к блокированному

;Адреса старого обработчика 33 прерывания++++++++++++++++++++++++++++++++++++
i            dw 0h
c            dw 0h

;Буффер для сохранения используемых регистров - чтобы нетревожить стэк+++++++
saveDI       dw 0
saveSI       dw 0
saveAX       dw 0
saveCX       dw 0
saveDX       dw 0
saveES       dw 0
saveBX       dw 0

;Вычисляем смещения для обращения из блока инсталляции к резидентной копии+++
_signature   equ $-signature
_files_buffer equ $-files_buffer
_count_files  equ $-count_files
_i            equ $-i
_c            equ $-c

;Наш обработчик 33 прерывания++++++++++++++++++++++++++++++++++++++++++++++++
locked      proc

            cli                         ;Запрещаем вызов прерываний

;Сохраняем используемые регистры+++++++++++++++++++++++++++++++++++++++++++++
            mov cs:saveDI,di
            mov cs:saveSI,si
            mov cs:saveAX,ax
            mov cs:saveDX,dx
            mov cs:saveCX,cx
            mov cs:saveES,es
            mov cs:saveBX,bx

;Файловая функция или функция расширенной обработки ошибки - обработка+++++++
            cmp ah,3ch
            je lockF
            cmp ah,3dh
            je lockF
            cmp ah,5bh
            je lockF
            cmp ah,6ch
            je lockF1
            cmp ah,41h
            je lockF
            cmp ax,4b00h
            je lockF
            cmp ax,4b01h
            je lockF
            cmp ax,4b03h
            je lockF
            cmp ah,4eh
            je lockF
            cmp ah,43h
            je lockF
            cmp ah,56h
            je lockF
            cmp ah,59h

;Вызываем стандартный обработчик 33 прерывания+++++++++++++++++++++++++++++++
            jne Lfakeerror
            jmp fakeerror
Lfakeerror: jmp std33

;Блок проверки на соответствие блокированного и вызванного файлов++++++++++++
lockF:      mov si,dx
lockF1:     mov ax,cs
            mov es,ax
            mov di,offset filekod
            call cs:name_to_int         ;Получаем тэг-код вызванного файла

            mov cl,cs:count_files       ;Считываем кол-во блокированных
            xor di,di                   ;Настраиваем смещение для чтения


;Читаем тэг-код очередного файла из списка и сравниваем с вызванным
repoF:      mov ax,word ptr cs:files_buffer[di]
            mov dx,word ptr cs:filekod
            cmp ax,dx
            jne notyetF

            mov ax,word ptr cs:files_buffer[di+2]
            mov dx,word ptr cs:filekod[2]
            cmp ax,dx
            je ZergoNaftF   ;Совпадение

notyetF:    add di,4
            dec cl
            jnz repoF
            jmp  std33      ;Нет совпадений



ZergoNaftF: pop ax              ;Мы должны возвратить программе CF=1, но
            pop dx              ;команда iret затирает наши флаги, поэтому
            pop cx              ;прочитываем из стэка 3-е слово - флаги
            or cx,1             ;вызвавшей нас программы и устанавливаем CF=1
            push cx             ;после чего всё возвращаем на место
            push dx
            push ax

;Восстанавливаем используемые регистры+++++++++++++++++++++++++++++++++++++++
            mov di,cs:saveDI
            mov si,cs:saveSI
            mov ax,cs:saveAX
            mov dx,cs:saveDX
            mov cx,cs:saveCX
            mov es,cs:saveES
            mov bx,cs:saveBX

            mov cs:errflag,1    ;Сообшаем 59h что у нас была ошибка
            mov ax,5            ;Возвращаем код ошибки - блокирован
            sti                 ;Разрешаем прерывания
            iret                ;Выходим из прерывания

;Восстанавливаем используемые регистры+++++++++++++++++++++++++++++++++++++++
std33:      mov di,cs:saveDI
            mov si,cs:saveSI
            mov ax,cs:saveAX
            mov dx,cs:saveDX
            mov cx,cs:saveCX
            mov es,cs:saveES
            mov bx,cs:saveBX

            sti                 ;Разрешаем прерывания
            jmp dword ptr cs:i  ;Вызываем стандартное

;Обрабатываем прерывание 59h - расширенное сообщение об ошибке+++++++++++++++
fakeerror:  mov al,cs:errflag
            and al,al
            jz std33
            mov cs:errflag,0            ;Если флаг ошибки взведен
            mov ax,33                   ;Возвращаем расширенное сообщение
            mov bx,0201h                ;об ошибке внешней программе
            mov ch,2

;Восстанавливаем используемые регистры+++++++++++++++++++++++++++++++++++++++
            mov di,cs:saveDI
            mov si,cs:saveSI
            mov dx,cs:saveDX
            mov bx,cs:saveBX

            sti                ;Разрешаем прерывания
            iret               ;Выходим из прерывания

locked      endp

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;Вход DS:[SI] - адрес строки полное имя файла ASCIIZ
;Выход ES:[SI] двойное слово - код файла
name_to_int proc

            mov bx,si                   ;Сохраняем

;Находим последний символ строки+++++++++++++++++++++++++++++++++++++++++++++
while0:     mov al,ds:[si]
            inc si
            and al,al
            jnz while0
            xor cl,cl
            dec si
            dec si

;Обнуляем приемник+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            mov word ptr es:[di],0
            mov word ptr es:[di+2],0

;Переводим строку из строкового представления в цифровое+++++++++++++++++++++
dig128:     xor ah,ah
            mov al,ds:[si]      ;Читаем очередной символ

;Если имя файла содержит путь до него то отсекаем все лишнее+++++++++++++++++
            cmp al,'\'
            je result
            cmp al,':'
            je result
            cmp al,' '
            je result


;Переводим строку в код следующим образом F=sn*2^n+...+s2*2^2+s1*2^1+s0*2^0
            mov dx,ax
            shl ax,cl
            mov ch,16
            sub ch,cl
            xchg cl,ch
            shr dx,cl
            add es:[di],ax
            jnc zer_good
            inc dx
zer_good:   add es:[di+2],dx
            mov cl,ch
            inc cl
            cmp bx,si
            je result
            dec si
            jmp dig128

result:     ret
name_to_int endp
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
tsr_length      equ $-entry_point     ;Длина резидентной части

_init:          mov si,80h             ;Выбираем параметры из PSP
                mov cl,[si]            ;Если командная строка пуста
                inc si
                and cl,cl              ;то мы прекращаем обработку и
                jne mem_install        ;уходим на обработку
                mov dx,offset er_mes1  ;первой ошибки
                jmp error


;Код установки резидента в память++++++++++++++++++++++++++++++++++++++++++++
mem_install:    mov di,si                 ;Заданную строку параметров
                xor ch,ch                 ;переводим в ASCIIZ строку
                add di,cx
                mov byte ptr [di],0

                mov ax,3521h              ;С помощью функции ДОС получаем
                int 21h                   ;адрес вектора прерывания 33
                mov ax,signature          ;Проверяем есть ли по этому адресу
                cmp ax,es:[bx-_signature] ;наша подпись
                je  filesblock            ;Если есть то уходим на проверку
                                          ;блокированных файлов

;Устанавливаем тэг-код файла в буфер под номером 1+++++++++++++++++++++++++++
                push es
                mov ax,ds
                mov es,ax
                mov di,offset files_buffer
                push bx
                call name_to_int
                pop bx
                pop es

                mov i,bx               ;Сохраняем значения адреса заменяемой
                mov c,es               ;процедуры прерывания

                mov si,2Ch             ;Получаем значение адреса буфера с
                mov ax,[si]            ;переменными окружения ДОС для нашей
                mov es,ax              ;программы
                mov ah,49h             ;Освобождаем занимаемое буфером место
                int 21h

                mov ax,2521h            ;Устанавливаем новый обработчик
                mov dx,offset locked    ;прерывания 33
                int 21h

                mov ah,09h              ;Финальное сообщение
                mov dx,offset end_mes1
                int 21h

                mov cl,count_files      ;Увеличиваем счетчик блокированных
                inc cl                  ;на 1
                mov count_files,cl

                mov dx,100h+tsr_length  ;Выходим и остаемся резидентно
                int 27h
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
filesblock:     push es
                mov ax,ds
                mov es,ax
                mov di,offset filekod
                push bx
                call name_to_int             ;Вычисляем тэг-код имени файла
                pop bx
                pop es

                mov cl,es:[bx-_count_files]  ;Счетчик=кол-во блок файлов

                mov di,bx                    ;di=базовый адрес для счета

;Читаем тэги файлов из буффера и сравниваем с заданным в ком. строке+++++++++
repo:           mov ax,es:[di-_files_buffer]
                mov dx,word ptr filekod
                cmp ax,dx
                jne notyet

                mov ax,es:[di-_files_buffer+2]
                mov dx,word ptr filekod[2]
                cmp ax,dx
                je ZergoNaft                 ;Совпадение

notyet:         add di,4
                dec cl
                jnz repo

                mov cl,es:[bx-_count_files] ;Нет совпадений
                cmp cl,ferk                 ;Если буфер не полон
                jne set_file                ;выполнить установку файла
                mov dx,offset er_mes2       ;иначе вызвать ошибку
                jmp error

set_file:       mov ax,word ptr filekod             ;Записываем файл в буфер
                mov es:[di-_files_buffer],ax        ;на последнее место
                mov ax,word ptr filekod[2]
                mov es:[di-_files_buffer+2],ax
                inc cl                              ;Увеличиваем кол-во
                mov es:[bx-_count_files],cl         ;блокированных файлов

                mov dx,offset end_mes3              ;Завершаем выполнение
                jmp error

ZergoNaft:      xor cx,cx                         ;Расчитываем смещение
                mov cl,es:[bx-_count_files]       ;последнего тэга
                mov si,cx
                shl si,1
                shl si,1
                add si,bx
                sub si,4
                mov ax,es:[si-_files_buffer]     ;Переносим его на текущий
                mov es:[di-_files_buffer],ax
                mov ax,es:[si-_files_buffer+2]
                mov es:[di-_files_buffer+2],ax

                mov word ptr es:[si-_files_buffer],0   ;Обнуляем последний
                mov word ptr es:[si-_files_buffer+2],0

                mov cl,es:[bx-_count_files]          ;Уменьшаем счетчик
                dec cl                               ;блокированных
                mov es:[bx-_count_files],cl
                and cx,cx                            ;Если нет блокированных
                jz mem_deinstall                     ;то деинсталируем
                mov dx,offset end_mes4
                jmp error



;Код удаления резидента из памяти++++++++++++++++++++++++++++++++++++++++++++
mem_deinstall:  mov ax,3521h            ;Получаем вектор прерывания 33
                int 21h


                push ds                 ;Сохраняем на время

                mov ax,es:[bx-_c]       ;Восстанавливаем старые значения
                mov ds,ax               ;вектора прерывания
                mov dx,es:[bx-_i]
                mov ax,2521h
                int 21h

                pop ds                  ;Восстанавливаем

                mov ah,49h              ;Освобождаем память занимаемую
                int 21h                 ;нашим обработчиком

                mov ax,ds               ;Восстанавливаем ES
                mov es,ax

                                        ;Выводим сообщение об успешной
                mov dx,offset end_mes5  ;выгрузке

error:          mov ah,09h              ;Сообщения об ошибках
                int 21h

end_prg:        mov ah,09h              ;Финальное сообщение
                mov dx,offset end_mes
                int 21h

.exit                                   ;Выход
end

