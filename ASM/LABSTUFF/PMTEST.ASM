.486p
rm_seg          segment para public 'code' use16
                assume cs:rm_seg,ss:am_stack,ds:pm_seg

start:          mov     ax,3
                int     10h

                mov     ax,am_stack
                mov     bx,am_stack_l
                mov     ss,ax
                mov     sp,bx

                mov     ax,pm_seg
                mov     ds,ax
                push    0b800h
                pop     es


                mov     eax,cr0
                test    al,1
                jz      no_v86

                mov     dx,small offset v86_msg

rm_exit:

                mov     ah,09h
                int     21h
r_rm_exit:      mov     ah,4ch
                int     21h

no_V86:

                mov     ax,1600h
                int     2fh
                test    al,al
                jz      no_windows

                mov     dx,small offset win_msg
                jmp     rm_exit

no_windows:
                cli
                in      al,70h
                or      al,80h
                out     70h,al

                mov     eax,cr0
                or      al,1
                mov     cr0,eax

                xor     di,di
                mov     si,small offset e_pm
                mov     cx,e_pm_l
        rep     movsb

                mov     eax,cr0
                and     al,0feh
                mov     cr0,eax

                in      al,70h
                and     al,7fh
                out     70h,al
                sti

                mov     di,e_pm_l
                mov     si,small offset o_pm
                mov     cx,o_pm_l
rep             movsb

                xor     eax,eax
                mov     ax,rm_seg
                shl     eax,4
                mov     word ptr gdt_16bitcs+2,ax
                shr     eax,16
                mov     byte ptr gdt_16bitcs+4,al

                mov     ax,pm_seg
                shl     eax,4
                mov     word ptr gdt_32bitcs+2,ax
                mov     word ptr gdt_32bitds+2,ax
                shr     eax,16
                mov     byte ptr gdt_32bitcs+4,al
                mov     byte ptr gdt_32bitds+4,al

                mov     ax,am_stack
                shl     eax,4
                mov     word ptr gdt_16bitss+2,ax
		mov	word ptr gdt_32bitss+2,ax
                shr     eax,16
                mov     byte ptr gdt_16bitss+4,al
		mov	byte ptr gdt_32bitss+4,al

                xor     eax,eax
                mov     ax,pm_seg
                shl     eax,4
                push    eax
                add     eax,offset gdt
                mov     dword ptr gdtr+2,eax
                lgdt    fword ptr gdtr


                cli

                in      al,70h
                or      al,80h
                out     70h,al

                pop     eax
                add     eax,offset idt
                mov     dword ptr idtr+2,eax
                lidt    fword ptr idtr

                in      al,92h
                or      al,2
                out     92h,al

                mov     bl,50h
                call    map_irq

                mov     eax,cr0
                or      al,1
                mov     cr0,eax

                db      66h
                db      0eah
                dd      offset pm_entry
                dw      sel_32bitcs

rm_return:

                mov     eax,cr0
                and     al,0feh
                mov     cr0,eax

                db      0eah
                dw      $+4
                dw      rm_seg

                mov     ax,pm_seg
                mov     ds,ax
                mov     ax,0b800h
                mov     es,ax

                mov     ax,am_stack
                mov     bx,am_stack_l
                mov     ss,ax
                mov     sp,bx

                mov     bl,08h
                call    map_irq

                lidt    fword ptr idtr_real

                in      al,70h
                and     al,07fh
                out     70h,al

                sti

                mov     edi,280h
                mov     esi,small offset endmsg
                mov     ecx,endmsg_l
        rep     movsb

                xor     ah,ah
                int     16h

                mov     ax,3
                int     10h

                jmp     r_rm_exit


;bl - номер базы для первого контроллера прерывания
map_irq         proc

                mov     al,00010101b
                out     20h,al
                mov     al,bl
                out     21h,al
                mov     al,04h
                out     21h,al
                mov     al,00001101b
                out     21h,al

                ret

map_irq         endp



rm_seg          ends

pm_seg          segment para public 'CODE' use32
                assume  cs:pm_seg

v86_msg         db      'CPU in V86 - stop$'
win_msg         db      'Microsoft Windows detected - stop$'
e_pm            db      'E',7,'n',7,'t',7,'e',7,'r',7,' ',7,'P',7,'M',7,' ',7,'-',7,' ',7,'O',10,'.',10,'K',10,'.',10
e_pm_l          equ     $-e_pm
o_pm            db      ' ',7,'L',7,'e',7,'a',7,'v',7,'e',7,' ',7,'P',7,'M',7,' ',7,'-',7,' ',7,'O',10,'.',10,'K',10,'.',10
o_pm_l          equ     $-o_pm
endmsg          db      'P',7,'M',7,' ',7,'t',7,'e',7,'s',7,'t',7,' ',7,'-',7,' ',7,'c',7,'o',7,'m',7,'p',7,'l',7,'i',7,'t',7,'e',7
endmsg_l        equ     $-endmsg
alr_np          db      '#',7,'N',7,'P',7,' ',7,'e',7,'r',7,'r',7,'o',7,'r',7,' ',7,'t',7,'e',7,'s',7,'t',7,' ',7,'-',7,' ',7,'O',10,'.',10,'K',10,'.',10
alr_np_l        equ     $-alr_np
alr_gp0         db     '#',7,'G',7,'P',7,'0',7,' ',7,'e',7,'r',7,'r',7,'o',7,'r',7,' ',7,'t',7,'e',7,'s',7,'t',7,' ',7,'-',7,' ',7,'O',10,'.',10,'K',10,'.',10
alr_gp0_l       equ    $-alr_gp0
alr_gp1         db     '#',7,'G',7,'P',7,'1',7,' ',7,'e',7,'r',7,'r',7,'o',7,'r',7,' ',7,'t',7,'e',7,'s',7,'t',7,' ',7,'-',7,' ',7,'O',10,'.',10,'K',10,'.',10
alr_gp1_l       equ    $-alr_gp1
flg             db      0

