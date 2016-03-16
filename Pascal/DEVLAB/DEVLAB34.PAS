program Devices_FD;
uses crt;

var
 kod:char;
 scan:boolean;
 tdcs,tdip:word;
 q:word;
 p:byte;
 pt:byte;
 h:byte;
 d:byte;
 t:word;

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
  for q:=0 to 3 do
   begin
    s:=dd[l and $F]+s;
    l:=l shr 4;
   end;
  hexstring:=s;
 end;

function conv(s:string):string;
 var
  sto:string;
  l:byte;
  space:boolean;
  b:byte;
 begin
  conv:='';
  if length(s)=0 then exit;
  l:=1;
  sto:='';
  space:=FALSE;
  b:=0;
  while l<=ord(s[0]) do
   begin
    case s[l] of
     '0':begin
          b:=(b shl 4)+$0;
          space:=TRUE;
         end;
     '1':begin
          b:=(b shl 4)+$1;
          space:=TRUE;
         end;
     '2':begin
          b:=(b shl 4)+$2;
          space:=TRUE;
         end;
     '3':begin
          b:=(b shl 4)+$3;
          space:=TRUE;
         end;
     '4':begin
          b:=(b shl 4)+$4;
          space:=TRUE;
         end;
     '5':begin
          b:=(b shl 4)+$5;
          space:=TRUE;
         end;
     '6':begin
          b:=(b shl 4)+$6;
          space:=TRUE;
         end;
     '7':begin
          b:=(b shl 4)+$7;
          space:=TRUE;
         end;
     '8':begin
          b:=(b shl 4)+$8;
          space:=TRUE;
         end;
     '9':begin
          b:=(b shl 4)+$9;
          space:=TRUE;
         end;
 'A','a':begin
          b:=(b shl 4)+$A;
          space:=TRUE;
         end;
 'B','b':begin
          b:=(b shl 4)+$B;
          space:=TRUE;
         end;
 'C','c':begin
          b:=(b shl 4)+$C;
          space:=TRUE;
         end;
 'D','d':begin
          b:=(b shl 4)+$D;
          space:=TRUE;
         end;
 'E','e':begin
          b:=(b shl 4)+$E;
          space:=TRUE;
         end;
 'F','f':begin
          b:=(b shl 4)+$F;
          space:=TRUE;
         end;
     #32:begin
          if space then
           begin
            sto:=sto+chr(b);
            b:=0;
            space:=FALSE;
           end;
         end;
     else
       exit;
    end;
    l:=l+1;
   end;
  if space then sto:=sto+chr(b);
  conv:=sto;
 end;


procedure motor_on(d_:byte;mst_:byte);
 label MOTOR_DELAY,FIN;
 var
  c_:byte;
 begin
  c_:=(1 shl d_)shl 4+$0C+d_;
  asm
             MOV CL,mst_
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

procedure motor_off(d_:byte;mot_:byte);
label MOTOR_DELAY,FIN;
 var
  c_:byte;
 begin
  c_:=$C+d_;
  asm
             MOV CL,mot_
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

procedure FORMAT_TRACK(d_,t_,s_,h_,z_,gpl_,f_:byte;hst_:byte);
 label
  WAIT_SETTLE,NO_CARRY,NEXT,OUT_FDC,KEEP_TRYING,AGAIN,WAIT_INTERRUPT,ROE,IN_FDC,ONCE_AGAIN,TIME_WAIT,TIK_TAK,FIN;
 var
  buffer:array[0..$3F] of record
                           C:byte;
                           H:byte;
                           N:byte;
                           S:byte;
                          end;
  q:byte;
  ST0,ST1,ST2,_C,_H,_R,_N:byte;
  lo:longint;
  oh,ol,ns:byte;
 begin
   for q:=1 to s_ do
   begin
    buffer[q-1].C:=t_;
    buffer[q-1].H:=h_;
    buffer[q-1].N:=q;
    buffer[q-1].S:=z_;
   end;

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
 asm;

   MOV  AH,0Fh
   CALL OUT_FDC
   MOV  AH,h_
   SHL  AH,1
   SHL  AH,1
   ADD  AH,d_
   CALL OUT_FDC
   MOV  AH,t_
   CALL OUT_FDC
   CALL WAIT_INTERRUPT


   MOV CL,hst_
   CALL TIME_WAIT

   MOV  AL,4AH
   OUT  12,AL
   OUT  11,AL

   MOV  AL,ol
   OUT  4,AL
   MOV  AL,oh
   OUT  4,AL
   MOV  AL,ns
   OUT  81H,AL

   XOR  AX,AX
   MOV  AL,s_
   SHL  AX,1
   SHL  AX,1
   DEC  AX
   OUT  5,AL
   MOV  AL,AH
   OUT  5,AL
   MOV  AL,2
   OUT  10,AL

   MOV  AH,4DH
   CALL OUT_FDC
   MOV  AH,h_
   SHL  AH,1
   SHL  AH,1
   ADD  AH,d_
   CALL OUT_FDC
   MOV  AH,z_
   CALL OUT_FDC
   MOV  AH,s_
   CALL OUT_FDC
   MOV  AH,gpl_
   CALL OUT_FDC
   MOV  AH,f_
   CALL OUT_FDC
   CALL WAIT_INTERRUPT

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
 textcolor(14);
 gotoxy(1,24);writeln('ST0:     ST1:     ST2:');
 textcolor(12);
 gotoxy(5,24);writeln(hexstring(ST0));
 gotoxy(14,24);writeln(hexstring(ST1));
 gotoxy(23,24);writeln(hexstring(ST2));
 end;



