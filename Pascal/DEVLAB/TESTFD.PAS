program Test_FDisk;
uses crt;

type
  testbuffer=array[0..511] of byte;
var
 kod:char;
 scan:boolean;
 q:word;
 p:byte;{Количество дисководов в системе по версии BIOS}
 d:byte;{Текущий выбранный дисковод}
 r:byte;{Количество повторов}

procedure hidecursor;assembler;
 asm
  mov ah,1
  mov ch,20h
  int 10h
 end;

procedure showcursor;assembler;
 asm
  mov ah,1
  mov cx,01fh
  int 10h
 end;

function hexstring(d:word):string;
 const
  dd:array[0..15] of char=('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
 var
  l:word;
  q:byte;
  s:string[5];
 begin
  l:=d;
  s:='';
  for q:=0 to 1 do
   begin
    s:=dd[l and $F]+s;
    l:=l shr 4;
   end;
  hexstring:=s;
 end;


procedure motor_on(d_:byte);
 label MOTOR_DELAY,FIN;
 var
  c_:byte;
 begin
  c_:=(1 shl d_)shl 4+$0C+d_;
  asm
             STI
             MOV CL,8
             CMP CL,0
             JE  FIN
             XOR AX,AX
             MOV ES,AX
             MOV DI,046CH
             MOV AL,BYTE PTR ES:[DI]
             ADD AL,CL
MOTOR_DELAY: MOV AH,BYTE PTR ES:[DI]
             CMP AH,AL
             JNE MOTOR_DELAY

FIN:         MOV  DX,3F2H
             MOV  AL,c_
             OUT  DX,AL

  end;
 end;

procedure motor_off(d_:byte);
label MOTOR_DELAY,FIN;
 var
  c_:byte;
 begin
  c_:=$C+d_;
  asm
             STI
             MOV CL,25h
             CMP CL,0
             JE  FIN
             XOR AX,AX
             MOV ES,AX
             MOV DI,046CH
             MOV AL,BYTE PTR ES:[DI]
             ADD AL,CL
MOTOR_DELAY: MOV AH,BYTE PTR ES:[DI]
             CMP AH,AL
             JNE MOTOR_DELAY

FIN:         MOV  DX,3F2H
             MOV  AL,c_
             OUT  DX,AL
  end;
 end;

procedure calibrate(d_:byte);
 label
  OUT_FDC,KEEP_TRYING,AGAIN,WAIT_INTERRUPT,ROE,TIME_WAIT,TIK_TAK,FIN;
 var
  q:byte;
  ST0,ST1,ST2,_C,_H,_R,_N:byte;
  lo:longint;
  oh,ol,ns:byte;
 begin
 MOTOR_ON(d_);
 asm

{Калибровка дисковода}
   STI
   MOV  AH,07h
   CALL OUT_FDC
   XOR  AH,AH
   ADD  AH,d_ {Номер накопителя от 0 до 3}
   CALL OUT_FDC
   CALL WAIT_INTERRUPT

{Ждем некоторое время, пока головка доедет до места}

   MOV CL,0Fh
   CALL TIME_WAIT

   JMP ROE

OUT_FDC:      MOV  DX,3F4H
KEEP_TRYING:  IN   AL,DX
              TEST AL,128
              JZ   KEEP_TRYING
              INC  DX
              MOV  AL,AH
              OUT  DX,AL
              RET


WAIT_INTERRUPT:  MOV  AX,40H
                 MOV  ES,AX
                 MOV  BX,3EH
AGAIN:           MOV  DL,ES:[BX]
                 TEST DL,80H
                 JZ   AGAIN
                 AND  DL,01111111B
                 MOV  ES:[BX],DL
                 RET


TIME_WAIT:   CMP CL,0
             JE  FIN
             XOR AX,AX
             MOV ES,AX
             MOV DI,046CH
             MOV AL,BYTE PTR ES:[DI]
             ADD AL,CL
TIK_TAK:     MOV AH,BYTE PTR ES:[DI]
             CMP AH,AL
             JNE TIK_TAK
FIN:         RET
ROE:
 end;
 MOTOR_OFF(d_);
end;

procedure READ_SECTOR(d_,h_,t_,s_:byte;var buffer:testbuffer);
 label
  OUT_FDC,KEEP_TRYING,AGAIN,WAIT_INTERRUPT,ROE,IN_FDC,ONCE_AGAIN,TIME_WAIT,TIK_TAK,FIN;
 var
  q:byte;
  ST0,ST1,ST2,_C,_H,_R,_N:byte;
  lo:longint;
  oh,ol,ns:byte;
 begin

 lo:=seg(buffer);
 lo:=lo shl 4;
 lo:=lo+ofs(buffer);
 oh:=(lo and $FF00) shr 8;
 ol:=lo and $FF;
 ns:=(lo and $F0000) shr 16;
 ST0:=$FF;
 ST1:=$FF;
 ST2:=$FF;
 _C:=$FF;
 _H:=$FF;
 _R:=$FF;
 _N:=$FF;
 asm
{Позиционируем головку чтения/записи}
   STI
   MOV  AH,0Fh
   CALL OUT_FDC
   MOV  AH,h_ {Сторона 0/1}
   SHL  AH,1
   SHL  AH,1
   ADD  AH,d_ {Номер накопителя от 0 до 3}
   CALL OUT_FDC
   MOV  AH,t_ {Номер дорожки}
   CALL OUT_FDC
   CALL WAIT_INTERRUPT

{Ждем некоторое время, пока головка доедет до места}

   MOV CL,0Fh
   CALL TIME_WAIT

{Программируем ПДП}

   MOV  AL,46H {Код чтения данных от НГМД}
   OUT  12,AL
   OUT  11,AL

   MOV  AL,ol
   OUT  4,AL
   MOV  AL,oh
   OUT  4,AL
   MOV  AL,ns
   OUT  81H,AL

   MOV  AX,511
   OUT  5,AL
   MOV  AL,AH
   OUT  5,AL
   MOV  AL,2
   OUT  10,AL

{Программируем чтение сектора}

   MOV  AH,66H {Код чтения одного сектора}
   CALL OUT_FDC
   MOV  AH,h_
   SHL  AH,1
   SHL  AH,1
   ADD  AH,d_
   CALL OUT_FDC  {Посылаем номер головки и накопителя}
   MOV  AH,t_
   CALL OUT_FDC  {Посылаем номер дорожки}
   MOV  AH,h_
   CALL OUT_FDC  {Посылаем номер головки}
   MOV  AH,s_
   CALL OUT_FDC  {Посылаем номер сектора}
   MOV  AH,2
   CALL OUT_FDC  {Посылаем код размера сектора 512 байт}
   MOV  AH,12h
   CALL OUT_FDC  {Посылаем номер последнего сектора на дорожке}
   MOV  AH,2Ah
   CALL OUT_FDC  {GPL}
   MOV  AH,0FFH
   CALL OUT_FDC  {Что-то если N=0}

   CALL WAIT_INTERRUPT

{Считываем результат операции (статусные регистры)}

   CALL IN_FDC
   MOV  ST0,AL
   CALL IN_FDC
   MOV  ST1,AL
   CALL IN_FDC
   MOV  ST2,AL
   CALL IN_FDC
   MOV  _C,AL
   CALL IN_FDC
   MOV  _H,AL
   CALL IN_FDC
   MOV  _R,AL
   CALL IN_FDC
   MOV  _N,AL

   JMP  ROE

OUT_FDC:      MOV  DX,3F4H
KEEP_TRYING:  IN   AL,DX
              TEST AL,128
              JZ   KEEP_TRYING
              INC  DX
              MOV  AL,AH
              OUT  DX,AL
              RET


WAIT_INTERRUPT:  MOV  AX,40H
                 MOV  ES,AX
                 MOV  BX,3EH
AGAIN:           MOV  DL,ES:[BX]
                 TEST DL,80H
                 JZ   AGAIN
                 AND  DL,01111111B
                 MOV  ES:[BX],DL
                 RET

IN_FDC:      MOV  DX,3F4H
ONCE_AGAIN:  IN   AL,DX
             TEST AL,128
             JZ   ONCE_AGAIN
             INC  DX
             IN   AL,DX
             RET

TIME_WAIT:   CMP CL,0
             JE  FIN
             XOR AX,AX
             MOV ES,AX
             MOV DI,046CH
             MOV AL,BYTE PTR ES:[DI]
             ADD AL,CL
TIK_TAK:     MOV AH,BYTE PTR ES:[DI]
             CMP AH,AL
             JNE TIK_TAK
FIN:         RET
ROE:
 end;
  gotoxy(1,23);
  textcolor(14);
  writeln('ST0:',hexstring(ST0),'H ST1:',hexstring(ST1),'H ST2:',hexstring(ST2),
          'H Head:',_H,' Track:',_C,' Sector:',_R,' Size of sector code:',_N,'      ');
end;


function stepreadtest(r:byte;d:byte):boolean;
 var
  predI,predT,nextI,nextT:testbuffer;
  h:byte;
  c:byte;
  rep:byte;
  q:word;
 begin
  MOTOR_ON(d);
  for h:=0 to 1 do
   for c:=0 to 78 do
    for rep:=1 to r do
     begin
      READ_SECTOR(d,h,c,1,predI);
      READ_SECTOR(d,h,c+1,1,nextI);
      READ_SECTOR(d,h,c,1,predT);
      READ_SECTOR(d,h,c+1,1,nextT);
      for q:=0 to 511 do
        if (predI[q]<>predT[q]) or (nextI[q]<>nextT[q]) then
         begin
          stepreadtest:=false;
          MOTOR_OFF(d);
          exit;
         end
     end;
  stepreadtest:=true;
  MOTOR_OFF(d);
 end;

function butreadtest(r:byte;d:byte):boolean;
 var
  predI,predT,nextI,nextT:testbuffer;
  h:byte;
  c:byte;
  rep:byte;
  q:word;
 begin
  MOTOR_ON(d);
  for h:=0 to 1 do
   for c:=0 to 39 do
    for rep:=1 to r do
     begin
      READ_SECTOR(d,h,c,1,predI);
      READ_SECTOR(d,h,79-c,1,nextI);
      READ_SECTOR(d,h,c,1,predT);
      READ_SECTOR(d,h,79-c,1,nextT);
      for q:=0 to 511 do
        if (predI[q]<>predT[q]) or (nextI[q]<>nextT[q]) then
         begin
          butreadtest:=false;
          MOTOR_OFF(d);
          exit;
         end
     end;
  butreadtest:=true;
  MOTOR_OFF(d);
 end;

function rndreadtest(r:byte;d:byte):boolean;
 var
  predI,predT,nextI,nextT:testbuffer;
  h,hr,hr1:byte;
  c,cr,cr1:byte;
  sr,sr1:byte;
  rep:byte;
  q:word;
 begin
  randomize;
  MOTOR_ON(d);
  for h:=0 to 1 do
   for c:=0 to 39 do
    for rep:=1 to r do
     begin
      hr:=random(2);
      hr1:=random(2);
      cr:=random(80);
      cr1:=random(80);
      sr:=random(18)+1;
      sr1:=random(18)+1;

      READ_SECTOR(d,hr,cr,sr,predI);
      READ_SECTOR(d,hr1,cr1,sr1,nextI);
      READ_SECTOR(d,hr,cr,sr,predT);
      READ_SECTOR(d,hr1,cr1,sr1,nextT);
      for q:=0 to 511 do
        if (predI[q]<>predT[q]) or (nextI[q]<>nextT[q]) then
         begin
          rndreadtest:=false;
          MOTOR_OFF(d);
          exit;
         end
     end;
  rndreadtest:=true;
  MOTOR_OFF(d);
 end;

begin
     r:=1;
     d:=0;
     textbackground(1);
     clrscr;
     hidecursor;
     textcolor(10);
     gotoxy(28,1);
     writeln('*FLOPPY DISK CONTROLLER*');
     textcolor(15);
     gotoxy(33,2);
     writeln('Test diskette');
     textcolor(14);
     gotoxy(1,25);
     write('Made in VSTU by Michael V. VT-562,2006');
     gotoxy(1,4);
     write('Number of FD drivers:');
     p:=MEM[0:$410];
     p:=((p shr 6)+1)*(p and 1);
     textcolor(12);writeln('  ',p);
     textcolor(14);
     write('Select drive for test: ');
     textcolor(12);writeln(d);
     textcolor(14);
     write('Test repeats: ');
     textcolor(12);writeln(r);
     textcolor(10);
     writeln;
     writeln('Press ENTER for start tests.');

     repeat
      scan:=false;

      kod:=#0;
      while KeyPressed do
       begin
        kod:=ReadKey;
        if kod=#0 then
        begin
         scan:=true;
         continue;
        end;
       end;

      textcolor(14);
      if scan=false then
       case ord(kod) of
        13:begin
            window(1,8,80,24);
            clrscr;
            window(1,1,80,25);
            calibrate(d);
            textcolor(14);
            gotoxy(1,8);writeln('"Consecutive reading" test in progress. Please wait a few minutes.');
           repeat
            if stepreadtest(r,d)=false then
             begin
              textcolor(12);
              gotoxy(1,10);writeln('"Consecutive reading" test: FAILED!');
              gotoxy(1,9);writeln('All tests are cancelled!');
              break;
             end;
            textcolor(14);
            gotoxy(1,8);writeln('"Butterfly" test in progress.  Please wait a few minutes.         ');
            textcolor(10);
            gotoxy(1,10);writeln('"Consecutive reading" test: PASSED');

            if butreadtest(r,d)=false then
             begin
              textcolor(12);
              gotoxy(1,11);writeln('"Butterfly" test: FAILED!');
              gotoxy(1,9);writeln('All tests are cancelled!');
              break;
             end;
            textcolor(14);
            gotoxy(1,8);writeln('"Random access" test in progress.  Please wait a few minutes.     ');
            textcolor(10);
            gotoxy(1,11);writeln('"Butterfly" test: PASSED');

            if rndreadtest(r,d)=false then
             begin
              textcolor(12);
              gotoxy(1,12);writeln('"Random access" test: FAILED!');
              gotoxy(1,9);writeln('All tests are cancelled!');
              break;
             end;
            textcolor(10);
            gotoxy(1,12);writeln('"Random access" test: PASSED');
            gotoxy(1,9);writeln('All tests are successfully completed!');
            break;
           until 0<0;
            textcolor(10);
            gotoxy(1,8);writeln('Press ENTER for start tests again.                                ');
           end;
        $30:begin
            end;
        $31:begin
            end;
        27:break;
       end
      else
       case ord(kod)of
        $44:break;
        72:begin
             if d=1 then d:=0 else d:=1;
             textcolor(12);
             gotoxy(24,5);writeln(d);
           end;
        80:begin
             if d=1 then d:=0 else d:=1;
             textcolor(12);
             gotoxy(24,5);writeln(d);
           end;
        75:begin
            if r>1 then r:=r-1 else r:=255;
            textcolor(12);
            gotoxy(15,6);writeln(r,'   ');
           end;
        77:begin
            if r<255 then r:=r+1 else r:=1;
            textcolor(12);
            gotoxy(15,6);writeln(r,'   ');
           end;
       end;
     until 0<0;
     window(1,1,80,25);
     showcursor;
     textbackground(0);
     textcolor(7);
     clrscr;
end.
