{Метод касательных}
program newton2d;
uses crt;
var
 e,x,x3,a,b:double;
 q,t:longint;
function f(x:double):double;
 begin
  f:=sin(x*x);
 end;
function l1_f(x:double):double;
 begin
  l1_f:=cos(x*x)*2*x;
 end;

function l1_dfdx(x:double):double;
 begin
  l1_dfdx:=2*cos(x*x)-4*x*x*sin(x*x);
 end;

function newton(a,b,e:double;var x:double):integer;
 var
  x3:double;
  t:integer;
 begin
  x3:=a;
  t:=0;
  repeat
   x:=x3;
   x3:=x-l1_F(x)/l1_dFdx(x);
   if (x3<a) or (x3>b) then
    begin
     newton:=-1;
     exit;
    end;
   t:=t+1;
  until(abs(x3-x)<e);
  newton:=t;
  x:=x3;
 end;
begin
  e:=0.0001;
  a:=0;
  b:=2;
  q:=0;
  x3:=b;

 clrscr;
 writeln('Лабораторная работа 1 по методам оптимизации,');
 writeln('cтудента 3-его курса ВолгГТУ 2003 года Васильева Михаила.');
 writeln('"Безусловная оптимизация функции одной переменной методом <Касательных>"');
 writeln('');
 writeln('Границы интервала поиска аргумента:[',a:0:6,',',b:0:6,']');
 writeln;

 t:=0;
 while (a<b) do
  begin
   q:=newton(a,b,e,x);
   t:=t+1;
   if (q<>-1)and(x3-x>e) then
    begin
     write('F(X)=',f(x):0:6,' X=',x:0:6,' Кол-во итераций:',q);
     if l1_dfdx(x)>0 then writeln(' -> Минимум') else
     if l1_dfdx(x)<0 then writeln(' -> Максимум') else writeln('Метод не даёт решения');
    end;
   x3:=x;
   a:=a+e;
  end;
 writeln('Кол-во просмотренных интервалов, отсечения оптимумов:',t);

 gotoxy(1,25);
 write('Оптимизация завершена',^G);
 repeat
 until keypressed;
 clrscr;
 writeln('(c) 2003 PyRE Std.');
end.