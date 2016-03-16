Program Salut;
uses crt;
 label reset;
 const
  numstars=100;
  sled=50;
  videoseg=$0A000;
 var
  q,t:longint;
  c,endest:byte;
  x,y,x1,y1,x2,y2:integer;
  stars:array [1..numstars] of record
                          x,y:shortint;
                          p:word;
                         end;

 procedure changex(n:byte);assembler;
  asm
   xor ah,ah
   mov al,n
   int 10h
  end;

 procedure changec(c,r,g,b:byte);
  begin
   port[$3C8]:=c;
   port[$3C9]:=r;
   port[$3C9]:=g;
   port[$3C9]:=b;
  end;


 procedure changepalette;
  begin
  for q:=1 to 48 do
   begin
    changec(q,q+15,0,0);
   end;
  for q:=49 to 96 do
   begin
    changec(q,63,q-34,0);
   end;
  for q:=97 to 160 do
   begin
    changec(q,63-(q-97),63,0);
   end;
  for q:=161 to 209 do
   begin
    changec(q,0,63,q-147);
   end;
  for q:=210 to 255 do
   begin
    changec(q,0,63-(q-210),63);
   end;
  end;

 procedure drawstar(x:word;y,c:byte);
  begin
   mem[videoseg:y*320+x]:=c;
  end;

 begin
  randomize;
  changex($13);
  changepalette;
reset:
  for q:=1 to numstars do
   begin
    stars[q].x:=-100+random(200);
    stars[q].y:=-128+random(200);
    stars[q].p:=0;
   end;

  q:=1;t:=0;x:=random(200)+60;y:=random(40)+45;endest:=0;c:=0;
  repeat
   if t<100 then sound(100-t) else nosound;
   if port[$60]=1 then break;

   if ((t-sled<=stars[q].p) or (stars[q].p=0))and (t-sled>=0) then
    begin
     x2:=x+(stars[q].x*(t-sled))div 90;
     y2:=y+(stars[q].y*(t-sled)+(t-sled)*(t-sled) div 2)div 90;
     if (x2<320) and (x2>0) and (y2<200) and (y2>0)then
      begin
       drawstar(x2,y2,0);
       endest:=1;
      end;
    end
   else
    if t-sled<0 then endest:=1;

   if stars[q].p=0 then
    begin
     x1:=x+(stars[q].x*t)div 90;
     y1:=y+(stars[q].y*t+t*t div 2)div 90;
     if (x1>319) or (x1<1) or (y1>199) or (y1<1)then stars[q].p:=t else drawstar(x1,y1,c);
    end
   else
    if (x1<320) and (x1>0) and (y1<200) and (y1>0)then stars[q].p:=0;

   q:=q+1;
   if q>numstars then
    begin
     if endest=0 then goto reset else endest:=0;
     delay(100);
     q:=1;t:=t+1;
     c:=c+1;if c>254 then c:=254;
    end;
  until 0<0;
  nosound;
  changex(3);
 end.