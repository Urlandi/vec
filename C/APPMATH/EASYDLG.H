#ifndef _EASYDLG_
#define _EASYDLG_
#include "easyfcel.h"
short messagedialog(struct border_style *getparam,char *text){
int *oldscr;
short k;
struct border_style tbm=*getparam;
char *quest[1]={"OK"};
tbm.xleftcorner=tbm.xleftcorner+(tbm.xrightcorner-tbm.xleftcorner)/2-1;
tbm.yleftcorner=tbm.yrightcorner-2;
tbm.xrightcorner=tbm.xleftcorner;
tbm.yrightcorner=tbm.yleftcorner;
tbm.fillbackcolor++;
if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr))return -1;
border(getparam);
gotoxy(getparam->xleftcorner+2,getparam->yleftcorner+1);
textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
cprintf("%s",text);
k=buttonmenu(&tbm,quest,1,LINEMENU,MENU);
loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
return k;
}
short choosedialog(struct border_style *getparam, char *text){
int *oldscr;
short k;
struct border_style tbm=*getparam;
char *quest[2]={"Да","Нет"};
tbm.xleftcorner=tbm.xleftcorner+(tbm.xrightcorner-tbm.xleftcorner)/2-5;
tbm.yleftcorner=tbm.yrightcorner-2;
tbm.xrightcorner=tbm.xleftcorner+1;
tbm.yrightcorner=tbm.yleftcorner+1;
tbm.fillbackcolor++;
if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr))return -1;
border(getparam);
gotoxy(getparam->xleftcorner+2,getparam->yleftcorner+1);
textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
cprintf("%s",text);
k=buttonmenu(&tbm,quest,2,LINEMENU,MENU);
loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
return k;
}

unsigned inputdialog(struct border_style *getparam,char *s,char *title){
int *oldscr;
unsigned lengthstr;
if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr))return -1;
border(getparam);
textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+1);
cprintf("%s",title);
gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+2);
lengthstr=getstring(s,getparam->xrightcorner-getparam->xleftcorner-2);
loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
return lengthstr;
}
#endif