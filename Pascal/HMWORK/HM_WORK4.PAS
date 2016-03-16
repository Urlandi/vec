program home_work;
uses crt;
var
 x,y,q:byte;
 d:char;
 n:boolean;
begin
 asm
  mov ah,01h
  mov ch,20h
  int 10h
 end;
 clrscr;
 gotoxy(30,1);write('Код в ASCII таблице');
 gotoxy(1,24);write('Нажатие дважды на Enter завершает программу');
 q:=0;x:=8;
 while x<72 do
  begin
   for y:=5 to 12 do
    begin
     if q<>7 then
      begin
       gotoxy(x,y);write(chr(q));
      end;
     q:=q+1;if q=255 then break;
    end;
   x:=x+2;
   if q=255 then break;
  end;
 repeat
  d:=readkey;
  q:=0;x:=8;
  while x<72 do
   begin
    for y:=5 to 12 do
     begin
      if q<>7 then
       begin
        if q=ord(d) then
         begin
          textcolor(15);textbackground(1);
         end
        else
         begin
          textcolor(7);textbackground(0);
         end;
        gotoxy(x,y);write(chr(q));
       end;
      q:=q+1;if q=255 then break;
     end;
    x:=x+2;
    if q=255 then break;
   end;
  textcolor(7);textbackground(0);
  gotoxy(30,15);write('Символ     Код  ',ord(d),'   ');
  gotoxy(38,15);write(d);
  if (n=true) and (ord(d)=13) then break else n:=false;
  if ord(d)=13 then n:=true
 until 0<0;
end.