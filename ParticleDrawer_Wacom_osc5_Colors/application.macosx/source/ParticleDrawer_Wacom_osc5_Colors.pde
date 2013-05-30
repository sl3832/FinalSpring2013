import oscP5.*;
import netP5.*;

int MAXPARTICLES = 100;

OscP5 oscP5;
NetAddress myRemoteLocation;

PFont f;



// new drawing class
NewDrawing nd;

// ParticleSystem class
ParticleSystem ps;

import codeanticode.protablet.*;



Tablet tablet;    

float pressure = 0.;

/*
boolean sketchFullScreen() {
 return true;
 }*/

void setup() {
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

void draw() {
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

void sendOSCshit()
{
  OscMessage themess = new OscMessage("stuff");
  themess.add(tablet.getPenX()); 
  themess.add(tablet.getPenY()); 
  themess.add(tablet.getPressure()); 
  themess.add(tablet.getTiltX()); 
  themess.add(tablet.getTiltY()); 
  oscP5.send(themess, myRemoteLocation);
}


