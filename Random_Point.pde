class RandomPoint extends Element {
  Point p1,p2, randomPoint;
  Random random;
  vec  direction;
  float freedomVal = .2;
  LinkedHashSet<Line> theseLines = new LinkedHashSet<Line>();
  
  RandomPoint(Point p1, Point p2) {
    this.p1 =p1;
    this.p2 =p2;
    this.randomPoint = new Point(p1);
    this.randomPoint.translateTowards(.5,p2);
    this.random =  new Random();
    this.direction = new vec(1,1);
    P.addPointSpecial(randomPoint);
    allPoints.add(randomPoint);
    
  }
  Point ptA, ptB;
  void update() {
    
    if (p1.x > p2.x && p1.y > p2.y) {
      ptA = p1;
      ptB = p2;
    } else {
      ptA = p2;
      ptB = p1;
    }
    vec dir = addDirection(direction);
    direction.add(dir);
    if (randomPoint.x > ptB.x) {
      direction.add(-1 * freedomVal,0);
    }
    if (randomPoint.x < ptA.x) {
      direction.add(1 * freedomVal,0);
    }
    if (randomPoint.y > ptB.y) {
      direction.add(0,-1 * freedomVal);
    }
    if (randomPoint.y < ptA.y) {
      direction.add(0,1 * freedomVal);
    }
    float prevx = randomPoint.x, prevy = randomPoint.y;
    randomPoint.add(direction.normalizeNew().scaleBy(5));
    direction.showAt(randomPoint);
    theseLines.add(new Line(prevx,prevy,randomPoint.x,randomPoint.y,red));
    for (Line line : theseLines) {
      line.make();
    }
      
  }
  
  Point[] returnPoints() {
    Point[] x = new Point[3];
    x[0] = p1;
    x[1] = p2;
    x[2] = randomPoint;
    return x;
  }
  
  
    
  vec addDirection(vec currDir) {
     float vert = random.nextFloat() * pi/4;
     vec x = currDir.clone();
     if (random.nextBoolean()) {
       vert = vert * -1;
     }
     x.rotateBy(vert);
     return x;
     
     
     //float hori = 1 - vert;
     //if (random.nextBoolean()) {
     //  vert *= -1;
     //}
     //if (random.nextBoolean()) {
     //  hori *= -1;
     //}
     //vec x = new vec(vert,hori);
     //if (dot(x,currDir) > 0) {
     //  return x;
     //} else { 
     //  return x.scaleBy(-1);
     //}
  }
}