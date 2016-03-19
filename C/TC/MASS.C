#include <conio.h>
#include <time.h>
#include <stdlib.h>

void printmatrix(int *matrix,short m,short n,short k1,short k2);
void sortmatrix(int *matrix,short m,short n);
void inputmatrix(int **matrix,short *m,short *n);
void swapvar(int *x1,int *x2);
void stop(int **matrix);

void main(void){
int *hilo,s,c,c1,i,j;
short k1,k2,m,n;

textmode(64);
clrscr();
gotoxy(21,1);
textcolor(13);
_setcursortype(_SOLIDCURSOR);
cprintf("\"THE MATRIX HAS YOU\" (c) NEO's COMPUTER\n\r");
window(1,2,80,50);
randomize();
while(1){
 hilo=NULL;
 c=-32768;
 c1=32767;
 inputmatrix(&hilo,&m,&n);
 textcolor(15);
 cprintf("Source MATRIX %dx%d:\n\r",m,n);

 for(i=0;i<n;i++){
  s=0;
  for(j=0;j<m;j++)
   s+=*(hilo+j*n+i);
  if(s>c){
   c=s;
   k1=i;
  }
  if(s<c1){
   c1=s;
   k2=i;
  }
 }

 printmatrix(hilo,m,n,k1,k2);
 for(j=0;j<m;j++) swapvar(hilo+j*n+k2,hilo+j*n+k1);
 textattr(0xF);cprintf("Changed MATRIX                     \n\r");
 printmatrix(hilo,m,n,k2,k1);

 textattr(0xF);cprintf("Sorted MATRIX                      \n\r");
 sortmatrix(hilo,m,n);
 printmatrix(hilo,m,n,-2,-2);
 free(hilo);
 clrscr();
}
}

void printmatrix(int *matrix,short m,short n,short k1,short k2){
char a;
int i;

for(i=0;i<m*n;i++){
 if(k1==i-(i/n)*n)textattr(0xE);
 else if(k2==i-(i/n)*n)textattr(0xB);
 else textcolor(10);
 cprintf("%6d",*(matrix+i));
 if((i+1)%n==0)cprintf("\n\r");
 }

textattr(0x4);
cprintf("Press ENTER to NEXT or ESC for EXIT");

do{
a=getch();
if (a==27)stop(&matrix);
}while(a!=13&&a!=27);
cprintf("\r");
}

void sortmatrix(int *matrix,short m,short n){
int i;
for(i=0;i<m*n-1;i++)
 if (*(matrix+i)>*(matrix+i+1)){
  swapvar(matrix+i,matrix+i+1);
  i=-1;
 }
}
void swapvar(int *x1,int *x2){
int c;
c=*x1;
*x1=*x2;
*x2=c;
}
void inputmatrix(int **matrix,short *m,short *n){
int i;
char a;
short _m,_n;
textattr(0xA);
cprintf("Initialize RANDOM matrix ([Y]/N):");
do{
getch();
a=inportb(0x60);
switch(a){
case 28:
case 21:*m=random(15)+1;
	*n=random(13)+1;
	*matrix=(int*)malloc(*m**n);
	for(i=0;i<*m**n;i++) *(*matrix+i)=random(65536);
	break;
case 49:cprintf("\rВведите размерность матрицы (0<m<16):");
	cscanf("%d",&_m);*m=_m;
	delline();
	cprintf("\rВведите размерность матрицы (0<n<14):");
	cscanf("%d",&_n);*n=_n;
	*matrix=(int*)malloc(*m**n);
	for(i=0;i<*n**m;i++){
	cprintf("Введите элемент матрицы %dx%d (-32769<X<32768):",i/(*n),i-i/(*n)**n);
	cscanf("%d",(*matrix+i));
	delline();
	a=49;
	getch();
	}
	break;
case 1:stop(matrix);
}
}while(a!=21&&a!=49&&a!=28);
cprintf("\r                                 \r");
}
void stop(int **matrix){
if(*matrix!=NULL) free(*matrix);
textmode(3);
cprintf("(c)2001 IVT-162\n\r");
exit(-1);
}