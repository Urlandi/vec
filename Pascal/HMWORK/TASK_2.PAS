program Zadanie2_Variant14;
const
 x:real=-3;
var
z:real;
begin
while x<=2 do
 begin
  if x<0 then z:=x*x*x*x+4*x*x-7*x else
  if x>0 then z:=1/(x*x+exp(ln(8)*x)+12)
  else
   z:=x;
  if z>=0 then writeln('X=',x:1:2,' Z=',z:6:4);
  x:=x+0.25;
 end;
writeln(' ¦¬¨β¥ ‚‚„ ¤«ο Άλε®¤ ');
readln
end.