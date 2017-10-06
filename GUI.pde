
  //**************************** user actions ****************************
void keyPressed()  // executed each time a key is pressed: sets the Boolean "keyPressed" till it is released   
                    // sets  char "key" state variables till another key is pressed or released
    {
  
    if(key=='~') ;
    if(key=='!') ;
    if(key=='@');
    if(key=='#') ;
    if(key=='$') ;
    if(key=='%') ; 
    if(key=='^') ;
    if(key=='&') ;
    if(key=='*') ;    
    if(key=='(') ;
    if(key==')') ;  
    if(key=='_') ;
    if(key=='+') ;

    if(key=='`') ;
    if(key=='1') ;               // toggles what should be displayed at each fram
    if(key=='2') ;
    if(key=='3') ;
    if(key=='4') ;
    if(key=='5') ;
    if(key=='6') ;
    if(key=='7') ;
    if(key=='8') ;
    if(key=='9') ;
    if(key=='0') ; 
    if(key=='-') ;
    if(key=='=') ;

    if(key=='a') ; // used to append
    if(key=='b') background.toggleRefresh();
    if(key=='c') if(!mousePressed){P.pickClosest(Mouse()); P.setPicekdLabel(key);}
    if(key=='d') ; 
    if(key=='e') ;
    if(key=='f') if(!mousePressed){P.pickClosest(Mouse()); P.setPicekdLabel(key);}
    if(key=='g') ; 
    if(key=='h') ;
    if(key=='i') ; 
    if(key=='j') ;
    if(key=='k') ;   
    if(key=='l') ;
    if(key=='m') ;//used for selection
    if(key=='n') player.resetBeat();
    if(key=='o') P.resetOnCircle(P.nv);
    if(key=='p') ;
    if(key=='q') ; 
    if(key=='r') ; // used in mouseDrag to rotate the control points 
    if(key=='s') if(!mousePressed){P.pickClosest(Mouse()); P.setPicekdLabel(key);}
    if(key=='t') ; // used in mouseDrag to translate the control points 
    if(key=='p') ;
    if(key=='v') ; 
    if(key=='w') ;  
    if(key=='x') ;
    if(key=='y') ;
    if(key=='z') ; // used in mouseDrag to scale the control points

    if(key=='A') ;
    if(key=='B') ; 
    if(key=='C') ; 
    if(key=='D') P.empty();  
    if(key=='E') ;
    if(key=='F') ;
    if(key=='G') ; 
    if(key=='H') ; 
    if(key=='I') ; 
    if(key=='J') ;
    if(key=='K') ;
    if(key=='L') P.loadPoints("data/pts");    // load current positions of control points from file
    if(key=='M') ;
    if(key=='N') ;
    if(key=='O') ;
    if(key=='P') ; 
    if(key=='Q') exit();  // quit application
    if(key=='R') ; 
    if(key=='S') P.savePoints("data/pts");    // save current positions of control points on file
    if(key=='T') ;
    if(key=='U') ;
    if(key=='V') ;
    if(key=='W') ;  
    if(key=='X') ;  
    if(key=='Y') ;
    if(key=='Z') ;  

    if(key=='{') ;
    if(key=='}') ;
    if(key=='|') ; 
    
    if(key=='[') ; 
    if(key==']') ;
    if(key=='\\') ;
    
    if(key==':') ; 
    if(key=='"') ; 
    
    if(key==';') ; 
    if(key=='\''); 
    
    if(key=='<') ;
    if(key=='>') ;
    if(key=='?') ;
   
  if(key==',') time.maxDown();
  if(key=='.') time.maxUp();
    if(key=='/') ;
    
  if(key==' ') ;

  
    if (key == CODED) 
       {
       String pressed = "Pressed coded key ";
       if (keyCode == UP) {pressed="UP"; player.play(); player.rewind();}
       if (keyCode == DOWN) {pressed="DOWN"; player.togglePlay(); };
       if (keyCode == LEFT) {pressed="LEFT";   player.skip(-5000);};
       if (keyCode == RIGHT) {pressed="RIGHT";  player.skip(5000);};
       if (keyCode == ALT) {pressed="ALT";   };
       if (keyCode == CONTROL) {pressed="CONTROL";   };
       if (keyCode == SHIFT) {pressed="SHIFT";   };
       println("Pressed coded key = "+pressed); 
       } 

    }

void mousePressed()   // executed when the mouse is pressed
  {
  P.pickClosest(Mouse()); // pick vertex closest to mouse: sets pv ("picked vertex") in pts
  if(!keyPressed) { checkCreate(); checkElement(); selected.empty(); }
  if (keyPressed) 
     {
     if (key=='a')  P.addPoint(Mouse()); // appends vertex after the last one
     if (key=='f')  {P.addPoint(Mouse()); P.setPicekdLabel(key);} // appends vertex after the last one and set its label
     if (key=='b')  {P.addPoint(Mouse()); P.setPicekdLabel(key);} // appends vertex after the last one and set its label
     if (key=='s')  {P.addPoint(Mouse()); P.setPicekdLabel(key);} // appends vertex after the last one and set its label
     if (key=='c')  {P.addPoint(Mouse()); P.setPicekdLabel(key);} // appends vertex after the last one and set its label
     if (key=='i')  P.insertClosestProjection(Mouse()); // inserts vertex at closest projection of mouse
     if (key=='d')  P.deletePickedPoint(); // deletes vertex closeset to mouse
     if (key=='m')  selected.addPoint(P.G[P.pv]); // deletes vertex closeset to mouse
     if (key!='m')  selected.empty(); // deletes vertex closeset to mouse


     }  
  }

void mouseDragged() // executed when the mouse is dragged (while mouse buttom pressed)
  {
  if (!keyPressed || (key=='a')|| (key=='i')) P.dragPicked();   // drag selected point with mouse
  if (keyPressed) {
      if (key=='.') ;  // adjust current frame   
      if (key=='t') P.dragAll(); // move all vertices
      if (key=='r') P.rotateAllAroundCentroid(Mouse(),Pmouse()); // turn all vertices around their center of mass
      if (key=='z') P.scaleAllAroundCentroid(Mouse(),Pmouse()); // scale all vertices with respect to their center of mass
      }
  }  
 
void mouseWheel(MouseEvent event) { // reads mouse wheel and uses to zoom
  float s = event.getAmount();
  P.scaleAllAroundCentroid(s/100);
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
void scribeHeader(String S, int i) {fill(black); stroke(color(0,0,0,255)); rect(10,i*20+5,S.length() * 10,20 );
                                                          fill(white); text(S,10,20+i*20); noFill(); } // writes white at line i


void drawInfo() {
  scribeHeader( String.valueOf(time.max),1);
  scribeHeader( String.valueOf(time.count),2);
  scribeHeader( String.valueOf(player.getSong() + player.getFramesPerBeat()),3);
  scribeHeader( String.valueOf(P.nv),4);
  



  
  
}