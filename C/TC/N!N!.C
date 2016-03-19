#include <stdio.h>

void forward(char *st,short s){
 if(*(st+s)==0) return;
 forward(st,s+1);
 printf("%c",*(st+s));
}
void main(void){
char str[10]="1234567890";
/*unsigned q,n=6;
unsigned long resultat=1;
for(q=1;q<=n;q++) resultat*=q;
printf("\n%d\n",resultat);*/
forward(str,0);
}