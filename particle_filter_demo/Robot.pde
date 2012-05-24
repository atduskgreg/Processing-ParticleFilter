class Robot {
  float x;
  float y;
  int numSensors;
  int velocity;

  Robot(float x, float y) {
    this.x = x;
    this.y = y;

    numSensors = 4;
    velocity = 10;
  }

  void draw() {
    pushStyle();
    fill(0, 255, 0);
    rectMode(CENTER);
    rect(x, y, 10, 10);
    popStyle();
  }

  float[] sense(boolean doDraw) {
    Line2D[] lines = new Line2D[numSensors];
    // look left
    lines[0] = new Line2D.Float(x, y, x - width, y);   
    // look right
    lines[1] = new Line2D.Float(x, y, x + width, y);   
    // look up
    lines[2] = new Line2D.Float(x, y, x, y - height);   
    // look down
    lines[3] = new Line2D.Float(x, y, x, y + height);   

    float[] result = new float[4];

    for (int i = 0; i < lines.length; i++) {
      Line2D l = lines[i];
      if (doDraw) {
        pushStyle();
        stroke(0, 0, 255);  
        line((float)l.getX1(), (float)l.getY1(), (float)l.getX2(), (float)l.getY2());
        popStyle();

      }
        float closestIntersection = width;
        PVector boundaryIntersection = new PVector();
      
      for (int j = 0; j < boundaries.size(); j++) {
        Rectangle b = boundaries.get(j);
        PVector intersect = lineRectIntersect(lines[i], b);
        if (intersect != null) {
          float distanceFromRobot = intersect.dist(new PVector(x, y));

          if (distanceFromRobot < closestIntersection) {
            boundaryIntersection = intersect;
            closestIntersection = distanceFromRobot;
          }
        }
      }

      result[i] = closestIntersection;
      if (doDraw) {
        pushStyle();
        fill(255, 0, 0);
        ellipse(boundaryIntersection.x, boundaryIntersection.y, 10, 10);
        popStyle();
      }
    }
    return result;
  }

  /*
      def sense(self):
   Z = []
   for i in range(len(landmarks)):
   dist = sqrt((self.x - landmarks[i][0]) ** 2 + (self.y - landmarks[i][1]) ** 2)
   dist += random.gauss(0.0, self.sense_noise)
   Z.append(dist)
   return Z
   */
}

