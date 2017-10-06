class FreqLine extends Element{
  
  int num=  0;
  int bottomCutoff=100;
  int topCutoff = 100;
  Point startP , endP;
    
  
  FreqLine(Point p1, Point p2) {
   startP = p1;
   endP = p2;
    


 }
  void update() {
    AudioBuffer buff = player.left();
    float x1 = map( 0, 0, player.bufferSize(), startP.x, endP.x );
    float y1 = map( 0, 0, player.bufferSize(), startP.y, endP.y );
    float scale1 = buff.get(0)*100;
    stroke(color(red,green,blue));
    vec dirVec = new vec ((-1) *( endP.y - startP.y),endP.x - startP.x);
    dirVec.normalize();
    int buffsize = player.bufferSize();
    for (int i = 0; i < buffsize - 1; i++) {
      float x2 = map( i+1, 0, buffsize, startP.x, endP.x );
      float y2 = map (i+1, 0, buffsize, startP.y, endP.y );
      float scale2 = buff.get(i+1)*100;
      //stroke(currentImage.get((int)map(x1, 0, width, 0, currentImage.width), (int) map((lineLevel+ player.left.get(i)*500), 0, height, 0, currentImage.height)));
      line( x1 + scale1 *dirVec.x, y1 + scale1 *dirVec.y, x2 + scale2 *dirVec.x, y2 + scale2 *dirVec.y);
      x1=x2; y1=y2; scale1 = scale2;
    }
  }
  Point[] returnPoints() {
    Point[] x = new Point[2];
    x[0] = startP;
    x[1] = endP;
    return x;
  }

  
  
}