gdt             label   byte
                db      8 dup(0)
gdt_16bitcs     db      0ffh,0ffh,0,0,0,10011010b,0,0
gdt_32bitcs     db      0ffh,0ffh,0,0,0,10011010b,01001111b,0
gdt_16bitds     db      0ffh,0ffh,0,0,0,10010010b,0,0
gdt_32bitds     db      0ffh,0ffh,0,0,0,10010010b,01001111b,0
gdt_16bitss     db      0ffh,0ffh,0,0,0,10010010b,0,0
gdt_32bitss     db      0ffh,0ffh,0,0,0,10010010b,01001111b,0
gdt_flatdata    db      0ffh,0ffh,0,0,0,10010010b,11001111b,0
gdt_notpresent  db      0ffh,0ffh,0,0,0,00010010b,11001111b,0
gdt_codefix     db      0ffh,0ffh,0,0,0,11111010b,01001111b,0

gdt_l           equ     $-gdt
gdtr            dw      gdt_l-1
                dd      ?

sel_16bitcs     equ     00001000b
sel_32bitcs     equ     00010000b
sel_16bitds     equ     00011000b
sel_32bitds     equ     00100000b
sel_16bitss     equ     00101000b
sel_32bitss     equ     00110000b
sel_flatdata    equ     00111000b
sel_notpresent  equ     01000000b
sel_codefix     equ     01001000b


idt             label   byte
                dw      small offset sys_alert00,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert01,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert02,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert03,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert04,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert05,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert06,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert07,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert08,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert09,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert0a,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert0b,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert0c,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert0d,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert0e,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert0f,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert10,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert11,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert12,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert13,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert14,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert15,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert16,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert17,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert18,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert19,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert1a,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert1b,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert1c,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert1d,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert1e,SEL_32bitCS,8e00h,0
                dw      small offset sys_alert1f,SEL_32bitCS,8e00h,0
                dw      30h dup(small offset any_app_ints,SEL_32bitCS,8e00h,0)
                dw      08h dup(small offset irq0_7,SEL_32bitCS,8e00h,0)
                dw      18h dup(small offset any_app_ints,SEL_32bitCS,8e00h,0)
                dw      08h dup(small offset irq8_15,SEL_32bitCS,8e00h,0)
                dw      88h dup(small offset any_app_ints,SEL_32bitCS,8e00h,0)

idt_l           equ     $-idt
idtr            dw      idt_l-1
                dd      ?

idtr_real       dw      3ffh,0,0

pm_entry:

                mov     ax,sel_32bitds
                mov     ds,ax
                mov     ax,sel_32bitss
                mov     ebx,am_stack_l
                mov     ss,ax
                mov     esp,ebx
                mov     ax,sel_flatdata
                mov     es,ax

                sti

                mov     ax,sel_notpresent
                mov     ds,ax

np:
                mov     cs:[0],word ptr 0
gp0:
                mov     flg,1

                db      0eah
                dd      0
                dw      sel_codefix
gp1:
                cli

                mov     ax,sel_16bitds
                mov     ds,ax
                mov     es,ax
                mov     ax,sel_16bitss
                mov     ss,ax

                db      0eah
                dd      offset rm_return
                dw      sel_16bitcs


sys_alert00:
sys_alert01:
sys_alert02:
sys_alert03:
sys_alert04:
sys_alert05:
sys_alert06:
sys_alert07:
sys_alert08:
sys_alert09:    
sys_alert0a:
sys_alert0b:

                mov     edi,0b80a0h
                mov     esi,offset alr_np
                mov     ecx,alr_np_l
        rep     movsb

                mov     ebx,esp
                add     ebx,4+2+4+4
                mov     esp,ebx

                jmp     np
sys_alert0c:	
sys_alert0d:
                mov     ebx,esp
                add     ebx,4+2+4+4
                mov     esp,ebx

                mov     al,flg
                cmp     al,0
                jne     n0

                mov     edi,0b8140h
                mov     esi,offset alr_gp0
                mov     ecx,alr_gp0_l
        rep     movsb
                jmp     gp0

n0:
                mov     edi,0b81e0h
                mov     esi,offset alr_gp1
                mov     ecx,alr_gp1_l
        rep     movsb
                jmp     gp1

sys_alert0e:
sys_alert0f:
sys_alert10:
sys_alert11:
sys_alert12:
sys_alert13:
sys_alert14:
sys_alert15:
sys_alert16:
sys_alert17:
sys_alert18:
sys_alert19:
sys_alert1a:
sys_alert1b:
sys_alert1c:
sys_alert1d:
sys_alert1e:
sys_alert1f:
any_app_ints:
                iretd

irq0_7:
                push    eax
                mov     al,20h
                out     20h,al
                pop     eax

                iretd

irq8_15:
                push    eax
                mov     al,20h
                out     0a0h,al
                pop     eax

                iretd

pm_seg          ends


am_stack        segment para stack 'STACK'

                db      1000h dup(?)
am_stack_l      equ     $-am_stack

am_stack        ends

end             start
