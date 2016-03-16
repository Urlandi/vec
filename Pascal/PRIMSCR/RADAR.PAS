program radar;
uses crt,graph;
var
 q,q1:byte;{Переменная цикла}
 y,x,r,x1,y1,r1:integer;{Координаты}
 celx,cely,celrx,celry:array [0..9] of word;
 d,m:integer;
 strokout:string;
begin
 randomize;
 d:=vga;m:=vgahi;x:=555;y:=240;
 initgraph(d,m,'c:\langs\bp\bgi');
 setcolor(5);setbkcolor(1);setrgbpalette(3,0,11,0);
 setfillstyle(1,3);
 fillellipse(320,240,235,235);
 setfillstyle(9,3);setcolor(3);fillellipse(100,20,10,10);
 setfillstyle(9,14);setcolor(14);fillellipse(70,20,10,10);
 setfillstyle(9,10);setcolor(10);fillellipse(40,20,10,10);
 setfillstyle(1,3);bar(570,10,630,60);
 outtextxy(580,40,'0');outtextxy( 580,50,'0');
 for q:=0 to 9  do
  begin
   celx[q]:=random(200)+220;cely[q]:=random(380)+80;
  end;
  repeat
   r:=r+1;
   {Заполняем черный прямоугольник}
   setcolor(3);str(r-1,strokout);outtextxy(580,20,strokout);
   str(r,strokout);strokout:=strokout+chr(248);
   setcolor(2);outtextxy(580,20,strokout);
   setcolor(3);str((r-1)*pi/180,strokout);strokout:=copy(strokout,1,6);
   outtextxy(573,30,strokout);
   str(r*pi/180,strokout);strokout:=copy(strokout,1,6);
   setcolor(2);outtextxy(573,30,strokout);
   {}
   if trunc(r/90)=r/90 then
    begin
     setfillstyle(9,3);setcolor(3);fillellipse(70,20,10,10);
     sound(100);delay(999);
     setfillstyle(9,14);setcolor(14);fillellipse(70,20,10,10); nosound;
    end;
   if r>360 then
    begin
     r:=0;celrx:= celx;celry:=cely;
     setcolor(3);strokout:='361'+ chr(248);outtextxy(580,20,strokout);
     for q:=0 to 9 do
     begin
      q1:=random(11);if q1>5 then celx[q]:=celx[q]+10 else celx[q]:=celx[q]-10;
      q1:=random(11);if q1>5 then cely[q]:=cely[q]+10 else cely[q]:=cely[q]-10;
     if (getpixel(celx[q],cely[q])<>3) or (celx[q]= 320) or (cely[q]= 240) then
      begin
       celx[q]:=random(200)+220;cely[q]:=random(380)+80;
       setfillstyle(9,3);setcolor(3);fillellipse(40,20,10,10);
       sound(1000);delay(999);
       setfillstyle(9,10);setcolor(10);fillellipse(40,20,10,10); nosound;
      end;
     end;
    end;
   delay(100);
   setcolor (3);line(320,240,x,y);
   x:=round(cos(r*pi/180)*235+320);
   y:=round(sin(r*pi/180)*235+240);
   setrgbpalette(2,0,63,0);setcolor(2);line(320,240,x,y);
   for q:=0 to 9 do
    begin
     if (celx[q]<=320) and  (cely[q]<=240) then
      begin
        x1:=320-celx[q];y1:=240-cely[q];
        r1:=180+round(arctan(y1/x1)*180/pi);
       end;
     if (celx[q]<=320) and  (cely[q]>=240) then
       begin
        x1:=320-celx[q];y1:=cely[q]-240;
        r1:=180-round(arctan(y1/x1)*180/pi);
       end;
     if (celx[q]>=320) and  (cely[q]<=240) then
       begin
         x1:=celx[q]-320;y1:=240-cely[q];
         r1:=360-round(arctan(y1/x1)*180/pi);
       end;
     if (celx[q]>=320) and  (cely[q]>=240) then
       begin
          x1:=celx[q]-320;y1:=cely[q]-240;
          r1:=round(arctan(y1/x1)*180/pi);
       end;
     if r=r1 then
      begin
       setfillstyle(1,3);setcolor(3);fillellipse(celx[q],cely[q],3,3);
       fillellipse(celrx[q],celry[q],3,3);
       setcolor(3);strokout:=chr(219)+chr(219)+chr(219);outtextxy(580,40,strokout);
       str(celx[q],strokout);
       setcolor(2);outtextxy(580,40,strokout);
       setcolor(3);strokout:=chr(219)+chr(219)+chr(219);outtextxy(580,50,strokout);
       str(cely[q],strokout);
       setcolor(2);outtextxy(580,50,strokout);
      end;
     if r-5=r1 then
      begin
       sound(5000);
       setfillstyle(9,12);setcolor(12);fillellipse(100,20,10,10);
       delay(500);nosound;
       setfillstyle(9,3);setcolor(3);fillellipse(100,20,10,10);
       setfillstyle(1,2);setcolor(2);fillellipse(celx[q],cely[q],3,3);
      end;
    end;
  until keypressed;
 closegraph
end.