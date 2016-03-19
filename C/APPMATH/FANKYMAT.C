#include <stdio.h>
#include <math.h>
#include <graphics.h>
#include <string.h>
#include "easylib.h"
#define EXITPRG 0xFF

#define l1_F (X-2+sin(1/X))
#define l1_Fx (2-sin(1/X))
#define l1_dFdx (1-cos(1/X)/(X*X))

#define l2_F (pow(1-X*X,-1/3))

#define l3_F (X-2*Y)
#define Y_0 0;

#define l4_N 3
struct datatable{
 double x,y;
};
void runline(void);
void aboutbox(struct border_style *getparam);
short exitbox(struct border_style *getparam);
void setuserparam(struct border_style *getparam,double *a,double *b,double *e);
void errormessage(struct border_style *getparam,short err);
void laboratoryN1(struct border_style *getparam,double a, double b, double e);
void laboratoryN2(struct border_style *getparam,double a, double b, double e);
void laboratoryN3(struct border_style *getparam,double a, double b, double e);
double laboratoryN4(struct border_style *getparam,struct datatable *opentable,double x,char k);
void laboratoryN4G(struct datatable *opentable);
int main(void){
struct datatable worktable[l4_N];
int l,q;
double a,b,e;
FILE *file;
#include "mm.h"
worktable[0].y= 8.0; worktable[1].y= 1.4; worktable[2].y= 2.3;
worktable[0].x=-0.3; worktable[1].x=-0.2; worktable[2].x=-0.1;
clrscr();
afterl4g:
_wscroll=0;
_setcursortype(_NOCURSOR);
fillborder('∞',80*25,1,7);
fillborder(' ',80,1,1);
textattr(15+16);
cprintf(" î†©´  ê•†´®ß†Ê®Ô  èÆ¨ÆÈÏ ");

do{
 messageline(1,25,80,6,1,"ç†Á≠®‚• ‡†°Æ‚„ · ¢Î°Æ‡† Ø„≠™‚† ¨•≠Ó - F10, ÇÎÂÆ§ - ALT+X, èÆ¨ÆÈÏ - F1");
 if((l=gk())==0)l=gk()+300;
 switch(l){
  case 27:break;
  case 407:runline();
           break;
  case 345:if(exitbox(&dialogview)==YES)l=EXITPRG;
           break;
  case 368:messageline(1,25,80,6,1,"ÇÎ°•‡®‚• §•©·‚¢®• ®ß ¨•≠Ó. ÇÎØÆ´≠•≠®• ´†°Æ‡†‚Æ‡≠ÎÂ - ê•†´®ß†Ê®Ô.");
           l=upmenu(&menuview,mainmenu,MENU,LINEMENU);
           switch(l){
            case 1000:if(exitbox(&dialogview)==YES)l=EXITPRG;
                      break;
            case 2000:setuserparam(&dialogview,&a,&b,&e);
                      laboratoryN1(&dialogview,a,b,e);
                      break;
            case 2001:setuserparam(&dialogview,&a,&b,&e);
                      laboratoryN2(&dialogview,a,b,e);
                      break;
            case 2002:setuserparam(&dialogview,&a,&b,&e);
                      laboratoryN3(&dialogview,a,b,e);
                      break;
            case 2030:setuserparam(&dialogview,&a,NULL,NULL);
                      laboratoryN4(&dialogview,worktable,a,0);
                      break;
            case 2031:laboratoryN4G(worktable);
                      goto afterl4g;
            case 3000:aboutbox(&dialogview);
                      break;

            default:;
           }
 }
}while(l!=EXITPRG);
erasemenu(mainmenu);
textcolor(7);
textbackground(0);
clrscr();
cprintf("(c)2002 IVT-262");
return 0;
}
void runline(void){
 int *oldscr;
 char strlrun[]="                                                         jmp short $-2";
 int q,len,i,k;
 struct border_style w;
 messageline(1,25,80,6,1,"FOREVER");
 w.borderline=1;
 w.xleftcorner=10;
 w.xrightcorner=69;
 w.yleftcorner=13;
 w.yrightcorner=15;
 w.bordercolor=2;
 w.borderbackcolor=0;
 w.fill=1;
 w.fillbackcolor=0;
 w.fillcolor=2;
 w.shadow=1;
 w.selectcolor=0;
 w.selectbackcolor=0;
 if(!savescr(w.xleftcorner,w.xrightcorner+1,w.yleftcorner,w.yrightcorner+1,&oldscr))return;
 border(&w);
 textcolor(12);
 len=length(strlrun);
 do{
  for(i=0;i<len;i++){
   delay(100);
   k=i+57;if(k>len)k=len;
   for(q=i;q<k;q++){
    gotoxy(11+q-i,14);putch(strlrun[q]);
   }
   putch(' ');
   if(kbhit())break;
  }
 }while(!kbhit());
 getch();
 loadscr(w.xleftcorner,w.xrightcorner+1,w.yleftcorner,w.yrightcorner+1,&oldscr);
}

