#include <stdio.h>
int main(void){
char txt[130],slo[7],q,qt=0,f=0,n=0;
printf("������ ⥪�⮢�� ��ப� ������� �� ���᪨� ᫮�:");
gets(txt);

for(q=0;txt[q-1]!=0;q++){
 switch(txt[q]){
  case 0:
  case ' ':slo[qt]=0;
	   printf("%s ",slo);
	   qt=0;
	   f=0;
	   break;
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':
  case '�':switch(f){
	   case 1:if(slo[qt-1]!='�'&&slo[qt-1]!='�'&&slo[qt-1]!='�'&&slo[qt-1]!='�'&&n!=q-1){
		   slo[qt-1]=0;q--;
		  }else slo[qt]=0;
		  printf("%s-",slo);
		  if(n!=q-1||q==1)
		  f=0;qt=0;n=q;
		  break;
	   default:f=1;n=q;
	   }slo[qt++]=txt[q];break;
  default:slo[qt++]=txt[q];
	  n=0;
 }
}
return 0;
}