#include <stdio.h>
#include <string.h>
#define l 5
void prst(char *el,short n1);
void main(void){
char txt[l+1];
printf("Набор из 5 букв:");
scanf("%s",txt);
printf("%s\t",txt);
prst(txt,0);
}
void prst(char *el,short n1){
unsigned q;
char c,k[6];
strcpy(k,el);
for(q=n1;q<l;q++){
 c=*(k+n1);
 *(k+n1)=*(k+q);
 *(k+q)=c;
 if(strcmp(k,el)!=0)printf("%s\t",k);
 if(n1+1<l)prst(k,n1+1);
}
}