void errormessage(struct border_style *getparam,short err){
char txleft,txright,tyleft,tyright;
char *errors[3]={"      î„≠™Ê®® ≠• ‡•†´®ßÆ¢†≠Î.",
                 "   ê•Ë•≠®• ¢≠• ß†§†≠≠Æ© £‡†≠®ÊÎ.",
                 "   ê•Ë•≠®• ≠† £‡†≠®Ê• ®≠‚•‡¢†´†."};
 messageline(1,25,80,6,1,"éË®°™† ¢ ‡†°Æ‚• · Ø‡Æ£‡†¨¨Æ©. é°‡†‚®‚•·Ï ™ §Æ™„¨•≠‚†Ê®®.");
 txleft=getparam->xleftcorner;
 txright=getparam->xrightcorner;
 tyleft=getparam->yleftcorner;
 tyright=getparam->yrightcorner;
 getparam->fillbackcolor=4;
 getparam->xleftcorner=22;
 getparam->xrightcorner=58;
 getparam->yleftcorner=9;
 getparam->yrightcorner=14;
 getparam->borderbackcolor=4;
 messagedialog(getparam,errors[err]);
 getparam->fillbackcolor=1;
 getparam->borderbackcolor=1;
 getparam->xleftcorner=txleft;
 getparam->xrightcorner=txright;
 getparam->yleftcorner=tyleft;
 getparam->yrightcorner=tyright;
}
void aboutbox(struct border_style *getparam){
 int *oldscr;
 getparam->xleftcorner=10;
 getparam->xrightcorner=70;
 getparam->yleftcorner=8;
 getparam->yrightcorner=15;
 if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr))return;
 border(getparam);
 messageline(1,25,80,6,1,"ç†¶¨®‚• ´Ó°„Ó ™´†¢®Ë„ §´Ô Ø‡Æ§Æ´¶•≠®Ô ‡†°Æ‚Î.");
 window(getparam->xleftcorner+1,getparam->yleftcorner+1,getparam->xrightcorner-1,getparam->yrightcorner-1);

 gotoxy(1,1);
 textcolor(14);
 cprintf("⁄ƒø   ⁄ƒø⁄ƒø⁄ƒƒø ≤≤≤≤   ≤ ≤ ≤≤≤≤  ≤   ≤≤≤≤ ëÑÖãÄçé Ç êéëëàà\n\r");
 cprintf("¿ƒø≥ ≥≥ƒø⁄ƒ¥√¬ƒŸ ≤≤  ≤  ≤ ≤ ≤  ≤  ≤   ≤  ≤ (·)PyRE STD.SHES\n\r");
 cprintf("¿ƒŸ¿ƒŸ¿ƒŸ¿ƒ¡≥¿ø  ≤≤ ≤≤  ≤≤≤ ≤ ≤≤≤ ≤≤≤ ≤ ≤  Ç†·®´Ï•¢ å.û.\n\r");
 cprintf("⁄ƒƒ⁄ƒƒø⁄ƒ ⁄ƒ     ≤≤  ≤≤     ≤   ≤     ≤    ÇÆ´£Éíì àÇí-262\n\r");
 cprintf("√ƒ √¬ƒŸ√  √ V1.1 ≤≤  ≤≤     ≤ ≤≤≤     ≤≤≤  £.ÇÆ´£Æ£‡†§ 2002\n\r");
 cprintf("≥  ≥¿ø ¿ƒ ¿ƒ     ≤≤ ≤≤≤ G U M!G U M!G U M! (R) Çõó.åÄí.");
 gk();
 window(1,1,80,25);
 loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
}
short exitbox(struct border_style *getparam){
 messageline(1,25,80,6,1,"ÇÎ°•‡®‚• <çÖí> •·´® ÂÆ‚®‚• Ø‡Æ§Æ´¶®‚Ï ‡†°Æ‚„");
 getparam->xleftcorner=32;
 getparam->xrightcorner=48;
 getparam->yleftcorner=9;
 getparam->yrightcorner=14;
 return choosedialog(getparam,"ïÆ‚®‚• ¢Î©‚®?");
}
void setuserparam(struct border_style *getparam,double *a,double *b,double *e){
int *oldscr,l,q,n=4,k;
char *defparam[4]={"ç®¶≠ÔÔ £‡†≠®Ê† ®≠‚•‡¢†´†:       0","Ç•‡Â≠ÔÔ £‡†≠®Ê† ®≠‚•‡¢†´†:      0","ë‚•Ø•≠Ï Ø‡®≠®¨†•¨Æ© ØÆ£‡•Ë≠Æ·‚®:1","ÇÎÁ®·´®‚Ï!"};
char addparam[]={"ÇÎÁ®·´®‚Ï ‰„≠™Ê®Ó §´Ô X= 0"};
char as[18]="0",bs[18]="0",es[2]="1",*endptr;
messageline(1,25,80,6,1,"á†§†©‚• Ø†‡†¨•‚‡Î ¢ÎÁ®·´•≠®©, ®·ØÆ´Ïß„Ô ™´†¢®Ë® „Ø‡†¢´•≠®Ô ™„‡·Æ‡† ® ENTER.");
getparam->xleftcorner=13;
getparam->xrightcorner=66;
getparam->yleftcorner=9;
getparam->yrightcorner=14;
getparam->bordercolor=14;
k=0;
if(e==NULL&&b==NULL){
 getparam->yrightcorner-=2;
 getparam->xrightcorner-=3;
 getparam->xleftcorner+=3;
 defparam[1]=defparam[3];
 defparam[0]=addparam;
 n=2;
 k=7;
}
if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+12,&oldscr))return;
*a=0;
if(e!=NULL&&b!=NULL){
 *b=0;
 *e=0.1;
}
l=1;
q=1;
*endptr=NULL;
do{
 l=menu(getparam,defparam,n,l,q);
 q=0;
 do{
  gotoxy(getparam->xleftcorner+34-k,getparam->yleftcorner+l);
  switch(l){
  case 1:getstring(as,18);
         *a=strtod(as,&endptr);
         break;
  case 2:if(b!=NULL&&e!=NULL){
          getstring(bs,18);
          *b=strtod(bs,&endptr);
         }
         break;
  case 3:if(e!=NULL&&b!=NULL){
          getstring(es,2);
          *e=pow(10,-strtod(es,&endptr));
         }
         break;
  }
 }while(*endptr!=NULL||(*e>=1&&e!=NULL));
 _setcursortype(_NOCURSOR);
}while(l!=n);
loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+12,&oldscr);
}

