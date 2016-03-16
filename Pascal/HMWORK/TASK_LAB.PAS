program average_matrix;
var
 D:array[1..5,1..5] of real;
 avg:real;
 x,y:byte;
begin
 writeln('Расчет максимальных элементов в строке матрицы 5х5');
 writeln('Введите элемент массива (строка,колонка)');
 avg:=0;
 for y:=1 to 5 do
  for x:=1 to 5 do
   begin
    write(y,',',x,':');
    readln(D[y,x]);
    avg:=avg+D[y,x];
   end;
 avg:=avg/25;
 writeln('Среднее матричное: ',avg:0:3);
 writeln('Получаемая матрица:');
 for y:=1 to 5 do
  begin
   for x:=1 to 5 do
    begin
     D[y,x]:=D[y,x]-avg;
     write(D[y,x]:0:2,#9);
    end;
   writeln;
  end;
 writeln('Нажмите ENTER для завершения');
 readln;
end.