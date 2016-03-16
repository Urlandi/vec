program home_work;
uses crt;
var
 num:byte;
function keykod:word;{Получаем код нажатой клавиши}
  var
   kodal:byte;
   kodah:byte;
  begin
   asm
    mov ah,0
    int 16h
    mov kodal,al    {ASCII код}
    mov kodah,ah    {Скан код}
   end;
   keykod:=kodal;
   if kodal=0 then keykod:=kodah+255
  end;
 function inputnumber(x,y,cf,c:byte;min,max:integer):byte;
 label
 err;
 var
  dec,m:boolean;
  num:word;
  pol:byte;
  prom:string[24];
 begin
  m:=false;dec:=false;
  textbackground(7);
  gotoxy(x,y);write(' ');
  prom:='';
  repeat
   num:=keykod;
   case num of
   13:begin
       textbackground(cf);
       gotoxy(x+length(prom),y);write(' ');
       val(prom,pol,num);
       if (pol>max) or (pol<min) then
       begin
        textbackground(cf);
        gotoxy(x,y);write('                              ');
        pol:=0;
        prom:='';
        goto err;
       end;
        inputnumber:=pol;
        break;
      end;
    8:begin
       if prom[length(prom)]='.' then dec:=false;
       if prom[length(prom)]='-' then goto err;
       delete(prom,length(prom),1);
      end;
    45:begin
        if m=false then begin prom:='-'+prom;m:=true; end
        else begin delete(prom,1,1);m:=false; end;
       end;
 46,44:begin
        if dec=true then goto err;
        dec:=true;
        prom:=prom+'.';
       end;
   else
    if (num<48) or(num>57) then goto err;
    if length(prom)>2 then goto err;
    prom:=prom+chr(num);
   end;
   err:
   textbackground(cf);
   gotoxy(x,y);write('                                       ');
   textcolor(c);textbackground(cf);
   gotoxy(x,y);write(prom);
   textbackground(cf);gotoxy(x+length(prom)+1,y);write(' ');
   textbackground(7);
   gotoxy(x+length(prom),y);
   write(' ');
  until 0<0
 end;
begin
 asm
  mov ah,01h
  mov ch,20h
  int 10h
 end;
repeat
 textbackground(2);
 clrscr;
 textcolor(10);
 gotoxy(27,1);write('Почти Dec<=>Hex конвектор');
 textcolor(13);
 gotoxy(1,24);write('Введите произвольное число от 0 до 15                  ');
 textcolor(14);
 gotoxy(1,3);write('Пожалуйста вводите>');
 num:=inputnumber(21,3,2,15,0,15);
 textcolor(11);
 gotoxy(15,5);write('Ваше число           Результат в Hex');
 textcolor(10);
 gotoxy(15+15,5);write(num);
 if num<10 then
  begin
   gotoxy(42+15,5);write(num);
  end
 else
  begin
   gotoxy(42+15,5);write(chr(55+num));
  end;
 textcolor(13);
 gotoxy(1,24);write('Нажмите Enter для выхода или любую клавишу для продолжения');
 if keykod=13 then break;
until 0<0;
 textcolor(7);textbackground(0);
 clrscr;
 write('В программе были исопльзованы элементы REYA(Modul1.tpu)');
end.