;Лабораторная работа #1 по предмету "Операционные системы" вариант задания #2
;Программа  выдает на экран и записывает в файл в удобной для восприятия
;форме карту занятых/свободных/дефектных  кластеров  диска  и соответствующих
;им логических и физических секторов.
.model tiny
.data

;Основные сообщения в ходе работы программы++++++++++++++++++++++++++++++++++
main_title             db 'Кластер-карта магнитного гибкого накопителя.'
l_main_title           equ $-main_title
main_status_bar        db 'Выберите магнитный диск для анализа.[ENTER-Выбор,'
                       db 'ESC-Выход]'
l_main_status_bar      equ $-main_status_bar
final_message          db '(c)2003 PyRE Std.'
l_final_message        equ $-final_message
about_message_title    db 'Лабораторная работа #1 по ОС'
l_about_message_title  equ $-about_message_title
about_message_name     db 'Студента 3-его курса ФЭВТ Васильева М.Ю. ИВТ-362 '
                       db '2003г'
l_about_message_name   equ $-about_message_name
about_message_bottom   db 'Assembler Language programm compiled by TASM 4.1'
l_about_message_bottom equ $-about_message_bottom
work_title             db 'Кластер <'
title_cluster          db '0000> Лог.Сектор <'
title_logsector        db '0000> Физ.Сектор <'
title_ph_head          db '0000:'
title_ph_track         db '0000:'
title_ph_sector        db '0000>  Статус <'
l_work_title           equ $-work_title
state_u_message        db 'Занятый>  '
state_f_message        db 'Свободный>'
state_b_message        db 'Сбойный>  '
l_state_message        equ $-state_b_message
state_message_pointer  dw 0
work_status_bar        db '[F1 О...] [ Выбор] [F2 Запись в файл] [F10 '
                       db 'Другой диск] [ESC Выход]'
l_work_status_bar      equ $-work_status_bar
file_id_message        db 'Лабораторная работа #1 по OC',13
                       db 'Выполнил Васильев М.Ю. ИВТ-362 2003г',13
                       db 'AKA PyRE Std.',13
                       db 'Кластер карта гибкого магнитного диска:',13
l_file_id_message      equ $-file_id_message

;Сообщения об ошибках в программе++++++++++++++++++++++++++++++++++++++++++++
error_no_floppy_message  db 34,'В системе нет ни одного дисковода!'
error_bad_floppy_message db 36,'Указанный диск невозможно прочитать!'
error_bad_file_message   db 35,'Невозможно записать указанный файл!'

;Данные о выборе дисковводов и имя файла для записи++++++++++++++++++++++++++
drivers_names          db ' A: ',' B: ',' a: ',' b: '
file_name_buf          db 13,0
file_name              db 13 dup(0)

;Данные о расположении данных на диске и системная информация из BR+++++++++
select_drive           db 0
all_drive              db 0

byte_sector            dw 0
sector_cluster         db 0
cluster_drive          dw 0
sector_track           dw 0
sector_drive           dw 0
head_drive             dw 0

sector_fat             dw 0
fat_start              dw 0
count_fat              db 0
root_enteres           dw 0

;Данные об отабражении данных на экране в ходе работы программы++++++++++++++
start_cluster_show     dw 2
end_cluster_show       dw 1407
position_cluster_show  dw 2
position_logsector     dw 0
view_position          dw 0302h

;Данные о выводе данных в файл++++++++++++++++++++++++++++++++++++++++++++++
position_cluster_showW dw 2
file_handle            dw 0

fat_buffer:            ;Буфер после программы для считывания секторов с диска

.code
.startup

;Видео режим 80х25 16 цветов+++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0003h
                        int 10h

;Не показывать курсор на экране++++++++++++++++++++++++++++++++++++++++++++++
                        mov ah,01h
                        mov ch,20h
                        int 10h

;Очищаем экран фон 7 цвет 15+++++++++++++++++++++++++++++++++++++++++++++++++
reload_programm:        mov ax,0600h
                        xor cx,cx
                        mov dx,184Fh
                        mov bh,7Fh
                        int 10h

;Вывод заголовка+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,1300h
                        mov cx,l_main_title
                        mov dx,19
                        mov bp,offset main_title
                        mov bl,7Fh
                        xor bh,bh
                        int 10h