void laboratoryN1(struct border_style *getparam,double a,double b,double e){
 int *oldscr,q,n1,n2,n3;
 char k=0;
 double X,Fa,Fb,x1,x2,x3,A,B;
 A=a;B=b;
 messageline(1,25,80,6,1,"ê•Ë•≠®• ≠•´®≠•©≠ÎÂ †´£•°‡†®Á•·™®Â ® ‚‡†·Ê•≠§•≠‚≠ÎÂ „‡†¢≠•≠®©.|ÇÎØÆ´≠Ô•‚·Ô.");
 getparam->xleftcorner=2;
 getparam->xrightcorner=78;
 getparam->yleftcorner=9;
 getparam->yrightcorner=13;
 getparam->bordercolor=14;
 if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr))return;
 border(getparam);
 getparam->bordercolor=15;
 gotoxy(getparam->xleftcorner+13,getparam->yleftcorner);
 cprintf("—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—");
 gotoxy(getparam->xleftcorner+13,getparam->yrightcorner);
 cprintf("œÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœ");
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+1);
 cprintf("èÆ£‡•Ë≠Æ·‚Ï ≥   Ñ®ÂÆ‚Æ¨®®    ≥èÆ¢≥è‡Æ·‚ÎÂ ®‚•‡†Ê®©≥èÆ¢≥    çÏÓ‚Æ≠†     ≥èÆ¢");
 for(q=getparam->yleftcorner+2;q<getparam->yrightcorner;q++){
  gotoxy(getparam->xleftcorner,q);
  if (q%2!=0)cprintf("«ƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒ∂");
  else cprintf("∫   %1.0E    ≥                ≥   ≥                ≥   ≥                ≥",e);
 }
 textcolor(12);
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner);cprintf("[%f;%f]",a,b);

 X=a;if(!l1_F){
  k=k|2;
  x1=x2=x3=a;
  n1=n2=n3=1;
  goto forever;
 }
 X=b;if(!l1_F){
  k=k|2;
  x1=x2=x3=b;
  n1=n2=n3=1;
  goto forever;
 }

 /*å•‚Æ§ §®ÂÆ‚Æ¨®®*/
 q=0;
 X=a;
 Fa=l1_F;
 X=b;
 Fb=l1_F;
 if(Fa*Fb>0){
  k=k|1;
  q=0;
  X=0;
 }else
 do{
  X=(a+b)/2;
  Fb=l1_F;
  if(Fb==0)break;
  if(Fa*Fb<0)b=X;else{a=X;X=a;Fa=l1_F;}
  q++;
 }while(fabs(a-b)>e);
 x1=X;
 n1=q;
 a=A;b=B;
 /*å•‚Æ§ Ø‡Æ·‚ÎÂ ®‚•‡†Ê®©*/
 x2=a;
 q=0;
 do{
  X=x2;
  if (l1_F==0) break;
  x2=l1_Fx;
  if(x2<a||x2>b){
   k=k|1;
   q=0;
   x2=0;
   break;
  }
  q++;
 }while(fabs(x2-X)>e);
 n2=q;

 /*å•‚Æ§ çÏÓ‚Æ≠†*/
 q=0;
 x3=a;
 do{
  X=x3;
  if (l1_F==0) break;
  x3=X-l1_F/l1_dFdx;
  if(x3<a||x3>b){
   k=k|1;
   q=0;
   x3=0;
   break;
  }
  q++;
 }while(fabs(x3-X)>e);
 n3=q;
