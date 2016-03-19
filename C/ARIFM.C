#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
int analizer(int strt,char *instr,int len,long int *vars);

int main(void){
char *func;
long int xyz;
long int e,q;
func=(char*)malloc(128);
clrscr();
gotoxy(35,1);puts("CALC  THIS");
puts("Введите арифметическое выражение, для подтвержденя его првильности.");
puts("Выражение может содержать следующие знаки операций:");
puts("'+'\tсумма\n'-'\tразность, знак числа\n'*'\tпроизведение\n'/'\tчастноe\n'^'\tстепень\n'()'\tприоритет\n','\tдесятичная часть");
puts("Переменная - буква латинского алфавита без учета регистра.");
window(1,13,80,25);
do{
 xyz=0;
 clrscr();
 printf(">");
 scanf("%s",func);
 e=analizer(0,strlwr(func),strlen(func),&xyz);
 if(e!=strlen(func))
  printf("Выражение содержит ошибки! Обработка прервана на %d символе.\n",abs(e));
 else{
  printf("Выражение верно ");
  if(xyz!=0){
   printf("и содержит следующие переменные:");
   for(e=1;e<27;e++){
    q=pow(2,e);
    if(xyz&q)
     printf("%c,",e+96);
   }
  }
  printf("\b.\n");
 }
puts("Нажмите ESC для выхода или любую клавишу для повторения.");
}while(getch()!=27);
free(func);
window(1,1,80,25);
clrscr();
puts("(c) 2001 IVT-162");
return 0;
}

int analizer(int strt,char *instr,int len,long int *vars){
int q;
short int xt=2;
long int tmps;
/*
xt=2  скобки открыты
xt=1  после мат.операции
xt=0  после числа
*/
for(q=strt;q<len;q++){
 if(*(instr+q)==')'&&q!=strt&&xt==0)break;
 if(*(instr+q)=='('&&xt>0){
  q=analizer(++q,instr,len,vars);
  xt=0;
  if(q<0)break;
 }else
 if(*(instr+q)>='a'&&*(instr+q)<='z'&&xt>0){
  tmps=pow(2,*(instr+q)-96);
  *vars|=tmps;
  xt=0;
 }else
 if(*(instr+q)>='0'&&*(instr+q)<='9'&&xt>0){
  tmps=0;xt=0;
  for(;(*(instr+q)>='0'&&*(instr+q)<='9'||*(instr+q)==',')&&tmps<=1;q++)
   if(*(instr+q)==',') tmps++;
  if(tmps>1||*(instr+q-1)==','){
   q=-q;
   break;
  }
  q--;
 }else
 if((*(instr+q)=='+'||*(instr+q)=='-'||*(instr+q)=='*'||*(instr+q)=='/'||*(instr+q)=='^')&&(xt==0)||(xt==2&&*(instr+q)=='-')){
  xt=1;
 }else{
 q=-(q+1);
 xt=0;
 break;
 }

}
if(xt!=0)q=-(q+1);
return q;
}