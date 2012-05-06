import java.awt.Rectangle;
import java.awt.geom.Line2D;

ArrayList<Rectangle> boundaries;
Robot robot;
ParticleFilter particleFilter;

void setup() {
  size(500, 500);
  boundaries = new ArrayList();
  
  // border
  boundaries.add(new Rectangle(0,0, width, 10));
  boundaries.add(new Rectangle(0,10, 10, height));
  boundaries.add(new Rectangle(10,height-10, width-10, 10));
  boundaries.add(new Rectangle(width-10,10, 10, height-20));
  
  
  boundaries.add(new Rectangle(120, 0, 30, 100));
  boundaries.add(new Rectangle(0, 160, 200, 30));
  boundaries.add(new Rectangle(350, 0, 30, 180));
  boundaries.add(new Rectangle(250, 250, 30, 250));

  robot = new Robot(int(random(0, width)), int(random(0, height)));
  particleFilter = new ParticleFilter(width, height);
}

void draw() {
  background(255);
  drawBoundaries();
  robot.draw();
  float[] sensors = robot.sense(true);
  particleFilter.update(sensors);
  
  particleFilter.draw();

  //println("left: " + sensors[0] + "\tright: " +  sensors[1] + "\tup: " +  sensors[2] + "\tdown: " +  sensors[3]);
}

void drawBoundaries() {
  fill(0);
  noStroke();
  for (int i = 0; i < boundaries.size(); i++) {
    Rectangle boundary = boundaries.get(i);
    rect(boundary.x, boundary.y, boundary.width, boundary.height);
  }
}



PVector lineRectIntersect(Line2D l, Rectangle r) {
  float x1 = (float)l.getX1();
  float y1 = (float)l.getY1();
  float x2 =  (float)l.getX2();
  float y2 = (float)l.getY2();

  float x3 = r.x;
  float y3 = r.y;
  float x4 = r.x + r.width;
  float y4 = r.y + r.height;

  float bx = x2 - x1; 
  float by = y2 - y1; 
  float dx = x4 - x3; 
  float dy = y4 - y3;
  float b_dot_d_perp = bx * dy - by * dx;
  if (b_dot_d_perp == 0) {
    return null;
  }
  float cx = x3 - x1;
  float cy = y3 - y1;
  float t = (cx * dy - cy * dx) / b_dot_d_perp;
  if (t < 0 || t > 1) {
    return null;
  }
  float u = (cx * by - cy * bx) / b_dot_d_perp;
  if (u < 0 || u > 1) { 
    return null;
  }
  return new PVector(x1+t*bx, y1+t*by);
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == UP){
      robot.y -= robot.velocity;
    }
    if(keyCode == DOWN){
      robot.y += robot.velocity;
    }
    if(keyCode == LEFT){
      robot.x -= robot.velocity;
    }
    
     if(keyCode == RIGHT){
      robot.x += robot.velocity;
    }
  }
}

