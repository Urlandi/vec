#ifndef _EASYFACEEL_
#define _EASYFACEEL_
#include "easyscr.h"
short menu(struct border_style *getparam,char **items,short numofitems,short startitem,short nodraw){
 short q,i;
 char l;
 if(nodraw)border(getparam);
 textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
 for(i=0,q=getparam->yleftcorner+1;i<numofitems&&nodraw;i++,q++){
  gotoxy(getparam->xleftcorner+2,q);
  cprintf("%s",*(items+i));
 }
 i=startitem;q=numofitems;if(q==i)q=1;
 do{
  if(q!=i){
   gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+q);putch(32);
   gotoxy(getparam->xrightcorner-1,getparam->yleftcorner+q);putch(32);
   gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+i);putch(16);
   gotoxy(getparam->xrightcorner-1,getparam->yleftcorner+i);putch(17);
  }
  q=i;
  l=gk();
  if(!l){
   l=getch();
   switch(l){
    case 80:if(i==numofitems)i=1;else i++;
            break;
    case 72:if(i==1)i=numofitems;else i--;
            break;
    default:if(nodraw==-1){
             i=-l;
             l=13;
            }
   }
  }else
    if(nodraw==-1&&l==27){
     i=0;
     l=13;
    }
 }while(l!=13);
