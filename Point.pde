int count = 0;
class Point 
{ 
  float x=0, y=0; 
  String instructions = "show";
  float  rotateAmount = PI/180;
  Point parentPoint = null;
  Point lerpPoint = null;
  float lerpAmount = .5;
  LinkedHashSet<Point> dependentPoints = new LinkedHashSet<Point>();
  float xDispParent = 0;
  float yDispParent = 0;
  boolean show = true;
  int theColor = white;
  Lerp theLerp;

  // CREATE
  Point () {
  }
  Point (Point p1) { 
    x =p1.x; 
    y=p1.y;
  }
  Point (float px, float py) {
    x = px; 
    y = py;
  };
  Point (float px, float py, int col) {
    x = px; 
    y = py; 
    theColor =col;
  };
  Point (Point p1, float px, float py) {
    x = p1.x + px; 
    y =p1.y + py;
  };
  Point (Point p1, float px, float py, int col) {
    x = p1.x + px; 
    y =p1.y + py; 
    theColor =col;
  };



  // MODIFY
  Point setTo(float px, float py) {
    x = px; 
    y = py; 
    return this;
  };  
  Point setTo(Point P) {
    x = P.x; 
    y = P.y; 
    return this;
  }; 
  Point setToMouse() { 
    x = mouseX; 
    y = mouseY;  
    return this;
  }; 
  Point add(float u, float v) {
    x += u; 
    y += v; 
    return this;
  }                       // P.add(u,v): P+=<u,v>
  Point add(Point P) {
    x += P.x; 
    y += P.y; 
    return this;
  };                              // incorrect notation, but useful for computing weighted averages
  Point add(vec V) {
    x += V.x; 
    y += V.y; 
    return this;
  }                              // P.add(V): P+=V 
  Point add(float s, Point P) {
    x += s*P.x; 
    y += s*P.y; 
    return this;
  };               // adds s*P
  Point add(float s, vec V) {
    x += s*V.x; 
    y += s*V.y; 
    return this;
  }                 // P.add(s,V): P+=sV

  Point translateTowards(float s, Point P) {
    x+=s*(P.x-x);  
    y+=s*(P.y-y);  
    return this;
  };  // transalte by ratio s towards P
  Point scale(float u, float v) {
    x*=u; 
    y*=v; 
    return this;
  };
  Point scale(float s) {
    x*=s; 
    y*=s; 
    return this;
  }                                  // P.scale(s): P*=s
  Point scale(float s, Point C) {
    x*=C.x+s*(x-C.x); 
    y*=C.y+s*(y-C.y); 
    return this;
  }    // P.scale(s,C): scales wrt C: P=L(C,P,s);
  Point rotate(float a) {
    float dx=x, dy=y, c=cos(a), s=sin(a); 
    x=c*dx+s*dy; 
    y=-s*dx+c*dy; 
    return this;
  };     // P.rotate(a): rotate P around origin by angle a in radians
  Point rotate(float a, Point G) {
    float dx=x-G.x, dy=y-G.y, c=cos(a), s=sin(a); 
    x=G.x+c*dx+s*dy; 
    y=G.y-s*dx+c*dy; 
    return this;
  };   // P.rotate(a,G): rotate P around G by angle a in radians

