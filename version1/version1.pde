float wind=0;
float solar=0;
float wasser=0;

ArrayList<Curve> curves;

Table Solar;
color so=color(255,255,0,100);
float ySolar=800;
float iSolar=0;
Table Wind;
color wi=color(255,0,255,100);
float yWind=800;
float iWind=0;
Table Wasser;
color wa=color(0,255,255,50);
float yWasser=800;
float iWasser=0;
boolean start=false;
boolean End=false;

void setup(){
  fullScreen(P3D);
  int a=0;
  int aa=0;
  curves=new ArrayList<Curve>();
  
  Solar=loadTable("solar.csv");
  Wind = loadTable("wind.csv");
  Wasser = loadTable("wasser.csv");
  aa=360/((Solar.getRowCount()-1)+(Wind.getRowCount()-1)+(Wasser.getRowCount()-1));
  for(int i=1; i<Solar.getRowCount();i++){
  TableRow rows;
  rows=Solar.getRow(i);
  curves.add(new Curve(rows,1646,so,a));
  a+=aa;}
  
  for(int i=1; i<Wind.getRowCount();i++){
  TableRow rowwi;
  rowwi = Wind.getRow(i);
  curves.add(new Curve(rowwi,12113,wi,a));
  a+=aa;}
  
  for(int i=1; i<Wasser.getRowCount();i++){
  TableRow rowwa;
  rowwa = Wasser.getRow(i);
  curves.add(new Curve(rowwa,29508,wa,a));
  a+=aa;}
  
}

void draw(){
  viz(wind,wasser,solar);
  inputSimulation();
}

void viz(float wi,float wa,float so){
  iSolar=so*1.1; iWind=wi*1.1; iWasser=wa*1.1;
 noStroke();
 background(255); 
 fill(0);
 ellipse(width/2,height/2,height,height);
for(Curve c:curves){if(c.A<180){c.display();}}
for(int i=curves.size()-1;i>=0;i--){
  if(curves.get(i).A>=180){curves.get(i).display();}
} 
}

void inputSimulation(){
 fill(so);
noStroke();
ellipse(50,ySolar,50,50);
fill(wi);
ellipse(100,yWind,50,50);
fill(wa);
ellipse(150,yWasser,50,50);
if(mousePressed){
  if(dist(mouseX,mouseY,50,ySolar)<50){ySolar=mouseY; solar=map(ySolar,800,100,0,1);}
  if(dist(mouseX,mouseY,100,yWind)<50){yWind=mouseY; wind=map(yWind,800,100,0,1);}
  if(dist(mouseX,mouseY,150,yWasser)<50){yWasser=mouseY; wasser=map(yWasser,800,100,0,1);}
}
}

void keyPressed(){
 if(key=='s'){start=true;} 
 if(key=='e'){End=true;} 
}