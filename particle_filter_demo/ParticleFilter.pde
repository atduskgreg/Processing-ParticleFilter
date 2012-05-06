class ParticleFilter {
  int numParticles = 4000;
  ArrayList<Robot> particles;
  float[] sensorReadings;
  float maxWeight;
  float[] weights;

  ParticleFilter(int xRange, int yRange) {
    particles = new ArrayList();
    for (int i = 0; i < numParticles; i++) {
      particles.add(new Robot(int(random(0, xRange)), int(random(0, yRange))));
    }
    weights = new float[numParticles];
  }
  
  void update(float[] sensors){
    sensorReadings = sensors;
    maxWeight = 0;

    for (int i = 0; i < numParticles; i++) {
      Robot p = particles.get(i);
      float w = weight(p.sense(false));  
      weights[i] = w;
     
      if(w > maxWeight){
        maxWeight = w;
      }        
    }
  }
  
  void repopulate(){
    ArrayList<Robot> newParticles = new ArrayList();
    int index = int(random(numParticles));
    float beta = 0.0;
    for(int i = 0; i < numParticles; i ++){
      beta += random(2) * maxWeight;
      while(beta > weights[index]){
        beta -= weights[index];
        index++;
        if(index >= numParticles){
          index = 0;
        }
      }
      
      newParticles.add(particles.get(index));
      
    }
    
    particles = newParticles;
    
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
      float w = weights[i];  

      w = map(w, 0, 0.000001, 1,2);
        
      ellipse(p.x, p.y, w,w);
    }
    
    println("maxWeight: " + maxWeight);
    popStyle();
  }
}

float gaussian(float mu, float sigma, float x){
  return exp(-pow(mu - x,2) / pow(sigma,2) / 2.0) / sqrt(2.0 * PI * pow(sigma,2));
}
