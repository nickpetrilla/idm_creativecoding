// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers = new Mover[10];
//Attractor a; This was a pipe dream. I want to add an attractor at mouseX/Y
float windNoise = 100;

void setup() {
  size(600, 400);
  smooth();
  randomSeed(1);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(1, 4), random(width), 0);
  }
   //a = new Attractor();
}

void draw() {
  background(0);

  for (int i = 0; i < movers.length; i++) {
//made PVectors in opposite directions
    PVector rightWind = new PVector(noise(windNoise)*.9, 0);
    PVector leftWind = new PVector(noise(windNoise)*-1.1, 0);
    PVector gravity = new PVector(0, 0.1*movers[i].mass);
    PVector antiGravity = new PVector(0, -0.1*movers[i].mass);

    float c = 0.05;
    PVector friction = movers[i].velocity.get();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);
    movers[i].applyForce(gravity);
    movers[i].applyForce(friction);


//interactivity. Left key = left wind, right key = right wind, up=antigravity
    if (key == CODED) {
      if (keyCode == LEFT) {
        movers[i].applyForce(leftWind);
      } else if (keyCode == RIGHT) {
        movers[i].applyForce(rightWind);
      } else if (keyCode == UP) {
        movers[i].applyForce(antiGravity);
      }
    }
      movers[i].update();
      movers[i].display();
      movers[i].checkEdges();
    }
  }

