program vektor;
var
 Y,X:array[1..10] of real;
 S:real;
 I:byte;
begin
 writeln('Вычисление S=SUM(i:1Ў10)[Xi*Yi]');
 writeln('Введите значения Xi(RAD):');
 S:=0;
 for I:=1 to 10 do
  begin
   write('i = ',I,#9,'Xi = ');
   readln(X[I]);
   Y[I]:=0.1*sin(I)/cos(I);
   writeln(#9,'Yi = ',Y[I]:0:4);
   S:=X[I]*Y[I];
  end;
 writeln('Сумма равна: ',S:0:4);
 writeln('Нажмите ENTER для завершения.');
 readln;
end.