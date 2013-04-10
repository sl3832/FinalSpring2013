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
  size(displayWidth,displayHeight);
  ps = new ParticleSystem();
  nd = new NewDrawing();

  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress("127.0.0.1", 8000);

  tablet = new Tablet(this);
}

void draw() {
  background(255);
  nd.update();
  ps.addParticle();
  ps.run();

  nd.display();
  
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
