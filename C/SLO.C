#include <stdio.h>
int main(void){
char txt[130],slo[7],q,qt=0,f=0,n=0;
printf("Введите текстовую строку состоящую из русских слов:");
gets(txt);

for(q=0;txt[q-1]!=0;q++){
 switch(txt[q]){
  case 0:
  case ' ':slo[qt]=0;
	   printf("%s ",slo);
	   qt=0;
	   f=0;
	   break;
  case 'а':
  case 'А':
  case 'е':
  case 'Е':
  case 'ё':
  case 'Ё':
  case 'и':
  case 'И':
  case 'о':
  case 'О':
  case 'у':
  case 'У':
  case 'ы':
  case 'Ы':
  case 'э':
  case 'Э':
  case 'ю':
  case 'Ю':
  case 'я':
  case 'Я':switch(f){
	   case 1:if(slo[qt-1]!='ь'&&slo[qt-1]!='ъ'&&slo[qt-1]!='Ь'&&slo[qt-1]!='Ъ'&&n!=q-1){
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