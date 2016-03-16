{$I-}
program absolute_disk_writer;
uses crt;
label
 nrr;
const
 visual:array[0..3] of char=('|','\','-','/');
var
 source:file of byte;
 sector:array[0..$1FF] of byte;
 y:char;
 q:word;
 r:byte;
begin
 if paramcount<>1 then
  begin
   writeln('Wrong parametr');
   halt(0);
  end;
 assign(source,paramstr(1));
 reset(source);
 if ioresult<>0 then
  begin
   write('Wrong file name');
   halt(0);
  end;
 writeln('WARNING! COPY <FILE> TO <FDA1(A:)> AS BOOT SECTOR 512 byte');
 write('Continue?[Y/N]:');readln(y);
 y:=upcase(y);
 if y='N' then
  begin
   writeln('Cancel');
   halt(0);
  end;
 q:=0;
 while not eof(source) do
  begin
   read(source,r);
   sector[q]:=r;
   q:=q+1;
   if q>$1ff then
    begin
     writeln('File >512 byte. Use only first 512 byte');
     break;
    end;
   if ioresult<>0 then
    begin
     writeln('Error read file');
     halt(0);
    end;
  end;
 writeln('Writing boot sector. Please wait');
 asm
  mov ax,seg sector
  mov es,ax
  mov ax,0301h
  xor dx,dx
  mov cx,01h
  mov bx,offset sector
  int 13h
  jnb nrr
  mov q,0
nrr:
 end;
 if q=0 then
  begin
   writeln('Error! Can''t write to <FDA1(A:)> successful');
   halt(0);
  end;
 writeln('OK');
end.