include windef.inc
.486p
.model flat
.const
tt              db      'Тест защиты i486+Win',0
mm              db      'Выполнение привилегированной команды mov cr0,eax',0
.code
_start:
                push    MB_ICONEXCLAMATION
                push    offset tt
                push    offset mm
                push    0
                Call    MessageBoxA
                xor     eax,eax
                mov     cr0,eax
                push    0
                Call    ExitProcess
end             _start
