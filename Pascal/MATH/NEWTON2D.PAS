{��⮤ ���⥫���}
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
 writeln('������ୠ� ࠡ�� 1 �� ��⮤�� ��⨬���樨,');
 writeln('c�㤥�� 3-��� ���� ������� 2003 ���� ��ᨫ쥢� ��堨��.');
 writeln('"����᫮���� ��⨬����� �㭪樨 ����� ��६����� ��⮤�� <���⥫���>"');
 writeln('');
 writeln('�࠭��� ���ࢠ�� ���᪠ ��㬥��:[',a:0:6,',',b:0:6,']');
 writeln;

 t:=0;
 while (a<b) do
  begin
   q:=newton(a,b,e,x);
   t:=t+1;
   if (q<>-1)and(x3-x>e) then
    begin
     write('F(X)=',f(x):0:6,' X=',x:0:6,' ���-�� ���権:',q);
     if l1_dfdx(x)>0 then writeln(' -> ������') else
     if l1_dfdx(x)<0 then writeln(' -> ���ᨬ�') else writeln('��⮤ �� ���� �襭��');
    end;
   x3:=x;
   a:=a+e;
  end;
 writeln('���-�� ��ᬮ�७��� ���ࢠ���, ���祭�� ��⨬㬮�:',t);

 gotoxy(1,25);
 write('��⨬����� �����襭�',^G);
 repeat
 until keypressed;
 clrscr;
 writeln('(c) 2003 PyRE Std.');
end.