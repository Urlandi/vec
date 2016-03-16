program home_work;
uses crt;
var
q:byte;
cb,cv,sm:real;
num:real;
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
 function inputnumber(x,y,cf,c:byte;min,max:real):real;
 label
 err;
 var
  dec,m:boolean;
  num:word;
  pol:real;
  prom:string[24];
 begin
  m:=false;dec:=false;
  textbackground(cf);write('                                ');
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
       if (pol>max) or (pol<min) or (trunc(pol)<>pol) then
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
    if length(prom)>8 then goto err;
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
 cv:=0;cb:=0;sm:=0;
 textbackground(3);textcolor(12);clrscr;
 gotoxy(33,1);write('Чет или неЧет');
 textcolor(13);
 gotoxy(1,24);write('Введите 10 целых чисел');
 for q:=1 to 10 do
  begin
   textcolor(5);
   gotoxy(1,3);write('Пожалуйста вводите>');
   num:=inputnumber(21,3,3,14,-999999999,999999999);
   if odd(round(num))=true then
    begin
     textcolor(10);
     cb:=cb+num*num*num
    end
    else
     begin
      textcolor(14);
      cv:=cv+num*num
     end;
   sm:=sm+num;
   gotoxy(40,q+3);write(q-1,') ',num:0:0);
   textcolor(5);
   gotoxy(40,14);write('Sum ',sm:0:0);
   textcolor(14);
   gotoxy(40,15);write('^2) ',cv:0:0);
   textcolor(10);
   gotoxy(40,16);write('^3) ',cb:0:0);
  end;
textcolor(13);
 gotoxy(1,24);write('Нажмите Enter для выхода или любую клавишу для продолжения');
 if keykod=13 then break;
until 0<0;
 textcolor(7);textbackground(0);
 clrscr;
 write('В программе были исопльзованы элементы REYA(Modul1.tpu)');
end.