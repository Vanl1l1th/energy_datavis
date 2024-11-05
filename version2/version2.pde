PShape vizMask;
float wind=0;
float solar=0;
float water=0;

ArrayList<Curve> curves;
Table Solar;
color so=color(255,255,255,100);
float ySolar=800;
float iSolar=0;
Table Wind;
color wi=color(255,255,255,99);
float yWind=800;
float iWind=0;
Table Wasser;
color wa=color(255,255,255,50);
float yWasser=800;
float iWasser=0;

void setup(){
  //size(1500, 1050,P3D);
  fullScreen(P3D);
  vizMask = loadShape("mask.svg");
  vizMask.setFill(color(0,0,0));
  vizMask.scale(vizMask.height / height);
  vizMask.translate((vizMask.width - width) / -2, 0);
  
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
  curves.add(new Curve(rows,1646,so,a,"solar"));
  a+=aa;}
  
  for(int i=1; i<Wind.getRowCount();i++){
  TableRow rowwi;
  rowwi = Wind.getRow(i);
  curves.add(new Curve(rowwi,12113,wi,a,"wind"));
  a+=aa;}
  
  for(int i=1; i<Wasser.getRowCount();i++){
  TableRow rowwa;
  rowwa = Wasser.getRow(i);
  curves.add(new Curve(rowwa,29508,wa,a,"wasser"));
  a+=aa;} 
}

void draw(){
  background(100);
  viz(water,wind,solar);
  //shape(vizMask, 0, 0);
  simulateInput();
}

void viz(float water, float wind, float solar){
  //background(200);
  iWasser=water*200; iWind=wind*200; iSolar=solar*200;
  noStroke(); 
  fill(0);
  ellipse(width/2,height/2,height,height);
  for(Curve c:curves){if(c.A<180){c.display();}}
  for(int i=curves.size()-1;i>=0;i--){
  if(curves.get(i).A>=180){curves.get(i).display();}
  }
}

void simulateInput(){
 fill(so);
noStroke();
ellipse(50,ySolar,50,50);
fill(wi);
ellipse(100,yWind,50,50);
fill(wa);
ellipse(150,yWasser,50,50);
if(mousePressed){
  if(dist(mouseX,mouseY,50,ySolar)<50){ySolar=mouseY; solar=map(ySolar,800,100,0,1);}
  if(dist(mouseX,mouseY,100,yWind)<50){yWind=mouseY; wind=map(yWind,800,100,0,1); }
  if(dist(mouseX,mouseY,150,yWasser)<50){yWasser=mouseY; water=map(yWasser,800,100,0,1); }
} 
}