  Point rotate(float s, float t, Point G) {
    float dx=x-G.x, dy=y-G.y; 
    dx-=dy*t; 
    dy+=dx*s; 
    dx-=dy*t; 
    x=G.x+dx; 
    y=G.y+dy;  
    return this;
  };   // fast rotate s=sin(a); t=tan(a/2); 
  Point moveWithMouse() { 
    x += mouseX-pmouseX; 
    y += mouseY-pmouseY; 
    return this;
  }; 
  Point lerp(Point V, float s) { 
    return new Point(this.x+s*(V.x-this.x), this.y+s*(V.y-this.y));
  };  
  Point  label(String s, vec V) {
    fill(black); 
    text(s, x+V.x, y+V.y); 
    noFill(); 
    return this;
  };
  // DRAW , WRITE
  Point write() {
    print("("+x+","+y+")"); 
    return this;
  };  // writes point coordinates in text window
  Point v() {
    vertex(x, y); 
    return this;
  };  // used for drawing polygons between beginShape(); and endShape();
  Point show(float r) { 
    if (!show) {
      return this;
    } 
    stroke(theColor);
    ellipse(x, y, 2*r, 2*r); 
    return this;
  }; // shows point as disk of radius r
  Point show() {
    show(3); 
    return this;
  }; // shows point as small dot
  Point label(String s, float u, float v) {
    fill(white); 
    text(s, x+u, y+v); 
    noFill(); 
    return this;
  };
  Point label(String s) {
    label(s, 5, 4); 
    return this;
  };


  void rotateAround (Point rPoint, float amount) {
    instructions = "rotate";
    parentPoint = rPoint;
    rotateAmount = amount;
    setRelativeToParent();
    parentPoint.addDependant(this);
  }
  void rotateAround (Point rPoint) {

    rotateAround (rPoint, PI/180);
  }
  void bind(Point pPoint, float xDis, float yDis) {

    instructions = "bind";
    parentPoint = pPoint;
    xDispParent = xDis;
    yDispParent = yDis;
    parentPoint.addDependant(this);
  }
  void bind(Point pPoint) {
    bind(pPoint, this.x - pPoint.x, this.y - pPoint.y);
  }


  void lerpPoint(Point pPoint, Point lPoint, Lerp theLerpObj) {
    theLerp = theLerpObj;
    instructions = "lerp";
    parentPoint = pPoint;
    lerpPoint = lPoint;
    this.setTo(parentPoint);
    this.add((lerpPoint.x-parentPoint.x) *lerpAmount, (lerpPoint.y-parentPoint.y) *lerpAmount);
    setRelativeToParent();
    parentPoint.addDependant(this);
  }



  void dontShow() {
    show = false;
  }
  void doShow() {
    show = true;
  }
  void changeColor(int col) {
    this.theColor=col;
  }

  void update() {

    if (instructions == "show") {
    } 
    if (instructions == "rotate") {
      this.rotate(rotateAmount, parentPoint);
      setRelativeToParent();
    }
    if (instructions == "bind") {
      this.setTo(parentPoint);
      this.add(xDispParent, yDispParent);
    }
    if (instructions == "lerp") {
      lerpAmount = time.upDownRel(1) * theLerp.lerpVariable;
      this.setTo(parentPoint);
      this.add((lerpPoint.x-parentPoint.x) *lerpAmount, (lerpPoint.y-parentPoint.y) *lerpAmount);
    }
    for (Point x : dependentPoints) {
      x.parentMoved();
    }
    setRelativeToParent();
  }

  void parentMoved() {
    this.setTo(parentPoint);
    this.add(xDispParent, yDispParent);
  }
  void setRelativeToParent() {
    if (parentPoint != null) {
      xDispParent = this.x - parentPoint.x;
      yDispParent = this.y - parentPoint.y;
    }
  }

  void addDependant(Point p1) {
    dependentPoints.add(p1);
  }
  @Override
    public String toString() {
    return String.format( "Point: " + x + ", " + y);
  }
} // end of Point class



Point P() {
  return P(0, 0);
};                                                                            // make point (0,0)
Point P(float x, float y) {
  return new Point(x, y);
};                                                       // make point (x,y)
Point P(Point P) {
  return P(P.x, P.y);
};                                                                    // make copy of point A
Point Mouse() {
  return P(mouseX, mouseY);
};                                                                 // returns point at current mouse location
Point Pmouse() {
  return P(pmouseX, pmouseY);
};                                                              // returns point at previous mouse location
Point ScreenCenter() {
  return P(width/2, height/2);
}                                                        //  point in center of  canvas

// measure 

