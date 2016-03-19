#ifndef _LISTLIB_
#define _LISTLIB_

#define NULL  0
#define NEXT  1
#define PREV  2
#define LAST  3
#define FIRST 4
struct list_item{
 void* data;
 struct list_item *next;
 struct list_item *prev;
};
struct list_item *movelist(struct list_item *li,short wib){
 if(!li)return NULL;
 switch(wib){
  case NEXT: li=li->next;break;
  case PREV: li=li->prev;break;
  case LAST: while(li->next)li=li->next;
	     break;
  case FIRST:while(li->prev)li=li->prev;
	     break;
  default:li=NULL;
 }
 return li;
};
struct list_item *poslist(struct list_item *li,unsigned long wib){
 unsigned long q;
 if(!li)return NULL;
 li=movelist(li,FIRST);
 for (q=0;q<wib;q++){
  if((li=movelist(li,NEXT))==NULL)return NULL;
 }
 return li;
}
unsigned numlist(struct list_item *li){
 unsigned c=1;
 if(!li)return 0;
 li=movelist(li,FIRST);
 while(li->next){li=li->next;c++;}
 return c;
}
struct list_item *addlist(struct list_item *li){
 if(!li){
  if((li=(struct list_item*)malloc(sizeof(struct list_item)))==NULL)return li;
  li->next=NULL;
  li->prev=NULL;
 }
 else{
  if((li=movelist(li,LAST))==NULL)return li;
  if((li->next=(struct list_item*)malloc(sizeof(struct list_item)))==NULL)return li->next;
  li->next->prev=li;
  li->next->next=NULL;
  li=li->next;
 }
 li->data=NULL;
 return li;
}
struct list_item *dellist(struct list_item *li){
 struct list_item *templist;
 if(!li)return NULL;
 templist=movelist(li,FIRST);
 if(li->prev)li->prev->next=li->next;else templist=li->next;
 if(li->next)li->next->prev=li->prev;
 free(li);
 return templist;
}

short swplist(struct list_item *lif,struct list_item *lis){
 void *tempdata;
 if(!lif||!lis)return 0;
 tempdata=lif->data;
 lif->data=lis->data;
 lis->data=tempdata;
 return 1;
}
#endif