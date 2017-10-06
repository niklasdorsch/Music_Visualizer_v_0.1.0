class Rotation extends Element {
  Point p1,p2;
  float rotationVariable = 1;
  float radius =20;
  float currentPosition = 0;
  float speed = 1;
  boolean clockwise = true;
  float offset = 0;
  
  
  Rotation(Point p1, Point p2) {
    this.p1 =p1;
    this.p2 =p2;
    
  }

  void update() {
     currentPosition = (float) time.getCount() / time.max + offset;

     float counter =(clockwise) ? 1 : -1;
     counter = counter * speed;
     float[] x = rotateBy(p1.x+radius, p1.y, p1.x, p1.y, 2*PI*currentPosition*counter);
     p2.setTo(x[0],x[1]);
     if (currentPosition  -offset > 1) {
       currentPosition =0;
     }

  }
  
  void addRadius(int x) {
    radius +=x;
  }
  boolean toggleClockwise() {
   clockwise = (clockwise) ? false : true;
   return clockwise;
  }
  
  float changeSpeed(float x) {
    speed += x;
    return speed;
  }
  float changeOffset(float x) {
    offset +=x;
    if (offset < 0) {
      offset = .99;
    }
    if (offset > .99) {
      offset = 0;
    }
      
    return offset;
  }
  
  Point[] returnPoints() {
    Point[] x = new Point[2];
    x[0] = p1;
    x[1] = p2;
    return x;
  }
  
  
  
  
  float[] rotateBy(float pointX, float pointY, float originX, float originY, float radians) {
    float newX = pointX -originX;
    float newY = pointY -originY; //move to origin
    float newX2 = newX * cos(radians) - newY * sin(radians);
    float newY2 = newY * cos(radians) + newX * sin(radians); //rotate
    float[] x = {(newX2+originX), (newY2+originY)};
    return x;
  }
}