;Вывод нижней строки экрана+++++++++++++++++++++++++++++++++++++++++++++++++
                        mov cx,l_main_status_bar
                        mov dx,180Ah
                        mov ax,1300h
                        mov bp,offset main_status_bar
                        mov bl,7Fh
                        xor bh,bh
                        int 10h

;Позиционировать курсор строка 25 колонка 0++++++++++++++++++++++++++++++++++
                        mov ah,02h
                        xor bh,bh
                        mov dx,0100h
                        int 10h

;Заполнить экран с 1-ой по 24-ую строку символом ▒+++++++++++++++++++++++++++
                        mov ax,09B1h
                        mov cx,1840
                        mov bx,17h
                        int 10h

;Получаем состояниe оборудования+++++++++++++++++++++++++++++++++++++++++++++
                        int 11h

                        mov dx,ax            ;Сохраняем копию слова состояния
                        and al,1             ;Проверяем 1-ый бит
                        jnz Lerror_no_floppy ;Если нет дисководов
                        jmp error_no_floppy  ;генерируем ошибку

Lerror_no_floppy:       mov ax,dx            ;Восстанавливаем слово состояния
                        mov cl,6             ;Сдвигаем на 6 вправо чтобы
                        shr al,cl            ;Определить кол-во гибких дисков
                        mov all_drive,al     ;Сохраняем в памяти

;Формируем экранное меню выбор диска для обработки+++++++++++++++++++++++++++
;Выводим на экран рамку меню+++++++++++++++++++++++++++++++++++++++++++++++++
                        mov dx,0205h    ;Высота и ширина по умолчанию
                        add dh,al       ;Изменяем высоту по кол-ву дисков
                        push dx
                        mov dx,0A26h    ;Задаем координаты по умолчанию
                        shr al,1        ;Изменяем координату Y
                        sub dh,al       ;По кол-ву дисков, симметрично центра
                        push dx
                        mov bh,17h      ;Белое на синем
                        call ramka

;Обрабатываем нажатия клавиш и вывод наименований дисков на экране+++++++++++
read_keys:              xor si,si        ;Номер текущего отображаемого пункта

show_drive:             mov dx,0A27h     ;Y 10 X 39

                        mov al,all_drive ;Изменяем Y по кол-ву дисков
                        shr al,1
                        sub dh,al
                        inc dh
                        mov ax,si
                        add dh,al

                        mov cx,4                    ;Длина выводимых пунктов
                        mov bp,offset drivers_names ;Адрес строк вывода

                        shl ax,2                ;Выбираем текущий пункт меню
                        add bp,ax

                        mov bl,select_drive     ;Если текущим выводимым
                        xor bh,bh               ;пунктом является текущий
                        cmp bx,si               ;выделенный пункт то
                        je  set_select          ;изменить его цвет

                        mov bl,1Fh              ;Ярко-белое на синем
                        jmp activ

set_select:             mov bl,71H              ;Синее на белом (выделенный)

activ:                  mov ax,1300h            ;Вывести пункт меню на экран
                        int 10h

                        inc si                  ;Текущий выводимый пункт +1
                        mov al,all_drive
                        xor ah,ah
                        inc al
                        cmp si,ax               ;Если вывели не все пункты
                        jne show_drive          ;то продолжаем вывод

                        xor ax,ax               ;Запрашиваем нажатую клавишу
                        int 16h

                        cmp ax,04800h           ;Клавиша вверх
                        je up_key
                        cmp ax,05000h           ;Клавиша вниз
                        je dw_key
                        cmp al,27               ;Прервать работу программы ESC
                        jne Lquit
                        jmp quit

Lquit:                  cmp al,0Dh              ;ENTER -выбрать текущий диск
                        je end_case
                        jmp read_keys           ;Вернуться к опросу клавиш

up_key:                 dec select_drive        ;Выделенный пункт-1
                        cmp select_drive,0FFh   ;Если не меньше 0
                        jne no_up_key           ;вернуться к опросу клавиш
                        mov select_drive,0      ;иначе выделенный пункт=0
no_up_key:              jmp read_keys

dw_key:                 inc select_drive        ;Выделенный пункт+1
                        mov al,all_drive        ;Если не больше максимального
                        cmp select_drive,al     ;кол-ва дисков
                        jna no_dw_key           ;вернуться к опросу клавиш
                        mov select_drive,al     ;выделенный пункт=всего дисков
no_dw_key:              jmp read_keys

