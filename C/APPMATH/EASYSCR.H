#ifndef _SCRLIB_
#define _SCRLIB_
#include <stdlib.h>
#include <dos.h>
#include <conio.h>
#include "easylist.h"

#define COMMAND     1
#define SUBMENU     2
#define VERTMENU    0
#define LINEMENU    1
#define KEYUP       72
#define KEYDOWN     80
#define KEYLEFT     75
#define KEYRIGHT    77
#define NODRAW      0
#define MENU        1
#define NOKEY       2
#define PREDSUBMENU -1
#define NEXTSUBMENU -2
#define ESC         0
#define YES         1
#define NO          2




union REGS registers;

struct menu_item{
 char *title;
 unsigned ret;
 short type;
 struct list_item *inmenu;
};

struct border_style{
 short xleftcorner,
       yleftcorner,
       xrightcorner,
       yrightcorner,
       bordercolor,
       borderbackcolor,
       fillcolor,
       fillbackcolor,
       selectcolor,
       selectbackcolor,
       shadow,
       fill,
       borderline;
};
void (*callingprocedure)(void)=NULL;

unsigned length(char *s){
 unsigned i=0;
 while(*(s+i++)!=0);
 return --i;
}
char gk(void){
if(callingprocedure!=NULL)while(!kbhit())(*callingprocedure)();
return getch();
}
int getcurchar(void){
 registers.h.ah=8;
 registers.h.bh=0;
 return int86(0x10,&registers,&registers);
}
void clrscrext(short xul,short yul,short xrd,short yrd,short c,short bc,short und,short n){
registers.h.cl=xul-1;
registers.h.ch=yul-1;
registers.h.dl=xrd-1;
registers.h.dh=yrd-1;
registers.h.al=n;
registers.h.ah=und+6;
registers.h.bh=bc*16+c;
int86(0x10,&registers,&registers);
}
void fillborder(char i,unsigned count,short c,short bc){
 registers.h.ah=9;
 registers.h.al=i;
 registers.x.cx=count;
 registers.h.bl=c+bc*16;
 registers.h.bh=0;
 int86(0x10,&registers,&registers);
}
void border(struct border_style *getparam){
short q;
textattr(8);
if(getparam->shadow){
 for(q=getparam->xleftcorner+1;q<=getparam->xrightcorner+1;q++){
  gotoxy(q,getparam->yrightcorner+1);
  putch(getcurchar());
 }
 for(q=getparam->yleftcorner+1;q<getparam->yrightcorner+1;q++){
  gotoxy(getparam->xrightcorner+1,q);
  putch(getcurchar());
 }
}
textattr(getparam->bordercolor+getparam->borderbackcolor*16);
for(q=getparam->xleftcorner+1;q<getparam->xrightcorner;q++){
 gotoxy(q,getparam->yleftcorner);
 putch(196+getparam->borderline*9);
 gotoxy(q,getparam->yrightcorner);
 putch(196+getparam->borderline*9);
}
for(q=getparam->yleftcorner+1;q<getparam->yrightcorner;q++){
 gotoxy(getparam->xleftcorner,q);
 putch(179+getparam->borderline*7);
 gotoxy(getparam->xrightcorner,q);
 putch(179+getparam->borderline*7);
}
gotoxy(getparam->xleftcorner,getparam->yleftcorner);putch(218-17*getparam->borderline);
gotoxy(getparam->xrightcorner,getparam->yleftcorner);putch(191-4*getparam->borderline);
gotoxy(getparam->xleftcorner,getparam->yrightcorner);putch(192+8*getparam->borderline);
gotoxy(getparam->xrightcorner,getparam->yrightcorner);putch(217-29*getparam->borderline);

if(getparam->fill)clrscrext(getparam->xleftcorner+1,getparam->yleftcorner+1,
                  getparam->xrightcorner-1,getparam->yrightcorner-1,
                  getparam->fillcolor,getparam->fillbackcolor,0,0);

}
short savescr(short xul,short xrd,short yul,short yrd,int **buf){
short x,y;
if((*buf=(int*)malloc((xrd-xul+1)*(yrd-yul+1)*2))==NULL)return 0;
for(y=yul;y<=yrd;y++)
 for(x=xul;x<=xrd;x++){
  gotoxy(x,y);
  *(*buf+(x-xul)+(y-yul)*(xrd-xul+1))=getcurchar();
 }
return 1;
}
void loadscr(short xul,short xrd,short yul,short yrd,int **buf){
int x,y;
for(y=yul;y<=yrd;y++)
 for(x=xul;x<=xrd;x++){
  gotoxy(x,y);
  textattr(*(*buf+(x-xul)+(y-yul)*(xrd-xul+1))/256);
  putch(*(*buf+(x-xul)+(y-yul)*(xrd-xul+1)));
 }
free(*buf);
}
#endif