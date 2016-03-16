program cTyK;
uses crt;
var
 polo:array[0..70,0..319] of byte;
 sta,p,q:byte;
 pd:integer;
 y,x:word;
procedure pp(i,k,z,s:byte);
 begin
  port[$3c8]:=i;
  port[$3c9]:=k;
  port[$3c9]:=z;
  port[$3c9]:=s;
 end;
procedure scr;assembler;
 asm
  mov ax,seg polo
  mov ds,ax
  mov si,offset polo
  mov ax,0a000h
  mov es,ax
  mov di,20800
  mov cx,19200
  cld
  rep movsb
 end;
begin
asm
 xor ah,ah
 mov al,13h
 int 10h
end;

 pd:=0;y:=20;
 for x:=63 to 256 do
  begin
   if (x-63=10)or(x-63=80)or(x-63=150) then pd:=1;
   if (x-63=20)or(x-63=90)or(x-63=160) then pd:=-1;
   if (x-63=40)or(x-63=110)or(x-63=180)then pd:=1;
   if (x-63=50)or(x-63=120)or(x-63=190)then pd:=0;
   y:=y+pd;
   polo[y,x]:=x-63;
   polo[y+10,x]:=193-(x-63);
  end;

 scr;
 repeat


















   sta:=0;
   for pd:=1 to 255 do
    begin
     if pd>23 then
      begin
       sta:=sta+1;
       p:=40;
      end
     else
      p:=63-pd;
     for q:=1 to 255 do
      begin
       if q>sta then
        begin
         delay(2);
         p:=p+1;if p>63 then break;
         pp(q,0,0,p);
        end
        else pp(q,0,0,0);
      end;
    end;
 until keypressed;
asm
 xor ah,ah
 mov al,03h
 int 10h
end;
write('(c) Michael');
end.