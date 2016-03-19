const char *menuline[3]={"Файл","Реализация","Помощь"};
const char *menufile[1]={"Выход"};
const char *menuwork[4]={"Лабораторная N1","Лабораторная N2","Лабораторная N3","Лабораторная N4 "};
const char *menulab4[2]={"Вычисление функции в точке","График функции"};
const char *menuhelp[1]={"О программе"};

struct list_item *mainmenu=NULL,*elements[3],*elementslab4=NULL;
struct border_style menuview,dialogview;
menuview.borderline=0;
menuview.xleftcorner=1;
menuview.xrightcorner=80;
menuview.yleftcorner=1;
menuview.yrightcorner=2;
menuview.bordercolor=15;
menuview.borderbackcolor=1;
menuview.fill=1;
menuview.fillbackcolor=1;
menuview.fillcolor=15;
menuview.shadow=1;
menuview.selectcolor=1;
menuview.selectbackcolor=7;

dialogview.borderline=1;
dialogview.xleftcorner=0;
dialogview.xrightcorner=0;
dialogview.yleftcorner=0;
dialogview.yrightcorner=0;
dialogview.bordercolor=15;
dialogview.borderbackcolor=1;
dialogview.fill=1;
dialogview.fillcolor=15;
dialogview.fillbackcolor=1;
dialogview.shadow=1;
dialogview.selectcolor=1;
dialogview.selectbackcolor=7;

for(q=0;q<3;q++)elements[q]=NULL;

for(q=0;q<1;q++)elements[0]=addmenu(elements[0],(char*)menufile[q],1000+q,COMMAND,NULL);
for(q=0;q<3;q++)elements[1]=addmenu(elements[1],(char*)menuwork[q],2000+q,COMMAND,NULL);
for(q=0;q<1;q++)elements[2]=addmenu(elements[2],(char*)menuhelp[q],3000+q,COMMAND,NULL);
for(q=0;q<2;q++)elementslab4=addmenu(elementslab4,(char*)menulab4[q],2030+q,COMMAND,NULL);
elements[1]=addmenu(elements[1],(char*)menuwork[3],0,SUBMENU,elementslab4);
for(q=0;q<3;q++)mainmenu=addmenu(mainmenu,(char*)menuline[q],0,SUBMENU,elements[q]);
