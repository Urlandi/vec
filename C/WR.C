#include <conio.h>
#include <stdio.h>
#include <dos.h>
char game(void);
unsigned int keykod(void);
unsigned char readcursor(void);
void fl(char ux,char uy,char dx,char dy,char cm,char cb,char t);
void sr(char x,char y,char rx,char ry,char cb);
void push(char x,char y,char *stroka,char reg,char n);
unsigned int rnd(unsigned int init,unsigned long int r);
unsigned long int tm(void);
char load(char *fname);
void menu(void);
char strl(char *stroka);
void strin(char *stroka);

char fp=0,cp=12,fo=1,co=14,level=0;
signed char live=2;
unsigned long int score=0;

void main(void){
char q;
textmode(64);
clrscr();
_setcursortype(_NOCURSOR);
sr(1,1,80,50,7);
textcolor(11);textbackground(7);
gotoxy(19,47);cputs("(c) 1999 Ham-Ham (demo)");
gotoxy(17,48);cputs("C Languge Michael Programer");
gotoxy(22,49);cputs("Open Source Code");
textcolor(13);
gotoxy(64,1);cputs("Û Û Û Û Û Û Û Û");
gotoxy(64,2);cputs(" Û Û Û Û Û Û Û ");
gotoxy(64,3);cputs("Û Û Û Û Û Û Û Û");
fl(1,1,60,43,15,fo,0);
menu();
return;
}






char game(void){
char q,x=2,y=2,fb='Û',lf=12, ff=' ',bx[127],by[127],p=0,dx=1,dy=0;
char speed=50;
unsigned int k;

for (q=0;q<128;q++){bx[q]=by[q]=x;}
textcolor(cp);textbackground(fp);
gotoxy(25,25);cputs("1");
do{
delay(speed);
textcolor(9);textbackground(7);
gotoxy(62,5);cprintf("Life: not used",live);
gotoxy(62,7);cprintf("Score: %d",score);
gotoxy(62,9);cprintf("Speed: %d",150-speed);
gotoxy(62,11);cprintf("Level: not used",level+1);
gotoxy(69,13);cputs("       ");
gotoxy(62,13);cprintf("Pos. x:%d y:%d",x-1,y-1);
gotoxy(62,15);cprintf("Length: %d ",lf);


k=keykod();
switch (k){
case 27:{return(2);}
case 335:{dy=1;dx=0;break;}
case 327:{dy=-1;dx=0;break;}
case 332:{dx=1;dy=0;break;}
case 330:{dx=-1;dy=0;break;}
}
x+=dx;y+=dy;
gotoxy(x,y);
k=readcursor();
if (k!=ff &&(k>57 || k<49))
{
 return(1);
 x-=dx;y-=dy;dx=dy=0;
 live--;score-=1000;if (live<0)return(1);
 fl(24,20,36,24,15,7,1);gotoxy(26,22);cputs("LIFE LOST");
 while(!kbhit());
 sr(24,20,37,25,fo);
 continue;
}
if (k!=ff){lf+=(k-48);if (lf>127) return(0);
   score+=(k-48)*100;
 do {
    gotoxy(rnd(58,0)+1,rnd(42,0)+1);
    }while (readcursor()!=ff);
 textcolor(cp);textbackground(fp);
 cprintf("%d",rnd(9,0)+1);
 gotoxy(x,y);
 }

score++;
textcolor(co);textbackground(fo);
putch(fb);
bx[p]=x;by[p]=y;
p++;
if (p>lf) p=0;
gotoxy(bx[p],by[p]);putch(ff);

}while (1);
}

















unsigned int keykod(void){
unsigned char kodal,kodah;
unsigned int r;
asm{
mov ah,1
int 0x16
je m:
mov kodal,al
mov kodah,ah
mov ah,0
int 0x16
}
(kodal)?(r=kodal):(r=kodah+255);
m:

 return(r);
}
unsigned char readcursor(void){
char c;
asm{
mov ah,8
int 0x10
mov c,al
}
return(c);
}

void fl(char ux,char uy, char dx,char dy,char cm,char cb,char t){
char q;
if (t){
for (q=ux+1;q<dx+1;q++){gotoxy(q,dy+1);textcolor(8);textbackground(0);putch(readcursor());}
for (q=uy+1;q<=dy+1;q++){gotoxy(dx+1,q);textcolor(8);textbackground(0);putch(readcursor());}
}
textcolor(cm);
textbackground(cb);
sr(ux+1,uy+1,dx-1,dy-1,cb);
for (q=ux+1;q<dx;q++){
 gotoxy(q,uy);putch('Ä');
 gotoxy(q,dy);putch('Ä');
}
for (q=uy+1;q<dy;q++){
 gotoxy(ux,q);putch('º');
 gotoxy(dx,q);putch('º');
}
 gotoxy(ux,uy);putch('Ö');
 gotoxy(ux,dy);putch('Ó');
 gotoxy(dx,uy);putch('·');
 gotoxy(dx,dy);putch('½');
 gotoxy(dx-3,dy);cputs("mIC");
}