;Прочитать параметры дискеты+++++++++++++++++++++++++++++++++++++++++++++++++
end_case:               mov ah,36h              ;Запросить блок информации
                        mov dl,select_drive     ;по выбранной дискете
                        inc dl
                        int 21h

                        cmp ax,-1               ;В случае ошибки
                        jne Lerror_bad_floppy   ;генерировать сообщение
                        jmp error_bad_floppy

Lerror_bad_floppy:      mov sector_cluster,al   ;Кол-во секторов в кластере
                        mov cluster_drive,dx    ;Кол-во кластеров на диске
                        mov byte_sector,cx      ;Кол-во байт в секторе


Lerror_system:          mov bx,offset fat_buffer  ;Считываем BR в память
                        mov al,select_drive       ;из выбранного диска
                        mov cx,1
                        xor dx,dx                 ;Лог.Сектор 0
                        int 25h

                        pop dx                    ;Выбираем старые флаги
                        jnc L1error_bad_floppy    ;Уходим на ошибку
                        jmp error_bad_floppy

L1error_bad_floppy:     mov bp,offset fat_buffer  ;Считанный сектор
                        mov ax,[bp+0Eh]       ;Секторов перед FAT
                        mov fat_start,ax
                        mov ax,[bp+13h]       ;Секторов на диске
                        mov sector_drive,ax
                        mov ax,[bp+16h]       ;Секторов в FAT
                        mov sector_fat,ax
                        mov ax,[bp+18h]       ;Секторов на дорожке
                        mov sector_track,ax
                        mov ax,[bp+1Ah]       ;Дорожек на диске
                        mov head_drive,ax
                        mov al,[bp+10h]       ;Число копий FAT
                        mov count_fat,al
                        mov ax,[bp+11h]       ;Элементов корневого оглавления
                        mov root_enteres,ax

                        mov bx,offset fat_buffer ;Считываем в буффер FAT
                        mov al,select_drive
                        mov cx,sector_fat
                        mov dx,fat_start
                        int 25h

                        pop dx
                        jnc L2error_bad_floppy ;При ошибке уходим
                        jmp  error_bad_floppy

;Формируем основной рабочий экран++++++++++++++++++++++++++++++++++++++++++++
;Выводим нижнюю строку экрана с подсказками для работы+++++++++++++++++++++++
L2error_bad_floppy:     mov cx,l_work_status_bar
                        mov dx,1804h
                        mov ax,1300h
                        mov bp,offset work_status_bar
                        mov bl,7Fh
                        xor bh,bh
                        int 10h

;Выводим рамку высота 20 ширина 75 координаты X 2 Y 2++++++++++++++++++++++++
                        mov dx,144Bh
                        push dx
                        mov dx,0202h
                        push dx
                        mov bh,17h
                        call ramka

;Выводим данные на экран и опрашиваем клавиши+++++++++++++++++++++++++++++++
                        mov ax,cluster_drive    ;Если кластеров меньше чем
                        cmp end_cluster_show,ax ;позиций на экране уменьшаем
                        jna new_dawn            ;число позиций до количества
                        mov end_cluster_show,ax ;кластеров

new_dawn:               mov bp,offset fat_buffer  ;Адрес буфера с данными FAT
                        mov di,start_cluster_show ;Отображаемый кластер

select_clusters:        mov si,di       ;Расчитываем 12-битный кластер
                        shl si,1
                        add si,di       ;si*3
                        mov ax,si       ;Сохраняем для проверки четности
                        shr si,1        ;si/2
                        mov dx,[bp+si]  ;Считываем по полученном адресу
                        and ax,01       ;Проверка на четность
                        jnz chet        ;Не четная
                        and dx,0FFFh    ;Для четной выбираем первые 12 бит
                        jmp show_clusters

chet:                   mov cl,4        ;Для нечетного биты с 4 по 15
                        shr dx,cl

show_clusters:          and dx,dx
                        jz free_cluster ;Не занятый кластер 0
                        cmp dx,0FF7h
                        je bad_cluster  ;Сбойный кластер FF7

                        mov cl,'U'      ;Другой любой кластер используется
                        mov bl,1Eh      ;Ярко-желтый на синем
                        mov ax,offset state_u_message ;Сообщение <Занятый>
                        jmp i_see_cluster
free_cluster:           mov cl,'F'
                        mov bl,1Ah      ;Ярко-зеленый на синем
                        mov ax,offset state_f_message ;Сообщение <Свободный>
                        jmp i_see_cluster
