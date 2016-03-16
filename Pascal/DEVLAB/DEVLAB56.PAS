program Devices_VideoGraphicsArray;
uses crt;
type
 palette=array[0..15] of record
                          R,G,B:byte;
                         end;
var
 kod:char;
 scan:boolean;
 q:byte;
 s,o:word;
 real_palette:palette;
 my_palette:palette;

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

procedure write_pal(pal:palette);
 begin
  PORT[$3C8]:=$0;
  for q:=$0 to $7 do
   begin
    if q=6 then continue;
    PORT[$3C9]:=pal[q].R;
    PORT[$3C9]:=pal[q].G;
    PORT[$3C9]:=pal[q].B;
   end;
  PORT[$3C8]:=$14;
  PORT[$3C9]:=pal[6].R;
  PORT[$3C9]:=pal[6].G;
  PORT[$3C9]:=pal[6].B;
  PORT[$3C8]:=$38;
  for q:=8 to $F do
   begin
    PORT[$3C9]:=pal[q].R;
    PORT[$3C9]:=pal[q].G;
    PORT[$3C9]:=pal[q].B;
   end;
 end;
procedure read_pal(var pal:palette);
 begin
  PORT[$3C7]:=0;
  for q:=0 to $7 do
   begin
    if q=6 then continue;
    pal[q].R:=PORT[$3C9];
    pal[q].G:=PORT[$3C9];
    pal[q].B:=PORT[$3C9];
   end;
  PORT[$3C7]:=$14;
  pal[6].R:=PORT[$3C9];
  pal[6].G:=PORT[$3C9];
  pal[6].B:=PORT[$3C9];
  PORT[$3C7]:=$38;
  for q:=8 to $F do
   begin
    pal[q].R:=PORT[$3C9];
    pal[q].G:=PORT[$3C9];
    pal[q].B:=PORT[$3C9];
   end;
 end;
procedure setbord(n:byte);
 begin
  while PORT[$3DA] and 8=0 do;
  PORT[$3C0]:=$31;
  PORT[$3C0]:=n;
 end;
