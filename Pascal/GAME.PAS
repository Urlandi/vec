program Game ;
label
start,theend;
var
asc:char;
pop:integer;
popent:integer;
ent:integer;
zna:integer;
begin
start:write('���᪠�뢠��? Y/N ');readln(asc);
repeat
pop:=1;write('������ ������⢮ ����⮪ 1-10 ');read(popent)
until popent <= 10;
randomize;
repeat
write('������ �������� 㣠�뢠���� �ᥫ 10-1000 ');read(ent) ;
until ent<=1000;
zna:=random(ent+1);
case asc of
'Y','y':begin
  repeat
  pop:=pop+1;
  write('� ������� �᫮ - 㣠��� ');readln(ent);
  if ent>zna then writeln('����� ');
  if ent<zna then writeln('����� ');
  if pop>popent then
   begin
   writeln('�� �� ᫠�� ⥡� ���� ������'); goto theend;
   end;
  until (ent = zna);
  writeln('� ��� ࠧ �� 㣮���,�� ᬥ���� �� �� ᬥ���� ��᫥���� ');
  end;
'N','n':begin
  repeat
  pop:=pop+1;
  write('� ������� �᫮ - 㣠��� ');readln(ent);
  if pop >popent then
   begin
   writeln('���஡� �� � �� �������� '); goto theend;
   end;
  until (ent=zna) ;
  writeln('�� ᨫ�� ��ப,�� �� �� ��ᬮ�ਬ �� ���� ');
  end;
  else
  writeln('����� ���� � ��⮬ �ਢ������ � ������ �ॡ������ ')
end;
theend:write('C�ࠥ� �� Y/N ');readln(asc) ;
 case asc of
 'Y','y':goto start;
 'N','n':writeln('�� �� ���� ');
  else goto start;
 end;
end.