class Background {
  
  PImage current;
  HashMap<Integer, vec> cornerMap = new HashMap<Integer, vec>();
  boolean refresh = true;

  Background(String img) {
    current = loadImage(img);
    current.resize(width,height);
    
  }
  void  update() {
      //image(current,0,0,width,height);
      if (refresh) background(0);
      
     // spinningColors();
  }
  
  void verticalSymmetry() {
      PImage leftHalf = get(0, 0, width/2, height);
      translate(width, 0);
      scale(-1, 1);
      image(leftHalf, 0, 0);
      translate(-width,0);
    
  }
  boolean setUpSpin = true;
  List<vec> allVectors = new ArrayList<vec>();
  Point middlePoint;
  vec v1,v2, v3, v4, v5;
  
  void spinningColors() {
    if(setUpSpin) {
      updateCornerVector();
      middlePoint = new Point(width/2, height/2);
      v1 = new vec(1,2).scaleBy(100);
      v2 = new vec(-.5,-3).scaleBy(100);
      v3 = new vec(.5,-2).scaleBy(100);
            v4 = new vec(1.5,-2).scaleBy(100);

      v5 = new vec(3,-2).scaleBy(100);

      allVectors.add(v1);
      allVectors.add(v2);
      allVectors.add(v3);
      allVectors.add(v4);
      allVectors.add(v5);

      setUpSpin = false;
    }

   middlePoint.show();
   v1.rotateBy(pi/400);
   v2.rotateBy(pi/100);
   v3.rotateBy(-pi/200);
   v4.rotateBy(-pi/150);
   v5.rotateBy(-pi/300);

   int i = 1;   
   Collections.sort(allVectors,vecComparator);
   
   
   boolean firstPass=true;
   vec firstVec =null, prevVec =null;
   int firstSec =0, prevSec =0;
   currentFill = 0;
   for(vec x : allVectors) {
     int sector = scaleToEdge(x);
     x.showAt(middlePoint);
     x.label("   "+ sector+ "  " + i,middlePoint);
     i++;
     if(!firstPass) {
       
       fillArea(prevVec, prevSec, x, sector, updateFill());
       prevVec = x;
       prevSec = sector;    
     }  else {
       firstVec = x;
       firstSec = sector;
       prevVec = x;
       prevSec =sector;
       firstPass= false;
     }
   }
   fillArea(prevVec, prevSec, firstVec, firstSec, updateFill());

  }
  boolean toggleRefresh() {
    refresh = !refresh;
    return refresh;
  }
  
  void fillArea(vec vec1, int ar1, vec vec2, int ar2, color fill) {
    PShape s;  // The PShape object
    s = createShape();
    s.beginShape();
    s.fill(fill);
    s.stroke(pink);
    s.vertex(0, 0);
    s.vertex(vec1.x, vec1.y); 
    addCorners(s,ar1,ar2);
    s.vertex(vec2.x, vec2.y);
    s.vertex(0,0);
    s.endShape(CLOSE);  
    shape(s, middlePoint.x, middlePoint.y);

  }
  
  void addCorners(PShape s, int ar1, int ar2) {
    for (vec x : getCorners(ar1, ar2)) {
      if (x != null) {
        s.vertex(x.x, x.y);
      }
    }
  }
  
  vec[] getCorners( int ar1, int ar2) {
    vec[] returnArray = new vec[4];
    int corner = ar1;
    int count = 0;
    while( corner != ar2) {
      returnArray[count] = cornerMap.get(corner);
      count++;
      corner++;
      if (corner == 4) corner = 0;
    }
    return returnArray;
  }


vec upLeft, upRight, downLeft, downRight;

void updateCornerVector() {
       upLeft = new vec(-width/2, -height/2);
       upRight = new vec(width/2, -height/2);
       downLeft = new vec(-width/2, height/2);
       downRight = new vec(width/2, height/2);
       cornerMap.put(0, upRight);
       cornerMap.put(1, downRight);
       cornerMap.put(2, downLeft);
         cornerMap.put(3, upLeft);
  }
  
  int scaleToEdge(vec theVec) {
  
    if (theVec.isBetween(upLeft,upRight) || theVec.isBetween(downRight,downLeft)) {
      float amount = Math.abs(height / (theVec.y * 2));
      S2(amount,theVec);
      return (theVec.isBetween(upLeft,upRight)) ?  0 :  2;
    } else {
      float amount = Math.abs(width / (theVec.x * 2));
      S2(amount,theVec);
       return (theVec.isBetween(upRight,downRight)) ?  1 :  3;
    }
  }
  
  
  
  public  Comparator<vec> vecComparator = new Comparator<vec>() {
    vec mesVec = new vec(1,0);
    public int compare(vec vec1, vec vec2) {
         
      float a1 =angle(mesVec, vec1);
      float a2 =angle(mesVec, vec2);
    
      if (a1<a2) {
        return -1;
      } else {
        return 1;
      }
    
    }
   
  };
  int currentFill = 0;
  color[] fillArray = {blue,green,pink};
  color updateFill() {
    fill(fillArray[currentFill]);
    color returnCol = fillArray[currentFill];
    currentFill++;
    if (currentFill == fillArray.length) currentFill = 0;
    return returnCol;
  }
}