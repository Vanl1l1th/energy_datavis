class Curve{
 PVector points[];
 color C;
 float colorChange=255;
 int A;
 int offSet=160;
 ArrayList<Segment> sList;
 
 float speed=1;
 int m=6;
 int months[]= new int[m];
 int totalMonth;
 int end=0;
 
 float Off=0;
 int speedOff=4;
 float maxOff=0;
 String id;
 
 Curve(TableRow r,float max,color c, int a,String st){
   id=st;
   sList= new ArrayList<Segment>();
  for(int i=0;i<r.getColumnCount()-1;i++){
   float ymin=map(r.getFloat(i),0,max,0,height/2);
   float xmin=map(i+1,0,r.getColumnCount(),(width/2)-(height/2)-offSet,(width/2)+(height/2));
   float ymax=map(r.getFloat(i+1),0,max,0,height/2);
   float xmax=map(i+2,0,r.getColumnCount(),(width/2)-(height/2)-offSet,(width/2)+(height/2));
   sList.add(new Segment(xmin,xmax,ymin,ymax));
  }
  C=c;
  A=a;
  totalMonth=r.getColumnCount()-1;
  for(int i=m-1;i>=0;i--){months[i]=i;
      sList.get(i).minX=map(i,0,m,(width/2)-(height/2)-offSet,(width/2)+(height/2));
      sList.get(i).maxX=map(i+1,0,m,(width/2)-(height/2)-offSet,(width/2)+(height/2));}
 }
 
 void display(){
  fill(C);
  noStroke();
  
  float lastmax=0;
  
  for(int j=0;j<months.length;j++){
      int i=months[j];
      //if(j>0){sList.get(i).minY=lastmax;}
      float scale=map(sList.get(i).minX,(width/2)-(height/2),width/2,0,1);
      if(sList.get(i).minX-100>width/2){scale=map(sList.get(i).minX,width/2,(width/2)+(height/2),1,0);}
        float ymin=sList.get(i).minY*sin(radians(A))*scale+height/2;
        
        float scale2=map(sList.get(i).maxX,(width/2)-(height/2),width/2,0,1);
      if(sList.get(i).maxX>width/2){scale2=map(sList.get(i).maxX,width/2,(width/2)+(height/2),1,0);}
        float ymax=sList.get(i).maxY*sin(radians(A))*scale2+height/2;
      //if(i%2==0){Off=-1*Off;}  
      if(j==0){sList.get(i).display(ymin,ymax,Off,int(maxOff/12));}
      else{sList.get(i).display(lastmax,ymax,Off,int(maxOff/12));}
      sList.get(i).minX+=speed;
      sList.get(i).maxX+=speed;
      lastmax=ymax;
    }
  
  rot();
  off();
  if(sList.get(months[m-1]).minX>(width/2)+(height/2)){next();}
  if(id=="solar"){maxOff=iSolar; colorChange=int(map(iSolar,0,130,255,0)); C=color(255,255,colorChange,100); so=C;}
  if(id=="wind"){maxOff=iWind;  colorChange=int(map(iWind,0,130,255,0)); C=color(255,colorChange,255,99); wi=C;}
  if(id=="wasser"){maxOff=iWasser;colorChange=int(map(iWasser,0,130,255,0)); C=color(colorChange,255,255,50); wa=C;}
}

void off(){
  if(Off>=maxOff){speedOff=int(random(-3,-5));}
  if(Off<=(-1)*maxOff){speedOff=int(random(3,5));}
  
 //if(maxOff>0){ Off+=speedOff;}
 if(maxOff<=0){Off=0;}else{Off+=speedOff;}
}

void next(){
 //println("eeee");
if(end==totalMonth-1){end=0;} else{end++;}
   int next=end;
   for(int i=m-1;i>=0;i--){
     months[i]=next; 
     //sList.get(next).minX=map(i,0,m,(width/2)-(height/2),(width/2)+(height/2));
     sList.get(next).minX=map(i,0,m,(width/2)-(height/2)-offSet,(width/2)+(height/2));
     sList.get(next).maxX=map(i+1,0,m,(width/2)-(height/2)-offSet,(width/2)+(height/2));
     if(next==totalMonth-1){next=0;}else{next++;}
   }
}
void rot(){
 if(A<360){A++;}
 else{A=0;}
}

}

class Segment{
 float minX;
 float maxX;
 float minY;
 float maxY;
 float w=15;
 float n=4;
 
 Segment(float minx,float maxx, float miny, float maxy){
  minX=minx; maxX=maxx; minY=miny; maxY=maxy; 
 }
 
 void display(float ymin, float ymax, float off,int nn){
   if(nn>4){n=nn;}else{n=4;}
   float xd=abs(maxX-minX)/n;
   float yd=abs((ymax-ymin))/n;
   if(ymin>ymax){yd=yd*-1;}
  for(int i=0;i<n;i++){
    if(minX+(xd*i)>(width/2)-(height/2)&&minX+(xd*i)<(width/2)+(height/2)){
    beginShape();
    vertex(minX+(xd*i),height/2);
    vertex(minX+(xd*i)+off,ymin+(i*yd));
    vertex(minX+w+(xd*i)+off,ymin+(i*yd));
    vertex(minX+w+(xd*i),height/2);
    endShape();}
  }
 }
  
}