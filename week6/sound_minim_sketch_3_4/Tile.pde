class Tile {

  color c;
  float xpos;
  float ypos;

  Tile(color tempC, float tempXpos, float tempYpos) {
    c=tempC;
    xpos=tempXpos;
    ypos=tempYpos;
  }


  void display(){
    stroke(75);
    strokeWeight(2);
    fill(c);
    rect(xpos,ypos,800,100);
  }
  
  
  void rolloverDisplay(){
    stroke(0);
    strokeWeight(2);
    fill(random(255),random(255),random(255));
    rect(xpos,ypos,800,100);
  }
}

