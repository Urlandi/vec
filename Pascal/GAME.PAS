program Game ;
label
start,theend;
var
asc:char;
pop:integer;
popent:integer;
ent:integer;
zna:integer;
begin
start:write('Подсказывать? Y/N ');readln(asc);
repeat
pop:=1;write('Введите количество попыток 1-10 ');read(popent)
until popent <= 10;
randomize;
repeat
write('Введите диапазон угадываемых чисел 10-1000 ');read(ent) ;
until ent<=1000;
zna:=random(ent+1);
case asc of
'Y','y':begin
  repeat
  pop:=pop+1;
  write('Я загадал число - угадай ');readln(ent);
  if ent>zna then writeln('Меньше ');
  if ent<zna then writeln('Больше ');
  if pop>popent then
   begin
   writeln('Ну что слабо тебе меня обыграть'); goto theend;
   end;
  until (ent = zna);
  writeln('В этот раз ты угодал,но смеется тот кто смеется последний ');
  end;
'N','n':begin
  repeat
  pop:=pop+1;
  write('Я загадал число - угадай ');readln(ent);
  if pop >popent then
   begin
   writeln('Попробуй еще и все получится '); goto theend;
   end;
  until (ent=zna) ;
  writeln('Ты сильный игрок,но мы еще посмотрим кто кого ');
  end;
  else
  writeln('Повтори ввод с учетом приводимых в запросах требований ')
end;
theend:write('Cыграем еще Y/N ');readln(asc) ;
 case asc of
 'Y','y':goto start;
 'N','n':writeln('Да ты трус ');
  else goto start;
 end;
end.