boolean isSame(Point A, Point B) {
  return (A.x==B.x)&&(A.y==B.y) ;
}                                         // A==B
boolean isSame(Point A, Point B, float e) {
  return d2(A, B)<sq(e);
}                                          // |AB|<e

// transform 
Point R(Point Q, float a) {
  float dx=Q.x, dy=Q.y, c=cos(a), s=sin(a); 
  return new Point(c*dx+s*dy, -s*dx+c*dy);
};  // Q rotated by angle a around the origin
Point P(Point P, vec V) {
  return P(P.x + V.x, P.y + V.y);
}                                                 //  P+V (P transalted by vector V)
Point P(Point P, float s, vec V) {
  return P(P, W(s, V));
}                                                    //  P+sV (P transalted by sV)
Point P(Point P, float x, vec I, float y, vec J) {
  return P(P.x+x*I.x+y*J.x, P.y+x*I.y+y*J.y);
}            //  P+xI+yJ                          
Point MoveByDistanceTowards(Point P, float d, Point Q) { 
  return P(P, d, U(V(P, Q)));
};                          //  P+dU(PQ) (transLAted P by *distance* s towards Q)!!!

// average 
Point P(Point A, Point B) {
  return P((A.x+B.x)/2.0, (A.y+B.y)/2.0);
};                                          // (A+B)/2 (average)
Point P(Point A, Point B, Point C) {
  return P((A.x+B.x+C.x)/3.0, (A.y+B.y+C.y)/3.0);
};                            // (A+B+C)/3 (average)
Point P(Point A, Point B, Point C, Point D) {
  return P(P(A, B), P(C, D));
};                                            // (A+B+C+D)/4 (average)

// weighted average 
Point P(float a, Point A) {
  return P(a*A.x, a*A.y);
}                                                         // aA (used to collect weighted average) 
Point P(float a, Point A, float b, Point B) {
  return P(a*A.x+b*B.x, a*A.y+b*B.y);
}                              // aA+bB, (assumes a+b=1) 
Point P(float a, Point A, float b, Point B, float c, Point C) {
  return P(a*A.x+b*B.x+c*C.x, a*A.y+b*B.y+c*C.y);
}   // aA+bB+cC, (assumes a+b+c=1) 
Point P(float a, Point A, float b, Point B, float c, Point C, float d, Point D) {
  return P(a*A.x+b*B.x+c*C.x+d*D.x, a*A.y+b*B.y+c*C.y+d*D.y);
} // aA+bB+cC+dD (assumes a+b+c+d=1)

// display 
void show(Point P, float r) {
  ellipse(P.x, P.y, 2*r, 2*r);
};                                             // draws circle of center r around P
void show(Point P) {
  ellipse(P.x, P.y, 6, 6);
};                                                           // draws small circle around point
void label(Point P, String S) {
  text(S, P.x-4, P.y+6.5);
}                                                 // writes string S next to P on the screen ( for example label(P[i],str(i));)
void label(Point P, vec V, String S) {
  text(S, P.x-3.5+V.x, P.y+7+V.y);
}                                  // writes string S at P+V
void showId(Point P, String S) {
  fill(white); 
  show(P, 13); 
  fill(black); 
  label(P, S);
}                       // sows disk with S written inside
void edge(Point P, Point Q) {
  line(P.x, P.y, Q.x, Q.y);
};                                                      // draws edge (P,Q)
void v(Point P) {
  vertex(P.x, P.y);
};                                                                      // vertex for drawing polygons between beginShape() and endShape()
void arrow(Point P, Point Q) {
  arrow(P, V(P, Q));
}                                                            // draws arrow from P to Q
void show(Point A, Point B, Point C) {
  beginShape();  
  A.v(); 
  B.v(); 
  C.v(); 
  endShape(CLOSE);
}                   // render triangle A, B, C
void show(Point A, Point B, Point C, Point D) {
  beginShape();  
  A.v(); 
  B.v(); 
  C.v(); 
  D.v(); 
  endShape(CLOSE);
}      // render quad A, B, C, D