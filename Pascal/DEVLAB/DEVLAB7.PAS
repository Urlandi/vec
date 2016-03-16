program Devices_VideoGraphicsArray;
uses crt;
type
 palette=array[0..15] of record
                          R,G,B:byte;
                         end;
var
 kod:char;
 scan:boolean;
 l,r,g,b:boolean;
 clears:boolean;
 x,y:word;
 q:byte;
 binimage:array[0..299,0..199] of byte;

function loadpicture(picturename:string):boolean;
 var
  f:file of byte;
  x,y:word;
  r:longint;
 begin
  assign(f,picturename);
{$I-}
  reset(f);
  if ioresult<>0 then
   begin
    loadpicture:=false;
    exit;
   end
  else loadpicture:=true;
{$I+}
  for y:=0 to 299 do
   begin
    for x:=0 to 199 do
     begin
      seek(f,((299-y)*200+x)+120);
      read(f,binimage[y,x]);
     end;
   end;
  close(f);
 end;

procedure vidmode(n:byte);assembler;
 asm
  xor ah,ah
  mov al,n
  int 10h
 end;

procedure setlrgb(l,r,g,b:boolean);
 var
  p:byte;
 begin
  p:=ord(l)*8+ord(r)*4+ord(g)*2+ord(b);
  PORTW[$03CE]:=(p shl 8)+1;
 end;

procedure setpixel(x,y:word;c:byte);
 const
  vs=$A000;
  vo=$0000;
 var
  o,p:word;
 begin
  o:=y*80+(x div 8);
  p:=c shl 8;
  PORTW[$3CE]:=p;
  p:=($80 shr (x mod 8)) shl 8+8;
  PORTW[$3CE]:=p;
  p:=MEM[vs:vo+o];
  if clears=true then MEM[vs:vo+o]:=0 else MEM[vs:vo+o]:=p;
 end;


procedure showpicture;
 var
  q:word;
  x,xt,y:word;
 begin
  for y:=90 to 389 do
   begin
    xt:=120;
    for x:=0 to 199 do
     begin
      setpixel(xt,y,binimage[y-90,x] shr $4);
      setpixel(xt+1,y,binimage[y-90,x] and $F);
      xt:=xt+2;
     end;
   end;


 end;


begin
     clears:=true;
     l:=true;
     r:=l;
     g:=r;
     b:=g;
     loadpicture('1.bmp');
     vidmode($12);
     setlrgb(TRUE,TRUE,TRUE,TRUE);
     showpicture;

     repeat
      scan:=false;

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
        $31:begin
             loadpicture('1.bmp');
             showpicture;
           end;
        $32:begin
             loadpicture('2.bmp');
             showpicture;
           end;
        $33:begin
             loadpicture('3.bmp');
             showpicture;
           end;
        $34:begin
             loadpicture('4.bmp');
             showpicture;
           end;
        $35:begin
             loadpicture('5.bmp');
             showpicture;
           end;
        $36:begin
             loadpicture('6.bmp');
             showpicture;
           end;
        $30:begin
             loadpicture('devlab7.bmp');
             showpicture;
           end;
        $4c,$6c:begin
                 if l then l:=false else l:=true;
                 setlrgb(l,r,g,b);
                 showpicture;
                end;
        $52,$72:begin
                 if r then r:=false else r:=true;
                 setlrgb(l,r,g,b);
                 showpicture;
                end;
        $47,$67:begin
                 if g then g:=false else g:=true;
                 setlrgb(l,r,g,b);
                 showpicture;
                end;
        $42,$62:begin
                 if b then b:=false else b:=true;
                 setlrgb(l,r,g,b);
                 showpicture;
                end;
        $43,$63: begin
                  if clears then clears:=false else clears:=true;
                  showpicture;
                 end;
       end
      else
       case ord(kod)of
        $44:break;
       end;

     until 0<0;
   textmode(C80);
   textbackground(0);
   textcolor(7);
end.
