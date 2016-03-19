#include <graphics.h>
#include <conio.h>
#include <stdlib.h>
main()
{
int x=9,y=2;
srand(99);
initgraph(&x,&y,"c:\\langs\\bc\\bgi");
do
{
setcolor(random(15)+1);
rectangle(random(640),random(480),random(640),random(480));
}
while (kbhit()==0);
closegraph();
return(0);
}