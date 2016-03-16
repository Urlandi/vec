program NETS;
uses wincrt;
const
 V=7;
 ss=1;
 st=7;
 outnumber=1.7E308;
type
 MatrixNet=array[1..V,1..V] of double;
const
 mi:MatrixNet=((0,5,outnumber,10,10,outnumber,outnumber),
               (5,0,30,15,3,outnumber,outnumber),
               (outnumber,30,0,15,15,2,outnumber),
               (10,15,15,0,outnumber,10,20),
               (10,3,15,outnumber,0,outnumber,10),
               (outnumber,outnumber,2,10,outnumber,0,outnumber),
               (outnumber,outnumber,outnumber,20,10,outnumber,0));
var
 mo:MatrixNet;

procedure MON(WM:MatrixNet;var OM:MatrixNet;s:byte);
 var
  Linked:set of 1..V;
  UnLinked:set of 1..V;
  qy,qx:integer;
  M:double;
  KandidX,KandidY:byte;
 begin
  Linked:=[];
  UnLinked:=[];
  include(Linked,s);
  for qx:=1 to V do
   begin
    if qx<>s then include(UnLinked,qx);
    for qy:=1 to V do
     if qy<>qx then OM[qy,qx]:=outnumber else OM[qy,qx]:=0;
   end;


  repeat
   M:=outnumber;
   for qy:=1 to V do
    if qy in Linked then
     for qx:=1 to V do
      if qx in UnLinked then
       if WM[qy,qx]<=M then
        begin
         M:=WM[qy,qx];
         KandidX:=qx;
         KandidY:=qy;
        end;
   Include(Linked,KandidX);
   Exclude(UnLinked,KandidX);
   OM[KandidY,KandidX]:=M;
   OM[KandidX,KandidY]:=M;
  until UnLinked=[];


 end;
function MWON(WM:MatrixNet;var OM:MatrixNet;s:byte;t:byte):double;
 type
  Mark=record
        U:double;
        T:boolean;
        From:byte;
       end;
 var
  W:array[1..V] of Mark;
  qx,qy:byte;
  M:double;
  KandidX:byte;
 begin
  W[s].U:=0;
  W[s].T:=True;
  for qx:=1 to V do
   begin
    if qx<>s then
     begin
      W[qx].U:=outnumber;
      W[qx].T:=False;
     end;
    for qy:=1 to V do
     if qy<>qx then OM[qy,qx]:=outnumber else OM[qy,qx]:=0;
   end;

  repeat
   for qy:=1 to V do
    if W[qy].T=True then
     for qx:=1 to V do
      if (WM[qy,qx]<outnumber-outnumber/100) and (W[qx].T=False) then
       if WM[qy,qx]+W[qy].U<W[qx].U then
        begin
         W[qx].U:=WM[qy,qx]+W[qy].U;
         W[qx].From:=qy;
        end;



   M:=outnumber;
   for qx:=1 to V do
    if (W[qx].U<=M) and (W[qx].T=False) then
      begin
       KandidX:=qx;
       M:=W[qx].U;
      end;


   W[KandidX].T:=True;
  until KandidX=t;
  qx:=t;
  repeat
   OM[W[qx].From,qx]:=WM[W[qx].From,qx];
   qx:=W[qx].From;
  until qx=s;
  MWON:=W[t].U;

 end;
