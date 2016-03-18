include windef.inc

 EditID         equ     1
 MEMSIZE        equ     65535
.386
.model flat
.data
 class_name     db 'Class_1',0
 window_name    db 'Read Me v1.0',0
 edit_class     db 'edit',0
 file           db 'read.me!',0
 mtext          db 'ERROR! File <READ.ME!> NOT FOUND!',13,10,\
                   'Œÿ»¡ ¿! ‘‡ÈÎ <READ.ME!> Õ≈ Õ¿…ƒ≈Õ!',0

 window_setup    WNDCLASSEX <SIZE WNDCLASSEX,CS_HREDRAW or CS_VREDRAW,offset window_procedure,\
                            0,0,?,?,?,COLOR_WINDOW+1,0,offset class_name,0>
 window_message MSG <?,?,?,?,?,?>

.data?
 rw_size        dd ?
 rec            RECT <>
 h_edit         dd ?
.code
_start:
                xor     ebx,ebx
                push    ebx
                Call    GetModuleHandleA
                mov     esi,eax
                mov     window_setup.hInstance,eax

                push    9
                push    esi
                Call    LoadIconA
                mov     window_setup.hIcon,eax
                push    IDC_ARROW
                push    ebx
                Call    LoadCursorA
                mov     window_setup.hCursor,eax
                push    offset window_setup
                Call    RegisterClassExA
                mov     ecx,CW_USEDEFAULT
                push    ebx
                push    esi
                push    ebx
                push    ebx
                push    ecx
                push    ecx
                push    ecx
                push    ecx
                push    WS_OVERLAPPEDWINDOW
                push    offset window_name
                push    offset class_name
                push    ebx
                Call    CreateWindowExA
                push    eax
                push    SW_SHOWNORMAL
                push    eax
                Call    ShowWindow
                Call    UpdateWindow
                mov     edi,offset window_message
message_loop:
                push    ebx
                push    ebx
                push    ebx
                push    edi
                Call    GetMessageA
                test    eax,eax
                jz      exit_msg_loop
                push    edi
                Call    TranslateMessage
                push    edi
                Call    DispatchMessageA
                jmp     short message_loop
exit_msg_loop:
                push    ebx
                Call    ExitProcess

window_procedure proc
wp_hWnd         equ     dword ptr [ebp+08h]
wp_uMsg         equ     dword ptr [ebp+0Ch]
wp_wParam       equ     dword ptr [ebp+10h]
wp_lParam       equ     dword ptr [ebp+14h]

                push    ebp
                mov     ebp,esp

                pusha
                xor     ebx,ebx
                mov     eax,wp_uMsg
                mov     esi,wp_hWnd

                cmp     eax,WM_CREATE
                je      wm_create

                cmp     eax,WM_SIZE
                je      wm_size

                cmp     eax,WM_ACTIVATE
                je      wm_activate

                cmp     eax,WM_DESTROY
                je      wm_destroy

                popa
                leave
                Jmp     DefWindowProcA

wm_create:
                push    ebx
                push    window_setup.hInstance
                push    EditID
                push    esi
                push    ebx
                push    ebx
                push    ebx
                push    ebx
                push    WS_VISIBLE or WS_CHILD or ES_LEFT or ES_MULTILINE\
                        or ES_READONLY\
                        or WS_HSCROLL or WS_VSCROLL or WS_BORDER
                push    ebx
                push    offset edit_class
                push    ebx
                Call    CreateWindowExA
                mov     h_edit,eax

                push    eax
                Call    SetFocus

                push    ebx
                push    FILE_ATTRIBUTE_ARCHIVE
                push    OPEN_EXISTING
                push    ebx
                push    FILE_SHARE_READ or FILE_SHARE_WRITE
                push    GENERIC_READ or GENERIC_WRITE
                push    offset file
                Call    CreateFileA
                mov     edi,eax

                cmp     eax,INVALID_HANDLE_VALUE
                je     _err

                push    MEMSIZE
                push    GMEM_MOVEABLE or GMEM_ZEROINIT
                Call    GlobalAlloc

                push    eax
                push    eax
                Call    GlobalLock
                push    eax
                push    eax

                push    ebx
                push    offset rw_size
                push    MEMSIZE-1
                push    eax
                push    edi
                Call    ReadFile

                push    ebx
                push    WM_SETTEXT
                push    h_edit
                Call    SendMessageA

                Call    GlobalUnlock
                Call    GlobalFree
                push    edi
                Call    CloseHandle

                jmp     short end_wm_check


wm_activate:
                push    h_edit
                Call    SetFocus
                jmp     short end_wm_check

wm_size:
                push    offset rec
                push    esi
                Call    GetClientRect

                push    1
                push    rec.Bottom
                push    rec.Right
                push    ebx
                push    ebx
                push    h_edit
                Call    MoveWindow

                jmp     short end_wm_check

_err:
                push    offset mtext
                push    ebx
                push    WM_SETTEXT
                push    h_edit
                Call    SendMessageA
                jmp     short end_wm_check

wm_destroy:
                push    ebx
                Call    PostQuitMessage

end_wm_check:
                popa
                xor eax,eax
                leave
                ret 16

window_procedure endp

end             _start