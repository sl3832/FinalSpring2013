import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 
import netP5.*; 
import codeanticode.protablet.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ParticleDrawer_Wacom_osc5_Colors extends PApplet {




int MAXPARTICLES = 100;

OscP5 oscP5;
NetAddress myRemoteLocation;

PFont f;



// new drawing class
NewDrawing nd;

// ParticleSystem class
ParticleSystem ps;





Tablet tablet;    

float pressure = 0.f;

/*
boolean sketchFullScreen() {
 return true;
 }*/

public void setup() {
  //size(900,800);
  size(displayWidth, displayHeight);
  

  f = createFont("Geneva", 18);
  textFont(f);


  ps = new ParticleSystem();
  nd = new NewDrawing();

  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress("127.0.0.1", 8000);

  tablet = new Tablet(this);
  frameRate(30);
}

public void draw() {
  background(0);
  noCursor();

  pressure = tablet.getPressure();
  //println(pressure);

  nd.update();
  println(ps.size);
  if (ps.size<MAXPARTICLES) ps.addParticle();
  ps.run();
  nd.display();

  fill(255);
  stroke(255);
  // text(frameRate, 50, 50);

  sendOSCshit();
}

public void sendOSCshit()
{
  OscMessage themess = new OscMessage("stuff");
  themess.add(tablet.getPenX()); 
  themess.add(tablet.getPenY()); 
  themess.add(tablet.getPressure()); 
  themess.add(tablet.getTiltX()); 
  themess.add(tablet.getTiltY()); 
  oscP5.send(themess, myRemoteLocation);
}


//pertains to what I am actually drawing with pen

class NewDrawing {
  //Using this ArrayList to save the vertexes that I'm drawing 
  ArrayList<PVector> points;

  NewDrawing() {
    points  = new ArrayList<PVector>();
  }

  public void update() {
    //whenever mouse is pressed, add the vertex point to the arraylist
    if (mousePressed) {
      points.add(new PVector(mouseX, mouseY));
    }
    
    if (points.size() > 15) {
      points.remove(0); 
    }
    
  }

  public void display() {
    stroke(0);
   // noFill();
  
     if(keyPressed){
      if (key == 'r' || key == 'R'){
        fill(188,57,57,50);
      }else{
         fill(113,242,235,50);
      }
    }
    beginShape();
    for (PVector v : points) {
      curveVertex(v.x, v.y);
     
    }
    endShape();
  }
}

//drawing a vertex

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  //ArrayList<PVector> points = new ArrayList<PVector>();


  Particle(PVector l) {
    acceleration = new PVector(0, 0.05f);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    location = l.get();
    lifespan = 255.0f;

  }

  public void run() {
    update();
    display();
  }

  // Method to update location
  public void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0f;
  }

  // Method to display, drawing shapes by vertex points
  public void display() {
    
    stroke(0, lifespan);
    
    strokeWeight(30 * pressure);
//     println(pressure);
    fill(113,242,235, lifespan);
  if(keyPressed){
      if (key == 'r' || key == 'R'){
        fill(188,57,57,lifespan);
      }else{
        fill(113,242,235, lifespan);
      }
    }
    

    pushMatrix();
    translate(location.x, location.y);
    beginShape();
   // fill(113,242,235, lifespan);
   
    for (PVector v : nd.points) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
  }

  // Is the particle still useful?
  public boolean isDead() {
    if (lifespan < 0.0f) {
      return true;
    } 
    else if (location.y > height)
    {
      return true; 
    }
    else {
      return false;
    }
  }
}
//drawing the duplicates 

class ParticleSystem {
  ArrayList<Particle> particles;
  int size;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }

  public void addParticle() {
   
    PVector spot = new PVector(random(-width,width),random(-height,height));  
    particles.add(new Particle(spot));
  
  }

  public void run() {
    size = particles.size();
    //counting back the loop in the ArrayList location to subtract the dead particles
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "ParticleDrawer_Wacom_osc5_Colors" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
