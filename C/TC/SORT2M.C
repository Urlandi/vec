#include <stdio.h>
#include <conio.h>
#define i 3
#define j 9
int main(void){
int mSort[i][j],*mSorted[i],*tSwap=NULL;
char q,b;

for(q=0;q<i;q++) mSorted[q]=mSort[q];

clrscr();

for(q=0;q<i;q++){
 for(b=0;b<j;b++)
  scanf("%d",&mSort[q][b]);
 printf("\n");
}



for(q=0;q<i-1;q++){
 b=0;while(*(mSorted[q]+b)==*(mSorted[q+1]+b)&&b++<j);

 if(*(mSorted[q]+b)>*(mSorted[q+1]+b)){
  tSwap=mSorted[q];
  mSorted[q]=mSorted[q+1];
  mSorted[q+1]=tSwap;
  q=-1;
 }
}

for(q=0;q<i;q++){
 for(b=0;b<j;b++)
  printf("%d ",*(mSorted[q]+b));
 printf("\n");
}
return 0;
}