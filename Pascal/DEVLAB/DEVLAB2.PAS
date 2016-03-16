program Devices_Printer;
uses crt;

var
 kod:char;
 scan:boolean;
 baseport:array[0..3] of word;
 ps:byte;
 q:word;
 p:byte;
 s:string;

procedure hidecursor;assembler;
 asm
  mov ah,1
  mov ch,20h
  int 10h
 end;

procedure showcursor;assembler;
 asm
  mov ah,1
  mov cx,01fh
  int 10h
 end;

function hexstring(d:word):string;
 const
  dd:array[0..15] of char=('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
 var
  l:word;
  q:byte;
  s:string[5];
 begin
  l:=d;
  s:='';
  for q:=0 to 3 do
   begin
    s:=dd[l and $F]+s;
    l:=l shr 4;
   end;
  hexstring:=s;
 end;

function conv(s:string):string;
 var
  sto:string;
  l:byte;
  space:boolean;
  b:byte;
 begin
  conv:='';
  if length(s)=0 then exit;
  l:=1;
  sto:='';
  space:=FALSE;
  b:=0;
  while l<=ord(s[0]) do
   begin
    case s[l] of
     '0':begin
          b:=(b shl 4)+$0;
          space:=TRUE;
         end;
     '1':begin
          b:=(b shl 4)+$1;
          space:=TRUE;
         end;
     '2':begin
          b:=(b shl 4)+$2;
          space:=TRUE;
         end;
     '3':begin
          b:=(b shl 4)+$3;
          space:=TRUE;
         end;
     '4':begin
          b:=(b shl 4)+$4;
          space:=TRUE;
         end;
     '5':begin
          b:=(b shl 4)+$5;
          space:=TRUE;
         end;
     '6':begin
          b:=(b shl 4)+$6;
          space:=TRUE;
         end;
     '7':begin
          b:=(b shl 4)+$7;
          space:=TRUE;
         end;
     '8':begin
          b:=(b shl 4)+$8;
          space:=TRUE;
         end;
     '9':begin
          b:=(b shl 4)+$9;
          space:=TRUE;
         end;
 'A','a':begin
          b:=(b shl 4)+$A;
          space:=TRUE;
         end;
 'B','b':begin
          b:=(b shl 4)+$B;
          space:=TRUE;
         end;
 'C','c':begin
          b:=(b shl 4)+$C;
          space:=TRUE;
         end;
 'D','d':begin
          b:=(b shl 4)+$D;
          space:=TRUE;
         end;
 'E','e':begin
          b:=(b shl 4)+$E;
          space:=TRUE;
         end;
 'F','f':begin
          b:=(b shl 4)+$F;
          space:=TRUE;
         end;
     #32:begin
          if space then
           begin
            sto:=sto+chr(b);
            b:=0;
            space:=FALSE;
           end;
         end;
     else
       exit;
    end;
    l:=l+1;
   end;
  if space then sto:=sto+chr(b);
  conv:=sto;
 end;

function printthis(c:byte):byte;
 var
  p:byte;
  trk:integer;
 begin
  printthis:=0;
  trk:=1;
  while PORT[baseport[ps]+1] and $80=0 do
   begin
    trk:=trk+1;
    if trk=0 then
     exit;
   end;
  PORT[baseport[ps]]:=c;
  repeat
   p:=PORT[baseport[ps]+1];
   if p and $80<>0 then break;
   if p and $8=0 then exit;
   if p and $20<>0 then exit;
  until 0<0 ;
  PORT[baseport[ps]+2]:=$0D;
  PORT[baseport[ps]+2]:=$0C;
  printthis:=1;
 end;

procedure print(s:string);
 var
  l:byte;
 begin
  l:=1;
  while l<=ord(s[0]) do
   begin
    if printthis(ord(s[l]))=0 then exit;
    l:=l+1;
   end;
 end;

begin
     textbackground(1);
     clrscr;
     hidecursor;
     textcolor(10);
     gotoxy(22,1);
     writeln('*EPSON PRINTER ESCAPE COMMAND SYSTEM*');
     textcolor(15);
     gotoxy(28,2);
     writeln('Bidirectional print data');
     textcolor(14);
     gotoxy(1,25);
     write('Made in VSTU by Michael V. VT-562,2005');
     gotoxy(1,4);
     write('Number of printers:');
     textcolor(12);writeln('   ',MEMW[0:$410] shr 14);
     gotoxy(1,6);
     textcolor(14);
     writeln('1.Base address of LPT1:      *');
     writeln('2.Base address of LPT2:');
     writeln('3.Base address of LPT3:');
     writeln('4.Base address of LPT4:');
     writeln;
     writeln('Printer status:');
     writeln;
     writeln(' Error');
     writeln(' Printer is selected');
     writeln(' Out of paper');
     writeln(' Ready for next chracter');
     writeln(' Busy or offline or error');

     gotoxy(39,6);
     writeln('Text for print:');

     gotoxy(35,13);
     writeln('Bytecode for print:');

     textcolor(12);
     window(25,6,80,24);
     q:=$408;
     ps:=0;
     repeat
      begin
        baseport[ps]:=MEMW[0:q];
        writeln(hexstring(baseport[ps]));
        q:=q+2;
        ps:=ps+1;
      end;
     until q>$40E;
     ps:=0;


     repeat
      scan:=false;

      window(27,13,80,24);
      textcolor(12);
      p:=PORT[baseport[ps]+1];
      p:=(p shr 3)xor $19;
      for q:=0 to 4 do
       begin
        if (p and $1)<>0 then writeln('- YES') else  writeln('- NO ');
        p:=p shr 1;
       end;
      window(1,1,80,24);
      kod:=#0;
      while KeyPressed do
       begin
        kod:=ReadKey;
        if kod=#0 then
        begin
         scan:=true;
         continue;
        end;
       end;

      textcolor(14);
      if scan=false then
       case ord(kod) of
        27:break;
        13:begin
            window(54,6,80,12);
            showcursor;
            textcolor(12);
            readln(s);
            print(s);
            hidecursor;
           end;
        32:begin
            window(54,13,80,19);
            showcursor;
            textcolor(12);
            readln(s);
            s:=conv(s);
            print(s);
            hidecursor;
           end;
        $31:begin
             gotoxy(30,6+ps);write(' ');
             ps:=0;
             gotoxy(30,6+ps);write('*');
            end;
        $32:begin
             gotoxy(30,6+ps);write(' ');
             ps:=1;
             gotoxy(30,6+ps);write('*');
            end;
        $33:begin
             gotoxy(30,6+ps);write(' ');
             ps:=2;
             gotoxy(30,6+ps);write('*');
            end;
        $34:begin
             gotoxy(30,6+ps);write(' ');
             ps:=3;
             gotoxy(30,6+ps);write('*');
            end;
       end
      else
       case ord(kod)of
        $44:break;
       end;

     until 0<0;
     window(1,1,80,25);
     textbackground(0);
     textcolor(7);
     clrscr;
end.