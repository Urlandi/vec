/*Квадратное Уравнение*/
/*Заданы верные аргументы - ЧИСЛА,где А не равнo 0*/
#include <stdio.h>
#include <conio.h>
#include <math.h>
int main(void){
double a,b,c,d,x1,x2;
char ask;
while(1){
 clrscr();
 gotoxy(15,1);printf("ПРОГРАММА НАХОЖДЕНИЯ КОРНЕЙ КВАДРАТНОГО УРАВНЕНИЯ");
 gotoxy(34,2);printf("a*x*x+b*x+c=0");

 gotoxy(1,4);printf("Введите соответствующие значения:\n");
 printf("a -> ");
 scanf("%le",&a);
 printf("b -> ");
 scanf("%le",&b);
 printf("c -> ");
 scanf("%le",&c);
 d=b*b-4*a*c;

 if(d<0)
  printf("Дискриминант = %lf, что меньше 0 вычисления прерваны\n",d);
 else
 {
  x1=(-b+sqrt(d))/(2*a);
  x2=(-b-sqrt(d))/(2*a);

  if (d==0)
   printf("Уравнение имеет один корень %lf\n",x1);
  else
   printf("Уравнение имеет корни x1=%lf x2=%lf\n",x1,x2);
 }

 printf("Пoвторить[Y]:");
 ask=getche();
 if (ask=='Y'||ask=='y'||ask=='Н'||ask=='н')
  continue;
 else
  break;
}
clrscr();
printf("(c) 2001 IVT-162\n");
return 0;
}