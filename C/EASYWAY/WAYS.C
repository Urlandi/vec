#include <stdio.h>
#include <string.h>
#include <time.h>
#include "easylib.h"
#define EXITPRG 0xFF
void runline(void);
void showfile(struct border_style *getparam,char *file);
void runmmm(long x,long y,long max,unsigned char *where,unsigned char *sets,FILE *mmm,long *pttp,long *dds,long *lmin,long *lmax, long *mc);
void aboutbox(struct border_style *getparam);
void showhelp(struct border_style *getparam);
void rungir(struct border_style *getparam);
short exitbox(struct border_style *getparam);
void errormessage(struct border_style *getparam,short err);
void setpoint(long x,long y,long el,long max,unsigned char *where);
short getpoint(long x,long y,long max,unsigned char *where);
void postview(struct border_style *getparam);
int main(void){
int l,q,n;
FILE *file;
#include "mm.h"
clrscr();
_wscroll=0;
_setcursortype(_NOCURSOR);
fillborder('�',80*25,1,7);
fillborder(' ',80,1,1);
textattr(15+16);
cprintf(" ����  ������ ");

do{
 messageline(1,25,80,6,1,"��筨� ࠡ��� � �롮� �㭪� ���� - F10, ��室 - ALT+X, ������ - F1");
 if((l=gk())==0)l=gk()+300;
 switch(l){
  case 27:break;
  case 407:runline();
           break;
  case 345:if(exitbox(&dialogview)==YES)l=EXITPRG;
           break;
  case 359:showhelp(&dialogview);
           break;
  case 368:messageline(1,25,80,6,1,"�롥�� ����⢨� �� ����. ��ࠡ�⪠ ������ 䠩�� - ����/��ࠡ����");
           l=upmenu(&menuview,mainmenu,MENU,LINEMENU);
           switch(l){
            case 1000:rungir(&dialogview);
                      break;
            case 1001:postview(&dialogview);
                      break;
            case 1002:if(exitbox(&dialogview)==YES)l=EXITPRG;
                      break;
            case 2000:showhelp(&dialogview);
                      break;
            case 2001:aboutbox(&dialogview);
                      break;

            default:;
           }
 }
}while(l!=EXITPRG);
erasemenu(mainmenu);
textcolor(7);
textbackground(0);
clrscr();
cprintf("(c)2002 IVT-162");
return 0;
}
void showfile(struct border_style *getparam,char *file){
 FILE *f;
 char **text,p[80],t;
 int o;
 long curpos, l;
 if((f=fopen(file,"rt"))==NULL){
  errormessage(getparam,1);
  return;
 }
 if((text=(char**)malloc(sizeof(char*)))==NULL){
   errormessage(getparam,3);
   fclose(f);
   return;
  }
 l=0;
 while(1){
  o=0;
  t=0;
  while(o!=10&&o!=EOF){
   o=fgetc(f);
   p[t++]=o;
  }
  p[t-1]=0;
  t=length(p);
  if(!t)t=1;
  if((*(text+l)=(char*)malloc(t+1))==NULL){
   errormessage(getparam,3);
   fclose(f);
   return;
  }
  strcpy(*(text+l),p);
  l++;
  if((text=(char**)realloc(text,(l+1)*sizeof(char*)))==NULL){
    errormessage(getparam,3);
    fclose(f);
    return;
  };
  if(o==EOF)break;
 }
 fclose(f);
 *(text+l)=NULL;
 getparam->xleftcorner=2;
 getparam->xrightcorner=78;
 getparam->yleftcorner=3;
 getparam->yrightcorner=22;
 messageline(1,25,80,6,1,"�����襭�� ��ᬮ�� <ESC>. ��६�饭�� ��५���� �����.");
 scrollwindow(getparam,text);
 l=0;
 while(*(text+l)!=NULL){
  free(*(text+l));
  l++;
 }
 free(*(text+l));
 free(text);
}
void runline(void){
int *oldscr;
char strlrun[]="                                                         1+2+3+4+5+6+7+8+9+10+11+12+13+14+15+16+17+18+19+20+21+22+23+24+25+26+27+28+29+30+31+32+33+34+35+36+37+38+39+40+41+42+43+44+45+46+47+48+49+50+51+52+53+54+55+56+57+58+59+60=1830";
int q,len,i,k;
struct border_style w;
messageline(1,25,80,6,1,"SUXXX!!!");
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
textcolor(14);
len=length(strlrun);
do{
for(i=0;i<len;i++){
 delay(150);
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
char *errors[6]={"      ��� 䠩��� � ����묨.",
                 "   ���� �訡�� �����/�뢮��.",
                 " ���� �� ���� 䠩���-������.",
                 "  ��� ����� ��� �⮣� ����⢨�.",
                 "�訡�� �����. ������ ����⢨�.",
                 "�訡�� ᮧ����� 䠩��-१���⮢."};

 messageline(1,25,80,6,1,"�訡�� � ࠡ�� � �ணࠬ���. ������� � ���㬥��樨.");
 getparam->xleftcorner=22;
 getparam->xrightcorner=58;
 getparam->yleftcorner=9;
 getparam->yrightcorner=14;
 getparam->fillbackcolor=4;
 getparam->borderbackcolor=4;
 messagedialog(getparam,errors[err]);
 getparam->fillbackcolor=1;
 getparam->borderbackcolor=1;
}
void aboutbox(struct border_style *getparam){
 int *oldscr;
 getparam->xleftcorner=10;
 getparam->xrightcorner=69;
 getparam->yleftcorner=8;
 getparam->yrightcorner=15;
 if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr))return;
 border(getparam);
 messageline(1,25,80,6,1,"������ ���� ������� ��� �த������� ࠡ���.");
 window(getparam->xleftcorner+1,getparam->yleftcorner+1,getparam->xrightcorner-1,getparam->yrightcorner-1);
 textcolor(10);
 cprintf("\n\r                    ���-��������� ����� final\n\r");
 cprintf("              ������஢�� ࠡ�� �� ����⭮� ��⥬�⨪�\n\r");
 cprintf("                    ������� ���-162 ��ᨫ쥢 �.\n\r");
 cprintf("                          ������ࠤ 2002\n\r");

 gotoxy(1,1);
 textcolor(14);
 cprintf(" ����Ŀ1001b\n\r");
 cprintf(" ��������Ŀo\n\r");
 cprintf(" ���ĳ��Ŀ�n\n\r");
 cprintf(" ���ĳ��ĳ�A\n\r");
 cprintf(" ���Ĵ���ٳi\n\r");
 cprintf("     ������r");
 gk();
 window(1,1,80,25);
 loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
}
short exitbox(struct border_style *getparam){
 messageline(1,25,80,6,1,"�롥�� <���> �᫨ ��� �த������ ࠡ���");
 getparam->xleftcorner=32;
 getparam->xrightcorner=48;
 getparam->yleftcorner=9;
 getparam->yrightcorner=14;
 return choosedialog(getparam,"���� ���?");

}
void showhelp(struct border_style *getparam){
#include "helph.h"
 getparam->xleftcorner=2;
 getparam->xrightcorner=78;
 getparam->yleftcorner=3;
 getparam->yrightcorner=22;
 messageline(1,25,80,6,1,"�����襭�� ��ᬮ�� <ESC>. ��६�饭�� ��५���� �����.");
 scrollwindow(getparam,text);
}
void setpoint(long x,long y,long el,long max,unsigned char *where){
 unsigned char j;
 j=1;
 j<<=x%8;
 if(el)*(where+(max/8+1)*y+(x/8))|=j;else{
  j^=0xFF;
  *(where+(max/8+1)*y+(x/8))&=j;
 }
}
short getpoint(long x,long y,long max,unsigned char *where){
 unsigned char  j;
 j=1;
 j<<=x%8;
 j&=*(where+(max/8+1)*y+(x/8));
 if(j)j=1;
 return j;
}
void runmmm(long x,long y,long max,unsigned char *where,unsigned char *sets,FILE *mmm,long *pttp,long *dds,long *lmin,long *lmax,long *mc){
 long q,s,k;
 if(getpoint(x,0,max,sets))return;
 *(pttp+*dds)=x;
 *dds=*dds+1;
 setpoint(x,0,1,max,sets);
 for(q=0;q<=max;q++){
  gotoxy(42,13);
  cprintf("%ld    ",*mc);
  if(getpoint(q,x,max,where)&&q!=x)
   if(q==y){
    *mc=*mc+1;
    fprintf(mmm,"\n------>������� #%ld.����� - %ld\n",*mc,*dds);
    for(s=0;s<*dds;s++){
     if(s%12==0&&s!=0)fprintf(mmm," +\n+ ");
     fprintf(mmm,"X%ld ",*(pttp+s)+1);
    }
   fprintf(mmm,"X%ld\n",y+1,*dds);
   if(*lmin==0)*lmin=*dds;
   if(*lmin>*dds)*lmin=*dds;
   if(*lmax<*dds)*lmax=*dds;
   }
   else
    runmmm(q,y,max,where,sets,mmm,pttp,dds,lmin,lmax,mc);
 }
 *(pttp+*dds)=0;
 *dds=*dds-1;
 setpoint(x,0,0,max,sets);
 return;
}
void rungir(struct border_style *getparam){
 struct time t;
 struct date d;
 char ss[13]="",ofile[13],rb,*endptr;
 long q,x,y,axb,*stroy,max,min,c;
 unsigned char *datatable,*settable;
 FILE *mmm;
 messageline(1,25,80,6,1,"�롥�� 䠩� ��� ����㧪� ������.");
 getparam->xleftcorner=32;
 getparam->xrightcorner=48;
 getparam->yleftcorner=3;
 getparam->yrightcorner=15;
 if(filelist(getparam,ss,"*.MMM",FA_RDONLY|FA_HIDDEN|FA_SYSTEM|FA_ARCH)==1){
  errormessage(getparam,0);
  return;
 }
 if(ss[0]==0)return;
 if((mmm=fopen(ss,"rb"))==NULL){
  errormessage(getparam,1);
  return;
 }
 strcpy(ofile,ss);
 q=0;c=1;
 while(1){
  if(fread(&rb,1,1,mmm)==NULL)break;
  if(rb>='0'&&rb<='9'&&c==1){
   max=ftell(mmm)-1;
   do{
    if(fread(&rb,1,1,mmm)==NULL)break;
    if(rb>='0'&&rb<='9')q++;
   }while(rb!=13);
   break;
  };
  if(rb==10)c=1;else c=0;
 }
 if(!q){
  errormessage(getparam,2);
  fclose(mmm);
  return;
 }
 axb=q;
 if((datatable=(unsigned char*)malloc((axb/8+1)*(axb+1)))==NULL){
  errormessage(getparam,3);
  fclose(mmm);
  return;
 };
 for(q=0;q<(axb/8+1)*(axb+1);q++)*(datatable+q)=0;
 x=0;y=0;
 fseek(mmm,max,SEEK_SET);
 while(fread(&rb,1,1,mmm)!=NULL){
  if(rb>='0'&&rb<='9'){
   rb=rb-'0';
   setpoint(x,y,rb,axb,datatable);
   x++;
  }
  if(rb==13&&x){
   y++;
   x=0;
  }
 }
 fclose(mmm);
do{
 randomize();
 q=0;
 while(ofile[q]!='.')q++;
 x=0;
 ofile[q+1]='^';
 do{
  ofile[q+2]=random(94)+33;
  ofile[q+3]=random(94)+33;
  x++;
  if(x>512){
   errormessage(getparam,5);
   return;
  }
  if((mmm=fopen(ofile,"r"))==NULL)
   if((mmm=fopen(ofile,"w+"))!=NULL)break;
 }while(1);

 messageline(1,25,80,6,1,"������ ��砫��� � ������� ���設� �������. � ���� १����.");
 getparam->xleftcorner=20;
 getparam->xrightcorner=60;
 getparam->yleftcorner=9;
 getparam->yrightcorner=15;
 border(getparam);
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+1);
 cprintf(" �����୮��� %ldx%ld",axb+1,axb+1);
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+2);
 cprintf(" ��室��� �窠   ->");
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+3);
 cprintf(" ��窠 �����祭�� ->");
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+4);
 cprintf(" ������⮢ ������� -> 0");
 gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+5);
 cprintf(" ���� १����  -> %s",ofile);
 ss[0]=0;
 while(1){
  gotoxy(42,11);
  getstring(ss,9);
  _setcursortype(_NOCURSOR);
  x=strtol(ss, &endptr, 10);
  if(x>axb+1||endptr[0]||x==0){
   errormessage(getparam,4);
   continue;
  }
  break;
 }
 ss[0]=0;
 while(1){
  gotoxy(42,12);
  getstring(ss,9);
  _setcursortype(_NOCURSOR);
  y=strtol(ss, &endptr, 10);
  if(y>axb+1||endptr[0]||y==0||x==y){
   errormessage(getparam,4);
   continue;
  }
  break;
 }
 gettime(&t);
 getdate(&d);
 fprintf(mmm,"���� १���⮢ �ணࠬ�� ���-���������(*)\n");
 fprintf(mmm,"C�����: %02d.%02d.%04d %2d:%02d:%02d.%02d\n",d.da_day,d.da_mon,d.da_year,t.ti_hour, t.ti_min, t.ti_sec, t.ti_hund);
 fprintf(mmm,"������⢮ ���設 ���: %ld\n",axb+1);
 fprintf(mmm,"��室��� ���設�: %ld\n���設� �����祭��: %ld\n",x,y);
 if((settable=(unsigned char*)malloc(axb/8+1))==NULL){
  errormessage(getparam,3);
  fclose(mmm);
  return;
 };
 if((stroy=(long*)malloc((axb+1)*4))==NULL){
  errormessage(getparam,3);
  fclose(mmm);
  return;
 };
 for(q=0;q<(axb/8+1);q++)*(settable+q)=0;
 q=0;min=max=0;c=0;
 runmmm(x-1,y-1,axb,datatable,settable,mmm,stroy,&q,&min,&max,&c);
 if(min==0&&max==0){
  if(fprintf(mmm,"����� ������⮢ ���")==EOF)errormessage(getparam,5);
 }else{
  if(fprintf(mmm,"\n����� �������쭮�� �������: %ld \n����� ���ᨬ��쭮�� �������: %ld\n�ᥣ� ������⮢: %ld",min,max,c)==EOF)errormessage(getparam,5);
 }
 free(settable);
 free(stroy);
 fclose(mmm);
 showfile(getparam,ofile);
 messageline(1,25,80,6,1,"�롥�� <��> �᫨ ��� �த������ ࠡ���");
 getparam->xleftcorner=28;
 getparam->xrightcorner=52;
 getparam->yleftcorner=8;
 getparam->yrightcorner=13;
}while(choosedialog(getparam,"�த������ ��ࠡ���?")==YES);
 free(datatable);
 for(q=9;q<=16;q++){
  gotoxy(20,q);
  fillborder('�',42,1,7);
 }
}
void postview(struct border_style *getparam){
 char ss[13]="";
 FILE *mmm;
 messageline(1,25,80,6,1,"�롥�� 䠩� ��� ��ᬮ�� ࠭�� ����祭��� १���⮢.");
 getparam->xleftcorner=32;
 getparam->xrightcorner=48;
 getparam->yleftcorner=3;
 getparam->yrightcorner=15;
 if(filelist(getparam,&ss[0],"*.^??",FA_RDONLY|FA_HIDDEN|FA_SYSTEM|FA_ARCH)==1){
  errormessage(getparam,0);
  return;
 }
 if(ss[0]==0)return;
 showfile(getparam,&ss[0]);
}