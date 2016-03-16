program Virus_intro;
{$R-}
uses crt;
procedure delai(d:integer);
 var
  prtloop:integer;
  prt:byte;
 begin
  for prtloop:=1 to d do
   begin
    repeat
     prt:=PORT[$3DA];
     prt:=prt AND 8
    until prt=0;
    repeat
     prt:=port[$3DA];
     prt:=prt AND 8;
    until prt<>0;
   end;
 end;
procedure box(x,y,lx,ly:word;col:byte);
 var
  qx,qy:word;
 begin
  for qx:=x to x+lx do
   for qy:=y to y+ly do
    mem[$0A000:qy*320+qx]:=col;
 end;
procedure changescr(mode:byte);assembler;
 asm
  xor ah,ah
  mov al,mode
  int 10h
 end;
procedure main;
var
 q,qx,qy:word;
 maintext:array[0..45,0..8] of boolean;
 maincolor:array[0..319] of record
                             red,green,blue:byte;
                            end;
 red,green,blue:byte;
begin
 changescr($13);
 for q:=0 to 255 do
  begin
   maincolor[q].red:=0;
   maincolor[q].green:=0;
   maincolor[q].blue:=0;
   if q<63 then maincolor[q].red:=q;
   if (q>62) and (q<125) then
    begin
     maincolor[q].red:=maincolor[q-1].red-1;
     maincolor[q].blue:=q-62;
    end;
   if (q>124) and (q<187) then
    begin
     maincolor[q].blue:=maincolor[q-1].blue-1;
     maincolor[q].green:=q-124;
    end;
   if (q>186) and (q<249) then maincolor[q].green:=maincolor[q-1].green-1;
   if q>248 then
    begin
     maincolor[q].red:=maincolor[q-1].red;
     maincolor[q].green:=maincolor[q-1].green;
     maincolor[q].blue:=maincolor[q-1].blue;
    end;
   port[$3c8]:=q;
   port[$3c9]:=0;
   port[$3c9]:=0;
   port[$3c9]:=0;
  end;
 randomize;
 directvideo:=FALSE;
 write('êéëëàü');
 for qx:=0 to 45 do
  for qy:=0 to 8 do
   if mem[$0A000:qy*320+qx]<>0 then maintext[qx,qy]:=TRUE else maintext[qx,qy]:=FALSE;
 gotoxy(1,1);
 for q:=1 to 357 do
  begin
   textcolor(128);
   write('¢Ø•‡•§');
  end;
 for qx:=0 to 45 do
  for qy:=0 to 8 do
   if maintext[qx,qy]=TRUE then box(qx*6+20,qy*20+30,5,20,255);

 for qx:=0 to 320 do
  for qy:=0 to 200 do
   if mem[$0A000:qy*320+qx]=255 then
    begin
     mem[$0A000:qy*320+qx]:=qx+qy;
     if mem[$0A000:qy*320+qx]=0 then mem[$0A000:qy*320+qx]:=1;
    end;
 for qx:=0 to 63 do
  begin
   for q:=0 to 255 do
    begin
     port[$3c7]:=q;
     red:=port[$3c9];
     green:=port[$3c9];
     blue:=port[$3c9];
     if red<maincolor[q].red then inc(red);
     if green<maincolor[q].green then inc(green);
     if blue<maincolor[q].blue then inc(blue);
     port[$3c8]:=q;
     port[$3c9]:=red;
     port[$3c9]:=green;
     port[$3c9]:=blue;
    end;
   delai(3);
  end;

 for qx:=0 to 460 do
 begin
  red:=maincolor[255].red;
  green:=maincolor[255].green;
  blue:=maincolor[255].blue;
  for q:=254 downto 1 do
   begin
      if qx>200 then
       begin
        maincolor[255].red:=14;
        maincolor[255].green:=50;
        maincolor[255].blue:=50;
       end;
    maincolor[q+1].red:=maincolor[q].red;
    maincolor[q+1].green:=maincolor[q].green;
    maincolor[q+1].blue:=maincolor[q].blue;
    port[$3c8]:=q+1;
    port[$3c9]:=maincolor[q+1].red;
    port[$3c9]:=maincolor[q+1].green;
    port[$3c9]:=maincolor[q+1].blue;
   end;
  maincolor[1].red:=red;
  maincolor[1].green:=green;
  maincolor[1].blue:=blue;
  port[$3c8]:=1;
  port[$3c9]:=maincolor[1].red;
  port[$3c9]:=maincolor[1].green;
  port[$3c9]:=maincolor[1].blue;
  delai(3);
  if keypressed then break;
 end;
 port[$3c8]:=1;
 port[$3c9]:=63;
 port[$3c9]:=0;
 port[$3c9]:=0;
 port[$3c8]:=255;
 port[$3c9]:=14;
 port[$3c9]:=50;
 port[$3c9]:=50;
 for qx:=0 to 45 do
  for qy:=0 to 8 do
   if maintext[qx,qy]=TRUE then box(qx*6+20,qy*20+30,5,20,255);
 for q:=0 to 319 do
  maincolor[q].red:=29;
 repeat
  qx:=0;
  for q:=20 to 300 do
   begin
    if (maincolor[q].red<189) and (random(2)=0) then
     begin
      inc(maincolor[q].red);
      qx:=1;
      if mem[$0A000:maincolor[q].red*320+q]=255 then
        box(q,maincolor[q].red,1,1,1);
     end;
   end;
   delai(1);
 until qx=0;
 for qx:=0 to 63 do
  begin
   for q:=0 to 255 do
    begin
     port[$3c7]:=q;
     red:=port[$3c9];
     green:=port[$3c9];
     blue:=port[$3c9];
     if red<63 then inc(red);
     if green>0 then dec(green);
     if blue>0 then dec(blue);
     port[$3c8]:=q;
     port[$3c9]:=red;
     port[$3c9]:=green;
     port[$3c9]:=blue;
    end;
   delai(1);
  end;
end;
begin
 main;
 changescr($13);
 textcolor(7);
 textbackground(0);
 changescr($3);
 writeln('(c)2002 I''m(R)');
end.