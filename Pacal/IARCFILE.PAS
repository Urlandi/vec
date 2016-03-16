program Ideal_arc_file;
{$I-}
uses crt;
var
 openfile:file of byte;
 sizefile,q:longint;
 letter:array[0..255] of longint;
 h,p:double;
 t,x,y:byte;
begin
 if paramcount=0 then
  begin
   writeln('Missing file name.');
   halt(1);
  end;
 assign(openfile,paramstr(1));
 reset(openfile);
 if ioresult<>0 then
  begin
   writeln('Wrong file name.');
   halt(2);
  end;
 for q:=0 to 255 do
  letter[q]:=0;
 sizefile:=filesize(openfile);
 x:=wherex;
 y:=wherey;
 for q:=0 to sizefile-1 do
  begin
   read(openfile,t);
   inc(letter[t]);
   gotoxy(x,y);
   write(q/(sizefile-1)*100:0:2,'%');
  end;
 h:=0;
 writeln;
 for q:=0 to 255 do
  begin
   p:=letter[q]/sizefile;
   if p=0 then continue;
   h:=h+(p)*(ln(p)/ln(2));
  end;
 h:=-h;
 writeln('Byte in file: ',sizefile);
 writeln('Bit per letter (BPL): ',h:0:6);
 writeln('Ideal Byte in: ',round(h*sizefile/8+0.5));
 close(openfile);
 halt(0);
end.