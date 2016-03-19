#include <conio.h>
#include <dos.h>
void showmouse(void);
void clearmouse(void);
void mouseXY(int X, int Y);
void wheremouse(int *X, int *Y);
int mousestat(int *X,int *Y);
int initmouse(void);
void breakmouseX(int minX,int maxX);
void breakmouseY(int minY,int maxY);
void main(void){
int i,x,y;
clrscr();
gotoxy(1,25);cprintf("PRESS ANY KEY TO EXIT");
gotoxy(1,1);
i=initmouse();
if(!i){
 cprintf("NOT MOUSE");
 return;
}else{
if((i&3)==2)cprintf("2 BUTTON");
if((i&3)==3)cprintf("3 BUTTON");
}
mouseXY(96,96);
breakmouseX(40,600);
breakmouseY(30,190);
showmouse();
do{
i=mousestat(&x,&y);
if(i){
 gotoxy(15,3);cprintf("                 ");
 gotoxy(1,3);cprintf("X:%4d,Y:%4d",x,y);
 if(i&1){
  gotoxy(15,3);cprintf("LEFT");
 }
 if(i&2){
  gotoxy(20,3);cprintf("RIGHT");
 }
 if(i&4){
  gotoxy(26,3);cprintf("CENTER");
 }
}
wheremouse(&x,&y);
gotoxy(1,2);cprintf("X:%4d,Y:%4d",x,y);
}while(!kbhit());
clearmouse();
}


int initmouse(void){
union REGS regs;
regs.x.ax = 0;
int86(0x33, &regs, &regs);
return regs.x.ax&regs.x.bx;
}
int mousestat(int *X,int *Y){
union REGS regs;
regs.x.ax = 3;
int86(0x33, &regs, &regs);
*X=regs.x.cx;*Y=regs.x.dx;
return regs.x.bx;
}
void wheremouse(int *X, int *Y){
union REGS regs;
regs.x.ax = 3;
int86(0x33, &regs, &regs);
*X=regs.x.cx;*Y=regs.x.dx;
}
void mouseXY(int X, int Y){
union REGS regs;
regs.x.ax = 4;
regs.x.cx=X;
regs.x.dx=Y;
int86(0x33, &regs, &regs);
}
void clearmouse(void){
union REGS regs;
regs.x.ax = 2;
int86(0x33, &regs, &regs);
}
void showmouse(void){
union REGS regs;
regs.x.ax = 1;
int86(0x33, &regs, &regs);
}
void breakmouseX(int minX,int maxX){
union REGS regs;
regs.x.ax = 7;
regs.x.cx=minX;
regs.x.dx=maxX;
int86(0x33, &regs, &regs);
}
void breakmouseY(int minY,int maxY){
union REGS regs;
regs.x.ax = 8;
regs.x.cx=minY;
regs.x.dx=maxY;
int86(0x33, &regs, &regs);
}