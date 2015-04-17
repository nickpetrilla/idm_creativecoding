//Forces in P5js
//press the arrow keys to add forces to the balls



// moving bodies
var movers = [];

//forces
var rightWind;
var leftWind;
var antiGravity
// liquid
var liquid;

function setup() {
  createCanvas(600, 400);
  reset();
  // liquid object
  liquid = new Liquid(200, 150, 200, 100, 0.1);
}

function draw() {
  background(0);
  
  // Draw water
  liquid.display();

  for (var i = 0; i < movers.length; i++) {
    if (liquid.contains(movers[i])) {
 
      var dragForce = liquid.calculateDrag(movers[i]);
      movers[i].applyForce(dragForce);
    }

    var gravity = createVector(0, 0.1*movers[i].mass);
    rightWind = createVector(.06,0);
    leftWind = createVector (-1.1,0);
    antiGravity =createVector(0,-0.51*movers[i].mass);

    movers[i].applyForce(gravity);


    movers[i].update();
    movers[i].display();
    movers[i].checkEdges()
    
  
  }

  
}



function mousePressed() {
  reset();
  
}

function reset() {
  for (var i = 0; i < 9; i++) {
    movers[i] = new Mover(random(0.5, 3), 40+i*70, 0);
  }
}

function keyPressed(){
  for (var i = 0; i < movers.length; i++){
      if (keyCode === LEFT_ARROW) {
        println("left");
        movers[i].applyForce(leftWind);
      } else if (keyCode === RIGHT_ARROW) {
        movers[i].applyForce(rightWind);
      } else if (keyCode === UP_ARROW) {
        movers[i].applyForce(antiGravity);
      } 
    }
    }


var Liquid = function(x, y, w, h, c) {
  this.x = x;
  this.y = y;
  this.w = w;
  this.h = h;
  this.c = c;
};
  
// Is the Mover in the Liquid?
Liquid.prototype.contains = function(m) {
  var l = m.position;
  return l.x > this.x && l.x < this.x + this.w &&
         l.y > this.y && l.y < this.y + this.h;
};

// Calculate drag force
Liquid.prototype.calculateDrag = function(m) {
  
  var speed = m.velocity.mag();
  var dragMagnitude = this.c * speed * speed;

  var dragForce = m.velocity.copy();
  dragForce.mult(-1);
 
  dragForce.normalize();
  dragForce.mult(dragMagnitude);
  return dragForce;
};
  
Liquid.prototype.display = function() {
  stroke(255);
  fill(255, 51, 153);
  rect(this.x, this.y, this.w, this.h);
};

function Mover(m,x,y) {
  this.mass = m;
  this.position = createVector(x,y);
  this.velocity = createVector(0,0);
  this.acceleration = createVector(0,0);
}

Mover.prototype.applyForce = function(force) {
  var f = p5.Vector.div(force,this.mass);
  this.acceleration.add(f);
};
  
Mover.prototype.update = function() {
  // Velocity changes according to acceleration
  this.velocity.add(this.acceleration);
  // position changes by velocity
  this.position.add(this.velocity);
  // We must clear acceleration each frame
  this.acceleration.mult(0);
};

Mover.prototype.display = function() {
  stroke(0);
  strokeWeight(2);
  fill(0,random(200,255),0);
  ellipse(this.position.x,this.position.y,this.mass*16,this.mass*16);
};

// Bounce off edges of window
Mover.prototype.checkEdges = function() {
  if (this.position.y > height) {
    this.velocity.y *= -.9;
    this.position.y = height;
  } else if (this.position.y < 0) {
    this.velocity.y *= -.9;
    this.position.y = 0;
  } else if (this.position.x > width) {
    this.velocity.x *= -.9;
    this.position.x = width-1;
  } else if (this.position.x < 0) {
    this.velocity.x *= -.9;
    this.position.x = 0+1;
  }
  
};