function trackformat(d:byte;h:byte;t:word;s:byte;z:byte):byte;
 label retrn;
 var
  lcx:word;
  chns:array[0..$3F] of record
                         C:byte;
                         H:byte;
                         N:byte;
                         S:byte;
                        end;
  q:byte;
  err:byte;
 begin
  err:=0;
  for q:=1 to s do
   begin
    chns[q-1].C:=t;
    chns[q-1].H:=h;
    chns[q-1].N:=q;
    chns[q-1].S:=z;
   end;
  lcx:=t shl 8;
  lcx:=lcx+((t shr 2) and $C0);
  asm
   mov ax,seg chns
   mov es,ax
   mov ah,05h
   mov bx,offset chns
   mov dl,d
   mov dh,h
   mov cx,lcx
   int 13h
   jnc retrn
   mov err,ah
retrn:
  end;
  trackformat:=err;
 end;
procedure diskformat(d:byte;h:byte;t:word;s:byte;z:byte;lowlevel:boolean);
 var
  ch:byte;
  ct:byte;
  err:byte;
 begin
  err:=0;
  gotoxy(1,23);writeln('                                                              ');
  gotoxy(1,24);writeln('                                                              ');
  if lowlevel=true then MOTOR_ON(d,mem[tdcs:(tdip+10)]*2);
  for ct:=0 to t-1 do
   begin
    for ch:=0 to h-1 do
     begin
      if lowlevel=false then err:=trackformat(d,ch,ct,s,z)
      else FORMAT_TRACK(d,ct,s,ch,z,mem[tdcs:(tdip+7)],mem[tdcs:(tdip+8)],mem[tdcs:(tdip+9)]*18 div 1000);
      textcolor(14);
      gotoxy(5,23);writeln('H:            C:');
      textcolor(12);
      gotoxy(8,23);writeln(hexstring(ch));
      gotoxy(22,23);writeln(hexstring(ct));
      if err<>0 then break;
     end;
    if err<>0 then
     begin
      asm
{       xor ah,ah
       mov dl,d 
       int 13h}
      end;
      break;
     end;
   end;
  gotoxy(1,23);
  textcolor(14);
  case err of
   0:writeln('Formatting is successfully completed');
   1:writeln('Bad command: invalid request to controller');
   2:writeln('Bad address mark                    ');
   3:writeln('Write protect: attempted to write on write-protected diskette');
   4:writeln('Sector ID bad or not found          ');
   5:writeln('Reset controller error              ');
   6:writeln('Diskette change line is active      ');
   8:writeln('DMA failure                         ');
   9:writeln('DMA overrun: attempted to write across a 64K-byte boundary');
 $0B:writeln('Bad track flag found                ');
 $0C:writeln('Media type not available            ');
 $11:writeln('Repair data with ECC                ');
 $10:writeln('Bad CRC: Cyclical Redundancy Code does not agree with data');
 $20:writeln('Diskette controller failure         ');
 $40:writeln('Bad seek: requested track not found ');
 $80:writeln('Time-out                            ');
else writeln('Uncknow error                       ');
  end;
  if lowlevel=true then MOTOR_OFF(d,mem[tdcs:(tdip+2)]);
 end;
