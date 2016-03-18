.model tiny
.code
.startup
jmp short Entry_point
dosapicall            dw 'SU'
dosapicall_seg        dw 'RS'

fcall                 proc
                      cmp ah,30h
                      je  fake
                      jmp dword ptr cs:dosapicall
fake:
                      iret
fcall                 endp

Sign                  db 'Sign',10,13,'$'
Entry_point:
                      mov ah,09h
                      mov dx,offset sign
                      int 21h

                      mov ah,30h
                      int 21h
                      cmp al,07h
                      jne  stop_end

                      mov ax,3521h
                      int 21h
                      mov dosapicall,bx
                      push es
                      pop ax
                      mov dosapicall_seg,ax

                      mov ax,2521h
                      mov dx,offset fcall
                      int 21h

                      mov bx,2ch
                      mov es,es:[bx]
                      mov ah,49h
                      int 21h

                      mov dx,120h
                      int 27h
stop_end:
                      retn
end