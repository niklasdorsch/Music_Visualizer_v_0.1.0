class FreqCircle extends Element{
  
  int num=  0;
  int bottomCutoff=100;
  int topCutoff = 100;
  float circRadius =20, circRim = 8;
  float centerX =width/2;
  float centerY =height/2;
  float total = num-bottomCutoff-topCutoff;
  float offset = 0;
  PImage currentImage =null;
  boolean useImage = false, hasRadiusPoint = false, byX =false;
  Point center,radius;
    
  
  FreqCircle(MusicPlayer player, Point p, int col)
  {
    num = player.getSpecSize();
    stroke(#FF0000);
    
    center = p;
    updatePoint();
    


    }  
  void makeCircle() {
    updatePoint();
    stroke(color(red,green,blue));
  for (int i = bottomCutoff; i < num-1-topCutoff; i++) {
      float[] x = rotateBy(centerX+circRadius, centerY, centerX, centerY, 2*PI*i/total);
      float[] y = rotateBy(centerX+circRadius+player.fft.getBand(i) * circRim, centerY, centerX, centerY, 2*PI*i/total);
      if (useImage) {
        stroke(currentImage.get((int)map(y[0], 0, height, 0, currentImage.height), (int) map(y[1], 0, height, 0, currentImage.height)));
      } else {
        stroke(color(red,green,blue));
      }
       line(x[0], x[1], y[0], y[1] );
      }
  }
  void updatePoint() {
    centerX = center.x;
    centerY = center.y;
  }
  void update() {
    if (hasRadiusPoint) {
      if (!byX) {
      circRadius = d(center, radius);
      } else {
        circRadius = radius.x - center.x;
      }
      
    }
    makeCircle(); 
  }
  Point[] returnPoints() {
    Point[] x = new Point[1];
    x[0] = center ;
    return x;
  }
  
  void useImage(PImage image) {
    currentImage = image;
    useImage = true;
  } 
  void stopUsingImage(){
    useImage = false;
  }

  float[] rotateBy(float pointX, float pointY, float originX, float originY, float radians) {
      float newX = pointX -originX;
      float newY = pointY -originY; //move to origin
      float newX2 = newX * cos(radians) - newY * sin(radians);
      float newY2 = newY * cos(radians) + newX * sin(radians); //rotate
      float[] x = {(newX2+originX), (newY2+originY)};
      return x;
    }
    
  void makeRadius(Point x, boolean byX) {
    this.radius = x;
    hasRadiusPoint = true;
    this.byX = byX;
  }
  
  
  
}