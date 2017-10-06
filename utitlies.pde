float d(Point P, Point Q) {
  return sqrt(d2(P, Q));
}                                                   
float d2(Point P, Point Q) {
  return sq(Q.x-P.x)+sq(Q.y-P.y);
}
float angle (Point U, Point V) 
{
  return acos(dot(U, V)/(d(origin, U)*d(origin, V)));
} 
float anglePoints (Point A, Point B, Point C, Point D) 
{
  Point U = new Point (B.x-A.x, B.y-A.y);
  Point V = new Point (D.x-C.x, D.y-C.y);
  return acos(dot(U, V)/(d(origin, U)*d(origin, V)));
} 
float dot(Point U, Point V) {
  return U.x*V.x+U.y*V.y;
}                                                     // dot(U,V): U*V (dot product U*V)
float det(Point U, Point V) {
  return dot(R(U), V);
} 
Point R(Point V) {
  return new Point(-V.y, V.x);
};                                                             // V turned right 90 degrees (as seen on screen)
Point R(Point Q, float a, Point C)
{
  float dx=Q.x-C.x, dy=Q.y-C.y, c=cos(a), s=sin(a); 
  return new Point(C.x+c*dx-s*dy, C.y+s*dx+c*dy);
};  // Q rotated by angle a around point C

Point L(Point U, Point V, float s) {
  return new Point(U.x+s*(V.x-U.x), U.y+s*(V.y-U.y));
};                      // (1-s)U+sV (Linear interpolation between vectors)

Point project(Point U, Point V, float t) { 
  return new Point (U.x + t * (V.x-U.x), U.y + t * (V.y-U.y));
};


float minArrayVal(float[] arr) {
  float min=arr[0];
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] < min) {
      min = arr[i];
    }
  }
  return min;
}
float maxArrayVal(float[] arr) {
  float max=arr[0];
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] > max) {
      max = arr[i];
    }
  }
  return max;
}

void pen(color c, float w) {stroke(c); strokeWeight(w);}
// projection on line
boolean projectsBetween(Point P, Point A, Point B) {return dot(V(A,P),V(A,B))>0 && dot(V(B,P),V(B,A))>0 ; };
float disToLine(Point P, Point A, Point B) {return abs(det(U(A,B),V(A,P))); };
Point projectionOnLine(Point P, Point A, Point B) {return P(A,dot(V(A,B),V(A,P))/dot(V(A,B),V(A,B)),V(A,B));}
float triangleArea(Point A, Point B, Point C) 
  {
  return dot(R(V(A,B)),V(A,C)) / 2; 
  }
  
  
  
 class Line {
  float x1,x2,y1,y2;

  color col = white;
  Line(float x1, float y1, float x2, float y2,color col) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.col = col;
    count++;
  }
  void make(){
    stroke(col);
    line(x1,y1,x2,y2);
  }

}