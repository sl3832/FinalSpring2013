//drawing a vertex

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  //ArrayList<PVector> points = new ArrayList<PVector>();


  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    location = l.get();
    lifespan = 255.0;

  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display, drawing shapes by vertex points
  void display() {
    
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
  boolean isDead() {
    if (lifespan < 0.0) {
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
