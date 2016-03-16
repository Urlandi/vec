program newton3d;
uses crt;
const
 mm=-1;
var
 a,b,x,x3,e1,e2,d:double;
 k:integer;
function f(x:double):double;
 begin
  f:=(x*x+2*exp(x))*mm;
 end;

function dfdx(x:double):double;
 begin
  dfdx:=(2*x+2*exp(x))*mm;
 end;

function df2dx2(x:double):double;
 begin
  df2dx2:=(2+2*exp(x))*mm;
 end;

begin
 a:=-2;
 b:=2;
 k:=0;
 e1:=0.000001;
 e2:=e1;
 x:=a;
 clrscr;
 writeln('Лабораторная работа 1 по методам оптимизации,');
 writeln('cтудента 3-его курса ВолгГТУ 2003 года Васильева Михаила.');
 writeln('"Безусловная оптимизация функции одной переменной методом <Ньютона>"');
 writeln('');
 writeln('Границы интервала поиска аргумента:');
 writeln('[',a:0:6,',',b:0:6,']');

 repeat
  gotoxy(1,7);
  writeln('F(X)=',f(x)*mm:0:6,' X=',x:0:6,' Кол-во итераций:',k);
  k:=k+1;
  x3:=x;
  if abs(dfdx(x))>e1 then
   begin
    if 1/df2dx2(x)>0 then
     begin
      d:=-1/df2dx2(x)*dfdx(x);
      x:=x+d;
     end
    else
     begin
      d:=-dfdx(x);
      x:=x+e1*d;
     end;
   end
   else break;
   if (x>b)or(x<a) then
    begin
     if f(b)<f(a) then x:=b else x:=a;
     x3:=-x;
     break;
    end;
 until (abs(x-x3)<e2)and (abs(f(x)-f(x3))<e2);
 gotoxy(1,7);writeln('F(X)=',f(x)*mm:0:6,' X=',x:0:6,' Кол-во итераций:',k);
 if x3=-x then writeln('Метод не привел к решению на заданном интервале, было взято граничное значение!');
 gotoxy(1,25);
 write('Оптимизация завершена',^G);
 repeat
 until keypressed;
 clrscr;
 writeln('(c) 2003 PyRE Std.');
end.