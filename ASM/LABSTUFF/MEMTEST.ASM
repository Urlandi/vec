.486p
rm_seg          segment para public 'code' use16
                assume cs:rm_seg,ss:rm_stack

start:          cli                     ;прерывания нам будут только мешать
                in      al,70h
                or      al,80h
                out     70h,al

                push    cs
                pop     ds

;Прежде чем тестировать всю память необходимо оттестировать место под самой программой
;Сначала тестируем свободный сегмент в который будем перемещать нашу программу

;Тест все '0' все '1'
;Тестируем сегмент
                xor     si,si
                mov     cx,swap_seg_l
                mov     ax,swap_seg
                mov     fs,ax
                mov     al,0FFh

fs1:            mov     fs:[si],al
                inc     si
                dec     cx
                jnz     fs1

;Проверяем везде-ли единицы
                mov     cx,swap_seg_l
                xor     si,si

fs2:            mov     ah,byte ptr fs:[si]
                cmp     al,ah
                jne     err_mem
                inc     si
                dec     cx
                jnz     fs2

                jmp     movcod

err_mem:        mov     dx,offset err_mem_msg
                jmp     err_exit

;Копируем наш код в оттестированную область
movcod:         xor     si,si
                xor     di,di
                mov     ax,swap_seg
                mov     es,ax
                cld

                mov     ecx,swap_seg
                mov     eax,rm_seg
                sub     ecx,eax
                shl     ecx,4
                mov     dx,cx

rep             movsd


                db      0eah
                dw      offset test_this_seg
                dw      swap_seg


test_this_seg:  mov     ax,cs
                mov     ds,ax


;Тест все '0' все '1'
;Тестируем сегмент
                xor     si,si
                mov     cx,dx
                mov     ax,rm_seg
                mov     fs,ax
                mov     al,0FFh

fs11:           mov     fs:[si],al
                inc     si
                dec     cx
                jnz     fs11

;Проверяем везде-ли единицы
                mov     cx,dx
                xor     si,si

fs21:           mov     ah,byte ptr fs:[si]
                cmp     al,ah
                jne     err_mem1
                inc     si
                dec     cx
                jnz     fs21

                jmp     retcod

err_mem1:       mov     dx,offset err_mem_msg
                jmp     err_exit

Копируем наш код обратно
retcod:         xor     si,si
                xor     di,di
                mov     ax,rm_seg
                mov     es,ax
                cld

                mov     ecx,swap_seg
                mov     eax,rm_seg
                sub     ecx,eax
                shl     ecx,4

rep             movsd

                db      0eah
                dw      offset return_this_seg
                dw      rm_seg

return_this_seg:push    cs
                pop     ds

                mov     eax,cr0
                test    al,1
                jz      no_v86
                mov     dx,offset v86_msg

err_exit:       mov     ah,09h
                int     21h
                jmp     real_exit

v86_msg         db      'Область памяти занимаемая программой: без ошибок',0Dh,0Ah,'Процессор в режиме V86 - продолжение невозможно$'
win_msg         db      'Область памяти занимаемая программой: без ошибок',0Dh,0Ah,'Обнаружена Windows система -  продолжение невозможно$'
err_mem_msg     db      'Тест памяти занимаемой программой: сбой$'
err_bigmem_msg  db      'Тест памяти свыше 1Мб: сбой$'
err_lessmem_msg db      'Тест памяти до 1Мб: сбой$'
test_ok         db      'Тест памяти: выполнен успешно$'

no_V86:         mov     ax,1600h
                int     2fh
                test    al,al
                jz      no_windows

                mov     dx,offset win_msg
                jmp     err_exit

no_windows:     in      al,92h
                or      al,2
                out     92h,al

                xor     eax,eax
                mov     ax,pm_seg
                shl     eax,4
                add     eax,offset pm_entry
                mov     dword ptr pm_entry_off,eax

                xor     eax,eax
                mov     ax,cs
                shl     eax,4
                push    eax
                mov     word ptr gdt_16bitcs+2,ax
                mov     word ptr gdt_16bitds+2,ax
                shr     eax,16
                mov     byte ptr gdt_16bitcs+4,al
                mov     byte ptr gdt_16bitds+4,al

                pop     eax
                add     ax,offset gdt
                mov     dword ptr gdtr+2,eax

                lgdt    fword ptr gdtr

                mov     eax,cr0
                or      al,1
                mov     cr0,eax

                db      66h
                db      0eah
