/*My attempt at Sol Lewitt's Wall Drawing #118:

On a wall surface, any continuous stretch of wall, using a hard pencil, 
place fifty points at random.  

The points should be evenly distributed over the area of the wall.
All of the points should be connected by straight lines.*/


float x=0;
float y=0;

void setup() {
  size(300, 300);
}

void draw() {
  background(0);
  
  stroke(255);
  strokeWeight(5);
  
  //I know this is inefficient!
x=50;
    while (x<width){
    point(x,50);
    point(x,75);
    point(x,100);
    point(x,125);
    point(x,150);
    point(x,175);
    point(x,200);
    point(x,225);
    point(x,250);
    x=x+50;
  }
  //connect on y-axis
  strokeWeight(1);
x=50;
    while (x<width){
    line(x,50,x,250);
    x=x+50;
  }
  
  //connect on x-axis
  strokeWeight(1);
y=50;
    while (y<251){
    line(50,y,250,y);
    y=y+25;
  }
 
  
  
}

