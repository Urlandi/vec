program Home_work;
uses crt;
const
 ned:array[1..8] of string=
 (
  '�������쭨�','��୨�','�।�','��⢥�','��⭨�','�㡡��', '����ᥭ�','Comment>'
 );
var
 kod,q:word;h:boolean;
function getkey:word;
 var
  ml,mh:byte;
 begin
  getkey:=0;
  asm
   xor ah,ah
   int 16h
   mov ml,al
   mov mh,ah
  end;
  if ml=0 then  getkey:=256+mh else getkey:=ml;
 end;

begin
 asm
  mov ah,01h
  mov ch,20h
  int 10h
 end;
 clrscr;
 gotoxy(14,1);write('/\/\/\/\/\/\/\/\/\| ���� NoteBook |/\/\/\/\/\/\/\/\/\');
 gotoxy(12,25);write('������ ���� ���� �� 1 �� 7 � 㢨��� � �� �� 㢨���');
repeat
 for q:=1 to 8 do
  begin
   if (q=kod-48) and (q<6) then textcolor(11)else
   if (q=6) and(kod=54) then textcolor(12-ord(h))else
   if (q=7) and(kod=55) then textcolor(12)else textcolor(7);
   gotoxy(35,q+3);write(ned[q]);
  end;
 kod:=getkey;
 gotoxy(45,11);write('                                                     ');
 case kod of
  27:begin clrscr;halt;end;
  54:begin
      gotoxy(45,11);write('������ �� �᫨ ��室�o�');
      if getkey<>54 then h:=true else h:=false;
     end;
 else
 if (kod<49) or (kod>55) then begin gotoxy(45,11);write('�訡�窠 ��諠');end;
 end;
until 0<0
end.