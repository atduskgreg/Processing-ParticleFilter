class ParticleFilter {
  int numParticles = 1000;
  ArrayList<Particle> particles;

  ParticleFilter(int xRange, int yRange) {
    particles = new ArrayList();
    for (int i = 0; i < numParticles; i++) {
      particles.add(new Particle(int(random(0, xRange)), int(random(0, yRange)), 1));
    }
  }

  void draw() {
    pushStyle();
    fill(255,0,0);
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      ellipse(p.x, p.y, 1,1);
    }
    popStyle();
  }
}

class Particle {
  int x;
  int y;
  float weight;
  float sense_noise;

  Particle(int x, int y, int weight) {
    this.x = x;
    this.y = y;
    this.weight = weight;
    sense_noise = 5;
  }
}

