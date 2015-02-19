/*The Eighth point is located halfway between the two points 
where 

an arc, 

with its center at the first point,
and with a radius equal to the distance between the first and the seventh points,

would cross a line from the upper right corner to a point halfway 
between the midpoint of the bottom side and the lower right corner.*/

void setup(){
size(800,500);

}


void draw(){
  strokeWeight(1);
  line(800,0,600,500);
  noFill();
  arc(750,250, 200,200, HALF_PI, radians(270));
  
  //Perpindicular bisecting line
//line(550,175,750,250);
 
 
 
 strokeWeight(10);
  //point 1
  point(750,250);
  
  //point 7
  point(750+25,250+96.82);
  
  //point 8
  point(707,233);
  
  
  
  
}


