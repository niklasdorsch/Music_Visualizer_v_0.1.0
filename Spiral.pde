
class Spiral extends Element {
  Point A, B, C, D;
  boolean withMusic = false;
  MusicPlayer player;
  boolean reverse = false;
  float tMax = .99, tMin = .025;
      
  Spiral(Point A, Point B, Point C, Point D) {
    this.A = A;
    this.B = B;
    this.C = C;
    this.D = D;
  }

  void withMusic(boolean ifTrue, MusicPlayer player) {
    withMusic =ifTrue;
    this.player = player;
  }
  
  Point[] returnPoints() {
    Point[] x = new Point[4];
    x[0] = A ;
    x[1] = B ;
    x[2] = C ;
    x[3] = D ;
    return x;
  }


  void showSpiralPattern() 
  {
    float a =spiralAngle(A, B, C, D); 
    float m =spiralScale(A, B, C, D);
    Point F = SpiralCenter(a, m, A, C); 
    beginShape();
    color(red,green,blue);
    stroke(color(this.red,this.green,this.blue));
    if (withMusic) {
      int currentMin = 0;
      float[] spectrumVal = player.getSpectrum();
      float min = minArrayVal(spectrumVal);
      int num = player.getSpecSize();
      for (float t=tMin; t<tMax; t+=0.025) {
        Point w = spiralPt(A, F, m, a, t);
        float t2= t;
        if (reverse) {
          t2= tMax - t;
        }
        int index= (int) map(t2, tMin, tMax, 0, num);
        
        int count = 0;
        float total= 0;
        while (currentMin < index) {
          count++;
          currentMin++;
          total+= player.fft.getBand(currentMin) * 8;
        }
        float averageVal = total /count;

        float amount;

        amount = (float) Math.log( averageVal+(1-min) )* t;
        if (amount < 0 ) {
          amount = -amount * 2;
        }
        Point x = L(w, spiralPt(B, F, m, a, t), amount);
        new Edge(w, x).show();
      }
    } else {
      for (float t=tMin; t<tMax; t+=0.05) {
        new Edge(spiralPt(A, F, m, a, t), spiralPt(B, F, m, a, t)).show();
      }
    }
    endShape();
  }
  void update() {
    showSpiralPattern();
    
  }


  float spiralAngle(Point A, Point B, Point C, Point D) {
    return new Edge(A, B).angle( new Edge(C, D));
  }
  float spiralScale(Point A, Point B, Point C, Point D) {
    return d(C, D)/d(A, B);
  }
  Point SpiralCenter(float a, float m, Point A, Point C)  // computes center of spiral
  {
    float c=cos(a), s=sin(a);
    float d = sq(c*m-1)+sq(s*m);
    float ex = c*m*A.x - C.x - s*m*A.y;
    float ey = c*m*A.y - C.y + s*m*A.x;
    float x=(ex*(c*m-1) + ey*s*m) / d;
    float y=(ey*(c*m-1) - ex*s*m) / d;
    return new Point(x, y);
  } 
  Point spiralPt(Point A, Point F, float m, float a, float t)     //  A rotated by at and scaled by s^t wrt G
  {
    return F.lerp(R(A, t*a, F), pow(m, t));
  }
  void setTMax(float x) {
    this.tMax = x;
  }
}