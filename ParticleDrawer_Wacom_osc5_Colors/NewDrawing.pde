//pertains to what I am actually drawing with pen

class NewDrawing {
  //Using this ArrayList to save the vertexes that I'm drawing 
  ArrayList<PVector> points;

  NewDrawing() {
    points  = new ArrayList<PVector>();
  }

  void update() {
    //whenever mouse is pressed, add the vertex point to the arraylist
    if (mousePressed) {
      points.add(new PVector(mouseX, mouseY));
    }
    
    if (points.size() > 15) {
      points.remove(0); 
    }
    
  }

  void display() {
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

