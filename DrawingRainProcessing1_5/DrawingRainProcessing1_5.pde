import processing.opengl.*;
import javax.media.opengl.*;

import java.awt.Robot;

PGraphicsOpenGL pgl;
GL gl;

//import fullscreen.*;
import japplemenubar.*;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

// new drawing class
NewDrawing nd;

// ParticleSystem class
ParticleSystem ps;

//FullScreen fs; 
import processing.opengl.*;
import codeanticode.protablet.*;

Tablet tablet;    

Robot robot;


void setup() {
  //size(900,800);
  size(1400, 1200, P3D);


  ps = new ParticleSystem();
  nd = new NewDrawing();

  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress("127.0.0.1", 8000);

  tablet = new Tablet(this);

  // Create the fullscreen object
  //fs = new FullScreen(this); 

  // enter fullscreen mode
  //fs.enter(); 

  /*try {
    robot = new Robot();

    robot.mouseMove(1280, 800);
  } 
  catch (Exception e) {
  }*/
}

void draw() {
  noCursor();
  background(0);


  nd.update();
  ps.addParticle();

  ps.run();
  nd.display();

  sendOSC();
}

void sendOSC()
{
  OscMessage themess = new OscMessage("stuff");
  themess.add(tablet.getPenX()); 
  themess.add(tablet.getPenY()); 
  themess.add(tablet.getPressure()); 
  themess.add(tablet.getTiltX()); 
  themess.add(tablet.getTiltY()); 
  oscP5.send(themess, myRemoteLocation);
}