bad_cluster:            mov cl,'B'
                        mov bl,1Ch      ;Ярко-красный на синем
                        mov ax,offset state_b_message ;Сообщение <Сбойный>

i_see_cluster:          cmp di,position_cluster_show ;Если текущий выбран то
                        jne other_cluster            ;установить цвет фона
                        and bl,0Fh                   ;в черный
                        mov state_message_pointer,ax ;Статус выбранного

other_cluster:          mov ax,view_position         ;Координаты вывода
                        inc al                       ;Увеличить на 1
                        cmp al,76                    ;За границами окна?
                        jna correct_position
                        inc ah                       ;Переводим на следующую
                        mov al,03h                   ;строку

correct_position:       mov view_position,ax ;Запоминаем новую позицию

                        push bp     ;Сохраняем адрес буфера данных
                        push di     ;Сохраняем номер текущего кластера

;Устанавливаем курсор в точку вывода+++++++++++++++++++++++++++++++++++++++++
                        mov dx,ax
                        xor bh,bh
                        mov ah,02h
                        int 10h

;Выводим заданным ранее цветом и символом++++++++++++++++++++++++++++++++++++
                        xor bh,bh
                        mov al,cl
                        mov cx,1
                        mov ah,09h
                        int 10h

;Вывод координат в верхней строке экрана выбранного кластера+++++++++++++++++
;Переводим номер выбранного кластера в строковое представление+++++++++++++++
                        mov ax,position_cluster_show
                        mov si,offset title_cluster
                        call digit2string

;Расчитываем номер логического сектора DOS !ТОЛЬКО ДЛЯ ДИСКЕТ!+++++++++++++++
                        mov bx,byte_sector
                        mov ax,root_enteres
                        mov cl,5           ;Кол-во элементов оглавления корня
                        shl ax,cl          ;умножаем на 32
                        xor dx,dx          ;Байт в секторе делим на кол-во
                        div bx             ;байт в элементах оглавления корня
                        mov bx,ax          ;Сохраняем кол-во секторов в корне

                        mov dl,count_fat   ;Кол-во копий FAT умножаем
                        mov ax,sector_fat  ;на количество секторов в FAT
                        mul dl
                        add ax,fat_start   ;Прибавляем пропущенные сектора
                        add ax,bx          ;Прибавляем сектора в корне
                        mov bx,ax          ;Сохраняем

                        mov ax,position_cluster_show ;Выбранный кластер-2
                        dec ax                       ;т.е. FAT ID и
                        dec ax                       ;выравнивание по байту

                        xor dx,dx
                        mov dl,sector_cluster     ;Умножаем на кол-во
                        mul dx                    ;секторов в кластере
                        add ax,bx                 ;Прибавляем ранее найденное

;Переводим номер расчитанного логического сектора в строковое представление++
                        mov si,offset title_logsector
                        mov position_logsector,ax
                        call digit2string

;Рассчитываем координаты физического сектора DOS !ТОЛЬКО ДЛЯ ДИСКЕТ!+++++++++
                        mov al,byte ptr head_drive   ;Находим произведение
                        mov ah,byte ptr sector_track ;кол-ва секторов на
                        mul ah                       ;дорожке на кол-во сторон
                        mov dx,ax                    ;Сохраняем
                        mov ax,position_logsector    ;Делим это число на номер
                        div dl                       ;логического сектора
                        push ax                      ;Сохраняем результат

;Переводим номер расчитанного номера дорожки в строковое представление+++++++
                        xor ah,ah
                        mov si,offset title_ph_track
                        call digit2string

                        pop ax                       ;Восстанавливаем
                        mov cl,8                     ;Выбираем остаток от
                        shr ax,cl                    ;деления
                        mov dl,byte ptr sector_track ;Делим его на кол-во
                        div dl                       ;секторов на дорожке
                        push ax                      ;Сохраняем результат

;Переводим номер расчитанного номера стороны в строковое представление+++++++
                        xor ah,ah
                        mov si,offset title_ph_head
                        call digit2string

                        pop ax                        ;Восстанавливаем
                        mov cl,8                      ;Выбираем остаток от
                        shr ax,cl                     ;деления
                        inc ax                        ;Прибавляем 1

;Переводим номер расчитанного номера сектора в строковое представление+++++++
                        mov si,offset title_ph_sector
                        call digit2string

;Выводим строку с координатами кластера в заголовке экрана+++++++++++++++++++
                        mov cx,l_work_title
                        xor dx,dx
                        mov bp,offset work_title
                        mov bl,7Fh
                        xor bh,bh
                        mov ax,1300h
                        int 10h

