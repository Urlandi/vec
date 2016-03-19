#include <stdio.h>
#include <string.h>
#include <conio.h>
typedef char string[256];
int chars2string(char *str,string passtr);
void string2chars(string passtr,char *str);
void writeln_(string passtr);

int main(void){
 char t[]="HELLO WORLD. PASCAL - THE BEST PROGRAM LANGUAGE";
 string f;
 clrscr();

 if(!chars2string(t,f)){
  printf("String OUT >255");
  return -1;
 }
 string2chars(f,t);

 printf("Print ASCIIZ string - printf()\n-> %s\n",t);
 printf("Print PASCAL string - printf()\n-> %s\n",f);
 printf("Print PASCAL string - WriteLn\n-> ");
 writeln_(f);
 return 0;
}

int chars2string(char *str,string passtr){
 unsigned short int count;
 passtr[0]=strlen(str);
 if (strlen(str)<256)
  for(count=1;count<=passtr[0];count++) passtr[count]=str[count-1];
 else
  return 0;
 return 1;
}
void string2chars(string passtr,char *str){
 unsigned short int count;
 for(count=1;count<=passtr[0];count++) str[count-1]=passtr[count];
 str[count-1]='\0';
}
void writeln_(string passtr){
 unsigned short int count;
 for(count=1;count<=passtr[0];count++) putchar(passtr[count]);
 printf("\n");
}