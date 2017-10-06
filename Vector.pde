class vec 
  { 
  float x=0,y=0; 
  
  String toString(){
    return "x:"+x+" y:"+y;
  }
  
 // CREATE
  vec () {};
  
  vec (float px, float py) {x = px; y = py;};
 
 // MODIFY
  vec setTo(float px, float py) {x = px; y = py; return this;}; 
  vec setTo(vec V) {x = V.x; y = V.y; return this;}; 
  vec zero() {x=0; y=0; return this;}
  vec scaleBy(float u, float v) {x*=u; y*=v; return this;};
  vec scaleBy(float f) {x*=f; y*=f; return this;};
  vec scaleByNew(float f) {return new vec(x*f,y*f);};

  vec reverse() {x=-x; y=-y; return this;};
  vec divideBy(float f) {x/=f; y/=f; return this;};
  vec normalize() {float n=sqrt(sq(x)+sq(y)); if (n>0.000001) {x/=n; y/=n;}; return this;};
  vec normalizeNew() {float n=sqrt(sq(x)+sq(y)); if (n>0.000001) return new vec(x/=n, y/=n); return this;};

  vec add(float u, float v) {x += u; y += v; return this;};
  vec add(vec V) {x += V.x; y += V.y; return this;};   
  vec add(float s, vec V) {x += s*V.x; y += s*V.y; return this;};   
  vec rotateBy(float a) {float xx=x, yy=y; x=xx*cos(a)-yy*sin(a); y=xx*sin(a)+yy*cos(a); return this;};
  vec left() {float m=x; x=-y; y=m; return this;};
 
  // OUTPUT VEC
  vec clone() {return(new vec(x,y));}; 

  // OUTPUT TEST MEASURE
  float norm() {return(sqrt(sq(x)+sq(y)));}
  boolean isNull() {return((abs(x)+abs(y)<0.000001));}
  float angle() {return(atan2(y,x)); }

  // DRAW, PRINT
  void write() {println("<"+x+","+y+">");};
  void showAt (Point P) {line(P.x,P.y,P.x+x,P.y+y); }; 
  void showArrowAt (Point P) 
      {
      line(P.x,P.y,P.x+x,P.y+y); 
      float n=min(this.norm()/10.,height/50.); 
      Point Q=P(P,this); 
      vec U = S(-n,U(this));
      vec W = S(.3,R(U)); 
      beginShape(); Q.add(U).add(W).v(); Q.v(); Q.add(U).add(M(W)).v(); endShape(CLOSE); 
      }
      
  void label(String s, Point P) {P(P).add(0.5,this).add(3,R(U(this))).label(s); };
  
  boolean isBetween (vec v1, vec v2) {
    if (angle2(v1, this) < angle2(v1,v2))  {
        return true;
    }
    return false;
  }

  } // end vec class
  
  // create 
vec V(vec V) {return new vec(V.x,V.y); };                                                             // make copy of vector V
vec V(Point P) {return new vec(P.x,P.y); };                                                              // make vector from origin to P
vec V(float x, float y) {return new vec(x,y); };                                                      // make vector (x,y)
vec V(Point P, Point Q) {return new vec(Q.x-P.x,Q.y-P.y);};                                                 // PQ (make vector Q-P from P to Q
vec U(vec V) {float n = n(V); if (n==0) return new vec(0,0); else return new vec(V.x/n,V.y/n);};      // V/||V|| (Unit vector : normalized version of V)
vec U(Point P, Point Q) {return U(V(P,Q));};                                                                // PQ/||PQ| (Unit vector : from P towards Q)
vec MouseDrag() {return new vec(mouseX-pmouseX,mouseY-pmouseY);};                                      // vector representing recent mouse displacement

