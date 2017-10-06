class Lerp extends Element {
  Point p1,p2,p3;
  float lerpVariable = 1;
  
  Lerp(Point p1, Point p2) {
    this.p1 =p1;
    this.p2 =p2;
    Point x = new Point();
    x.lerpPoint(this.p1,this.p2, this);
    x.lerpAmount =.5;
    this.p3 = x;
    P.addPointSpecial(x);
    allPoints.add(x);
    
  }
  Lerp(Point p1, Point p2, Point p3){
    this.p1 =p1;
    this.p2 =p2;
    this.p3 =p3;
    this.p3.lerpPoint(this.p1,this.p2, this);
    this.p3.lerpAmount =.5;
    allPoints.add(this.p3);
  }
  void update() {
    
  }
  
  Point[] returnPoints() {
    Point[] x = new Point[3];
    x[0] = p1;
    x[1] = p2;
    x[2] = p3;
    return x;
  }
}