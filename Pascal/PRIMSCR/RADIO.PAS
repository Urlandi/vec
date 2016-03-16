program radio;
uses crt,graph;
var
 q,col:byte;
 d,m,x,xc,yc,xce,yce,s:integer;
 d1,g:real;
 strelka:pointer;
 j:string;
begin
 clrscr;
 randomize;
 d:=vga;m:=vgahi;
 initgraph(d,m,'c:\langs\bp\bgi');cleardevice;
 setcolor(1);setfillstyle(1,0);
 rectangle(100,150,540,330);setfillstyle(1,3);bar(101,151,539,329);
 rectangle(120,160,520,200);setfillstyle(1,8);bar(121,161,519,199);
 rectangle(120,210,250,220);rectangle(120,230,250,240);rectangle(120,250,250,260);
 bar(121,211,249,219); bar(121,231,249,239);bar(121,251,249,259);
 setfillstyle(9,12);setcolor(12);fillellipse(290,215,10,10);fillellipse(140,285,10,10);
 setfillstyle(9,8);setcolor(8);fillellipse(315,215,10,10);fillellipse(340,215,10,10);fillellipse(365,215,10,10);
 setfillstyle(1,9);setcolor(14);fillellipse(470,265,40,40);
 setfillstyle(1,1);setcolor(7);fillellipse(470,265,20,20);
 setfillstyle(9,2);setcolor(2);fillellipse(190,285,10,10);
 outtextxy(130,165,'1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19');
 outtextxy(127,300,'C…’œ.');outtextxy(178,300,'€’.');
 outtextxy(278,227,'ãª¢');outtextxy(308,227,'ª¢');outtextxy(333,227,'á¢'); outtextxy(358,227,'¤¢');
 settextstyle(2,0,2);
 outtextxy(130,185,'1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000 17000');
 outtextxy(245,175,'MICHAEL''S ''THE BEST RADIO'' 01.08.1998 ');
 outtextxy(120,200,'100 - 3400'); outtextxy(120,220,'3400 - 6700'); outtextxy(120,240,'6700 - 10000');
 setcolor(1);settextstyle(3,0,1);outtextxy(279,250,'VOLGOGRAD');
 x:=122;d:=1;d1:=0.909;q:=1;m:=imagesize(119,160,121,200);getmem(strelka,m);
 m:=121;getimage(m,160,x+1,200,strelka^);
 repeat
  putimage(m,160,strelka^,0);m:=x-1;setcolor(9);line(xc,yc,xce,yce);
  x:=x+d;g:=g+d1;if (g>359)or (g<0) then d1:=-d1;
  if (x>=519) or (x<=121) then
  begin
   d:=-d;
   q:=q+1;if q>4 then q:=1;
   setfillstyle(9,8);setcolor(8);fillellipse(290,215,10,10);
   fillellipse(315,215,10,10);fillellipse(340,215,10,10);fillellipse(365,215,10,10);
   case q of
    1:begin setfillstyle(9,12);setcolor(12);fillellipse(290,215,10,10);end;
    2:begin setfillstyle(9,12);setcolor(12);fillellipse(315,215,10,10);end;
    3:begin setfillstyle(9,12);setcolor(12);fillellipse(340,215,10,10);end;
    4:begin setfillstyle(9,12);setcolor(12);fillellipse(365,215,10,10);end;
   end;
  end;

  s:=10000-random(9900);setfillstyle(1,8);bar(121,211,249,219); bar(121,231,249,239);bar(121,251,249,259);
  if s<3300 then
   begin
    setfillstyle(1,7);bar(121,211,round(s/27.5)+121,219);
   end;
   if (s<6600) and (s>3300) then
   begin
    setfillstyle(1,7);bar(121,231,round((s-3300)/27.5)+121,239);
   end;
   if (s<9900) and (s>6600) then
   begin
    setfillstyle(1,7);bar(121,251,round((s-6600)/27.5)+121,259);
   end;
  sound(99);sound(s);
  getimage(m,160,x+1,200,strelka^);
  setcolor(14);line(x,160,x,200);
  xc:=round(cos(g*pi/180)*21+470);xce:=round(cos(g*pi/180)*39+470);
  yc:=round(sin(g*pi/180)*21+265);yce:=round(sin(g*pi/180)*39+265);
  setcolor(14);line(xc,yc,xce,yce);
  delay(299);nosound;
 until keypressed;
 closegraph;
end.