;Выводим строку со статусом выбранного кластера в заголовке экрана+++++++++++
                        add dl,cl
                        mov cx,l_state_message
                        mov ax,1300h
                        mov bp,state_message_pointer
                        mov bl,7Fh
                        xor bh,bh
                        int 10h

                        pop di  ;Восстанавливаем номер текущего кластера и
                        pop bp  ;адрес буфера с данными FAT

                        inc di  ;Увеличиваем номер кластера на 1
                        cmp di,end_cluster_show ;Если это последний кластер
                        ja Lselect_clusters     ;переходим к опросу клавиш
                        jmp select_clusters     ;иначе выводим дальше

Lselect_clusters:       mov view_position,0302h ;Вернуть координаты вывода

                        xor ax,ax       ;Запрашиваем клавишу
                        int 16h
                        cmp ax,04800h   ;Клавиша вверх
                        je up_key_show
                        cmp ax,05000h   ;Клавиша вниз
                        je dw_key_show
                        cmp ax,04D00h   ;Клавиша вправо
                        je rg_key_show
                        cmp ax,04B00h   ;Клавиша влево
                        je lt_key_show
                        cmp ax,03B00h   ;F1 - О программе
                        jne Lf1_key_show
                        jmp f1_key_show
Lf1_key_show:           cmp ax,03C00h   ;F2 - Сохранить
                        jne Lf2_key_show
                        jmp f2_key_show
Lf2_key_show:           cmp ax,04400h   ;F10 - Выбрать диск
                        jne Lf10_key_show
                        jmp f10_key_show

Lf10_key_show:          cmp al,27       ;Прервать работу программы
                        jne L1quit
                        jmp quit

L1quit:                 jmp new_dawn    ;Вернуться к опросу клавиш

;Блок обработки реакций на клавиши+++++++++++++++++++++++++++++++++++++++++++
up_key_show:            mov cx,74                    ;Перевести выбранный
                        sub position_cluster_show,cx ;на строку вверх

                        mov ax,start_cluster_show    ;Если кластер в не
                        cmp position_cluster_show,ax ;экрана корректировать
                        jl correct_start_position    ;изображение
                        jmp new_dawn

dw_key_show:            mov cx,74                    ;Перевести выбранный
                        add position_cluster_show,cx ;на строку вниз
                        mov ax,end_cluster_show
                        cmp position_cluster_show,ax ;Если кластер в не
                        jg correct_end_position      ;экрана корректировать
                        jmp new_dawn                 ;изображение

lt_key_show:            mov cx,1                     ;Перевести выбранный
                        dec position_cluster_show    ;на 1 назад
                        mov ax,start_cluster_show
                        cmp position_cluster_show,ax ;Если кластер в не
                        jb correct_start_position    ;экрана корректировать
                        jmp new_dawn                 ;изображение

rg_key_show:            mov cx,1                     ;Перевести выбранный
                        inc position_cluster_show    ;на 1 вперед
                        mov ax,end_cluster_show
                        mov cx,1                     ;Если кластер в не
                        cmp position_cluster_show,ax ;экрана корректировать
                        ja correct_end_position      ;изображение
                        jmp new_dawn

correct_end_position:  add end_cluster_show,cx      ;Сместить последний
                       mov ax,end_cluster_show      ;Если позиция не больше
                       cmp ax,cluster_drive         ;максимально допустимой
                       jna set_start_position       ;расчитать начальную
                       mov ax,cluster_drive         ;иначе последний равен
                       mov end_cluster_show,ax      ;максимльному допустимому
                       mov position_cluster_show,ax ;сластеру на диске

set_start_position:    sub ax,1405                  ;Начальная позиция на
                       mov start_cluster_show,ax    ;1405 меньше последней
                       jmp new_dawn

correct_start_position:sub start_cluster_show,cx    ;Сместить начальную
                       mov ax,start_cluster_show    ;Если позиция не меньше
                       cmp ax,2                     ;минимально допустимой
                       jnl set_end_position         ;расчитать конечную
                       mov ax,2                     ;иначе начальный равен
                       mov start_cluster_show,ax    ;минимально допустимому
                       mov position_cluster_show,ax ;сластеру на диске

set_end_position:      add ax,1405                  ;Конечная позиция на
                       mov end_cluster_show,ax      ;1405 больше начальной
                       jmp new_dawn

