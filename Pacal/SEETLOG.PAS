{$I-}
program about_test_use_dos_by_michael;
uses dos;
var
 s:string;
 c:word;
 q:integer;
 dire:array[0..255] of word;
 fd:searchrec;
 flog:text;
 flogout:text;
begin
 writeln;
 write('Поиск каталогов содержащих .LOG файлы');
 assign(flog,'aimtest');
 assign(flogout,'mtest.log');
 append(flog);
 if ioresult<>0 then rewrite(flog);
 if paramcount<1 then
  begin
   writeln('.Следует ввести начальный путь');
   halt(1);
  end;
 s:=paramstr(1);

 chdir(s);
 if ioresult<>0 then
  begin
   writeln('Неверный путь');
   halt(1);
  end;
 for q:=0 to 255 do dire[q]:=0;

 findfirst('*.*',$3f,fd);
 q:=1;
 repeat
  if doserror=0 then dire[q]:=dire[q]+1;
  if port[96]=1 then
   begin
    writeln(flog,'Прервано пользователем');
    break;
   end;
  if (fd.attr=$22) and (fd.name='MTEST.LOG') then
   begin
    reset(flogout);
    while not eof(flogout) do
     begin
      readln(flogout,s);
      writeln(flog,s);
      if ioresult<>0 then write(#7);
     end;
    close(flogout);
   end;
  if (fd.attr=$10) and (fd.name<>'.') and (fd.name<>'..') then
   begin
    q:=q+1;
    chdir(fd.name);
    write('.');
    findfirst('*.*',$3f,fd);
   end
  else
   findnext(fd);
  if doserror<>0 then
   repeat
    dire[q]:=0;
    q:=q-1;
    if q=0 then break;
    chdir('..');
    findfirst('*.*',$3f,fd);
    for c:=1 to dire[q] do findnext(fd);
   until doserror=0;
  if doserror<>0 then break;
 until 0<0;
 writeln(flog,'-/(c)Michael 1999 from 201P group VEC Volgograd Russia');
 close(flog);
 writeln('Удачное завершение');
 halt(0);
end.