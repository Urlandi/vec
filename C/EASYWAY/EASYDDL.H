#ifndef _EASYDISKDLG_
#define _EASYDISKDLG_
#include <dir.h>
#include <alloc.h>
#include <string.h>
#include "easyfcel.h"
short filelist(struct border_style *getparam, char* selfile,char* strtpath,int attr){
 struct ffblk O;
 struct list_item *fls,*tp;
 char *listfile,dir[512];
 int done,at;
 long numfile;
 selfile[0]=0;
 dir[0]=getdisk()+'A';
 dir[1]=':';
 dir[2]='\\';
 dir[3]=0;
 getcurdir(0,&dir[3]);
 while(1){
  fls=NULL;
  if(findfirst(strtpath,&O,attr))return 1;
  at=O.ff_attrib&FA_LABEL;
  if(!at&&strcmp(O.ff_name,".")){
   if((listfile=(char*)malloc(length(O.ff_name)+1))==NULL)return -1;
   strcpy(listfile,O.ff_name);
   at=O.ff_attrib&FA_DIREC;
   if(at)numfile=0;else numfile=1;
   fls=addmenu(fls,(char*)listfile,numfile,COMMAND,NULL);
  }
  do{
   done=findnext(&O);
   at=O.ff_attrib&FA_LABEL;
   if(at||!strcmp(O.ff_name,".")||done) continue;
    if((listfile=(char*)malloc(length(O.ff_name)+1))==NULL)return -1;
    strcpy(listfile,O.ff_name);
    at=O.ff_attrib&FA_DIREC;
    if(at)numfile=0;else numfile=1;
    fls=addmenu(fls,(char*)listfile,numfile,COMMAND,NULL);
  }while(!done);
  if((numfile=listmenu(getparam,fls,MENU))==0)break;
  tp=poslist(fls,numfile-1);
  if(((struct menu_item*)tp->data)->ret==0)
   chdir(((struct menu_item*)tp->data)->title);
  else
   strcpy(selfile,((struct menu_item*)tp->data)->title);
  tp=movelist(fls,FIRST);
  do{
   free(((struct menu_item*)tp->data)->title);
  }while((tp=movelist(tp,NEXT))!=NULL);
  erasemenu(fls);
  if(selfile[0]!=0)break;
 }
 setdisk(dir[0]-'A');
 chdir(dir);
 return 0;
};
#endif