;Вывод окна информации о программе+++++++++++++++++++++++++++++++++++++++++++
f1_key_show:            mov dx,0437h
                        push dx
                        mov dx,090Ch
                        push dx
                        mov bh,27h
                        call ramka

                        mov ax,1300h
                        mov cx,l_about_message_title
                        mov dx,0A1Ah
                        mov bp,offset about_message_title
                        mov bl,2Bh
                        xor bh,bh
                        int 10h

                        mov ax,1300h
                        mov cx,l_about_message_name
                        mov dx,0B0Dh
                        mov bp,offset about_message_name
                        mov bl,2Bh
                        xor bh,bh
                        int 10h

                        mov ax,1300h
                        mov cx,l_about_message_bottom
                        mov dx,0C10h
                        mov bp,offset about_message_bottom
                        mov bl,2Bh
                        xor bh,bh
                        int 10h

                        xor ax,ax
                        int 16h

                        jmp new_dawn

;Запрос и сохранение данных на диске в файле+++++++++++++++++++++++++++++++++
;Формируем поле для ввода имени файла с клавиатуры
f2_key_show:            mov dx,020Eh
                        push dx
                        mov dx,0A21h
                        push dx
                        mov bh,3Bh
                        call ramka
                        
;Перемещаем курсор внутрь этого поля+++++++++++++++++++++++++++++++++++++++++
                        mov dx,0B22h
                        xor bh,bh
                        mov ah,02h
                        int 10h

;Отображаем мигающий курсор++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ah,01h
                        mov ch,6h
                        mov cl,7h
                        int 10h

;Запрашиваем данные с клавиатуры+++++++++++++++++++++++++++++++++++++++++++++
                        mov ah,0Ah
                        mov dx,offset file_name_buf
                        int 21h

;Скрываем курсор+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ah,01h
                        mov ch,20h
                        int 10h

;Пытаемся создать файл с введенным именем++++++++++++++++++++++++++++++++++++
                        mov ah,3Ch
                        xor bx,bx
                        mov bl,file_name_buf[1]
                        mov file_name[bx],0     ;Формируем ASCII строку
                        mov dx,offset file_name
                        mov cx,20h
                        int 21h
                        jnc Lerror_bad_file     ;В случае ошибки генерируем
                        jmp error_bad_file      ;окно с сообщением

Lerror_bad_file:        mov file_handle,ax      ;Сохраняем указатель на файл

;Выводим заголовок файла для его идентификации+++++++++++++++++++++++++++++++
                        mov bx,ax
                        mov ah,40h
                        mov cx,l_file_id_message
                        mov dx,offset file_id_message
                        int 21h
                        
;Вывод данных в файл++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;Данный код практически полностью повторяет вывод данных на экран за тем
;исключением, что данные не отображаются в виде символов, а только своими
;координатами, и вывод происходит в файл, после чего выбранный кластер
;меняется на текущий и таким образом на всем протяжении вывода они равны.
;Данный подход обеспечиват пересчет координат для каждого обрабатываемого
;кластера. Тоесть текущий синоним выбранный.

                        mov bp,offset fat_buffer
                        mov di,position_cluster_showW

select_clustersW:       mov si,di
                        shl si,1
                        add si,di
                        mov ax,si
                        shr si,1
                        mov dx,[bp+si]
                        and ax,01
                        jnz chetW
                        and dx,0FFFh
                        jmp show_clustersW

chetW:                  mov cl,4
                        shr dx,cl

show_clustersW:         and dx,dx
                        jz free_clusterW
                        cmp dx,0FF7h
                        je bad_clusterW
                        mov ax,offset state_u_message
                        jmp i_see_clusterW
free_clusterW:          mov ax,offset state_f_message
                        jmp i_see_clusterW
bad_clusterW:           mov ax,offset state_b_message

