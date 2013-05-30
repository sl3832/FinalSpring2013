//drawing the duplicates 

class ParticleSystem {
  ArrayList<Particle> particles;
  int size;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
   
    PVector spot = new PVector(random(-width,width),random(-height,height));  
    particles.add(new Particle(spot));
  
  }

  void run() {
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
