/*Circuit Bender
 This was my attempt to make an expermential noise show
 come to life in Processing. Turn down the volume and guide your
 mouse over the rows.
 */

//For better documentation, visit http://sites.bxmc.poly.edu/~nicholaspetrilla/creativecode/


//The array of rows that light up when the mouse hovers over them
Tile [] tile = new Tile[9];


/*I commented out anything having to do with the Mover array, for now.
 //Mover[] movers = new Mover[2];
 //float windNoise = 100;
 */
 
 
 import ddf.minim.*;
 import ddf.minim.ugens.*;
 
 Minim minim;
 AudioOutput out;
 
 AudioSample kick;
 AudioSample snare;
 
 void setup() {
 size(800, 600);
 
 //array loop for the columns
 for (int i=0; i<tile.length; i++) {
 tile[i] = new Tile(color (0), 0, i*100);
 }
 
/* //loop for mover array 
 for (int m = 0; m < movers.length; m++) {
 movers[m] = new Mover(random(1, 4), random(width), 0);
 }
 
 */

minim = new Minim(this);
// use the getLineOut method of the Minim object to get an AudioOutput object
out = minim.getLineOut();
smooth();
}

void draw() {
  background(0);

  strokeWeight(6);


  //Setting up the rollover function.
  for (int t=0; t<tile.length; t++) {
    tile[t].display();

    //row 1 rollover
    if (mouseY<100) {
      tile[0].rolloverDisplay();
      stroke(0, 255, 0);
      //playing the notes
      out.playNote( 0.0, 0.5, new SineInstrument( 50 ) );
      // draw the waveforms
      for (int i = 0; i < out.bufferSize () - 1; i++)
      {
        rect( i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50 );
        //line( i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50 );
      }
    } 
    //row 2 rollover
    else if (mouseY>100 && mouseY<200) {
      tile[1].rolloverDisplay();
      stroke(0, 255, 255);
      out.playNote( 0, 2, new SineInstrument( 150) );
      for (int i = 0; i < out.bufferSize () - 1; i++)
      {
        line( i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50 );
        line( i, 100 + out.right.get(i)*50, i+1, 100 + out.right.get(i+1)*50 );
        line( i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50 );
        line( i, 200 + out.right.get(i)*50, i+1, 200 + out.right.get(i+1)*50 );
      }
    } 

    //row 3 rollover
    else if (mouseY>200 && mouseY<300) {
      tile[2].rolloverDisplay();
      stroke(0, 0, 255);
      out.playNote( 0.0, 2.9, new SineInstrument( Frequency.ofPitch( "C5" ).asHz() ) );
      for (int i = 0; i < out.bufferSize () - 1; i++)
      {
        //line( i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50 );
        rect( i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50 );
      }
    } 


    //row 4 rollover
    else if (mouseY>300 && mouseY<400) {
      tile[3].rolloverDisplay();
      stroke(255, 0, 255);
      out.playNote( 0, 0.5, new SineInstrument( Frequency.ofPitch( "E4" ).asHz() ) );
      for (int i = 0; i < out.bufferSize () - 1; i++)
      {
        line( i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50 );
        line( i, 75 + out.left.get(i)*50, i+1, 75 + out.left.get(i+1)*50 );
        line( i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50 );
      }
    } 

    //row 5 rollover
    else if (mouseY>400 && mouseY<500) {
      tile[4].rolloverDisplay();
      stroke(255, 0, 0);
      out.playNote( 0.0, 0.4, new SineInstrument( Frequency.ofPitch( "G6" ).asHz() ) );
      for (int i = 0; i < out.bufferSize () - 1; i++)
      {
        line( i, 25 + out.left.get(i)*50, i+1, 25 + out.left.get(i+1)*50 );
        // line( i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50 );
      }
    } 

    //row 6 rollover
    else if (mouseY>500 && mouseY<600) {
      tile[5].rolloverDisplay();
      stroke(255, 255, 0);
      out.playNote( 0.0, 5, new SineInstrument( Frequency.ofPitch( "A3" ).asHz() ) );
      for (int i = 0; i < out.bufferSize () - 1; i++)
      {
        rect( i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50 );
        rect( i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50 );
      }
    }
  }


  /*for (int i = 0; i < movers.length; i++) {
   //made PVectors in opposite directions
   PVector rightWind = new PVector(noise(windNoise)*.9, 0);
   PVector leftWind = new PVector(noise(windNoise)*-1.1, 0);
   PVector gravity = new PVector(0, 0.1*movers[i].mass);
   PVector antiGravity = new PVector(0, -0.2*movers[i].mass);
   
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
   movers[i].displayMovers();
   
   
   movers[i].checkEdges();
   }
   */
}