i_see_clusterW:         push bp
                        push di
                        mov state_message_pointer,ax
                        
                        mov ax,position_cluster_showW
                        mov si,offset title_cluster
                        call digit2string

                        mov bx,byte_sector
                        mov ax,root_enteres
                        mov cl,5
                        shl ax,cl
                        xor dx,dx
                        div bx
                        mov bx,ax

                        mov dl,count_fat
                        mov ax,sector_fat
                        mul dl
                        add ax,fat_start
                        add ax,bx
                        mov bx,ax

                        mov ax,position_cluster_showW
                        dec ax
                        dec ax
                        xor dx,dx
                        mov dl,sector_cluster
                        mul dx
                        add ax,bx
                        mov si,offset title_logsector
                        mov position_logsector,ax
                        call digit2string

                        mov al,byte ptr head_drive
                        mov ah,byte ptr sector_track
                        mul ah
                        mov dx,ax
                        mov ax,position_logsector
                        div dl
                        push ax
                        xor ah,ah
                        mov si,offset title_ph_track
                        call digit2string

                        pop ax
                        mov cl,8
                        shr ax,cl
                        mov dl,byte ptr sector_track
                        div dl
                        push ax
                        xor ah,ah
                        mov si,offset title_ph_head
                        call digit2string

                        pop ax
                        mov cl,8
                        shr ax,cl
                        inc ax
                        mov si,offset title_ph_sector
                        call digit2string
                        
;Вывод в файл координат кластера+++++++++++++++++++++++++++++++++++++++++++++
                        mov bx,file_handle
                        mov ah,40h
                        mov cx,l_work_title
                        mov dx,offset work_title
                        int 21h
                        
;Вывод в файл статуса кластера+++++++++++++++++++++++++++++++++++++++++++++++
                        mov ah,40h
                        mov cx,l_state_message
                        mov dx,state_message_pointer
                        int 21h
;Вывод в файл символа с кодом 13 - перевод строки++++++++++++++++++++++++++++
                        mov ah,40h
                        mov cx,1
                        mov dx,offset file_name_buf
                        int 21h
                        
;Восстанавливаем переменные цикла выбора кластера и переходим к следующему+++
                        pop di
                        pop bp

                        inc di
                        mov position_cluster_showW,di
                        cmp di,cluster_drive
                        ja Lselect_clustersW
                        jmp select_clustersW

;Закрыть открытый файл+++++++++++++++++++++++++++++++++++++++++++++++++++++++
Lselect_clustersW:      mov bx,file_handle
                        mov ah,3Eh
                        int 21h

                        jmp new_dawn

;Перезапуск программы - с выбора диска для обработки+++++++++++++++++++++++++
f10_key_show:           jmp reload_programm

;Обработка сообщений об ошибках++++++++++++++++++++++++++++++++++++++++++++++
;Неверное имя файла++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
error_bad_file:         mov cx,offset error_bad_file_message
                        push cx
                        mov bx,474Bh
                        push bx
                        call showmessage

                        xor ax,ax
                        int 16h
                        jmp new_dawn

;Невозможность прямого чтения с диска++++++++++++++++++++++++++++++++++++++++
error_bad_floppy:       mov cx,offset error_bad_floppy_message
                        push cx
                        mov bx,474Bh
                        push bx
                        call showmessage

                        xor ax,ax
                        int 16h
                        jmp reload_programm

;В системе не присутствуют дисководы+++++++++++++++++++++++++++++++++++++++++
error_no_floppy:        mov cx,offset error_no_floppy_message
                        push cx
                        mov bx,474Bh
                        push bx
                        call showmessage

                        xor ax,ax
                        int 16h

;Выход из программы++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;Очистить экран++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
quit:                   mov ax,0600h
                        xor cx,cx
                        mov dx,184Fh
                        mov bh,07h
                        int 10h

;Вывести завершающее сообщение+++++++++++++++++++++++++++++++++++++++++++++++
                        mov cx,l_final_message
                        xor dx,dx
                        mov ax,1300h
                        mov bp,offset final_message
                        mov bl,07h
                        xor bh,bh
                        int 10h
;Собственно выход++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.exit                   ;mov ah,04Ch
                        ;int 21h

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;Процедура вычерчивания рамки на экране
;Параметры в стеке: +4|2 -верхний левый угол Y/X
;                   +6|2 -ширина/высота
;Параметры в регистах: bh -атрибуты видео
ramka                   proc

                        push bp         ;Создаем стековый кадр
                        mov bp,sp

;Очищаем место под рамку+++++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0600h
                        mov cx,[bp+4]
                        mov dx,cx
                        add dh,[bp+7]
                        add dl,[bp+6]
                        int 10h

                        xor bx,bx

;Устанавливаем курсор в верхний левый угол+++++++++++++++++++++++++++++++++++
                        mov ah,02h
                        mov dx,cx
                        inc dl
                        int 10h

;Выводим верхнию границу+++++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0AC4h
                        xor cx,cx
                        mov cl,[bp+6]
                        dec cx
                        int 10h

