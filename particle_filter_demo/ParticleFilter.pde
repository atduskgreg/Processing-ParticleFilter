class ParticleFilter {
  int numParticles = 4000;
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
  
  float weight(float[] sensors){
    float prob = 1;
    for(int i = 0; i < sensors.length; i++){
      float distance = sqrt(pow(sensors[i], 2));
      prob *= gaussian(distance, 5, sensorReadings[i]);
    }
    return prob;
    
  }


  void draw() {
    pushStyle();
    fill(255,0,0);
    
    for (int i = 0; i < numParticles; i++) {
      Robot p = particles.get(i);
      float w = weight(p.sense(false));  
      
 
      w = map(w, 0, 0.000001, 1,2);
        
      ellipse(p.x, p.y, w,w);
    }
    popStyle();
  }
}

float gaussian(float mu, float sigma, float x){
  return exp(-pow(mu - x,2) / pow(sigma,2) / 2.0) / sqrt(2.0 * PI * pow(sigma,2));
}
