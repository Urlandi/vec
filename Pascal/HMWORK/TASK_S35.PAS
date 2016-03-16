program max_diagonal;
var
 A:array[1..5,1..5] of integer;
 tmp:integer;
 x,y,max:byte;
begin
 writeln('Расчет максимальных элементов в строке матрицы 5х5');
 writeln('Введите элемент массива (строка,колонка)');
 for y:=1 to 5 do
  begin
   max:=1;
   write(y,',',max,':');
   readln(A[y,max]);
   for x:=2 to 5 do
    begin
     write(y,',',x,':');
     readln(A[y,x]);
     if A[y,x]>A[y,x-1] then max:=x;
    end;
   tmp:=A[y,y];A[y,y]:=A[y,max];A[y,max]:=tmp;
  end;
 for y:=1 to 5 do write('A(',y,',',y,')=',A[y,y],#9);
 writeln;
 writeln('Нажмите ENTER для завершения.');
 readln;
end.