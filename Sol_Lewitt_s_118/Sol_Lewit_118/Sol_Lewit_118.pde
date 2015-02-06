void setup(){
 size(600,500); 
 background(255);
 noFill();
 smooth();
 beginShape(TRIANGLE_STRIP);

for(int i=0; i < 50; i++){
  
  vertex(random(0,width),random(0,height)); 
}
endShape();
 
 
}


void draw (){
  
  
}
