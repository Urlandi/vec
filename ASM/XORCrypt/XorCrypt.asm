RUN_BUTTON		equ	201
ABOUT_BUTTON		equ	202
CKEY_CHANGE		equ	0300006Fh
EDIT_KEY1		equ	111
EDIT_KEY2		equ	112
EDIT_OT			equ	101
EDIT_ET			equ	102
EDIT_DT			equ	103


.386
.model flat,stdcall

includelib c:\masm32\lib\kernel32.lib
includelib c:\masm32\lib\user32.lib

include c:\masm32\include\windows.inc
include c:\masm32\include\kernel32.inc
include c:\masm32\include\user32.inc

dlg_call PROTO

.data

	dlg		db	"EC",0


	about_message	db	"Лабораторная работа №1",13,10,"Методы и средства защиты информации",13,10
			db	"Выполнил студент: М.Ю. Васильев, ИВТ-462",13,10
                        db      "pmack@mail.ru",13,10
			db	"ВолгГТУ 2004",0
	about_title	db	"Зачем...",0
	error1		db	"Не задан исходный текст для обработки",0
	error2		db	"Не задан ключ 1",0
	error3		db	"Не задан ключ 2",0
	error_title	db	"Внимание!",0





	key1		db	8 dup(0)
keylength		equ	$-key1		
	key2		db	8 dup(0)

	open_text	db	128 dup(0)
textlength		equ	$-open_text
	
	encrypt_text	db	128 dup(0)
	decrypt_text	db	128 dup(0)
	sencrypt_text	db	128 dup(0)
	

	tablo		db	32 dup(0)
lengthtable		equ	$-tablo
	tablc		db	32 dup(0)

	bloki		dd	0

.code

_WMain:

			xor	ebx,ebx

		invoke	GetModuleHandle,ebx

		invoke	DialogBoxParam,eax,offset dlg,ebx,offset dlg_call,ebx

		invoke	ExitProcess,ebx


dlg_call		proc	near
		
			push	ebp
			mov	ebp,esp

hWndDlg			equ	dword ptr ss:[ebp+08h]
uMsg			equ	dword ptr ss:[ebp+0Ch]
wParam			equ	dword ptr ss:[ebp+10h]
lParam			equ	dword ptr ss:[ebp+14h]
			
			push	ebx			

			mov	ebx,hWndDlg			
			mov	eax,uMsg
			

			cmp	eax, WM_CLOSE
			jne	c1

		invoke	EndDialog,ebx,0
			

c1:			cmp	eax,WM_COMMAND
			jne	def_run
			
			mov	eax,wParam
			cmp	eax,ABOUT_BUTTON
			jne	c2

		invoke	MessageBox,0,offset about_message,offset about_title,MB_ICONINFORMATION
			
			jmp	ZG

c2:			cmp	eax,RUN_BUTTON
			jne	c3


		invoke	GetDlgItemText,ebx,EDIT_KEY1,offset key1,keylength
			
			test	eax,eax
			jnz	g1

		invoke	MessageBox,0,offset error2,offset error_title,MB_ICONHAND
			
			jmp	ZG
			
g1:			push	offset key1			
						
		invoke	GetDlgItemText,ebx,EDIT_OT,offset open_text,textlength
			
			test	eax,eax
			jnz	g2
			
			pop	eax

		invoke	MessageBox,0,offset error1,offset error_title,MB_ICONHAND
			
			jmp	ZG

g2:			mov	[sencrypt_text+eax],0
			mov	[encrypt_text+eax],0
			mov	[decrypt_text+eax],0

			push	offset open_text
			push	offset sencrypt_text
			shr	eax,3

			push	eax
			mov	bloki,eax

			call	shuffler

			push	offset key1
			push	offset sencrypt_text
			push	offset encrypt_text			

			call	xor_crypter

		invoke	GetDlgItemText,ebx,EDIT_KEY2,offset key2,keylength		

			test	eax,eax
			jnz	g3

		invoke	MessageBox,0,offset error3,offset error_title,MB_ICONHAND
			
			jmp	ZG

g3:			push	offset key2
			push	offset encrypt_text
			push	offset sencrypt_text

			call	xor_crypter
				
			push	offset key2
			push	offset sencrypt_text
			push	offset decrypt_text
			mov	eax,bloki
			push	eax
			
			call	shuffler

		invoke	SetDlgItemText,ebx,EDIT_ET,offset encrypt_text


		invoke	SetDlgItemText,ebx,EDIT_DT,offset decrypt_text

			jmp	ZG