function MTON(WM:MatrixNet;var OM:MatrixNet;s:word;t:byte):double;
 type
  History = set of 1..V;
 function RingRong(var OM:MatrixNet;var M:double;Step:byte;var From:history;t:byte):boolean;
  var
   SM:double;
   qx:byte;
  begin
   include(From,Step);
   for qx:=1 to V do
    if (OM[Step,qx]>0) and (OM[Step,qx]<outnumber/100) and (not (qx in From)) then
     if qx=t then
      begin
       if OM[Step,qx]<=M then M:=OM[Step,qx];
       OM[Step,qx]:=OM[Step,qx]-M;
       OM[qx,Step]:=OM[qx,Step]+M;
       RingRong:=True;
       exclude(from,step);
       exit;
      end
     else
      begin
       if OM[Step,qx]<=M then M:=OM[Step,qx];
       SM:=M;
       if RingRong(OM,M,qx,From,t)=True then
        begin
         OM[Step,qx]:=OM[Step,qx]-M;
         OM[qx,Step]:=OM[qx,Step]+M;
         if step=s then
          begin
           qx:=0;
           M:=outnumber;
           continue;
          end
         else
          begin
           RingRong:=True;
           exclude(from,step);
           exit;
          end;
        end else M:=SM;
      end;
   RingRong:=False;
   exclude(from,step);
  end;
 var
  qx,qy:byte;
  From:History;
  K:double;
  M:double;
 begin
  OM:=WM;
  K:=0;
  From:=[];
  M:=outnumber;
  RingRong(OM,M,s,From,t);
  for qy:=1 to V do
   for qx:=1 to V do
    begin
     if WM[qy,qx]>=OM[qy,qx] then OM[qy,qx]:=WM[qy,qx]-OM[qy,qx] else OM[qy,qx]:=0;
     if qx=t then K:=K+OM[qy,qx];
    end;
  MTON:=K;
 end;

var
 qx,qy:integer;

begin
 clrscr;
 writeln('Исходная сеть');
 for qy:= 0 to V do
  begin
   for qx:=0 to V do
    begin
     if (qx=0) and (qy=0) then write else
     if qy=0 then write(qx:7) else
     if qx=0 then write(qy);
     if (qx>0) and (qy>0) then
      if (mi[qy,qx]>= outnumber-outnumber/100) or (mi[qy,qx]=0) then
       write('  -   |')
      else  write(mi[qy,qx]:6:2,'|');
     end;
  writeln;
  end;

 readkey;
 clrscr;
 {window(1,12,80,25);}
 MON(mi,mo,ss);
 writeln('Минимальная сеть');
 for qy:= 0 to V do
  begin
   for qx:=0 to V do
    begin
     if (qx=0) and (qy=0) then write else
     if qy=0 then write(qx:7) else
     if qx=0 then write(qy);
     if (qx>0) and (qy>0) then
      if (mo[qy,qx]>= outnumber-outnumber/100) or (mo[qy,qx]=0) then
       write('  -   |')
      else  write(mo[qy,qx]:6:2,'|');
     end;
  writeln;
  end;
 readkey;
 clrscr;
 writeln('Минимальный путь');
 writeln('length =',MWON(mi,mo,ss,st):6:2);
 for qy:= 0 to V do
  begin
   for qx:=0 to V do
    begin
     if (qx=0) and (qy=0) then write else
     if qy=0 then write(qx:7) else
     if qx=0 then write(qy);
     if (qx>0) and (qy>0) then
      if (mo[qy,qx]>= outnumber-outnumber/100) or (mo[qy,qx]=0)then
       write('  -   |')
      else  write(mo[qy,qx]:6:2,'|');
     end;
  writeln;
  end;
 readkey;
 clrscr;
 writeln('Максимальный поток');
 writeln('flow = ',MTON(mi,mo,ss,st):6:2);
 for qy:= 0 to V do
  begin
   for qx:=0 to V do
    begin
     if (qx=0) and (qy=0) then write else
     if qy=0 then write(qx:7) else
     if qx=0 then write(qy);
     if (qx>0) and (qy>0) then
      if (mo[qy,qx]>= outnumber-outnumber/100)or (mo[qy,qx]=0) then
       write('  -   |')
      else  write(mo[qy,qx]:6:2,'|');
     end;
  writeln;
  end;
 readkey;
 {window(1,1,80,25);}
 clrscr;
 writeln('(c) 2003 PyRE Std. by Shesss');
end.