program Semsr_out_OK;
uses crt;
function analizer(strt:integer;var instr:string;len:integer;var vars:longint):integer;
 var
  q:integer;
  xt:shortint;
  tmps:longint;
 begin
(*
xt=2  ᪮��� ������
xt=1  ��᫥ ���.����樨
xt=0  ��᫥ �᫠
*)
xt:=2;
for q:=strt to len do
 begin
  if (instr[q]=')')and(q<>strt)and(xt=0)then break;
  if (instr[q]='(')and(xt>0) then
   begin
    q:=analizer(q+1,instr,len,vars);
    xt:=0;
  if q<0 then break;
  end
  else
   if (instr[q]>='a')and(instr[q]<='z')and(xt>0) then
    begin
     tmps:=1;
     tmps:=tmps shl (ord(instr[q])-96);
     vars:=vars or tmps;
     xt:=0;
    end
    else
     if (instr[q]>='0')and(instr[q]<='9')and(xt>0) then
      begin
       tmps:=0;xt:=0;
       while ((instr[q]>='0')and(instr[q]<='9')or(instr[q]=','))and(tmps<=1) do
        begin
         if instr[q]=','then  inc(tmps);
         inc(q);
        end;
       if (tmps>1)or(instr[q-1]=',') then
        begin
         q:=-q;
         break;
        end;
       dec(q);
      end
      else
      if((instr[q]='+')or(instr[q]='-')or(instr[q]='*')or(instr[q]='/')or(instr[q]='^'))
          and(xt=0)or((xt=2)and(instr[q]='-')) then xt:=1
      else
       begin
        q:=-(q+1);
        xt:=0;
        break;
       end;

 end;
if xt<>0 then q:=-(q+1);
analizer:=q;
end;
var
 func:string;
 xyz,e,q:longint;
begin
clrscr;
gotoxy(35,1);writeln('CALC  THIS');
writeln('������ ��䬥��᪮� ��ࠦ����, ��� ���⢥ত��� ��� �ࢨ�쭮��.');
writeln('��ࠦ���� ����� ᮤ�ঠ�� ᫥���騥 ����� ����権:');
writeln('"+"   �㬬�',#10,#13,'"-"   ࠧ�����, ���� �᫠',
         #10,#13,'"*"   �ந��������',#10,#13,'"/"   ��⭮e',
         #10,#13,'"^"   �⥯���',#10,#13,'"()"  �ਮ���',
         #10,#13,'","   �����筠� ����');
writeln('��६����� - �㪢� ��⨭᪮�� ��䠢�� ��� ��� ॣ����.');
window(1,13,80,25);
repeat
 xyz:=0;
 clrscr;
 write('>');
 readln(func);
 func:=concat(func,')');
 e:=analizer(1,func,length(func),xyz);
 if e<>length(func) then
  writeln('��ࠦ���� ᮤ�ন� �訡��! ��ࠡ�⪠ ��ࢠ�� �� ', abs(e)-1, ' ᨬ����.')
 else
  begin
   write('��ࠦ���� ��୮ ');
   if xyz<>0 then
    begin
     write('� ᮤ�ন� ᫥���騥 ��६����:');
     for e:=1 to 26 do
      begin
       q:=1;
       q:=q shl e;
       if (xyz and q)<>0 then write(chr(e+96),' ');
      end;
    end;
   writeln;
  end;
 writeln('������ ESC ��� ��室� ��� ���� ������� ��� ����७��.');
until(readkey=#27);
window(1,1,80,25);
clrscr;
writeln('(c) 2001 IVT-162');
end.