return i;
}
unsigned getstring(char *s,unsigned maxstringlen){
unsigned n=0;
char l;
 _setcursortype(_NORMALCURSOR);
 n=length(s);
 if(s)cprintf("%s",s);
 do{
  l=gk();if(!l)getch();else
  if(l>31&&n<maxstringlen){*(s+n++)=l;putch(l);}else
  if(l==8&&n>0){n--;putch(l);putch(' ');putch(l);}
 }while(l!=13);
 *(s+n)=0;
 return n;
}
struct list_item *addmenu(struct list_item *listmenu, char *title,unsigned ret, short type,struct list_item *inmenu){
 if((listmenu=addlist(listmenu))==NULL)return NULL;
 if((listmenu->data=(struct menu_item*)malloc(sizeof(struct menu_item)))==NULL)return NULL;
 ((struct menu_item*)listmenu->data)->title=title;
 ((struct menu_item*)listmenu->data)->ret=ret;
 ((struct menu_item*)listmenu->data)->type=type;
 ((struct menu_item*)listmenu->data)->inmenu=inmenu;
return listmenu;
}
void erasemenu(struct list_item *listmenu){
 listmenu=movelist(listmenu,FIRST);
 do{
  if(((struct menu_item*)listmenu->data)->inmenu)erasemenu(((struct menu_item*)listmenu->data)->inmenu);
  free((struct menu_item*)listmenu->data);
  listmenu=dellist(listmenu);
 }while((listmenu=movelist(listmenu,NEXT))!=NULL);
}
#define menuitems ((struct menu_item*)templist->data)
long upmenu(struct border_style *getparam,struct list_item *li,short nodraw,short und){
 struct list_item *templist=li,*tt;
 struct border_style inmenusets;
 int *oldscr;
 char l;
 long q;
 short prev=0,i=1,posX,cX,countitems=numlist(li);
 if(nodraw!=NODRAW){
  if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr))return -1;
  if(und==VERTMENU)border(getparam);
 };
 do{
  templist=movelist(li,FIRST);
  textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
  q=0;
  do{
   q++;
   if((nodraw==NODRAW&&q!=prev&&q!=i)||nodraw==NOKEY)continue;else
    if(q==i)textattr((getparam->selectcolor)+(getparam->selectbackcolor)*16);else
     if(q==prev)textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
   if(und==LINEMENU){
    posX=0;
    l=0;
    tt=templist;
    templist=movelist(li,FIRST);
    while(++l!=q){
     posX=posX+length(menuitems->title);
     templist=movelist(templist,NEXT);
    }
    templist=tt;
    posX=posX+2*(q-1);
    if(q==i)cX=posX;
    gotoxy(getparam->xleftcorner+posX,getparam->yleftcorner);
    cprintf(" %s ",menuitems->title);
   }else{
     cX=1;
     gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+q);
     cprintf(" %s ",menuitems->title);
     for(l=getparam->xleftcorner+length(menuitems->title)+2;l<getparam->xrightcorner-1;l++)putch(' ');
   }
   textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
  }while((templist=movelist(templist,NEXT))!=NULL);
  templist=movelist(li,FIRST);
  prev=i;
  l=gk();
  switch(l){
   case 13:l=1;
	   while(l++!=i) templist=movelist(templist,NEXT);
	   switch(menuitems->type){
	    case COMMAND:loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
			 return menuitems->ret;
	    case SUBMENU:nodraw=NODRAW;
			 inmenusets=*getparam;
			 inmenusets.xleftcorner=getparam->xleftcorner+cX;
			 inmenusets.yleftcorner=getparam->yleftcorner+1;
			 if(und==VERTMENU)inmenusets.yleftcorner+=i;
			 inmenusets.xrightcorner=0;
			 tt=templist;
			 templist=movelist(menuitems->inmenu,FIRST);
			 do{
			  if(inmenusets.xrightcorner<length(menuitems->title))
			   inmenusets.xrightcorner=length(menuitems->title);
			 }while((templist=movelist(templist,NEXT))!=NULL);
			 templist=tt;
			 inmenusets.xrightcorner+=inmenusets.xleftcorner+3;
			 inmenusets.yrightcorner=inmenusets.yleftcorner+numlist(menuitems->inmenu)+1;
			 q=upmenu(&inmenusets,menuitems->inmenu,MENU,VERTMENU);
			 if((und==VERTMENU&&q!=0)||q>0)
			  loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);

			 if(q>=0){
			  if(q>0)return q;else nodraw=NOKEY;
			 }else{
			  if(und==VERTMENU) return q;
			  if(q==NEXTSUBMENU){
			   i++;
			   if((templist=movelist(templist,NEXT))==NULL){
			    templist=movelist(li,FIRST);
			    i=1;
			   };
			  }else
			  if(q==PREDSUBMENU){
			   i--;
			   if((templist=movelist(templist,PREV))==NULL){
			    templist=movelist(li,LAST);
			    i=countitems;
			   }
			  }
			  if(menuitems->type==SUBMENU)ungetch(13);
			 }
	   }
	  break;
  case 27:loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
	  return 0;
   case 0:l=gk();
	   nodraw=NODRAW;
	   switch(l){
	    case KEYUP:   if(und==VERTMENU){if(i--==1)i=countitems;}else nodraw=NOKEY;
			  break;
	    case KEYDOWN: if(und==VERTMENU){if(i++==countitems)i=1;}else nodraw=NOKEY;
			  break;
	    case KEYLEFT: if(und==LINEMENU)
			   {if(i--==1)i=countitems;}
			  else{
			    loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
                            return -1;
                          }
                          break;
            case KEYRIGHT:if(und==LINEMENU)
                           {if(i++==countitems)i=1;}
                          else{
                           loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
                           return -2;
                          };
                          break;
            default:nodraw=NOKEY;
           }
          break;
   default:nodraw=NOKEY;
  }
 }while(1);
}
#undef menuitems
short buttonmenu(struct border_style *getparam,char **items,short numofitems,short und,short nodraw){
 short q,i,len=MENU;
 char l;
 if(und==VERTMENU)q=getparam->yleftcorner;else q=0;
 if(nodraw!=NODRAW){
  clrscrext(getparam->xleftcorner,getparam->yleftcorner,
            getparam->xrightcorner,getparam->yrightcorner,
            getparam->bordercolor,getparam->borderbackcolor,0,0);
  for(i=0;i<numofitems;i++){
   textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
   if(und==VERTMENU){
    gotoxy(getparam->xleftcorner,q);
    cprintf(" %s ",*(items+i));
    textattr(0+(getparam->borderbackcolor)*16);
    cprintf("Ü");
    gotoxy(getparam->xleftcorner+1,q+1);
    for(l=0;l<length(*(items+i))+2;l++)cprintf("ß");
    q+=2;
   }else{
    gotoxy(getparam->xleftcorner+q,getparam->yleftcorner);
    cprintf(" %s ",*(items+i));
    textattr(0+(getparam->borderbackcolor)*16);
    cprintf("Ü");
    gotoxy(getparam->xleftcorner+1+q,getparam->yleftcorner+1);
    for(l=0;l<length(*(items+i))+2;l++)cprintf("ß");
    q+=length(*(items+i))+4;
   }
  }
 }
 i=1;q=2;
 do{
  if(q!=i){
   textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
   if(und==VERTMENU){
    gotoxy(getparam->xleftcorner,getparam->yleftcorner+(q-1)*2);
    cprintf(" %s ",*(items+(q-1)));
    gotoxy(getparam->xleftcorner,getparam->yleftcorner+(i-1)*2);
    textattr((getparam->selectcolor)+(getparam->selectbackcolor)*16);
    cprintf(" %s ",*(items+(i-1)));
   }else{
    len=0;
    for(l=0;l<numofitems;l++){
     if(l==(i-1))textattr((getparam->selectcolor)+(getparam->selectbackcolor)*16);
     if(l==(q-1)||l==(i-1)){
      gotoxy(getparam->xleftcorner+len,getparam->yleftcorner);
      cprintf(" %s ",*(items+l));
      textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
     }
     len+=length(*(items+l))+4;
    }
   }

  }
  q=i;
  l=gk();
  if(l==27)return 0;
  if(!l){
   l=getch();
   if(und==VERTMENU)
    switch(l){
     case KEYDOWN:if(i==numofitems)i=1;else i++;
                  break;
     case KEYUP:  if(i==1)i=numofitems;else i--;
                  break;
    }
   else
    switch(l){
     case KEYRIGHT:if(i==numofitems)i=1;else i++;
                    break;
     case KEYLEFT: if(i==1)i=numofitems;else i--;
                   break;
    }
  }
 }while(l!=13);
 if(und==VERTMENU){
  gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+(i-1)*2+1);
  textattr((getparam->bordercolor)+(getparam->borderbackcolor)*16);
  for(l=0;l<length(*(items+(i-1)))+2;l++)cprintf(" ");
  gotoxy(getparam->xleftcorner,getparam->yleftcorner+(i-1)*2);
  cprintf(" ");
  textattr((getparam->selectcolor)+(getparam->selectbackcolor)*16);
  cprintf(" %s ",*(items+(i-1)));
  delay(300);
  gotoxy(getparam->xleftcorner,getparam->yleftcorner+(i-1)*2);
  cprintf(" %s ",*(items+(i-1)));
  textattr(0+(getparam->borderbackcolor)*16);
  cprintf("Ü");
  gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+(i-1)*2+1);
  for(l=0;l<length(*(items+(i-1)))+2;l++)cprintf("ß");
 }else{
  len=0;
  for(l=0;l!=(i-1);l++)len+=length(*(items+l))+4;
  gotoxy(getparam->xleftcorner+len+1,getparam->yleftcorner+1);
  textattr((getparam->bordercolor)+(getparam->borderbackcolor)*16);
  for(l=0;l<length(*(items+(i-1)))+2;l++)cprintf(" ");
  gotoxy(getparam->xleftcorner+len,getparam->yleftcorner);
  cprintf(" ");
  textattr((getparam->selectcolor)+(getparam->selectbackcolor)*16);
  cprintf(" %s ",*(items+(i-1)));
  delay(300);
  gotoxy(getparam->xleftcorner+len,getparam->yleftcorner);
  cprintf(" %s ",*(items+(i-1)));
  textattr(0+(getparam->borderbackcolor)*16);
  cprintf("Ü");
  gotoxy(getparam->xleftcorner+len+1,getparam->yleftcorner+1);
  for(l=0;l<length(*(items+(i-1)))+2;l++)cprintf("ß");
 }
 delay(100);