begin
     h:=2;
     t:=$50;
     d:=0;
     textbackground(1);
     clrscr;
     hidecursor;
     textcolor(10);
     gotoxy(28,1);
     writeln('*FLOPPY DISK CONTROLLER*');
     textcolor(15);
     gotoxy(33,2);
     writeln('Format diskette');
     textcolor(14);
     gotoxy(1,25);
     write('Made in VSTU by Michael V. VT-562,2005');
     gotoxy(1,4);
     write('Number of FD drivers:');
     p:=MEM[0:$410];
     textcolor(12);write(' ',((p shr 6)+1)*(p and 1));
     textcolor(14);
     write('     Select drive for format: ');
     textcolor(12);writeln(d);
     textcolor(14);
     writeln;
     writeln('Diskette Parameter Table:');
     writeln;
     writeln(' Step rate time');
     writeln(' Head unload time');
     writeln(' Use DMA');
     writeln(' Head load time');
     writeln(' 55ms increments before turning disk motor off*');
     writeln(' Sector size (byte)*');
     writeln(' Last sector on a track*                                <-');
     writeln(' Gap length for read/write operations');
     writeln(' Max trasfer then length not set');
     writeln(' Gap length for format operations*');
     writeln(' Fill character for format*');
     writeln(' Head settle time (ms)*');
     writeln(' Motor startup time (in 1/8th-seconds interval)*');
     writeln;
     write('Heads: ');textcolor(12);write(2);textcolor(14);
     write('     Tracks: ');textcolor(12);write('0050');
     window(50,8,80,24);
     tdip:=MEMW[0:$78];
     tdcs:=MEMW[0:$7A];
     for q:=0 to 10 do
      begin
       p:=mem[tdcs:(tdip+q)];
       case q of
        0: begin
            writeln('- ',hexstring(p and $0F));
            writeln('- ',hexstring(p shr $4));
           end;
        1: begin
            if (p and 1)=0 then writeln('- NO') else writeln('- YES');
            writeln('- ',hexstring(p shr 1));
           end;
        3:case (p and 3) of
           0:writeln('- 0080');
           1:writeln('- 0100');
           2:writeln('- 0200');
           3:writeln('- 0400');
          end;
        else writeln('- ',hexstring(p));
       end;
      end;

     window(1,1,80,25);
     pt:=6;
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
            diskformat(d,h,t,MEM[tdcs:tdip+4],MEM[tdcs:tdip+3],false);
           end;
        32:begin
            diskformat(d,h,t,MEM[tdcs:tdip+4],MEM[tdcs:tdip+3],true);
           end;
        $30:begin
             d:=0;
             textcolor(12);
             gotoxy(54,4);writeln('0');
            end;
        $31:begin
             d:=1;
             textcolor(12);
             gotoxy(54,4);writeln('1');
            end;
        27:break;
       end
      else
       case ord(kod)of
        $44:break;
        72:begin
            if pt<13 then
             begin
              gotoxy(57,8+pt);writeln('  ');
             end
            else
             if pt=13 then
              begin
               gotoxy(10,22);writeln('  ');
              end
             else
              begin
               gotoxy(27,22);writeln('  ');
              end;
            if pt=0 then pt:=14 else pt:=pt-1;
            if pt<13 then
             begin
              gotoxy(57,8+pt);writeln('<-');
             end
            else
             if pt=13 then
              begin
               gotoxy(10,22);writeln('<-');
              end
             else
              begin
               gotoxy(27,22);writeln('<-');
              end
           end;
        80:begin
            if pt<13 then
             begin
              gotoxy(57,8+pt);writeln('  ');
             end
            else
             if pt=13 then
              begin
               gotoxy(10,22);writeln('  ');
              end
             else
              begin
               gotoxy(27,22);writeln('  ');
              end;
            if pt=14 then pt:=0 else pt:=pt+1;
            if pt<13 then
             begin
              gotoxy(57,8+pt);writeln('<-');
             end
            else
             if pt=13 then
              begin
               gotoxy(10,22);writeln('<-');
              end
             else
              begin
               gotoxy(27,22);writeln('<-');
              end
           end;
        75:begin
            textcolor(12);
            case pt of
             0:begin
                p:=MEM[tdcs:tdip];
                p:=((p - 1) and $0F);
                p:=(MEM[tdcs:tdip] and $F0)+ p;
                MEM[tdcs:tdip]:=p;
                gotoxy(52,8);writeln((hexstring(MEM[tdcs:tdip] and $0F)));
               end;
             1:begin
                p:=MEM[tdcs:tdip];
                p:=((p shr 4)- 1) shl 4;
                p:=(MEM[tdcs:tdip] and $0F)+ p;
                MEM[tdcs:tdip]:=p;
                gotoxy(52,9);writeln((hexstring(MEM[tdcs:tdip] shr 4)));
               end;
             2:begin
{                p:=MEM[tdcs:tdip+1];
                p:=((p - 1) and $01);
                p:=(MEM[tdcs:tdip+1] and $FE)+ p;
                MEM[tdcs:tdip+1]:=p;
                gotoxy(52,10);
                if MEM[tdcs:tdip+1] and 1 =0 then writeln('NO ') else writeln('YES');}
               end;
             3:begin
                p:=MEM[tdcs:tdip+1];
                p:=((p shr 1)- 1) shl 1;
                p:=(MEM[tdcs:tdip+1] and $01)+ p;
                MEM[tdcs:tdip+1]:=p;
                gotoxy(52,11);writeln((hexstring(MEM[tdcs:tdip+1] shr 1)));
               end;
             5:begin
                p:=MEM[tdcs:tdip+3];
                p:=((p - 1) and $03);
                p:=(MEM[tdcs:tdip+3] and $FC)+ p;
                MEM[tdcs:tdip+3]:=p;
                gotoxy(52,13);
                case (MEM[tdcs:tdip+3] and 3) of
                 0:writeln('0080');
                 1:writeln('0100');
                 2:writeln('0200');
                 3:writeln('0400');
                end;
               end;
             6:begin
                p:=MEM[tdcs:tdip+4];
                p:=((p - 1) and $3F);
                p:=(MEM[tdcs:tdip+4] and $C0)+ p;
                MEM[tdcs:tdip+4]:=p;
                gotoxy(52,14);writeln(hexstring(MEM[tdcs:tdip+4]));
               end;
             13:begin
                 if h=1 then h:=2 else h:=1;
                 gotoxy(8,22);writeln(h);
                end;
             14:begin
                 if t=0 then t:=$3FF else t:=t-1;
                 gotoxy(22,22);writeln(hexstring(t));
                end;
             else
               begin
                p:=MEM[tdcs:tdip+pt-2];
                p:=p - 1;
                MEM[tdcs:tdip+pt-2]:=p;
                gotoxy(52,8+pt);writeln(hexstring(MEM[tdcs:tdip+pt-2]));
               end;
            end;
           end;
        77:begin
            textcolor(12);
            case pt of
             0:begin
                p:=MEM[tdcs:tdip];
                p:=((p + 1) and $0F);
                p:=(MEM[tdcs:tdip] and $F0)+ p;
                MEM[tdcs:tdip]:=p;
                gotoxy(52,8);writeln((hexstring(MEM[tdcs:tdip] and $0F)));
               end;
             1:begin
                p:=MEM[tdcs:tdip];
                p:=((p shr 4)+ 1) shl 4;
                p:=(MEM[tdcs:tdip] and $0F)+ p;
                MEM[tdcs:tdip]:=p;
                gotoxy(52,9);writeln((hexstring(MEM[tdcs:tdip] shr 4)));
               end;
             2:begin
{                p:=MEM[tdcs:tdip+1];
                p:=((p + 1) and $01);
                p:=(MEM[tdcs:tdip+1] and $FE)+ p;
                MEM[tdcs:tdip+1]:=p;
                gotoxy(52,10);
                if MEM[tdcs:tdip+1] and 1 =0 then writeln('NO ') else writeln('YES');}
               end;
             3:begin
                p:=MEM[tdcs:tdip+1];
                p:=((p shr 1)+ 1) shl 1;
                p:=(MEM[tdcs:tdip+1] and $01)+ p;
                MEM[tdcs:tdip+1]:=p;
                gotoxy(52,11);writeln((hexstring(MEM[tdcs:tdip+1] shr 1)));
               end;
             5:begin
                p:=MEM[tdcs:tdip+3];
                p:=((p + 1) and $03);
                p:=(MEM[tdcs:tdip+3] and $FC)+ p;
                MEM[tdcs:tdip+3]:=p;
                gotoxy(52,13);
                case (MEM[tdcs:tdip+3] and 3) of
                 0:writeln('0080');
                 1:writeln('0100');
                 2:writeln('0200');
                 3:writeln('0400');
                end;
               end;
             6:begin
                p:=MEM[tdcs:tdip+4];
                p:=((p + 1) and $3F);
                p:=(MEM[tdcs:tdip+4] and $C0)+ p;
                MEM[tdcs:tdip+4]:=p;
                gotoxy(52,14);writeln(hexstring(MEM[tdcs:tdip+4]));
               end;
             13:begin
                 if h=1 then h:=2 else h:=1;
                 gotoxy(8,22);writeln(h);
                end;
             14:begin
                 if t=$3FF then t:=$0 else t:=t+1;
                 gotoxy(22,22);writeln(hexstring(t));
                end;
             else
               begin
                p:=MEM[tdcs:tdip+pt-2];
                p:=p + 1;
                MEM[tdcs:tdip+pt-2]:=p;
                gotoxy(52,8+pt);writeln(hexstring(MEM[tdcs:tdip+pt-2]));
               end;
            end;
           end;
       end;
     until 0<0;
     window(1,1,80,25);
     textbackground(0);
     textcolor(7);
     clrscr;
end.
