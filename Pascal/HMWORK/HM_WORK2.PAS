program home_work;
uses crt;
var
 num1,num2,num3:real;
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
        m:=false;dec:=false;
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
    if length(prom)>24 then goto err;
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
 textbackground(1);textcolor(14);clrscr;
 gotoxy(30,1);write('+1<Игра с числами>1-');
 textcolor(13);
 gotoxy(1,24);write('Введите три числа                                       ');
 textcolor(15);
 gotoxy(1,3);write('1>');
 gotoxy(1,5);write('2>');
 gotoxy(1,7);write('3>');
 num1:=inputnumber(4,3,1,3,-999999,999999);
 num2:=inputnumber(4,5,1,3,-999999,999999);
 num3:=inputnumber(4,7,1,3,-999999,999999);
 textcolor(15);
 if (num1>num2) and (num1>num3) then begin gotoxy(40,5);write('Наибольшее  ',num1:0:3) end
 else
  if (num2>num1) and (num2>num3) then begin gotoxy(40,5);write('Наибольшее  ',num2:0:3) end
 else
  begin
   gotoxy(40,5);write('Наибольшее  ',num3:0:3);
  end;
 gotoxy(1,8);write('         >1                        >2                        >3');
 gotoxy(1,9);write('-1');gotoxy(10,9);write(num1-1:0:3);gotoxy(36,9);
 write(num2-1:0:3);gotoxy(62,9);write(num3-1:0:3);
 gotoxy(1,10);write('+1');gotoxy(10,10);write(num1+1:0:3);gotoxy(36,10);
 write(num2+1:0:3);gotoxy(62,10);write(num3+1:0:3);
 gotoxy(1,11);write('цел');gotoxy(10,11);write(trunc(num1));gotoxy(36,11);
 write(trunc(num2));gotoxy(62,11);write(trunc(num3));
 gotoxy(1,12);write('окр');gotoxy(10,12);write(round(num1));gotoxy(36,12);
 write(round(num2));gotoxy(62,12);write(round(num3));
 textcolor(13);
 gotoxy(1,24);write('Нажмите Enter для выхода или любую клавишу для продолжения');
 if keykod=13 then break;
until 0<0;
 textcolor(7);textbackground(0);
 clrscr;
 write('В программе были исопльзованы элементы REYA(Modul1.tpu)');
end.