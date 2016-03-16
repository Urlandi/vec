program _;
uses crt;
const
 videoseg=$a000;
 maxsng=2000;
 maxX=320;
 maxY=200;
var
 snow:array[1..maxsng] of record
                           x:integer;
                           y,c:byte;
                          end;

 q:integer;
 st1:word;
procedure changex(n:byte);assembler;
 asm
  xor ah,ah
  mov al,n
  int 10h
 end;

procedure drawdot(x:word;y,c:byte);
 begin
  mem[videoseg:y*maxX+x]:=c;
 end;
procedure drawsng(x:word;y,c:byte);
 begin
  drawdot(x-1,y,c);
  drawdot(x,y+1,c);
  drawdot(x+1,y,c);
  drawdot(x,y-1,c);
 end;

procedure changec(c,r,g,b:byte);
 begin
  port[$3C8]:=c;
  port[$3C9]:=r;
  port[$3C9]:=g;
  port[$3C9]:=b;
 end;

procedure initprg;
 begin
  randomize;
  changex($13);
  for q:=1 to maxsng do
   begin
    snow[q].x:=random(maxX-2)+1;
    snow[q].y:=random(maxY-2)+1;
    snow[q].c:=random(3)+1;
   end;
  changec(1,35,35,35);
  changec(2,45,45,45);
  changec(3,63,63,63);
 end;

begin
 initprg;
 st1:=1;

 repeat
  q:=random(3);
  snow[st1].y:=snow[st1].y+snow[st1].c;
  snow[st1].x:=snow[st1].x+(1-q);

  if (snow[st1].x>maxX-1)or(snow[st1].x<1)or(snow[st1].y>maxY-1)then
   begin
    snow[st1].x:=random(maxX-2)+1;
    snow[st1].y:=1;
   end;

  drawsng(snow[st1].x,snow[st1].y,snow[st1].c);
  inc(st1); if st1>maxsng then st1:=1;
  drawsng(snow[st1].x,snow[st1].y,0);

 until port[$60]<129;
 changex($3);
end.