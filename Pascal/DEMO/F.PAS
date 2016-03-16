program pole;
{$R- $I- $C- $S-}
type
 firescr=array[0..100,0..319] of byte;
var
 x,y:word;
 poli:firescr;
 polo:firescr;
procedure scr;assembler;
 asm
  mov ax,seg polo
  mov ds,ax
  mov si,offset polo
  mov ax,0a000h
  mov es,ax
  mov di,20800
  mov cx,32000-640-640-640
  cld
  rep movsb
 end;
begin
 asm
  xor ah,ah
  mov al,13h
  int 10h
 end;
 randomize;
 repeat
  for x:=0 to 319 do poli[99,x]:=random(200)+56;
  for x:=1 to 318 do for y:=1 to 99 do
   begin
    polo[y-1,x]:=(poli[y+1,x+1]+poli[y-1,x-1]+poli[y+1,x-1]+
    poli[y-1,x+1]+poli[y+1,x]+poli[y-1,x]+poli[y,x+1]+poli[y,x-1]) shr 3;
   end;
  poli:=polo;
  for y:=0 to 93 do
   for x:=0 to 15 do
    begin
     polo[y,x]:=0;
     polo[y,319-x]:=0;
    end;
  scr;
 until port[96]<=128;
end.