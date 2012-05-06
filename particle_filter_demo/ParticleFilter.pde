class ParticleFilter {
  int numParticles = 1000;
  ArrayList<Robot> particles;
  float[] sensorReadings;

  ParticleFilter(int xRange, int yRange) {
    particles = new ArrayList();
    for (int i = 0; i < numParticles; i++) {
      particles.add(new Robot(int(random(0, xRange)), int(random(0, yRange))));
    }
  }
  
  void update(float[] sensors){
    sensorReadings = sensors;
  }

  void draw() {
    pushStyle();
    fill(255,0,0);
    for (int i = 0; i < particles.size(); i++) {
      Robot p = particles.get(i);
      ellipse(p.x, p.y, 1,1);
    }
    popStyle();
  }
}
