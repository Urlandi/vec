program Zadanie1_Variant14;
var
x1,x2,x3,x4:real;
d,g:real;
begin
writeln('Введите 4 числа разделяя их пробелами'+
         '(десятичная чаcть отделяется точкой):');
readln(x1,x2,x3,x4);
d:=(x1+x2+x3+x4)/4;
writeln(
'/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/');
if d<100 then writeln('d<100')
else
if d=100 then writeln('X1=',x1:6:4,' X2=',x2:6:4,
                      ' X3=',x3:6:4,' X4=',x4:6:4)
else
 begin
  g:=sqrt(sqrt(x1*x2*x3*x4));
  writeln('Среднее геометрическое чисел:',g:6:4)
 end;
writeln('Нажмите ВВОД для выхода');
readln
end.