forever:
 textcolor(11);
 gotoxy(getparam->xleftcorner+14,getparam->yleftcorner+3);cprintf("%-.12f",x1);
 gotoxy(getparam->xleftcorner+31,getparam->yleftcorner+3);cprintf("%d",n1);
 gotoxy(getparam->xleftcorner+35,getparam->yleftcorner+3);cprintf("%-.12f",x2);
 gotoxy(getparam->xleftcorner+52,getparam->yleftcorner+3);cprintf("%d",n2);
 gotoxy(getparam->xleftcorner+56,getparam->yleftcorner+3);cprintf("%-.12f",x3);
 gotoxy(getparam->xleftcorner+73,getparam->yleftcorner+3);cprintf("%d",n3);
 if(k&1)errormessage(getparam,1);
 if(k&2)errormessage(getparam,2);
 messageline(1,25,80,6,1,"ê•Ë•≠®• ≠•´®≠•©≠ÎÂ †´£•°‡†®Á•·™®Â ® ‚‡†·Ê•≠§•≠‚≠ÎÂ „‡†¢≠•≠®©.|ÉÆ‚Æ¢Æ.");
 gk();
 loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
}
void laboratoryN2(struct border_style *getparam,double a,double b,double e){
 int *oldscr,q;
 char k=0;
 long int n1,n2,n3;
 double S,s,h,X,x1,x2,x3,h01,h02,h03;
 messageline(1,25,80,6,1,"ÇÎÁ®·´•≠®• ÆØ‡•§•´•≠≠ÎÂ ®≠‚•£‡†´Æ¢.|ÇÎØÆ´≠Ô•‚·Ô. èÆ¶†´„©·‚† ¶§®‚•.");
 getparam->xleftcorner=8;
 getparam->xrightcorner=72;
 getparam->yleftcorner=9;
 getparam->yrightcorner=15;
 getparam->bordercolor=14;
 if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+12,&oldscr))return;
 border(getparam);
 gotoxy(getparam->xleftcorner+13,getparam->yleftcorner);
 cprintf("—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—");
 gotoxy(getparam->xleftcorner+13,getparam->yrightcorner);
 cprintf("œÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœ");
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+1);
 cprintf("èÆ£‡•Ë≠Æ·‚Ï ≥   í‡†Ø•Ê®©     ≥    ë®¨Ø·Æ≠†    ≥è‡Ô¨Æ„£Æ´Ï≠®™Æ¢");
 for(q=getparam->yleftcorner+2;q<getparam->yrightcorner;q++){
  gotoxy(getparam->xleftcorner,q);
  if (q%2)cprintf("«ƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂");
  else cprintf("∫   %1.0E    ≥                ≥                ≥",e);
 }
 gotoxy(getparam->xleftcorner+1,getparam->yrightcorner-1);cprintf(" ê†ß°®•≠®©");
 textcolor(12);
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner);cprintf("[%f;%f]",a,b);
 textcolor(11);

 if(!(b-a)){
  k=k|1;
  x1=x2=x3=0;
  n1=n2=n3=1;
  goto forever;
 }
 h01=h03=b-a;
 h02=h01/2;
 /*å•‚Æ§ ‚‡†Ø•Ê®©*/
 h=h01;
 x1=0;
 while(1){
  X=a;S=0;
  n1=0;
  while(X<=b){
   s=l2_F;
   X+=h;
   s+=l2_F;
   S=S+s;
   n1++;
  }
  S*=h/2;
  if(fabs((S-x1)/3)<e){x1=S;break;}else h/=2;
  x1=S;
 }
 /*å•‚Æ§ ë®¨Ø·Æ≠†*/
 h=h02;
 x2=0;
 while(1){
  X=a;S=l2_F;
  n2=0;
  while(X<=b){
   X+=h;
   S+=2*l2_F;
   X+=h;
   S+=l2_F;
   n2++;
  }
  S=(2*S-l2_F)*h/3;
  if(fabs((S-x2)/15)<e){x2=S;break;}else h/=2;
  x2=S;
 }
 n2*=2;
 /*å•‚Æ§ ·‡•§≠®Â Ø‡Ô¨Æ„£Æ´Ï≠®™Æ¢*/
 h=h03;
 x3=0;
 while(1){
  S=0;X=a+h/2;
  n3=0;
  while(X<=b){
   S+=l2_F;
   X+=h;
   n3++;
  }
  S=S*h;
  if(fabs((S-x3)/3)<e){x3=S;break;}else h/=2;
  x3=S;
 }
