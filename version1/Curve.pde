class Curve{
 PVector points[];
 color C;
 int A;
 
 int speed=6;
 int m=6;
 int months[]= new int[m];
 int totalMonth;
 int end=0;
 float scale2=0;
 Curve(TableRow r,float max,color c, int a){
   points= new PVector[r.getColumnCount()];
  for(int i=0;i<r.getColumnCount();i++){
   float y=map(r.getFloat(i),0,max,0,height/2);
   float x=map(i+1,0,r.getColumnCount(),(width/2)-(height/2),(width/2)+(height/2));
   PVector p=new PVector(x,y);
   points[i]=p;
  }
  C=c;
  A=a;
  totalMonth=r.getColumnCount();
  for(int i=m-1;i>=0;i--){months[i]=i+1;
      points[i+1].x=map(i+1,0,m,(width/2)-(height/2),(width/2)+(height/2));}
 }
 
 void display(){
  fill(C);
  noStroke();
  
  beginShape();
  curveVertex((width/2)-(height/2),height/2);
  curveVertex((width/2)-(height/2),height/2);
  
  for(int j=0;j<months.length;j++){
      int i=months[j];
      float scale=map(points[i].x,(width/2)-(height/2),width/2,0,1);
      if(points[i].x>width/2){scale=map(points[i].x,width/2,(width/2)+(height/2),1,0);}
      if(start==false){scale2=0;}else if(scale2<1){scale2+=0.01;}else{scale2=1;}
      if(End==true){scale2=0;}
      float y=scale2*points[i].y*sin(radians(A))*scale+height/2;
      curveVertex(points[i].x,y);
      points[i].x+=speed;}
         
  curveVertex((width/2)+(height/2),height/2);
  curveVertex((width/2)+(height/2),height/2);
  endShape();
  
  rot();
  if(points[months[m-1]].x>(width/2)+(height/2)){next();}
  if(iSolar>0&&C==so){userLine(iSolar,color(255,255,0,200));}
  if(iWind>0&&C==wi){userWind(iWind,color(255,0,255,200));}
  if(iWasser>0&&C==wa){userWasser(iWasser,color(0,255,255,200));}
}
void next(){
 
   if(end==totalMonth-1){end=0;} else{end++;}
   int next=end;
   for(int i=m-1;i>=0;i--){
     months[i]=next;
     points[next].x=map(i,0,m,(width/2)-(height/2),(width/2)+(height/2));
     if(next==totalMonth-1){next=0;}else{next++;}
   }
}
void rot(){
 if(A<360){A++;}
 else{A=0;}
}

void userLine(float u,color c){
 int st=6;
 noFill();
 stroke(c);
 strokeWeight(0);
 for(int k=0;k<u*100;k+=40){
 beginShape();
  vertex((width/2)-(height/2),height/2);
  vertex((width/2)-(height/2),height/2);
  
  for(int j=0;j<months.length;j++){
      int i=months[j];
      float scale=map(points[i].x,(width/2)-(height/2),width/2,0,1);
      if(points[i].x>width/2){scale=map(points[i].x,width/2,(width/2)+(height/2),1,0);}
      float y=(points[i].y-k)*u*sin(radians(A))*scale+height/2;
       strokeWeight(st*scale);
      vertex(points[i].x,y);
      points[i].x+=(speed/5)*u;}
         
  vertex((width/2)+(height/2),height/2);
  vertex((width/2)+(height/2),height/2);
  endShape(); }
}

void userWind(float u,color c){
 int st=2;
 noFill();
 stroke(c);
 strokeWeight(0);
 for(int k=0;k<3;k++){
 beginShape();
  curveVertex((width/2)-(height/2),height/2);
  curveVertex((width/2)-(height/2),height/2);
  
  for(int j=0;j<months.length;j++){
      int i=months[j];
      float scale=map(points[i].x,(width/2)-(height/2),width/2,0,1);
      if(points[i].x>width/2){scale=map(points[i].x,width/2,(width/2)+(height/2),1,0);}
      int kk=30;
      if(k==1&&j%2==0){kk=-30;}
      if(k==2&&j%2==1){kk=-10;}
      if(k==2&&j%2==0){kk=10;}
      float y=(points[i].y-(k*kk))*u*sin(radians(A))*scale+height/2;
      strokeWeight(st);
      curveVertex(points[i].x,y);
      points[i].x+=(speed/5)*u;}
         
  curveVertex((width/2)+(height/2),height/2);
  curveVertex((width/2)+(height/2),height/2);
  endShape(); }
}

void userWasser(float u,color c){

 fill(c);
 noStroke();
  
  for(int j=0;j<months.length;j++){
      int i=months[j];
      float scale=map(points[i].x,(width/2)-(height/2),width/2,0,1);
      if(points[i].x>width/2){scale=map(points[i].x,width/2,(width/2)+(height/2),1,0);}
      float y=points[i].y*u*sin(radians(A))*scale+height/2;
      float offset=cos(radians(points[i].y))*70*scale;
      //println(offset);
      ellipse(points[i].x+offset,y,30*scale,30*scale);
      ellipse(points[i].x-offset,y,30*scale,30*scale);
      points[i].x+=(speed/5)*u;} 
}
}