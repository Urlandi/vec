program GoldMetod;
uses crt;
const
 g=0.618033988749895;{g=1/g-1)}
{��ਭ� ���ॢ��� ���᪠}
 a:double=-1;
 b:double=3;
{���ᨬ��쭮 �����⨬�� �ਭ� ���ࢠ�� ����।������� ��㬥��}
 e:double=1E-6;
 mm:shortint=-1;{1:������, -1:���ᨬ�}
var
 x1,x2,{��窨 ������� ���ࢠ�� ���᪠}
 f1,f2,{���祭�� �㭪樨 � ��� �窠�}
 r:double;{����� ����襣� ��१�� � ����⮬ �祭�� ��� ������� ���ࢠ��}
 n:word;{������⢮ ���権}
function F(x:double;maxmin:shortint):double;
 var
  tF:double;
  n:longint;
  t:shortint;
 begin
  {������쭠� �������� �㭪�� 3S �����஭� x=r/a0)
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
 clrscr;{���⪠ ��࠭�}

 {��砫쭠� ��⠭���� ��ࠬ��஢}
 r:=(b-a);
 x1:=b-r;
 f1:=F(x1,mm);
 x2:=a+r;
 f2:=F(x2,mm);

 writeln('������ୠ� ࠡ�� 1 �� ��⮤�� ��⨬���樨,');
 writeln('c�㤥�� 3-��� ���� ������� 2003 ���� ��ᨫ쥢� ��堨��.');
 writeln('"����᫮���� ��⨬����� �㭪樨 ����� ��६����� ��⮤�� <����⮣� �祭��>"');
 writeln('');
 writeln('�࠭��� ���ࢠ�� ���᪠ ��㬥��:');
 writeln('[',a:0:6,',',b:0:6,']');
 writeln('�࠭��� ���ࢠ�� ����।�������� ��㬥��:');
 writeln('[',x1:0:6,',',x2:0:6,']');
 writeln('���祭�� �㭪樨 �� ���� �࠭��� ���ࢠ�� ����।�������� ��㬥��:');
 writeln(f1*mm:0:6,' <-> ',f2*mm:0:6 );
 writeln('������⢮ ���権: ',n);

 {�᭮���� 横� ���権}
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
  write('��⨬����� �����襭�',^G);
  repeat
  until keypressed;
  clrscr;
  writeln('(c) 2003 PyRE Std.');
end.