program vektor;
var
 Y,X:array[1..10] of real;
 S:real;
 I:byte;
begin
 writeln('���᫥��� S=SUM(i:1�10)[Xi*Yi]');
 writeln('������ ���祭�� Xi(RAD):');
 S:=0;
 for I:=1 to 10 do
  begin
   write('i = ',I,#9,'Xi = ');
   readln(X[I]);
   Y[I]:=0.1*sin(I)/cos(I);
   writeln(#9,'Yi = ',Y[I]:0:4);
   S:=X[I]*Y[I];
  end;
 writeln('�㬬� ࠢ��: ',S:0:4);
 writeln('������ ENTER ��� �����襭��.');
 readln;
end.