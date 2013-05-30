import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

import processing.opengl.*;
import javax.media.opengl.*;

PGraphicsOpenGL pgl;
GL gl;

import fullscreen.*;
import japplemenubar.*;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

// new drawing class
NewDrawing nd;

// ParticleSystem class
ParticleSystem ps;

FullScreen fs; 

import codeanticode.protablet.*;

Tablet tablet;    


void setup() {
  //size(900,800);
  size(1400, 1200, OPENGL);

  ps = new ParticleSystem();
  nd = new NewDrawing();

  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress("127.0.0.1", 8000);

  tablet = new Tablet(this);

  canvas = createGraphics(1400, 1200, OPENGL);

  server = new SyphonServer(this, "Processing Syphon");

  // Create the fullscreen object
  //fs = new FullScreen(this); 

  // enter fullscreen mode
 // fs.enter();
}

void draw() {

  canvas.beginDraw();
  canvas.background(0);
  noCursor();



  nd.update();
  ps.addParticle();

  ps.run();
  nd.display();

  sendOSCshit();

  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
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

