/*�����⭮� �ࠢ�����*/
/*������ ���� ��㬥��� - �����,��� � �� ࠢ�o 0*/
#include <stdio.h>
#include <conio.h>
#include <math.h>
int main(void){
double a,b,c,d,x1,x2;
char ask;
while(1){
 clrscr();
 gotoxy(15,1);printf("��������� ���������� ������ ����������� ���������");
 gotoxy(34,2);printf("a*x*x+b*x+c=0");

 gotoxy(1,4);printf("������ ᮮ⢥�����騥 ���祭��:\n");
 printf("a -> ");
 scanf("%le",&a);
 printf("b -> ");
 scanf("%le",&b);
 printf("c -> ");
 scanf("%le",&c);
 d=b*b-4*a*c;

 if(d<0)
  printf("���ਬ����� = %lf, �� ����� 0 ���᫥��� ��ࢠ��\n",d);
 else
 {
  x1=(-b+sqrt(d))/(2*a);
  x2=(-b-sqrt(d))/(2*a);

  if (d==0)
   printf("�ࠢ����� ����� ���� ��७� %lf\n",x1);
  else
   printf("�ࠢ����� ����� ��୨ x1=%lf x2=%lf\n",x1,x2);
 }

 printf("�o�����[Y]:");
 ask=getche();
 if (ask=='Y'||ask=='y'||ask=='�'||ask=='�')
  continue;
 else
  break;
}
clrscr();
printf("(c) 2001 IVT-162\n");
return 0;
}