return i;
}
#define menuitems ((struct menu_item*)templist->data)
long listmenu(struct border_style *getparam,struct list_item *li,short nodraw){
 struct list_item *templist=li;
 int *oldscr,viewi,pc=0;
 char l;
 long q;
 short prev=0,i=1,countitems=numlist(li);
 if(nodraw!=NODRAW){
  if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr))return -1;
  border(getparam);
 };
 viewi=getparam->yrightcorner-getparam->yleftcorner-1;
 do{
  templist=movelist(li,FIRST);
  textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
  q=pc;
  templist=poslist(li,pc);
  do{
   q++;
   if((nodraw==NODRAW&&q!=prev&&q!=i)||nodraw==NOKEY)continue;else
    if(q==i)textattr((getparam->selectcolor)+(getparam->selectbackcolor)*16);else
     if(q==prev)textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
   gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+q-pc);
   cprintf(" %s ",menuitems->title);
   for(l=getparam->xleftcorner+length(menuitems->title)+2;l<getparam->xrightcorner-1;l++)putch(' ');
   textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
  }while((templist=movelist(templist,NEXT))!=NULL&&q<viewi+pc);
  prev=i;
  l=gk();
  switch(l){
   case 13:loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
	   return i;
  case 27:loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
	  return 0;
   case 0:l=gk();
	   nodraw=NODRAW;
	   switch(l){
	    case KEYUP:   if(i--==1)i=1;else
			   if(i==pc){
			   pc--;
			   nodraw=MENU;
			  }
			  break;
	    case KEYDOWN: if(i++==countitems)i=countitems; else
			  if(i>viewi+pc){
			   pc++;
			   nodraw=MENU;
			  }
			  break;
	   }
	  break;
   default:nodraw=NOKEY;
  }
 }while(1);
}
#undef menuitems
short scrollwindow(struct border_style *getparam,char **text){
 int *oldscr;
 int l;
 short outscr=getparam->yrightcorner-getparam->yleftcorner-1;
 long q;
 if(!savescr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr))return -1;
 border(getparam);
 q=0;
 textattr((getparam->fillcolor)+(getparam->fillbackcolor)*16);
 while(*(text+q)!=NULL&&q<outscr){
  gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+1+q);
  cprintf("%s",*(text+q));
  q++;
 }
 if(q<outscr)outscr=q;
 q=0;
 do{
  if((l=gk())==0)l=gk()+300;
  switch(l){
   case 300+KEYDOWN:if(*(text+q+outscr)!=NULL){
		     gotoxy(getparam->xleftcorner+1,getparam->yrightcorner-1);
		     clrscrext(getparam->xleftcorner+1,getparam->yleftcorner+1,
		     getparam->xrightcorner-1,getparam->yrightcorner-1,
		     getparam->fillcolor,getparam->fillbackcolor,0,1);
		     cprintf("%s",*(text+q+outscr));
		     q++;
		    }
		    break;
   case 300+KEYUP:if(q>0){
		   gotoxy(getparam->xleftcorner+1,getparam->yleftcorner+1);
		   clrscrext(getparam->xleftcorner+1,getparam->yleftcorner+1,
		   getparam->xrightcorner-1,getparam->yrightcorner-1,
		   getparam->fillcolor,getparam->fillbackcolor,1,1);
		   q--;
		   cprintf("%s",*(text+q));
		  }
		  break;
  case 27:l=0;
	  break;
  };
 }while(l!=0);
 loadscr(getparam->xleftcorner,getparam->xrightcorner+1,getparam->yleftcorner,getparam->yrightcorner+1,&oldscr);
 return 0;
}
void messageline(short x,short y,short l,short c,short b,char *message){
 textcolor(c);
 textbackground(b);
 gotoxy(x,y);fillborder(' ',l,c,b);
 cprintf(message);
}
#endif