forever:
 gotoxy(getparam->xleftcorner+14,getparam->yleftcorner+3);cprintf("%-.12f",x1);
 gotoxy(getparam->xleftcorner+31,getparam->yleftcorner+3);cprintf("%-.12f",x2);
 gotoxy(getparam->xleftcorner+48,getparam->yleftcorner+3);cprintf("%-.12f",x3);
 gotoxy(getparam->xleftcorner+14,getparam->yleftcorner+5);cprintf("%ld",n1);
 gotoxy(getparam->xleftcorner+31,getparam->yleftcorner+5);cprintf("%ld",n2);
 gotoxy(getparam->xleftcorner+48,getparam->yleftcorner+5);cprintf("%ld",n3);
 messageline(37,25,80,6,1,"ÉÆ‚Æ¢Æ.");
 gk();
 loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+12,&oldscr);
}
void laboratoryN3(struct border_style *getparam,double a, double b, double e){
 int *oldscr,q;
 long int n1,n2,n3;
 double y,x,f0,f1,f2,f3,h,X,Y,x1,x2,x3,h01,h02,h03;
 messageline(1,25,80,6,1,"ÇÎÁ®·´•≠®• éÑì.|ÇÎØÆ´≠Ô•‚·Ô. èÆ¶†´„©·‚† ¶§®‚•.");
 getparam->xleftcorner=8;
 getparam->xrightcorner=72;
 getparam->yleftcorner=9;
 getparam->yrightcorner=15;
 getparam->bordercolor=14;
 if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+12,&oldscr))return;
 border(getparam);
 gotoxy(getparam->xleftcorner+13,getparam->yleftcorner);
 cprintf("—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—");
 gotoxy(getparam->xleftcorner+13,getparam->yrightcorner);
 cprintf("œÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœ");
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+1);
 cprintf("èÆ£‡•Ë≠Æ·‚Ï ≥     ù©´•‡†     ≥  ù©´•‡†-äÆË®   ≥  ê„≠£•-ä„‚‚†");
 for(q=getparam->yleftcorner+2;q<getparam->yrightcorner;q++){
  gotoxy(getparam->xleftcorner,q);
  if (q%2)cprintf("«ƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂");
  else cprintf("∫   %1.0E    ≥                ≥                ≥",e);
 }
 gotoxy(getparam->xleftcorner+1,getparam->yrightcorner-1);cprintf("   ò†£Æ¢");
 textcolor(12);
 Y=Y_0;
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner);cprintf("[Y(%f)=%f §´Ô X=%f]",a,Y,b);
 textcolor(11);
 h01=h03=h02=b-a;
 /*å•‚Æ§ ù©´•‡†*/
 h=h01;
 x1=0;
 while(1){
  X=a+h;Y=Y_0;
  n1=0;
  while(X<=b&&b){
   y=Y+l3_F*h;
   X+=h;
   Y=y;
   n1++;
  }
  if(fabs(y-x1)<e){x1=y;break;}else h/=2;
  x1=y;
 }
 /*å•‚Æ§ ù©´•‡†-äÆË®*/
 h=h02;
 x2=0;
 while(1){
  X=a;Y=Y_0;
  n2=0;
  while(X<=b&&b){
   y=Y;x=X;
   f0=l3_F;
   X=x+h/2;
   Y=y+h*f0/2;
   y+=h*l3_F;
   Y=y;
   X=x+h;
   n2++;
  }
  if(fabs(y-x2)/3<e){x2=y;break;}else h/=2;
  x2=y;
 }
 /*å•‚Æ§ ê„≠£•-ä„‚‚†*/
 h=h03;
 x3=0;
 while(1){
  X=a;Y=Y_0;
  n3=0;
  while(X<=b&&b){
   x=X;y=Y;
   f0=h*l3_F;
   X=x+h/2;Y=y+f0/2;
   f1=h*l3_F;
   Y=y+f1/2;
   f2=h*l3_F;
   X=x+h;Y=y+f2;
   f3=h*l3_F;
   X+=h/2;
   Y=h*f0/2;
   y+=(f0+2*f1+2*f2+f3)/6;
   Y=y;
   X=x+h;
   n3++;
  }
  if(fabs(y-x3)/15<e){x3=y;break;}else h/=2;
  x3=y;
 }
 gotoxy(getparam->xleftcorner+14,getparam->yleftcorner+3);cprintf("%-.12f",x1);
 gotoxy(getparam->xleftcorner+31,getparam->yleftcorner+3);cprintf("%-.12f",x2);
 gotoxy(getparam->xleftcorner+48,getparam->yleftcorner+3);cprintf("%-.12f",x3);
 gotoxy(getparam->xleftcorner+14,getparam->yleftcorner+5);cprintf("%ld",n1);
 gotoxy(getparam->xleftcorner+31,getparam->yleftcorner+5);cprintf("%ld",n2);
 gotoxy(getparam->xleftcorner+48,getparam->yleftcorner+5);cprintf("%ld",n3);
 messageline(17,25,80,6,1,"ÉÆ‚Æ¢Æ.");
 gk();
 loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+12,&oldscr);
}
double laboratoryN4(struct border_style *getparam,struct datatable *opentable,double x,char k){
 int *oldscr,q,i,j;
 double P,M,A,f[l4_N],p1,p2;
 if(!k){
  messageline(1,25,80,6,1,"ÇÎÁ®·´•≠®• ØÆ´®≠Æ¨Æ¢.|ÇÎØÆ´≠Ô•‚·Ô. èÆ¶†´„©·‚† ¶§®‚•.");
  getparam->xleftcorner=22;
  getparam->xrightcorner=58;
  getparam->yleftcorner=9;
  getparam->yrightcorner=13;
  getparam->bordercolor=14;
  if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+12,&oldscr))return 0;
  border(getparam);
  gotoxy(getparam->xleftcorner+18,getparam->yleftcorner);
  cprintf("—");
  gotoxy(getparam->xleftcorner+18,getparam->yrightcorner);
  cprintf("œ");
  gotoxy(getparam->xleftcorner+18,getparam->yrightcorner-1);
  cprintf("≥");
  gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+1);
  cprintf("    ã†£‡†≠¶†     ≥    çÏÓ‚Æ≠†");
  gotoxy(getparam->xleftcorner,getparam->yleftcorner+2);
  cprintf("«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂");
  textcolor(12);
  gotoxy(getparam->xleftcorner+1,getparam->yleftcorner);cprintf("[§´Ô X=%f]",x);
  textcolor(11);

 /*èÆ´®≠Æ¨ ã†£‡†≠¶†*/
 P=0;
 for(i=0;i<l4_N;i++){
  M=1;
  for(j=0;j<l4_N;j++){
   if(j==i)continue;
   M*=(x-opentable[j].x)/(opentable[i].x-opentable[j].x);
  }
  P+=opentable[i].y*M;
 }
 p1=P;
 }
 /*èÆ´®≠Æ¨ çÏÓ‚Æ≠†*/
 for(q=0;q<l4_N;q++)f[q]=opentable[q].y;
 P=opentable[0].y;
 for(i=1;i<l4_N;i++)
  for(j=i;j<l4_N;j++)
    f[j]=(f[i-1]-f[j])/(opentable[i-1].x-opentable[j].x);

 for(q=0;q<l4_N-1;q++){
  M=1;
  for(i=0;i<=q;i++)M*=(x-opentable[i].x);
  P+=f[q+1]*M;
 }
 p2=P;
 if(!k){
  gotoxy(getparam->xleftcorner+1,getparam->yrightcorner-1);cprintf("%-.12f",p1);
  gotoxy(getparam->xleftcorner+19,getparam->yrightcorner-1);cprintf("%-.12f",p2);
  messageline(23,25,80,6,1,"ÉÆ‚Æ¢Æ.");
  gk();
  loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+12,&oldscr);
 }
 return p2;
}
void laboratoryN4G(struct datatable *opentable){
#define Mx 1700
#define My 45
#define Shx 600
#define Shy 400
#define Hx 0.0001
int g,m;
char number[]="A(X)";
double y=0,x=0;
g=9;m=2;
initgraph(&g,&m,"c:\\langs\\bc\\bgi");
line(Shx,1,Shx,480);
line(1,Shy,640,Shy);
g=0;
for(x=opentable[0].x;x<opentable[l4_N-1].x+Hx;x+=Hx){
 y=laboratoryN4(NULL,opentable,x,1);
 if(floor(opentable[g].x*Mx+Shx+0.5)==floor(x*Mx+Shx+0.5)){
  setfillstyle(1,10);
  setcolor(10);
  line(x*Mx+Shx,Shy-y*My,Shx,Shy-y*My);
  line(x*Mx+Shx,Shy-y*My,x*Mx+Shx,Shy);
  fillellipse(x*Mx+Shx,Shy-y*My,2,2);
  setcolor(7);
  number[2]='X';
  outtextxy(x*Mx+Shx,Shy+5,number);
  number[2]='Y';
  outtextxy(Shx+5,Shy-y*My,number);
  g++;
  number[0]++;
 }
 putpixel(x*Mx+Shx,Shy-y*My,12);
}
directvideo=0;
textcolor(7);
gotoxy(1,1);cprintf("Y:");
for(m=0;m<l4_N;m++){
 gotoxy(m*12+3,1);
 cprintf("%c(%-03.3f)",m+65,opentable[m].y);
}
gotoxy(1,2);cprintf("X:");
for(m=0;m<l4_N;m++){
 gotoxy(m*12+3,2);
 cprintf("%c(%-03.3f)",m+65,opentable[m].x);
}
directvideo=1;
gk();
restorecrtmode();
#undef Mx
#undef My
#undef Shx
#undef Shy
#undef Hx
}