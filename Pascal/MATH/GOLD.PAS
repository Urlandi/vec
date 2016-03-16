program GoldMetod;
uses crt;
const
 g=0.618033988749895;{g=1/g-1)}
{Ширина интревала поиска}
 a:double=-1;
 b:double=3;
{Максимально допустимая ширина интервала неопредленности аргумента}
 e:double=1E-6;
 mm:shortint=-1;{1:минимум, -1:максимум}
var
 x1,x2,{Точки деления интервала поиска}
 f1,f2,{Значение функции в этих точках}
 r:double;{Длина большего отрезка в золотом сечении для данного интервала}
 n:word;{Количество итераций}
function F(x:double;maxmin:shortint):double;
 var
  tF:double;
  n:longint;
  t:shortint;
 begin
  {Радиальная волновая функция 3S электрона x=r/a0)
   F:=((27.0-2.0*x*(9.0-x))*exp(-x/3.0))*maxmin;}
   tF:=0;
   for n:=1 to 260 do
    begin
     if n mod 2 =0 then t:=-1 else t:=1;
     tF:=tF+t*cos(n*x)/(n*n)
    end;
    F:=tF*maxmin;
 end;
begin
 clrscr;{Очистка экрана}

 {Начальная установка параметров}
 r:=(b-a);
 x1:=b-r;
 f1:=F(x1,mm);
 x2:=a+r;
 f2:=F(x2,mm);

 writeln('Лабораторная работа 1 по методам оптимизации,');
 writeln('cтудента 3-его курса ВолгГТУ 2003 года Васильева Михаила.');
 writeln('"Безусловная оптимизация функции одной переменной методом <Золотого сечения>"');
 writeln('');
 writeln('Границы интервала поиска аргумента:');
 writeln('[',a:0:6,',',b:0:6,']');
 writeln('Границы интервала неопределенности аргумента:');
 writeln('[',x1:0:6,',',x2:0:6,']');
 writeln('Значение функции на краях границы интервала неопределенности аргумента:');
 writeln(f1*mm:0:6,' <-> ',f2*mm:0:6 );
 writeln('Количество итераций: ',n);

 {Основной цикл итераций}
 while r>e do
  begin
   inc(n);
   r:=r*g;
   if f1<f2 then b:=x2 else a:=x1;
   x1:=b-r;
   f1:=F(x1,mm);
   x2:=a+r;
   f2:=F(x2,mm);
   gotoxy(1,8);clreol;writeln('[',x1:0:6,',',x2:0:6,']');
   gotoxy(1,10);clreol;writeln(f1*mm:0:6,' <-> ',f2*mm:0:6 );
   gotoxy(22,11);writeln(n);
  end;

  gotoxy(1,25);
  write('Оптимизация завершена',^G);
  repeat
  until keypressed;
  clrscr;
  writeln('(c) 2003 PyRE Std.');
end.