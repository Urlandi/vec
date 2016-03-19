#include <conio.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

short int pwrks(char *instr,unsigned int length,unsigned int wnd);
void dwrks(char *instr,unsigned int length);
void insert(char *sourcestring,char *insertstring,short int startsymb);
void delet(char *sourcestring,short int startsymb,short int lengthsymb);
int main(void){
FILE *source;
long i,lngth;
short int wd;
char *txt,fname[13]="file"/*,test[1024]="123e e 1we 3 we e14w 3e4 w1e 5w 1we6  e wew ew we 1we7 7we 1we8 8 188 sdugh seuig ewuriy sduf sdjfg ef ieuwr hgf djksfg "*/;
clrscr();
puts("Введите имя форматируемого файла:");
scanf("%s",fname);
if((source=fopen(fname,"r+t"))==NULL){
 printf("Не могу открыть файл \n");
 return -1;
}
fseek(source,0,2);
lngth=ftell(source);
if(lngth>40960){
 printf("Файл слишком большой\n");
 fclose(source);
 return -2;
}
i=lngth/80;i=(i+1)*200;
txt=(char*)malloc(i);
fseek(source,0,0);
for(i=0;i<lngth;i++){
 *(txt+i)=getc(source);
 if(*(txt+i)<32||*(txt+i)==255)*(txt+i)=32;
}
*(txt+i)=0;

/*txt=test;*/
wd=78;
if(pwrks(txt,strlen(txt),wd)<0)
 puts("Нельзя обработать данный текст, т.к. найдены слова превосходящие поле вывода.");
else
{
 txt[strlen(txt)-1]=0;
 dwrks(txt,strlen(txt)+1);
 puts(txt);
 fseek(source,0,0);
 for(i=0;i<strlen(txt);i++) putc(*(txt+i),source);

}
fclose(source);
getch();
clrscr();
puts("(c)2001 IVT-162");
free(txt);
return 0;
}


short int pwrks(char *instr,unsigned int length,unsigned int wnd){
unsigned int q,lstsps,strs,hs;
unsigned int words;
words=strs=lstsps=0;
hs=2;
for(q=0;q<length;q++)
 if(((*(instr+q)==32&&*(instr+q+1)==32))||(*(instr+q)==32&&q==length-1)||(*(instr+q)==32&&q==0)){
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
 if((q-strs+1)%wnd==0){
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