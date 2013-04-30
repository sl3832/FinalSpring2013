import codeanticode.syphon.*;

PGraphics canvas;
SyphonServer server;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

// new drawing class
NewDrawing nd;

// ParticleSystem class
ParticleSystem ps;

import codeanticode.protablet.*;

Tablet tablet;


void setup() {
  size(displayWidth-5, displayHeight-5,P3D);
  noCursor();

  ps = new ParticleSystem();
  nd = new NewDrawing();

  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress("127.0.0.1", 8000);

  tablet = new Tablet(this);

  canvas = createGraphics(displayWidth, displayHeight, P3D);

  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
 // loadPixels();
  canvas.beginDraw();
canvas.background(0);
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

