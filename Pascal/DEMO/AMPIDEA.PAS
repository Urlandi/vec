program cool_form;
{$R-}
uses graph,crt;
const
 d:integer=cga;
 m:integer=cgac0;
 steps=5;
 kx=1;
 ky=1;
 addx=150;
 addy=100;
 bm=100;
 stepx=pi*4/5;
 stepy=pi*4/5;
 dx=-0.1;
 dy=0.1;
var
 i:integer;
 tx,ty,fx,fy:real;
begin
 directvideo:=false;
 initgraph(d,m,'C:\langs\BP\BGI');
 setcolor(2);
 fx:=0;
 fy:=0;
 repeat
  delay(100);
  cleardevice;
  tx:=0;
  ty:=0;
  moveto(round(sin(kx*tx+fx)*bm+addx),round(cos(ky*ty+fy)*bm+addy));
  for i:=0 to steps do
   begin
    lineto(round(sin(kx*tx+fx)*bm+addx),round(cos(ky*ty+fy)*bm+addy));
    tx:=tx+stepx;
    ty:=ty+stepy;
   end;
   fx:=fx+dx;
   fy:=fy+dy;
  until keypressed;
 closegraph;
end.                                                             