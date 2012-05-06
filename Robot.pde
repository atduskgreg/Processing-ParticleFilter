class Robot {
  int x;
  int y;
  int numSensors;
  int velocity;

  Robot(int x, int y) {
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

  float[] sense() {
    Line2D[] lines = new Line2D[numSensors];
    // look left
    lines[0] = new Line2D.Float(float(x), float(y), float(x - width), float(y));   
    // look right
    lines[1] = new Line2D.Float(float(x), float(y), float(x + width), float(y));   
    // look up
    lines[2] = new Line2D.Float(float(x), float(y), float(x), float(y - height));   
    // look down
    lines[3] = new Line2D.Float(float(x), float(y), float(x), float(y + height));   

    float[] result = new float[4];

    for (int i = 0; i < lines.length; i++) {
      Line2D l = lines[i];
      pushStyle();
      stroke(0, 0, 255);  
      line((float)l.getX1(), (float)l.getY1(), (float)l.getX2(), (float)l.getY2());
      popStyle();

      for (int j = 0; j < boundaries.size(); j++) {
        Rectangle b = boundaries.get(j);
        PVector intersect = lineRectIntersect(lines[i], b);
        if (intersect != null) {
          pushStyle();
          fill(255, 0, 0);
          ellipse(intersect.x, intersect.y, 10, 10);
          popStyle();
        }
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