begin
     textmode(C80);
     read_pal(real_palette);
     for q:=0 to 7 do
      begin
       my_palette[q].R:=q*4;
       my_palette[q].G:=q*4;
       my_palette[q].B:=q*4;
       my_palette[q+8].R:=$20+q*4;
       my_palette[q+8].G:=$20+q*4;
       my_palette[q+8].B:=$20+q*4;
      end;

     textbackground(1);
     clrscr;
     hidecursor;
     textcolor(10);
     gotoxy(29,1);
     writeln('*Video Graphics Array*');
     textcolor(15);
     gotoxy(19,2);
     writeln('Information about... and ATC registers use');
     textcolor(14);
     gotoxy(1,25);
     write('Made in VSTU by Michael V. VT-562,2005');
     gotoxy(1,5);
     write('Current active video mode: ');
     textcolor(12);
     case MEM[$40:$49] of
      0:writeln('40x25,text,16 color(shades)');
      1:writeln('40x25,text,16 color');
      2:writeln('80x25,text,16 color(shades)');
      3:writeln('80x25,text,16 color');
      4:writeln('320x200,graphics,4 color');
      5:writeln('320x200,graphics,4 color (shades)');
      6:writeln('640x200,graphics,2');
      7:writeln('80x25,text,3 color');
      8,9,$A:writeln('PCjr modes');
      $B,$C:writeln('Unknow (EGA BIOS)');
      $D:writeln('320x200,grpahics,16 color');
      $E:writeln('640x200,grpahics,16 color');
      $F:writeln('640x350,grpahics,3 color');
      $10:writeln('640x350,grpahics,4 or 16 color');
      $11:writeln('640x480,grpahics,2 color');
      $12:writeln('640x480,grpahics,16 color');
      $13:writeln('320x200,grpahics,256 color');
     end;
     textcolor(14);
     write('VGA is active: ');
     textcolor(12);if MEM[$40:$89] and 1=1 then writeln('YES') else writeln('NO');textcolor(14);
     write('Gray-scale summing is ');
     textcolor(12);if MEM[$40:$89] and 2=2 then writeln('enabled') else writeln('disabled');textcolor(14);
     write('Using monochrome monitor: ');
     textcolor(12);if MEM[$40:$89] and 3=3 then writeln('YES') else writeln('NO');textcolor(14);
     write('Text mode scan lines: ');
     textcolor(12);
     case MEM[$40:$89] and $90 of
      0:writeln('350');
      $10:writeln('400');
      $80:writeln('200');
      $90:writeln('Unknow');
     end;
     textcolor(14);
     write('SavePtrRec address is ');
     s:=MEMW[$40:$AA];
     o:=MEMW[$40:$A8];
     textcolor(12);writeln('[',hexstring(s),':',hexstring(o),']');textcolor(14);
     write('SavePtr2Rec address is ');
     textcolor(12);
     if (MEMW[s:o+$12]=0) and (MEMW[s:o+$10]=0) then writeln('not used') else
      writeln('[',hexstring(MEMW[s:o+$12]),':',hexstring(MEMW[s:o+$10]),']');
     textcolor(14);
     window(1,13,80,25);
     writeln('Input status register 0:');
     writeln;
     write(' Frequency of pixels generation');
     textcolor(12);
     case PORT[$3C2] and $18 of
      $00:writeln(' - 25MHz');
      $08:writeln(' - 28MHz');
      $10:writeln(' - external');
      $18:writeln(' - unknow');
     end;
     textcolor(14);
     writeln(' Feature Connector (pin EFEAT0)');
     writeln(' Feature Connector (pin EFEAT1)');
     writeln(' CRT interrupt');

     window(45,13,80,25);
     writeln('Input status register 1:');
     writeln;
     writeln(' Display enable');
     writeln(' Light pen strobe');
     writeln(' Light pen switch');
     writeln(' Vertical retrace');
     window(1,1,80,25);

     gotoxy(1,20);
     textcolor(0);textbackground(7);write  (' BLACK  ');
     textcolor(1);textbackground(6);write  ('  BLUE  ');
     textcolor(2);textbackground(5);write  (' GREEN  ');
     textcolor(3);textbackground(4);write  ('  CYAN  ');
     textcolor(4);textbackground(3);write  ('  RED   ');
     textcolor(5);textbackground(2);write  ('MAGENTA ');
     textcolor(6);textbackground(1);write  (' BROWN  ');
     textcolor(7);textbackground(0);writeln(' LGRAY  ');
     textcolor(8);textbackground(0);write  (' DGRAY  ');
     textcolor(9);textbackground(1);write  (' LBLUE  ');
     textcolor(10);textbackground(2);write (' LGREEN ');
     textcolor(11);textbackground(3);write (' LCYAN  ');
     textcolor(12);textbackground(4);write ('  LRED  ');
     textcolor(13);textbackground(5);write ('LMAGENTA');
     textcolor(14);textbackground(6);write (' YELLOW ');
     textcolor(14);textbackground(7);write (' WHITE  ');

     textbackground(1);
     repeat
      scan:=false;

      textcolor(12);
      window(62,15,80,25);
      if PORT[$3DA] and 1 =1 then writeln(' - NO ') else writeln(' - YES');
      if PORT[$3DA] and 2 =2 then writeln(' - YES') else writeln(' - NO ');
      if PORT[$3DA] and 4 =4 then writeln(' - OFF') else writeln(' - ON ');
      if PORT[$3DA] and 8 =8 then writeln(' - YES') else writeln(' - NO ');

      window(32,16,80,25);
      if (PORT[$3C2] and $20)=$20 then writeln(' - 1') else writeln(' - 0 ');
      if (PORT[$3C2] and $40)=$40 then writeln(' - 1') else writeln(' - 0 ');
      if (PORT[$3C2] and $80)=$80 then writeln(' - NO ') else writeln(' - YES');

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

      if scan=false then
       case ord(kod) of
        27:break;
        $30:setbord(0);
        $31:setbord(1);
        $32:setbord(2);
        $33:setbord(3);
        $34:setbord(4);
        $35:setbord(5);
        $36:setbord(6);
        $37:setbord(7);
        $43,$63:begin
                 while PORT[$3DA] and 8=0 do;
                 write_pal(real_palette);
                end;
        $4D,$6D:begin
                 while PORT[$3DA] and 8=0 do;
                 write_pal(my_palette);
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
