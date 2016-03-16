program Home_work;
uses crt;
const
 l=9;
type
 st=string[32];
 vedom=record
        name:st;
        ocen:array[1..5] of byte;
        disc:array[1..5] of st;
       end;
var
student:array[1..l] of vedom;
symb:word;
q,x,y:integer;
sr:real;
function keykod:word;
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
function inputtext(x,y,l,cf,c:byte;stroka:st):st;
  label
   err;
  var
   polsymb:word;
   tekpol:byte;
  begin
   tekpol:=length(stroka)+1;
   textcolor(c);textbackground(cf);
   gotoxy(x,y);write('                                 ');
   gotoxy(x,y);write(stroka);
   gotoxy(x+tekpol-1,y);
   repeat
    polsymb:=keykod;
    case polsymb of
     13:begin
         textcolor(c);textbackground(cf);
         gotoxy(x+tekpol-1,y);
         inputtext:=stroka;
         break;
        end;
      8:begin
         tekpol:=tekpol-1;
         if tekpol <1 then
         begin
          tekpol:=1;
          goto err;
         end;
         delete(stroka,tekpol,1);
        end;
    332:begin
         tekpol:=tekpol+1;
         if tekpol>l then tekpol:=l;
        end;
    330:begin
         tekpol:=tekpol-1;
         if tekpol<1 then tekpol:=1;
        end;
    338:begin
         delete(stroka,tekpol,1);
        end;
    else
     if ((polsymb<128) or (polsymb>239)) and (polsymb<>32) then goto err;
     if tekpol=l then
     begin
      tekpol:=l;
      goto err;
     end;
     insert(chr(polsymb),stroka,tekpol);tekpol:=tekpol+1;
    end;
   textcolor(c);textbackground(cf);
   gotoxy(x,y);write('                                 ');
   gotoxy(x,y);stroka:=copy(stroka,1,l);write(stroka,' ');
   gotoxy(x+tekpol-1,y);
   err:
   until 0<0;
  end;
begin
 textbackground(1);textcolor(14);
 clrscr;
 for y:=1 to l do
  begin
   student[y].name:='';
   for x:=1 to 5 do
    student[y].disc[x]:=''
  end;
 gotoxy(1,1);
 write('[++++++++++++++++++++++++++++++++] Beдомость [+++++++++++++++++++++++++++++++++]');
 y:=1;x:=1;
repeat
 textcolor(14);textbackground(1);
 gotoxy(28,2);write('                               ');
 for q:=1 to 5 do
  begin
   gotoxy(2,q+6);write('                               ');
  end;
 gotoxy(19,2);write('Студента ',student[y].name);
 gotoxy(2,4);write('[Предметы]');gotoxy(40,4);write('Оценки');
 gotoxy(50,15);write('Средний балл: ',sr:0:3);
 for q:=1 to 5 do
  begin
   if q=x then
    begin
     gotoxy(1,q+6);write('');
     textcolor(11);textbackground(4);
    end
   else
    begin
     textcolor(14);textbackground(1);
     gotoxy(1,q+6);write(' ');
    end;
   gotoxy(2,q+6);write(student[y].disc[q]);
   gotoxy(40,q+6);write(student[y].ocen[q]);
  end;
 symb:=keykod;
 {write(symb);}
 case symb of
  27:break;
  32:begin
      student[y].name:=inputtext(28,2,32,1,14,student[y].name);
     end;
  327:begin
       x:=x-1;
       if x<1 then x:=5;
      end;
  335:begin
       x:=x+1;
       if x>5 then x:=1;
      end;
  332:begin
       y:=y+1;if y>l then y:=1;
      end;
  330:begin
       y:=y-1;if y<1 then y:=l;
      end;
  128..239:begin
            student[y].disc[x]:=inputtext(2,x+6,32,1,14,student[y].disc[x]+chr(symb));
           end;
  49..53:begin
          gotoxy(40,x+6);write(chr(symb));student[y].ocen[x]:=symb-48;
         end;
 end;
 sr:=0;
 for q:=1 to 5 do
  sr:=sr+student[y].ocen[q];
 sr:=sr/5
until 0<0;
end.