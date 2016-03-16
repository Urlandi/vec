{$I-}
program opros_piplov;
uses crt;
const
 opr=999;
 name:string[12]='data.dta';
var
 q:longint;
 r:longint;
 Ma,Mb,Mc:real;
 dta:text;
 data_spros:word;
 spros:array[1..opr] of longint;
 tbesed:array[1..opr] of longint;
 tableA:array[0..255] of integer;
 tableB:array[0..255] of integer;
 tableC:integer;
 col:integer;
 dataA:record
        incp,minp,maxp:shortint;
       end;
 dataB:record
        incp,minp,maxp:shortint;
       end;
 besed,rbesed:longint;
 proh:longint;
 AA,otkaz,zspros,B,mimo,t:longint;

function number_read(symb:byte;start:longint):longint;
 var
  rc:char;
  s:string;
  count:integer;
  out:longint;
 begin
  str(start,s);
  count:=length(s);
  out:=0;
  write(s);
 repeat
  repeat
   rc:=readkey;
   case rc of
    '0'..'9':begin
              if count<symb then
               begin
                write(rc);
                s:=s+rc;
                inc(count);
               end;
             end;
    #8:if count>0 then
        begin
         delete(s,count,1);
         dec(count);
         write(#8,#32,#8);
        end;
   end;
  until (rc=#13);
  val(s,out,count);
  if out<>0 then break;
  count:=length(s);
 until 0<0;
  number_read:=out;
 end;

function read_dta(var dta:text):longint;
 var
  r:string;
  out:longint;
  q:integer;
 begin
  out:=0;
  repeat
   if ioresult<>0 then break;
   readln(dta,r);
   if r[0]=#0 then continue;
   if (r[1]>='0')and (r[1]<='9')then
    begin
     for q:=2 to 5 do
      if (r[q]<'0')or (r[q]>'9') then break;
     delete(r,q,length(r)-q+1);
     val(r,out,q);
     read_dta:=out;
     exit;
    end
   else
    if r[1]='F' then
     begin
      read_dta:=-1;
      exit;
     end;
  until (0<0) or (eof(dta));
  read_dta:=-1;
  writeln('Ошибка чтения в файле данных. Немедленное завершение!');
  halt;
 end;
begin

if paramcount=1 then name:=paramstr(1);
assign(dta,name);
reset(dta);

col:=read_dta(dta);
dataA.incp:=read_dta(dta);
dataA.minp:=read_dta(dta);
dataA.maxp:=read_dta(dta);
Ma:=0;
for q:=0 to (dataA.maxp-dataA.minp) div dataA.incp do
 begin
  tableA[q]:=read_dta(dta);
  if q=0 then proh:=-1 else proh:=tableA[q-1];
  Ma:=(q*dataA.incp+dataA.minp)*(tableA[q]-proh)/col+Ma
 end;
dataB.incp:=read_dta(dta);
dataB.minp:=read_dta(dta);
dataB.maxp:=read_dta(dta);
Mb:=0;
for q:=0 to (dataB.maxp-dataB.minp) div dataB.incp do
 begin
  tableB[q]:=read_dta(dta);
  if q=0 then proh:=-1 else proh:=tableB[q-1];
  Mb:=(q*dataB.incp+dataB.minp)*(tableB[q]-proh)/col+Mb
 end;
tableC:=read_dta(dta);
Mc:=(tableC+1)/col;
close(dta);
data_spros:=0;
besed:=0;
repeat
textmode(3);
write('Введите число людей опрашивающих прохожих: ');
data_spros:=number_read(3,data_spros);
writeln;
write('Введите требуемое количество бесед: ');
besed:=number_read(6,besed);

asm
 mov ch,20h
 mov ah,1h
 int 10h
end;

gotoxy(1,4);
writeln('Прошло прохожих:');
writeln('Отказались отвечать:');
writeln('Не успели спросить:');
writeln('Задействовано опрашивающих:');
writeln('Произведено бесед:');
writeln('Прошло времени:');
writeln('Время на разговоры: ');
writeln('Время ожидания прохожего: ');
writeln('Среднее время беседы: ');
writeln('Погрешность модели: ');
randomize;
for q:=1 to opr do
 begin
  spros[q]:=0;
  tbesed[q]:=0;
 end;
rbesed:=0;proh:=0;
AA:=0;otkaz:=0;zspros:=0;mimo:=0;t:=0;
repeat
 if keypressed then if readkey=#27 then
  begin
   gotoxy(1,23);writeln('Прервано пользователем');
   break;
  end;
 inc(proh);
 r:=random(col);
 for q:=0 to (dataA.maxp-dataA.minp) div dataA.incp do
  if r<=tableA[q] then break;
 AA:=AA+q*dataA.incp+dataA.minp;

 r:=random(col);
 if r>=tableC+1 then
  begin
   inc(otkaz);
   continue;
  end;

 r:=random(col);
 for q:=0 to (dataB.maxp-dataB.minp) div dataB.incp do
  if r<=tableB[q] then break;

 B:=q*dataB.incp+dataB.minp;
 for q:=1 to data_spros do
  begin
   if (AA>spros[q])or((AA=0)and(spros[q]=0)) then
    begin
     if zspros<q then zspros:=q;
     spros[q]:=AA+B;
     tbesed[q]:=tbesed[q]+B;
     t:=t+B;
     inc(rbesed);
     break;
    end
   else
    if q=data_spros then inc(mimo);
  end;

 gotoxy(30,4);write(proh,' чел.   ');
 gotoxy(30,5);write(otkaz,'/',proh,' чел. (',otkaz/proh*100:0:2,'%)   ');
 gotoxy(30,7);write(zspros,'/',data_spros,' чел. (',zspros/data_spros*100:0:2,'%)   ');
 r:=0;B:=0;
 for q:=1 to zspros do
  begin
   if spros[q]>r then r:=spros[q];
   if tbesed[q]>B then B:=tbesed[q];
  end;
 gotoxy(30,9);write(r,' мин.\',r/60:0:2,' час.   ');
 gotoxy(30,8);write(rbesed,'/',besed,' (',rbesed/besed*100:0:2,'%)   ');
 gotoxy(30,6);write(mimo,'/',proh,' чел. (',mimo/proh*100:0:2,'%)   ');
 gotoxy(30,10);write(B,' мин.\',B/60:0:2,' час.(',B/r*100:0:2,'%)   ');
 gotoxy(30,11);write(r-B,' мин.\',(r-B)/60:0:2,' час. (',(r-B)/r*100:0:2,'%)   ');
 gotoxy(30,12);write(t/rbesed:0:2,' мин.\',t/rbesed/60:0:2,' час.   ');
 gotoxy(30,13);write((ABS(Ma-AA/proh)/Ma+ABS(Mb-t/rbesed)/Mb+ABS(Mc-(proh-otkaz)/proh)/Mc)*100:0:4,'%    ');
until besed=rbesed;
gotoxy(1,24);
writeln('Нажмите ENTER для пересчета или другую клавишу для выхода');
if readkey<>#13 then break;
clrscr;
until 0<0;
writeln('(c) 1997-2001 М.Васильев М.Швайко (FROM VEC)');
end.