void sr(char x,char y,char rx,char ry,char cb){
x--;y--;rx--;ry--;
cb*=16;
asm{
 mov ah,6
 mov al,0
 mov bh,cb
 mov ch,y
 mov cl,x
 mov dh,ry
 mov dl,rx
 int 0x10
}
}

void push(char x,char y,char *stroka,char reg,char n){
static struct key{char x,y;
	      char stroka[16];
	      }pk;
char q;
static char pred=255;
if (pred!=n){textcolor(3);textbackground(1);gotoxy(pk.x,pk.y);cputs(pk.stroka);}

textbackground(1);
textcolor(15);
switch (reg){
 case 0:{gotoxy(x,y);cputs(stroka);
	 textcolor(0);textbackground(7);
	 for(q=x+1;q<=x+strl(stroka);q++)
	 {gotoxy(q,y+1);putch('ß');}
	 gotoxy(q-1,y);putch('Ü');
	  break;}
 case 1:{sr(x,y,x+strl(stroka)+1,y+1,7);
	 gotoxy(x+1,y+1);cputs(stroka);delay(50);
	 push(x,y,stroka,0,n);
   break;}
}
pk.x=x;
pk.y=y;
for (q=0;q<16;q++) pk.stroka[q]=*(stroka+q);
pred=n;
return;
}

unsigned int rnd(unsigned int init,unsigned long int r){
unsigned int m;
if (r==0){
r=tm();
}
asm{
mov      cx,init
mov      ax,Word ptr cs:[r+2]
mov      bx,Word ptr cs:[r]
mov      si,ax
mov      di,bx
mov      dl,ah
mov      ah,al
mov      al,bh
mov      bh,bl
xor      bl,bl
rcr      dl,1
rcr      ax,1
rcr      bx,1
add      bx,di
adc      ax,si
add      bx,62e9h
adc      ax,3619h
mov      word ptr cs:[r],bx
mov      word ptr cs:[r+2],ax
xor      dx,dx
div      cx
mov      ax,dx
mov      m,ax
}
return(m);
}

unsigned long int tm(void){
unsigned int rl,rh,rt;
asm{
xor ah,ah
int 1ah
mov rl,dx
mov rh,cx
}
rt=rh*65536+rl;
return(rt);
}

char load(char *fname){
sr(2,2,59,42,fo);
return(0);
}

void menu(void){
unsigned int k;
char alevel=1;
char pos=0,q;
char st[2][13]={ "  NEW GAME  " ,"    QUIT    "};
char levels[2][13]={"l1.dat","l2.dat"},ulevel[13];
for (q=0;q<2;q++) push(65,24+q*3,&st[q],0,q);
do{
 textcolor(9);textbackground(7);
 gotoxy(62,5);cputs("Life: not used    ");
 gotoxy(62,7);cputs("Score: 0          ");
 gotoxy(62,9);cputs("Speed: 0          ");
 gotoxy(62,11);cputs("Level: not used  ");
 gotoxy(62,13);cputs("Pos. x:0 y:0     ");
 gotoxy(62,15);cputs("Length: 0        ");
 k=keykod();
 switch(k){
 case 13:{push(65,24+pos*3,&st[pos],1,pos);
	  switch (pos){
	  //case 1:{alevel=0;strin(&ulevel);}
	  case 0:{if (!k) q=load(&levels[0]); else q=load(&ulevel);
	  live=2;score=0;
	  do{
	     if (q)k=0;else k=game();
	     switch(k){
	     case 0:{level++;if (level>alevel){fl(24,20,36,24,15,7,1);gotoxy(26,22);cputs("");k=1;}
	     load(&levels[level]);break;}
	     case 1:{fl(24,20,36,24,15,7,1);gotoxy(26,22);cputs("GAME OVER");break;}
	     case 2:{fl(21,20,39,24,15,7,1);gotoxy(23,22);cputs("GAME TERMINATED");break;}
	     }
	  }while(!k);
	  break;}
	  case 1:{textmode(3);cputs("(c) 1999");return;break;}
	  }
	  break;
	  }
 case 335:{(pos==1)?(pos^=pos):(pos++);break;}
 case 327:{(pos==0)?(pos=1):(pos--);break;}
 }
push(65,24+pos*3,&st[pos],0,pos);
}while(1);

}
char strl(char *stroka){
char q=0;
do{
q++;
}while(*(stroka+q)!=0);
return(q);
}

void strin(char *stroka){
unsigned int k;
char l=0;
*stroka=0;
fl(21,20,40,24,15,7,1);
do{
k=keykod();
if (k<32 || k>126){if (k==8){if (l) l--;*(stroka+l)=0;}} else {*(stroka+l)=k;l++;}
*(stroka+l+1)=0;
gotoxy(20+(10-l/2),22);cprintf(" %s ",stroka);
}while(k!=13 && l<13);
return;
}