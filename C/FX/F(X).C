#include <graphics.h>
#include <conio.h>
#include <math.h>

#define F 2*cos(X*X)*(1-2*X*X) /*(2*X*cos(X*X))*/
#define B (0)

#define F11 (0)
#define F12 (0)
#define B1 (-1)

#define F2 (0)
#define B2 (-1)

#define S 0.001
#define M 40
int main(void)
{
int x=9,y=2;
double X;
initgraph(&x,&y,"c:\\langs\\bc\\bgi");

line(320,1,320,480);
line(1,240,640,240);


for(X=-302;X<320;X+=S)
if (!B) putpixel(X*M+320,240-F*M,12);

for(X=-320;X<320;X+=S)
if (!B1) putpixel(F11*M+320,240-F12*M,12);

for(X=-320;X<320;X+=S)
if (!B2) putpixel(F2*cos(X)*M+320,240-F2*sin(X)*M,12);

getch();
closegraph();
return 0;
}