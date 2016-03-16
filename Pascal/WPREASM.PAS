{$I-}
program pre_WinAsm;
var
 _asm,_gen:text;
 av,tv:string;
 e:byte;
begin
 e:=0;
 writeln('(c) Michael');
 if paramcount<>2 then
  begin
   writeln('Error! No parameters.');
   writeln('Use as: wpreasm <infile.asm> <outfile.inc>');
   halt(1);
  end;
 assign(_asm,paramstr(1));
 assign(_gen,paramstr(2));
 reset(_asm);
 if ioresult<>0 then
  begin
   writeln('Error! Wrong In file name.');
   halt(2);
  end;
 rewrite(_gen);

 if ioresult<>0 then
  begin
   writeln('Error! Wrong Out file name.');
   halt(4);
  end;
 while not eof(_asm) do
  begin
   if seekeoln(_asm) then;
   readln(_asm,av);
   tv:=copy(av,1,4);
   if (tv='Call') or (tv='Jmp ') then
    begin
      if tv='Jmp ' then delete(av,1,3) else delete(av,1,4);
      writeln(_gen,'extrn'+av+':near');
      write('ú');
    end;
   if ioresult<>0 then
    begin
     writeln('e');
     writeln('Error! Can''t read/write to file');
     e:=1;
     break;
    end;
  end;
 close(_asm);
 close(_gen);
 if e=1 then halt(99);
 writeln('w');
 halt(0);
end.