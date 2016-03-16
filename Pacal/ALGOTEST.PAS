program CG;
uses crt,graph;
type
 linefunctions=procedure(x1,y1,x2,y2,c1,c2:integer);
 cirlcefunctions=procedure(x,y,r,c:integer);

function outputline(L:linefunctions):longint;
 const
  minute=1092;
 var
  x1:integer;
  y1:integer;
  x2:integer;
  y2:integer;
  dx1,dx2,dy1,dy2:integer;
  tikes:longint;
  lines:longint;
 begin
   x1:=320;
   y1:=10;
   x2:=10;
   y2:=470;
   dx1:=1;
   dx2:=-1;
   dy1:=1;
   dy2:=-1;

   lines:=0;
   tikes:=memL[$040:$06C];
   tikes:=tikes+minute;
  while(tikes>memL[$040:$06C])do
   begin
    x1:=x1+dx1;if (x1>630)or(x1<10) then dx1:=-dx1;
    y1:=y1+dy1;if (y1>470)or(y1<10) then dy1:=-dy1;
    x2:=x2+dx2;if (x2>630)or(x2<10) then dx2:=-dx2;
    y2:=y2+dy2;if (y2>470)or(y2<10) then dy2:=-dy2;

    L(x1,y1,x2,y2,1,15);
    inc(lines);
   end;
   outputline:=lines;
 end;
function outputcircle(C:cirlcefunctions):longint;
 const
  minute=1092;
 var
  x,dx:integer;
  y,dy:integer;
  c1,dc1:integer;
  r,dr:integer;
  tikes:longint;
  circles:longint;
 begin
   x:=320;
   y:=240;
   r:=10;
   c1:=1;
   dx:=1;
   dy:=-1;
   dr:=1;
   dc1:=1;
   circles:=0;
   tikes:=memL[$040:$06C];
   tikes:=tikes+minute;
  while(tikes>memL[$040:$06C])do
   begin
    c1:=c1+dc1;if (c1>14)or(c1<2) then dc1:=-dc1;
    x:=x+dx;if (x+dx*r>630)or(x+dx*r<10) then begin dx:=-dx;r:=r+dr;end;
    y:=y+dy;if (y+dy*r>470)or(y+dy*r<10) then begin dy:=-dy;r:=r+dr;end;
    if (r>70)or(r<10) then dr:=-dr;
    C(x,y,r,c1);
    inc(circles);
   end;
   outputcircle:=circles;
 end;


procedure paramline(x1,y1,x2,y2,c1,c2:integer);far;
 var
  t,dx,dy,dc:double;
  x,y,c:double;
  N1,q:integer;
 begin
  x:=x1;y:=y1;c:=c1;
  if abs(x2-x1)>abs(y2-y1) then
   N1:=abs(x2-x1)
  else
   N1:=abs(y2-y1);
  t:=1/N1;
  dx:=t*(x2-x1);
  dy:=t*(y2-y1);
  dc:=t*(c2-c1);
  for q:=0 to N1+1 do
   begin
    putpixel(round(x),round(y),round(c));
    x:=x+dx;
    y:=y+dy;
    c:=c+dc;
   end;
 end;
procedure brezenhemline(x1,y1,x2,y2,c1,c2:integer);far;
 var
  dx,dy:integer;
  dc,c:double;
  d,mdx,mdy:integer;
  qx,qy,x,y:integer;
  q:integer;
 begin
   dx:=x2-x1;mdx:=abs(dx);if dx<0 then dx:=-1 else if dx>0 then dx:=1;
   dy:=y2-y1;mdy:=abs(dy);if dy<0 then dy:=-1 else if dy>0 then dy:=1;
   qx:=mdx;
   qy:=mdy;
   x:=x1;y:=y1;c:=c1;
   if mdx>mdy then d:=mdx else d:=mdy;
   dc:=(c2-c1)/d;
   for q:=0 to d+1 do
    begin
     putpixel(x,y,round(c));
     qx:=qx+mdx;
     qy:=qy+mdy;
     if qx>d then
      begin
       qx:=qx-d;
       x:=x+dx;
      end;
     if qy>d then
      begin
       qy:=qy-d;
       y:=y+dy;
      end;
     c:=c+dc;
    end;
 end;
procedure pixelcircle(x,y,r,c:integer);far;
 var
  x1:integer;
  y1:integer;
 begin
  x1:=0;
  while (x1<=round(r/sqrt(2))) do
   begin
    y1:=round(sqrt(sqr(r)-sqr(x1)));
    putpixel(x+x1,y+y1,c);
    putpixel(x+y1,y+x1,c);
    putpixel(x+y1,y-x1,c);
    putpixel(x+x1,y-y1,c);
    putpixel(x-x1,y-y1,c);
    putpixel(x-y1,y-x1,c);
    putpixel(x-y1,y+x1,c);
    putpixel(x-x1,y+y1,c);
    inc(x1);
   end;
 end;
procedure brezenhemcircle(x,y,r,c:integer);far;
 var
  d:integer;
  x1:integer;
  y1:integer;
 begin
  d:=3-2*r;
  x1:=0;
  y1:=r;
   while (x1<=round(r/sqrt(2))) do
   begin
    putpixel(x+x1,y+y1,c);
    putpixel(x+y1,y+x1,c);
    putpixel(x+y1,y-x1,c);
    putpixel(x+x1,y-y1,c);
    putpixel(x-x1,y-y1,c);
    putpixel(x-y1,y-x1,c);
    putpixel(x-y1,y+x1,c);
    putpixel(x-x1,y+y1,c);
    if d<0 then d:=d+4*x1+6 else begin d:=d+4*(x1-y1)+10;dec(y1);end;
    inc(x1);
   end;

 end;
var
  grDriver:integer;
  grMode:integer;
  paramModeN:longint;
  brezenhemModeN:longint;
  paramModeC:longint;
  brezenhemModeC:longint;
begin
  clrscr;
  writeln('Программа тестирует 2-а алгоритма вывода линий и окружностей.');
  writeln('Лабораторная работа №3 по курсу "Компьютерная графика",ВолгГТУ');
  writeln('Выполнил студнет группы ИВТ-362: Васильев М.Ю.');writeln;
  writeln('Тест занимает чуть больше 4-х минут.');
  writeln('Нажмите любую клавишу для начала.');
  repeat;until keypressed;
  grDriver:=detect;
  initgraph(grDriver, grMode,'c:\langs\bp\bgi');
  paramModeN:=outputline(paramline);
  cleardevice;
  brezenhemModeN:=outputline(brezenhemline);
  cleardevice;
  paramModeC:=outputcircle(pixelcircle);
  cleardevice;
  brezenhemModeC:=outputcircle(brezenhemcircle);
  closegraph;
  writeln('Вывод линий:');
  writeln('Параметрический метод. Линий:',paramModeN,' Быстродействие:',paramModeN/60:5:1,' л/с');
  writeln('Метод Брезенхема.      Линий:',brezenhemModeN,' Быстродействие:',brezenhemModeN/60:5:1,' л/с');
  writeln;
  writeln('Вывод окружностей:');
  writeln('Простой метод секторов. Окружностей:',paramModeC,' Быстродействие:',paramModeC/60:5:1,' о/с');
  writeln('Метод Брезенхема.       Окружностей:',brezenhemModeC,' Быстродействие:',brezenhemModeC/60:5:1,' о/с');
  writeln;
  writeln('Нажмите любую клавишу для завершения.');
  writeln('(c) 2003');
  readkey;
  repeat;until keypressed;
  clrscr;
end.