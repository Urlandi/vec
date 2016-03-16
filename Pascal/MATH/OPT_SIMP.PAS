{Решение задачи максимизации функции методом линейного программирования:
 канонический симплекс метод}
program Liner_programming_simplex_method;
uses crt;
label k;
const
 nX=14;{Количество переменных в целевой функции}
 mX=7;{Количество ограничений в задаче,кол-во доп. переменных в М-задаче}
 M=1E+50;{Большое М}

{Исходные данные - по условию}
 {Целевая функция}
 RA:array[1..nX] of double=(55/35,55/35,55/55,55/25,55/10,55/20,55/50,0,0,0,0,0,0,0);
 {Ограничения,левая часть}
 FA:array[1..mX,1..nX] of double=((1,1,0,0,0,1,1,1,0,0,0,0,0,0),
                                  (0,0,1,1,1,0,0,0,1,0,0,0,0,0),
                                  (1,0,1,0,0,0,1,0,0,1,0,0,0,0),
                                  (0,1,1,0,0,1,0,0,0,0,1,0,0,0),
                                  (0,1,0,1,0,0,1,0,0,0,0,1,0,0),
                                  (1,1,1,1,0,0,0,0,0,0,0,0,1,0),
                                  (0,0,0,0,1,1,1,0,0,0,0,0,0,1));
 RFA:array[1..mX] of double=(30,10,25,40,30,25,25);{Ограничения, правая часть}


var
{Исходные данные - к М-задаче}
 RAM:array[1..nX+mX] of double;{Переменные в целевой функции}
 FAM:array[1..mX,1..nX+mX] of double;{Переменные в ограничениях}

 _FAM:array[1..mX,1..nX+mX] of double;
 _RFA:array[1..mX] of double;

{Данные к симплекс таблице}
 BA:array[1..mX] of double;{Столбец b/a}
 D:array[1..nX+mX] of double;{Строка относительных оценок}
var
 baseX:array[1..mX] of byte;
 j,i,g,g1:double;
 q,q1,s,t,h:integer;
 c:longint;
 YN:char;
begin
 clrscr;
 writeln('Лабораторная работа №2 по методам оптимизации.');
 writeln('Выполнил студент Васильев М.Ю.-группа ИВТ-362 2003г.');
 c:=0;
 g1:=0;
 h:=0;

{Получаем первое допустимое базисное решение для М-задачи}
 for q:=1 to mX do baseX[q]:=q+nX;

 for q:=1 to nX+mX do if q<=nX then RAM[q]:=RA[q] else RAM[q]:=-M;

 for q:=1 to mX do
  for q1:=1 to nX+mX do
   begin
    if q+nX=q1 then FAM[q,q1]:=1 else FAM[q,q1]:=0;
    if q1<=nX then FAM[q,q1]:=FA[q,q1];
   end;

k:
{Получаем относительные оценки}

 for q:=1 to nX+mX do
  begin
   D[q]:=0;
   for q1:=1 to mX do
    D[q]:=D[q]+FAM[q1,q]*RAM[baseX[q1]];
   D[q]:=RAM[q]-D[q];
  end;


 j:=-1;
 for q:=1 to nX+mX do
  for q1:=1 to mX do
   if baseX[q1]<>q then
    if j<D[q] then
     begin
      j:=D[q];
      s:=q;
     end;


 if j<=0 then {Решение найдено}
  begin
   i:=0;
   g:=0;
   for q:=1 to mX do
    begin
     i:=i+RAM[baseX[q]]*RFA[q];
     g:=g+exp(ln(baseX[q])*q);
     if baseX[q]>nX then
      begin
       writeln('Противоречивые условия - решение остановлено');
       writeln;
       writeln('Нажмите ENTER для выхода',^G);
       readln;
       exit;
      end;
    end;
   if g=g1 then
    begin
     writeln('Нажмите ENTER для выхода                               ',^G);
     readln;
     exit;
    end
   else
    begin
     g1:=g;
     if h<>0 then
      begin
       writeln('Решение не единственно. Нажмите ENTER для продолжения',^G);
       readln;
      end;
     h:=h+1;
    end;
   gotoxy(1,4);
   writeln('Решение №',h);
   writeln('Количество итераций: ',c);
   writeln('Целевая функция R = ',i:0:6);
   writeln('Переменные:');
   for q:=1 to nX do
    if RAM[q]<>0 then
     begin
      write('X',q,'= ');
      i:=0;
      for q1:=1 to mX do
       if baseX[q1]=q then
        begin
         writeln(RFA[q1]:0:6);
         i:=-1;
         break;
        end;
      if i=0 then writeln('0.000000');
     end;
  end;

{Получаем столбец b/a}
 for q:=1 to mX do
   if FAM[q,s]<=0 then
    BA[q]:=-1
   else
    BA[q]:=RFA[q]/FAM[q,s];



 for q:=1 to mX do
 if BA[q]>=0 then
  begin
   j:=BA[q];
   t:=q;
   break;
  end;
 for q:=1 to mX do
  if (BA[q]<j) and (BA[q]>=0) then
   begin
    j:=BA[q];
    t:=q;
   end;

 if (j<0) then
  begin
   writeln('Противоречивые условия - решение остановлено');
   writeln;
   writeln('Нажмите ENTER для выхода',^G);
   readln;
   exit;
  end;

 baseX[t]:=s;

{Переходим к новой симплекс таблице}
 for q1:=1 to mX do
  begin
   for q:=1 to nX+mX do
    if q1=t then
     _FAM[q1,q]:=FAM[q1,q]/FAM[t,s]
    else
     _FAM[q1,q]:=FAM[q1,q]-FAM[t,q]*FAM[q1,s]/FAM[t,s];

   if q1=t then _RFA[q1]:=RFA[q1]/FAM[t,s] else _RFA[q1]:=RFA[q1]-RFA[t]*FAM[q1,s]/FAM[t,s];
  end;

 for q:=1 to nX+mX do
  for q1:=1 to mX do
   FAM[q1,q]:=_FAM[q1,q];

 for q:=1 to mX do
  RFA[q]:=_RFA[q];

 c:=c+1;
goto k;


end.