c3:			cmp	eax,CKEY_CHANGE
			jne	c4

		invoke	GetDlgItemText,ebx,EDIT_KEY1,offset key1,keylength
						
								
		invoke	SetDlgItemText,ebx,EDIT_KEY2,offset key1

			jmp	ZG
c4:

def_run:		xor	ebx,ebx

ZG:			mov	eax,ebx
			
			pop	ebx				

			leave
			ret	16

	
dlg_call		endp



;В стеке передаём адреса на исходные данные, ключ и результат

xor_crypter		proc

			push	ebp
			mov	ebp,esp

outtextaddr		equ	dword ptr ss:[ebp+08h]
intextaddr		equ	dword ptr ss:[ebp+0Ch]
keyaddr			equ	dword ptr ss:[ebp+10h]
			
			push	ebx
			push	edi
			push	esi

			
			xor	ecx,ecx
			mov	ebx,keyaddr
			mov	edi,intextaddr
			mov	esi,outtextaddr
			
try_again:		mov	al,ds:[ebx+ecx]
			test	al,al	
			jnz	doit
			xor	ecx,ecx
			jmp	try_again

doit:			mov	ah,ds:[edi]
			test	ah,ah
			jz	thats_all

			cmp	ah,0B6h
			jne	xorit
			xor	ah,ah
				
xorit:			xor	al,ah
			jnz	zer_good
			mov	al,0B6h

zer_good:		mov	ds:[esi],al
			
			inc	ecx
			inc	edi
			inc	esi

			jmp	try_again
			
thats_all:		pop	esi			
			pop	edi
			pop	ebx
			
			leave
			ret 12

xor_crypter		endp



;В стеке передаём адреса на исходные данные, ключ,результат и кол-во перестановок

shuffler		proc

			push	ebp
			mov	ebp,esp

blocks			equ	dword ptr ss:[ebp+08h]
outtextaddr		equ	dword ptr ss:[ebp+0Ch]
intextaddr		equ	dword ptr ss:[ebp+10h]
keyaddr			equ	dword ptr ss:[ebp+14h]
					
			push	ebx
			push	edi
			push	esi

			mov	ecx,textlength
			mov	esi,intextaddr
			mov	edi,outtextaddr
			cld
rep			movsb

			mov	ecx,blocks			
			test	ecx,ecx
			jz	zonder

			mov	ebx,keyaddr
			xor	eax,eax
			
			xor	edx,edx	
			mov	ecx,4

r11:			shl	edx,8
r1:			mov	dl,ds:[ebx+eax]
			test	dl,dl
			jnz	cadd	
			xor	eax,eax
			jmp	r1

cadd:			inc	eax
			dec	ecx
			jnz	r11


			mov	edi,offset tablo
			mov	esi,offset tablc

			mov	eax,blocks
			mov	ebx,eax	

			mov	ecx,eax
			shl	ecx,2
			
			dec	eax
			dec	ebx

r2:			shl	edx,1
			jnc	N0

			mov	byte ptr ds:[edi+ebx],cl

			test	ebx,ebx
			jnz	folk1

			xor	edx,edx

folk1:			dec	ebx
			jmp	corrective

N0:			mov	byte ptr ds:[esi+eax],cl

			test	eax,eax
			jnz	folk2

			xor	edx,edx
			dec	edx

folk2:			dec	eax			

corrective:		test	ecx,ecx
			jz	rout
			sub	ecx,4
			jmp	r2

rout:			mov	ebx,edi
			mov	edi,intextaddr
			mov	esi,outtextaddr

			xor	eax,eax
			mov	ecx,blocks

r3:			mov	al,byte ptr ds:[ebx]
			mov	edx,dword ptr ds:[edi+eax]

			mov	al,byte ptr ds:[ebx+lengthtable]
			mov	dword ptr ds:[esi+eax],edx

			mov	edx,dword ptr ds:[edi+eax]

			mov	al,byte ptr ds:[ebx]		
			mov	dword ptr ds:[esi+eax],edx

			inc	ebx
			dec	ecx
			jnz	r3

zonder:			pop	esi			
			pop	edi
			pop	ebx

			leave
			ret 16

shuffler		endp




end _WMain