pm_entry_off    dd      ?
                dw      sel_flatcs

rm_return:      mov     eax,cr0
                and     al,0feh
                mov     cr0,eax

                db      0eah
                dw      $+4
                dw      rm_seg

                mov     ax,cs
                mov     ds,ax
                mov     es,ax
                mov     fs,ax

                cmp     ebx,1
                je      fail_bigmem
                cmp     ebx,2
                je      fail_lessmem
                mov     dx,offset test_ok
                jmp     err_exit
fail_bigmem:    mov     dx,offset err_bigmem_msg
                jmp     err_exit
fail_lessmem:   mov     dx,offset err_lessmem_msg
                jmp     err_exit

real_exit:      in      al,70h
                and     al,07fh
                out     70h,al

                sti

                xor     ah,ah
                int     16h

                mov     ah,4ch
                int     21h

total_mem_size  dd      400000h;50000000h

gdt             label   byte
                db      8 dup(0)

gdt_flatcs      db      0ffh,0ffh,0,0,0,10011010b,11001111b,0
gdt_flatds      db      0ffh,0ffh,0,0,0,10010010b,11001111b,0
gdt_16bitcs     db      0ffh,0ffh,0,0,0,10011010b,0,0
gdt_16bitds     db      0ffh,0ffh,0,0,0,10010010b,0,0
gdt_l           equ     $-gdt
gdtr            dw      gdt_l-1
                dd      ?

sel_flatcs      equ     00001000b
sel_flatds      equ     00010000b
sel_16bitcs     equ     00011000b
sel_16bitds     equ     00100000b

rm_seg          ends

pm_seg          segment para public 'CODE' use32
                assume  cs:pm_seg,ds:rm_seg

pm_entry:       xor     ebx,ebx
                mov     ax,sel_16bitds
                mov     ds,ax
                mov     ax,sel_flatds
                mov     fs,ax

;Тестируем память от 1Мб до конца
;Обратить внимание!!!
;Область памяти А000:0 - FFFF:F тест не проходит

                mov     ecx,total_mem_size
                mov     esi,110000h
                sub     ecx,esi

fa1:            mov     dword ptr fs:[esi],esi
                add     esi,4
                sub     ecx,4
                jnz     fa1

                mov     ecx,total_mem_size
                mov     esi,110000h
                sub     ecx,esi

fa2:            mov     eax,dword ptr fs:[esi]
                cmp     eax,esi
                jne     err_bigmem
                add     esi,4
                sub     ecx,4
                jnz     fa2

                jmp     less1

err_bigmem:     mov     ebx,1
                jmp     jtr

less1:          mov     ax,sel_flatds
                mov     ds,ax
                mov     es,ax
                xor     esi,esi
                mov     edi,200000h
                mov     ecx,110000h
                cld
rep             movsd

                mov     eax,pm_seg
                shl     eax,4
                add     eax,offset enter_copy2
                add     eax,200000h
                jmp     eax

enter_copy2:    mov     ecx,110000h
                xor     esi,esi

fa11:           mov     dword ptr fs:[esi],esi
                add     esi,4
                sub     ecx,4
                jnz     fa11

                mov     ecx,110000h
                xor     esi,esi

fa21:           mov     eax,dword ptr fs:[esi]

                cmp     esi,0A0000h
                jb      no_vid_mem
                cmp     esi,100000h
                jae     no_vid_mem
                jmp     short vid_mem_skip

no_vid_mem:     cmp     eax,esi
                jne     err_lessmem

vid_mem_skip:   add     esi,4
                sub     ecx,4
                jnz     fa21
                jmp     short good_bye

err_lessmem:    mov     ebx,2

good_bye:       xor     edi,edi
                mov     esi,200000h
                mov     ecx,110000h
                cld
rep             movsd

jtr:            mov     ax,sel_16bitds
                mov     fs,ax
                mov     ds,ax
                mov     es,ax

                db      0eah
                dd      offset rm_return
                dw      sel_16bitcs

pm_seg          ends

rm_stack        segment para stack 'STACK' use16

                db      100h dup(?)

rm_stack        ends

swap_seg        segment para public 'DATA' use16
voiddata        db      0FFFFh dup(?)
swap_seg_l      equ     $-voiddata

swap_seg        ends

end             start