interface Create {
  void make();
}

class makeSpiral implements Create {
  boolean withMusic;
  makeSpiral(boolean withMusic) {
    this.withMusic = withMusic;
  }
  void make() {
    Spiral x = new Spiral(selected.M[0], selected.M[1], selected.M[2], selected.M[3]);
    if (withMusic) {
      x.withMusic(true, player);  
    }
    allSpirals.add(x);
  }  
}
class makeFreqCircle implements Create {
  makeFreqCircle() {
  }
  void make() {
    FreqCircle x = new FreqCircle(player, selected.M[0], white);
    allFreqCircles.add(x);
  }  
}
class makeLerp implements Create {
  makeLerp() {
  }
  void make() {
    Lerp y = new Lerp(selected.M[0],selected.M[1]);
    allLerps.add(y);
  }  
}
class makeLerp2 implements Create {
  makeLerp2() {
  }
  void make() {
    Point x = selected.M[2];
    Lerp y = new Lerp(selected.M[0],selected.M[1], x);
    allLerps.add(y);
   // P.addPointSpecial(x);
  }  
}
class makeRotation implements Create {
  makeRotation() {
  }
  void make() {
    Rotation y = new Rotation(selected.M[0],selected.M[1]);
    allRotations.add(y);
  } 
  
}
class makeRandomPoint implements Create {
  makeRandomPoint() {
  }
  void make() {
    RandomPoint y = new RandomPoint(selected.M[0],selected.M[1]);
    allRandomPoints.add(y);
  } 
  
}
class makeFreqLine implements Create {
  makeFreqLine() {
  }
  void make() {
    FreqLine y = new FreqLine(selected.M[0],selected.M[1]);
    allFreqLines.add(y);
  } 
  
}




LinkedHashSet<Option> allOptions = new LinkedHashSet<Option>();

class Option {
  int row;
  String text;
  Create method;
  Option(int row, String text, Create methodClass ) {
    this.row = row;
    this.text = text;
    this.method = methodClass;
  } 
  
 void show() {
    fill(black);
    rect(2,row*20+105, (text.length() * 10),20 );   
    fill(white); text(text,2,120+row*20); 
  }
}




void checkCreate() {  
  for (Option x : allOptions) {
    if (mouseX > 0 && x.text.length() * 10 < width) {
      if(mouseY > (x.row*20+105) && mouseY < (x.row*20+125)) {
        x.method.make();
      }
    }
  } 
}