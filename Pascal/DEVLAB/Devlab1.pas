program Devices_Keyboard;
uses crt;
const
 cds:array[0..3] of string[7]=(' 250',' 500',' 750','1000');
 crs:array[0..$1F] of string[8]=('30.0','26.7','24.0','21.8','20.0','18.5','17.1','16.0','15.0','13.3','12.0','10.9','10.0',
                                 ' 9.2',' 8.6',' 8.0',' 7.5',' 6.7',' 6.0',' 5.5',' 5.0',' 4.6',' 4.3',' 4.0',' 3.7',' 3.3',
                                 ' 3.0',' 2.7',' 2.5',' 2.3',' 2.1',' 2.0');
var
 kod:char;
 scan:boolean;
 q:byte;
 p:byte;
 cd,cr:byte;

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

procedure setkeyboardspeed(cd,cr:byte);
 label wait_KBin1,wait_KBin2;
 var
  rb:byte;
 begin
  rb:=0;
  rb:=((cd and 3) shl 5)+(cr and $1F);
  asm
    cli
wait_KBin1:
    in al,64h
    test al,0010b
    jnz wait_KBin1
    mov al,0F3h
    out 60h,al
wait_KBin2:
    in al,64h
    test al,0010b
    jnz wait_KBin2
    mov al,rb
    out 60h,al
    sti
  end;
 end;

begin
     cr:=0;
     cd:=0;
     setkeyboardspeed(cd,cr);
     textbackground(1);
     clrscr;
     hidecursor;
     textcolor(10);
     gotoxy(32,1);
     writeln('*AT-keyboard*');
     textcolor(15);
     gotoxy(17,2);
     writeln('Set "Start delay and Repeat rate" for keyboard');
     textcolor(14);
     gotoxy(1,25);
     write('Made in VSTU by Michael V. VT-562,2005');
     gotoxy(1,5);
     writeln('Keyboard Status byte (from PORT 64H):');
     window(2,7,80,24);
     textcolor(10);
     writeln('Parity Error');
     writeln('Input timeout');
     writeln('Output timeout');
     writeln('Keyboard lock');
     writeln('Last input data is command');
     writeln('Auto test is completed');
     writeln('There are data in the buffer (for keyboard controller');
     writeln('There are data in then buffer (for computer)');
     window(1,1,80,25);
     gotoxy(1,16);
     textcolor(14);
     writeln('Start delay (LEFT,RIGHT):     ms Repeat rate (UP, DOWN):     kps');
     gotoxy(1,18);
     writeln('Test input:');

     repeat
      scan:=false;

      window(60,7,80,24);
      textcolor(12);

      p:=PORT[$64];
      for q:=0 to 7 do
       begin
        if (p and $80)<>0 then writeln('- YES') else  writeln('- NO ');
        p:=p shl 1;
       end;

      window(1,1,80,25);
      textcolor(12);
      gotoxy(27,16);write(cds[cd]);
      gotoxy(58,16);write(crs[cr]);

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

      if scan=false then
       case ord(kod) of
        27:break;
        13:begin
            gotoxy(12,18);
            showcursor;
            readln;
            hidecursor;
           end;
       end
      else
       case ord(kod)of
        $44:break;
        72:begin
            if cr=0 then cr:=$1f else cr:=cr-1;
            setkeyboardspeed(cd,cr);
           end;
        80:begin
            if cr=$1f then cr:=$0 else cr:=cr+1;
            setkeyboardspeed(cd,cr);
           end;
        75:begin
            if cd=0 then cd:=3 else cd:=cd-1;
            setkeyboardspeed(cd,cr);
           end;
        77:begin
            if cd=3 then cd:=0 else cd:=cd+1;
            setkeyboardspeed(cd,cr);
           end;
       end;

     until 0<0;
     window(1,1,80,25);
     textbackground(0);
     textcolor(7);
     clrscr;
end.
