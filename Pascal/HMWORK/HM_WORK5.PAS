program home_work;
uses crt;
label
 start;
const
 den:array[0..6] of string=
 (
 '����ᥭ�','�������쭨�','��୨�','�।�','��⢥�','��⭨�','�㡡��'
 );
 month:array[1..12] of string=
 (
 '������','���ࠫ�','����','��५�','���','���','���',
 '������','�������','������','�����','�������'
 );
var
 c,d,m:byte;
 h,min,sec,sot:byte;
 g,kod:word;
 len:byte;
 prm:string[2];
 id,im,iy:byte;
 q:integer;
 nm:boolean;
procedure getdate;assembler;
 asm
  mov ah,2ah
  int 21h
  mov c,al
  mov d,dl
  mov m,dh
  mov g,cx
 end;

procedure gettime;assembler;
 asm
  mov ah,2ch
  int 21h
  mov h,ch
  mov min,cl
  mov sec,dh
  mov sot,dl
end;





function getkey:word;
 label
  sop;
 var
  ml,mh:byte;
 begin
  getkey:=0;
  repeat
  gettime;
  gotoxy(1,4);write('���⥬��� �६� ',h,':',min,':',sec,':',sot,'   ');
  getdate;
  gotoxy(37,4);write('���⥬��� ��� ',den[c],',',d,' ',month[m],' ',g,' ����');
   asm
    mov ah,01h
    int 16h
    jne sop
   end;
  until 0<0;
sop:
  asm
   xor ah,ah
   int 16h
   mov ml,al
   mov mh,ah
  end;
  if ml=0 then  getkey:=256+mh else getkey:=ml;
 end;

begin
 clrscr;
 asm
  mov ah,01h
  mov ch,20h
  int 10h
 end;
 gotoxy(12,1);write('-+-+-+-+-+-+-+-+[ �᫨ ����㯨� ����� ]+-+-+-+-+-+-+-+-');
 gotoxy(3,25);write('������ ���� � ���� ��.��.�� � 㧭��� ����� ���� ����� ���� ����㯨� �����');
 gotoxy(25,14);write('�ਬ�砭�� ->                                              ');
start:
 id:=0;im:=0;iy:=0;nm:=false;
 gotoxy(25,12);write('�����     ->                                              ');
 gotoxy(25,10);write('�������    ->                                              ');
 len:=0;prm:='';
 repeat
  kod:=getkey;
  len:=len+1;
  if len>8 then len:=9;
  gotoxy(41,14);write('                                                 ');
  case kod of
   27:begin
       clrscr;
       write('(c) Michael');
       halt;
      end;
   32:begin
       id:=31;im:=12;iy:=00;
       break;
      end;
   46:begin
       if len mod 3<>0 then
        begin
         gotoxy(41,14);write('������ ����� �᫠ �� 0 �� 9 ��� "."');
         len:=len-1;
        end
       else
        begin
         if len>8 then
          begin
           gotoxy(41,14);write('������ ������ ENTER');
          end
         else
          begin
           gotoxy(40+len,10);write('.');
           prm:='';
         end;
        end;
      end;
   13:begin
       if len<8 then
        begin
         gotoxy(41,14);write('��� ��⠫��� ����� �� ����');
         len:=len-1;
        end
       else
        break;
      end;
  else
   begin
    if len>8 then
     begin
      gotoxy(41,14);write('������ ������ ENTER');
     end
    else
    if (kod<48) or (kod>57) then
     begin
      gotoxy(41,14);write('������ ����� �᫠ �� 0 �� 9 ��� "."');
      len:=len-1;
     end
    else
    if len mod 3=0 then
     begin
      gotoxy(41,14);write('������ ����� "."');
      len:=len-1;
     end
    else
     begin
      prm:=prm+chr(kod);
      gotoxy(40+len,10);write(chr(kod));
      if len=2 then val(prm,id,q);
      if len=5 then val(prm,im,q);
      if len=8 then val(prm,iy,q);
     end;
   end;
  end;
 until 0<0;
 gotoxy(41,14);write('                                                 ');
 if (id>31)or(im>12)or(im<1)or(id<1) then
  begin
   gotoxy(41,14);write('��㡠� �訡�� �� ����� ����');
   goto start;
  end;
 if im=2 then
  begin
   if iy mod 4 =0 then
    begin
     if id>29 then
      begin
       gotoxy(41,14);write('��㡠� �訡�� �� ����� ����');
       goto start;
      end;
     if id=29 then nm:=true;
    end
   else
    begin
     if id>28 then
      begin
       gotoxy(41,14);write('��㡠� �訡�� �� ����� ����');
       goto start;
      end;
     if id=28 then nm:=true;
    end;
  end
 else
 if im<8 then
  begin
   if im mod 2=0 then
    begin
     if id>30 then
      begin
       gotoxy(41,14);write('��㡠� �訡�� �� ����� ����');
       goto start;
      end;
     if id=30 then nm:=true;
    end
   else
    if id=31 then nm:=true;
  end
 else
  begin
   if im mod 2<>0 then
    begin
     if id>30 then
      begin
       gotoxy(41,14);write('��㡠� �訡�� �� ����� ����');
       goto start;
      end;
     if id=30 then nm:=true;
    end
   else
    if id=31 then nm:=true;
  end;


 if nm=true then
  begin
   id:=1;im:=im+1;
   if im>12 then
    begin
     iy:=iy+1;
     im:=1;
    end;
   if iy>99 then iy:=0;
  end
 else
 id:=id+1;
 if iy<10 then
  begin
   gotoxy(25,12);write('�����     ->   ',id,' ',month[im],' ','190',iy,' ����');
  end
 else
  begin
   gotoxy(25,12);
   write('�����     ->   ',id,' ',month[im],' ','19',iy,' ����');
  end;
 if (id=1)and(im=1)and(iy=0) then
  begin
   gotoxy(41,14);write('�஡���� 2000 � ����⢨�');
  end
 else
 if (id=1)and(im=1) then
  begin
   gotoxy(41,14);write('� ����� ����� ��� ��������!!!');
  end;
 getkey;
 goto start;
end.