#include <conio.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
/*8912364 u whjger uwyger 77 ryu8g4 wyuegr 8732 4rwyuegr 7823t rhwqr 623 rywer 67t
qr yqrg hwuqer */
short int pwrks(char *instr,unsigned int length,unsigned short int wnd);
void dwrks(char *instr,unsigned int length);
void insert(char *sourcestring,char *insertstring,short int startsymb);
void delet(char *sourcestring,short int startsymb,short int lengthsymb);
int main(void){
short int wd;
char *txt/*,test[1024]="8912364 u whjger uwyger 77 ryu8g4 wyuegr 8732 4rwyuegr 7823t rhwqr 623 rywer 67t qr yqrg hwuqer   "*/;
txt=(char*)malloc(1024);
clrscr();
puts("Введите текст длиной не более 127 символов:");
gets(txt);
/*txt=test;*/
printf("Введите максимальную ширину страницы не более 79 символов:");
scanf("%d",&wd);
if(pwrks(txt,strlen(txt),wd)<0)
 puts("Нельзя обработать данный текст, т.к. найдены слова превосходящие поле вывода.");
else
{
 dwrks(txt,strlen(txt));
 puts(txt);
}
getch();
clrscr();
puts("(c)2001 IVT-162");
free(txt);
return 0;
}

short int pwrks(char *instr,unsigned int length,unsigned short int wnd){
unsigned int q,lstsps,strs,hs;
unsigned short int words;
words=strs=lstsps=0;
hs=2;
for(q=0;q<length;q++)
 if(((*(instr+q)==32&&*(instr+q+1)==32))||((*(instr+q)==32&&q==length-1))||((*(instr+q)==32&&q==1))){
   delet(instr,q+1,1);
   q--;
   length--;
  }

*(instr+length)=32;
length++;
*(instr+length)=0;

for(q=0;q<length;q++){
 if((*(instr+q)==32)){
  lstsps=q;
  words++;
 }
 if((q-strs+1)%(wnd)==0){
  if(*(instr+q+1)==32){
    lstsps=q+1;
    words++;
   }
  if(strs==lstsps){
   lstsps=-1;
   break;
  }
  *(instr+lstsps)='\n';
  *(instr+length+hs+1)=wnd-lstsps+strs;
  *(instr+length+hs+2)=--words;
  strs=q=lstsps+=1;
  hs+=2;
  words=0;
 }
}
if(lstsps==0&&wnd<length)lstsps=-1;

/*if(strs==0){
 *(instr+length+hs+1)=wnd-length+1;
 *(instr+length+hs+2)=--words;
 hs+=2;
}
else
{*/
 *(instr+length+hs+1)=wnd-length+strs+1;
 *(instr+length+hs+2)=--words;
 hs+=2;
/*} */
*(instr+length+1)=hs/256;
*(instr+length+2)=hs%256;

return lstsps;
}

void dwrks(char *instr,unsigned int length){
char *ts;
unsigned int q,qw,hs;
div_t space;
ts=(char*)malloc(*(instr+length+1)*4+*(instr+length+2));
for(q=0;q<*(instr+length+1)*4+*(instr+length+2);q++){
*(ts+q)=*(instr+length+q+3);
}
space=div(*(ts),(*(ts+1)==0)?(1):(*(ts+1)));
hs=2;
q=0;
while(q<length){
 switch(*(instr+q)){
 case 32:  for(qw=0;qw<space.quot;qw++) insert(instr," ",q+1);
	   length+=qw;
	   if(space.rem-->0){
	    insert(instr," ",q+1);
	    q++;
	    length++;
	   }
	   q+=qw;
	   break;
 case '\n':if(*(ts+hs+1)!=0)space=div(*(ts+hs),*(ts+hs+1));
	   hs+=2;
	   break;
  }
q++;
}
free(ts);
}

void insert(char *sourcestring,char *insertstring,short int startsymb){
char *tempstring;
tempstring=(char*)malloc(strlen(sourcestring));
strcpy(tempstring,sourcestring);
*(tempstring+startsymb-1)=0;
strcat(tempstring,insertstring);
strcat(tempstring,sourcestring+startsymb-1);
strcpy(sourcestring,tempstring);
free(tempstring);
}
void delet(char *sourcestring,short int startsymb,short int lengthsymb){
char *tempstring;
tempstring=(char*)malloc(strlen(sourcestring));
strcpy(tempstring,sourcestring);
*(tempstring+startsymb-1)=0;
strcat(tempstring,sourcestring+startsymb+lengthsymb-1);
strcpy(sourcestring,tempstring);
free(tempstring);
}