;Устанавливаем курсор в нижний левый угол++++++++++++++++++++++++++++++++++++
                        mov ah,02h
                        add dh,[bp+7]
                        int 10h

;Выводим нижнюю границу++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0AC4h
                        int 10h

;Устанавливаем курсор в верхний левый угол+++++++++++++++++++++++++++++++++++
                        mov ah,02h
                        mov dx,[bp+4]
                        int 10h

;Выводим верхний левый угол++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0EDAh
                        int 10h

;Устанавливаем курсор в нижний левый угол++++++++++++++++++++++++++++++++++++
                        mov ah,02h
                        add dh,[bp+7]
                        int 10h

;Выводим нижний левый угол+++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0EC0h
                        int 10h

;Устанавливаем курсор в нижний правый угол+++++++++++++++++++++++++++++++++++
                        mov ah,02h
                        add dl,[bp+6]
                        int 10h

;Выводим нижний правый угол++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0ED9h
                        int 10h

;Устанавливаем курсор в верхний правый угол++++++++++++++++++++++++++++++++++
                        mov ah,02h
                        sub dh,[bp+7]
                        int 10h

;Выводим верхний правый угол+++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0EBFh
                        int 10h

;Выводим боковые границы рамки+++++++++++++++++++++++++++++++++++++++++++++++
                        mov cl,[bp+7] ;Высота нашей рамки
                        dec cl

;Устанавливаем курсор на левую границу+++++++++++++++++++++++++++++++++++++++
borders:                inc dh
                        mov ah,02h
                        sub dl,[bp+6]
                        int 10h

;Выводим по символам+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0EB3h
                        int 10h

;Устанавливаем курсор на правую границу++++++++++++++++++++++++++++++++++++++
                        mov ah,02h
                        add dl,[bp+6]
                        int 10h

;Выводим по символам+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        mov ax,0EB3h
                        int 10h

                        loop borders ;Повторяем до конца

                        pop bp ;Восстанавливаем
                        ret 4  ;Очищаем стэк

ramka                   endp

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;Процедура вывода текстового сообщения в центре экрана, заданным цветом
;Параметры в стеке: +4|2 -текста/рамки
;                   +6|2 -адрес начала строки в формате 0|1 -длина
;                                                       1|* -данные
showmessage             proc

                        push bp     ;Создаем стековый кадр
                        mov bp,sp

                        mov bx,[bp+6] ;Узнаем адрес строки

                        mov cl,[bx]   ;Узнаем длину строки

                        shr cl,1      ;/2
                        mov dl,40
                        sub dl,cl     ;40-половина длины строки

                        dec dl        ;Смещаем для вывода рамки
                        dec dl

                        mov dh,0Ah    ;Y координата рамки

                        push dx

                        mov cl,[bx]   ;Вычисляем длину рамки
                        add cl,3

                        mov ch,2      ;Высота рамки

                        push cx
                        push dx
                        mov bx,[bp+4]
                        call ramka    ;Выводим рамку

                        pop dx

;Выводим соообщение по вычесленным координатам+++++++++++++++++++++++++++++++
                        inc dh
                        inc dl
                        inc dl
                        xor ch,ch
                        mov bx,[bp+6]
                        mov cl,[bx]
                        mov bl,[bp+4]
                        xor bh,bh
                        mov bp,[bp+6]
                        inc bp
                        mov ax,1300h
                        int 10h

                        pop bp  ;Восстанавливаем
                        ret 4   ;Очищаем стэк

showmessage             endp

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;Переводит число в текстовую строку представление этого числа 16 c/c
;Данные в регистрах: ax -число
;                    si -адрес строки вывода
digit2string            proc

                        mov cl,12
n1:                     mov dx,ax
                        shr dx,cl    ;Получаем тэтрады числа

                        mov bx,dx
                        shl bx,cl
                        not bx       ;Убираем полученную тэтраду
                        and ax,bx    ;из исходного числа

                        cmp dx,0Ah   ;Если не больше 10
                        jb corr      ;считаем как есть
                        add dx,7     ;иначе буквы
                        
corr:                   add dx,48    ;Прибавляем чтобы получить код ASCII
                        mov [si],dl  ;Записываем в строке
                        
                        inc si       ;Переходим к обработке следующей тэтрады
                        sub cl,4
                        cmp cl,0
                        jge n1

                        ret
digit2string            endp
end