// measure 
float dot(vec U, vec V) {return U.x*V.x+U.y*V.y; }                                                     // dot(U,V): U*V (dot product U*V)
float det(vec U, vec V) {return dot(R(U),V); }                                                         // det | U V | = scalar cross UxV 
float n(vec V) {return sqrt(dot(V,V));};                                                               // n(V): ||V|| (norm: length of V)
float n2(vec V) {return sq(V.x)+sq(V.y);};                                                             // n2(V): V*V (norm squared)
boolean parallel (vec U, vec V) {return dot(U,R(V))==0; }; 
float angle (vec U, vec V) {return atan2(det(U,V),dot(U,V)); };                                   // angle <U,V> (between -PI and PI)
float angle2 (vec U, vec V) {
  float val = atan2(det(U,V),dot(U,V)); 
  if (val < 0) {
    return 2*pi + val;
  }
  return val;
};                                   // angle <U,V> (between 0 and 2PI)

float angle(vec V) {return(atan2(V.y,V.x)); };                                                       // angle between <1,0> and V (between -PI and PI)
float angle(Point A, Point B, Point C) {return  angle(V(B,A),V(B,C)); }                                       // angle <BA,BC>
float angle(float x, float y, float z) {return (float) Math.acos((pow(z,2)-pow(y,2)-pow(x,2))/(-2*x*y));}

float turnAngle(Point A, Point B, Point C) {return  angle(V(A,B),V(B,C)); }                                   // angle <AB,BC> (positive when right turn as seen on screen)
int toDeg(float a) {return int(a*180/PI);}                                                           // convert radians to degrees
float toRad(float a) {return(a*PI/180);}                                                             // convert degrees to radians 
float positive(float a) { if(a<0) return a+TWO_PI; else return a;}                                   // adds 2PI to make angle positive

// weighted sum 
vec W(float s,vec V) {return V(s*V.x,s*V.y);}                                                      // sV
vec W(vec U, vec V) {return V(U.x+V.x,U.y+V.y);}                                                   // U+V 
vec W(vec U,float s,vec V) {return W(U,S(s,V));}                                                   // U+sV
vec W(float u, vec U, float v, vec V) {return W(S(u,U),S(v,V));}                                   // uU+vV ( Linear combination)

// transformed 
vec S(float s,vec V) {return new vec(s*V.x,s*V.y);};                                                  // sV
void S2(float s,vec V) {V.x *= s; V.y *= s; return;}                                                        // sV on same vector

vec M(vec V) { return V(-V.x,-V.y); }                                                                 // -V
vec R(vec V) {return new vec(-V.y,V.x);};                                                             // V turned right 90 degrees (as seen on screen)
vec R(vec V, float a) { return W(cos(a),V,sin(a),R(V)); }                                           // V rotated by angle a in radians
vec Reflection(vec V, vec N) { return W(V,-2.*dot(V,N),N);};                                          // reflection OF V wrt unit normal vector N

// Interpolation 
vec L(vec U, vec V, float s) {return new vec(U.x+s*(V.x-U.x),U.y+s*(V.y-U.y));};                      // (1-s)U+sV (Linear interpolation between vectors)
vec S(vec U, vec V, float s) // steady interpolation from U to V
  {
  float a = angle(U,V); 
  vec W = R(U,s*a); 
  float u = n(U), v=n(V); 
  return W(pow(v/u,s),W); 
  } 

// display 
void show(Point P, vec V) {line(P.x,P.y,P.x+V.x,P.y+V.y); }                                              // show V as line-segment from P 
void show(Point P, float s, vec V) {show(P,S(s,V));}                                                     // show sV as line-segment from P 
void arrow(Point P, float s, vec V) {arrow(P,S(s,V));}                                                   // show sV as arrow from P 
void arrow(Point P, vec V, String S) {arrow(P,V); P(P(P,0.70,V),15,R(U(V))).label(S,V(-5,4));}       // show V as arrow from P and print string S on its side
void arrow(Point P, vec V) 
  {
  show(P,V);  
  float n=n(V); 
  if(n<0.01) return;  // too short a vector
  // otherwise continue
     float s=max(min(0.2,20./n),6./n);       // show V as arrow from P 
     Point Q=P(P,V); 
     vec U = S(-s,V); 
     vec W = R(S(.3,U)); 
     beginShape(); 
       v(P(P(Q,U),W)); 
       v(Q); 
       v(P(P(Q,U),-1,W)); 
     endShape(CLOSE);
  } 