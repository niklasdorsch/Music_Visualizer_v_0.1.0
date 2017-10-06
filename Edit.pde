//holds the elements so they can be displayed and it can be tracked which one is being displayed
import java.util.Iterator;
class ElementHolder {
  int row;
  String text;
  boolean selected = false;
  Element elem;
  ElementHolder (Element elem, int row, String text ) {
    this.row = row;
    this.text = text;
    this.elem = elem;
  } 
  void show() {
    fill(blue);
    if (selected) {
      fill(yellow);
    }
    rect(0,height - row*20, (text.length() * 10),20 );   
    fill(white);
    if (selected) {
      fill(blue);
    }
    text(text,2,height - row*20 +17);
  }
  void show(int x) {
     row = x;
     show();
     if(selected) {
       displayPoints();
     }
  }   
  //shows the points of selected element
  void displayPoints () {
    Point[] x = elem.returnPoints();
    for (int i = 0; i < x.length; i++) {
      x[i].theColor = color(red);
      fill(0,0,0,0);
      x[i].show(15);
      x[i].show(12);
      x[i].theColor = color(white);

    }
  }
}

boolean newElementPicked =true;
Element selectedElement = null;

void checkElement() {  
  boolean notChoosen = true;
  for (ElementHolder x : elements) {
    if (mouseX >0 && mouseX < (x.text.length() * 10)) {
      if(mouseY > height - (x.row*20) && mouseY < height - (x.row*20 -20)) {
        selectedElement = x.elem;
        newElementPicked = true;
        notChoosen = false;
      }
    }
  }
  boolean prevNull = selectedEdit == null;
  boolean subMenuPicked = !checkEdit();
  if (notChoosen && !subMenuPicked) {
    selectedElement = null;
  }
}

void showMenu() {
  if(newElementPicked){
   
    allOptionBoxes.clear();
    if (selectedElement instanceof FreqCircle) {
      FreqCircle elem = (FreqCircle) selectedElement;
      allOptionBoxes.add( new OptionBox(new  FreqCricleRadius1(elem),1,"Radius 1"));
      allOptionBoxes.add( new OptionBox(new  FreqCricleRadius2(elem),2,"Radius 2"));
      allOptionBoxes.add( new OptionBox(new  changeRed(elem),3,"Red"));
      allOptionBoxes.add( new OptionBox(new  changeGreen(elem),4,"Green"));
      allOptionBoxes.add( new OptionBox(new  changeBlue(elem),5,"Blue"));
    }
    if (selectedElement instanceof Spiral) {
      Spiral elem = (Spiral) selectedElement;
      allOptionBoxes.add( new OptionBox(new  SpiralTMax(elem),1,"TMax"));
      allOptionBoxes.add( new OptionBox(new  SpiralTMin(elem),2,"TMin"));
      allOptionBoxes.add( new OptionBox(new  changeRed(elem),3,"Red"));
      allOptionBoxes.add( new OptionBox(new  changeGreen(elem),4,"Green"));
      allOptionBoxes.add( new OptionBox(new  changeBlue(elem),5,"Blue"));
  
  
    }
    if (selectedElement instanceof Lerp) {
      Lerp elem = (Lerp) selectedElement;
      allOptionBoxes.add( new OptionBox(new  LerpScaleVal(elem),1,"Scaling Value"));
      
      
    }
    
    if (selectedElement instanceof Rotation) {
      Rotation elem = (Rotation) selectedElement;
      allOptionBoxes.add( new OptionBox(new  changeRadius(elem),1,"Scaling Value"));
      allOptionBoxes.add( new OptionBox(new  changeRotationDirection(elem),2,"Toggle Clockwise"));
      allOptionBoxes.add( new OptionBox(new  changeRotationSpeed(elem),3,"Change Speed"));
      allOptionBoxes.add( new OptionBox(new  changeRotationOffset(elem),3,"Change Offset"));



      
      
    }
       
    if (selectedElement instanceof FreqLine) {
      FreqLine elem = (FreqLine) selectedElement;

      allOptionBoxes.add( new OptionBox(new  changeRed(elem),3,"Red"));
      allOptionBoxes.add( new OptionBox(new  changeGreen(elem),4,"Green"));
      allOptionBoxes.add( new OptionBox(new  changeBlue(elem),5,"Blue"));
  
  
    }
    
    
    newElementPicked = false;
  } 
  
  int row =1;
  for (OptionBox x : allOptionBoxes) {
    if (x.edit == selectedEdit) {
      x.selected = true;
    } else {
      x.selected = false;
    }
    x.show(row++);
  }
  fill(blue);
  stroke(white);
  rect(0+300,height -20, 20,20); 
  rect(0+320,height -20, 20,20); 
  rect(340,height-20,100,100); 
  rect(440,height-20,20,20); 
  rect(460,height-20,20,20); 
  fill(white);
  text("--",305,height - 3);
  text("-",325,height - 3);
  text(selectedEdit != null ? String.valueOf(selectedEdit.value()) : "Pick Option" ,350,height -3);
  text("+",445,height -3 );
  text("++",465,height -3 );
}

class OptionBox {
  int row;
  String text;
  boolean selected = false;
  Edit edit;
  OptionBox (Edit edit, int row, String text ) {
    this.row = row;
    this.text = text;
    this.edit = edit;
  } 
 void show() {
    fill(blue);
    if (selected) {
      fill(yellow);
    }
    rect(0+100,height - row*20, (text.length() * 10),20 );   
    fill(white);
    if (selected) {
      fill(blue);
    }
    text(text,2+100,height - row*20 +17);
 }
void show(int x) {
   row = x;
   show();
 } 
}

interface Edit {
  void up();
  void down();
  float value();
  void onPoint();
}
class changeRed implements Edit {
  Element theElement;
  changeRed(Element x) {
    if (x instanceof Spiral) {
      theElement = (Spiral) x; 
     }
    if (x instanceof FreqCircle) {
      theElement = (FreqCircle) x; 
     }
    if (x instanceof FreqLine) {
      theElement = (FreqLine) x; 
     }
  }
  void up() {
   theElement.red++; 
  }
    void down() {
   theElement.red--; 
  }
  float value() {
   return theElement.red; 
  } 
  void onPoint(){};
}
class changeGreen implements Edit {
  Element theElement;
  changeGreen(Element x) {
   if (x instanceof Spiral) {
    theElement = (Spiral) x; 
   }
   if (x instanceof FreqCircle) {
    theElement = (FreqCircle) x; 
   }
   if (x instanceof FreqLine) {
      theElement = (FreqLine) x; 
   }
   
  }
  void up() {
   theElement.green++; 
  }
    void down() {
   theElement.green--; 
  }
  float value() {
   return theElement.green; 
  } 
    void onPoint(){};

}
class changeBlue implements Edit {
  Element theElement;
  changeBlue(Element x) {
   if (x instanceof Spiral) {
    theElement = (Spiral) x; 
   }
      if (x instanceof FreqCircle) {
    theElement = (FreqCircle) x; 
   }
   if (x instanceof FreqLine) {
      theElement = (FreqLine) x; 
   }
   
  }
  void up() {
   theElement.blue++; 
  }
    void down() {
   theElement.blue--; 
  }
  float value() {
   return theElement.blue; 
  } 
    void onPoint(){};

}
class FreqCricleRadius1 implements Edit {
  FreqCircle theCircle;
  FreqCricleRadius1 (FreqCircle x){
    theCircle = x;
  }
  void up() {
    theCircle.circRadius++;
  }
  void down() {
    theCircle.circRadius--;
  }
  float value() {
    return theCircle.circRadius;
  }
    void onPoint(){
      theCircle.makeRadius(selected.M[0], false);
    };

}
class FreqCricleRadius2 implements Edit {
  FreqCircle theCircle;
  FreqCricleRadius2 (FreqCircle x){
    theCircle = x;
  }
  void up() {
    theCircle.circRim+=.25;
  }
  void down() {
    theCircle.circRim-=.25;
  }
  float value() {
    return theCircle.circRim;
  }
    void onPoint(){
      theCircle.makeRadius(selected.M[0], true);
    };

}
class LerpScaleVal implements Edit {
  Lerp theLerp;
  LerpScaleVal (Lerp x){
    theLerp = x;
  }
  void up() {
    theLerp.lerpVariable+=.25;
  }
  void down() {
    theLerp.lerpVariable-=.25;
  }
  float value() {
    return theLerp.lerpVariable;
  }
    void onPoint(){
      
    };

}



class SpiralTMax implements Edit {
  Spiral theSpiral;
  SpiralTMax (Spiral x){
    theSpiral = x;
  }
  void up() {
    theSpiral.tMax+=.025;
  }
  void down() {
    theSpiral.tMax-=.025;
  }
  float value() {
    return theSpiral.tMax;
  }
    void onPoint(){};

}
class SpiralTMin implements Edit {
  Spiral theSpiral;
  SpiralTMin (Spiral x){
    theSpiral = x;
  }
  void up() {
    theSpiral.tMin+=.025;
  }
  void down() {
    theSpiral.tMin-=.025;
  }
  float value() {
    return theSpiral.tMin;
  }
    void onPoint(){};
}
class changeRadius implements Edit {
  Rotation theRotation;
  changeRadius (Rotation x){
    theRotation = x;
  }
  void up() {
    theRotation.radius+=1;
  }
  void down() {
    theRotation.radius-=1;
  }
  float value() {
    return theRotation.radius;
  }
    void onPoint(){};
}
class changeRotationDirection implements Edit {
  Rotation theRotation;
  changeRotationDirection(Rotation x){
    theRotation = x;
  }
  void up() {
    theRotation.toggleClockwise();
  }
  void down() {
    theRotation.toggleClockwise();
  }
  float value() {
    return theRotation.clockwise ? 0 : 1;
  }
    void onPoint(){};
}
class changeRotationSpeed implements Edit {
  Rotation theRotation;
  changeRotationSpeed(Rotation x){
    theRotation = x;
  }
  void up() {
    theRotation.changeSpeed(.1);
  }
  void down() {
    theRotation.changeSpeed(-.1);
  }
  float value() {
    return theRotation.speed;
  }
    void onPoint(){};
}
class changeRotationOffset implements Edit {
  Rotation theRotation;
  changeRotationOffset(Rotation x){
    theRotation = x;
  }
  void up() {
    theRotation.changeOffset(.01);
  }
  void down() {
    theRotation.changeOffset(-.01);
  }
  float value() {
    return theRotation.offset;
  }
    void onPoint(){};
}

Edit selectedEdit = null;
LinkedHashSet<OptionBox> allOptionBoxes= new LinkedHashSet<OptionBox>();


boolean checkEdit() {  
  boolean notChoosen = true;
  for (OptionBox x : allOptionBoxes) {
    if (mouseX +100>0 && mouseX < (x.text.length() * 10)+100) {
      if(mouseY > height - (x.row*20) && mouseY < height - (x.row*20 -20)) {
        selectedEdit = x.edit;
        notChoosen = false;
      }
    }
  }
  if (selectedEdit != null) {
    if( mouseX >300 && mouseX < 300+20 && mouseY > height -20 && mouseY < height) {
      for(int i =0; i<10; i++) selectedEdit.down();
      notChoosen = false;
    }
    if( mouseX >320 && mouseX < 320+20 && mouseY > height -20 && mouseY < height) {
      selectedEdit.down();
      notChoosen = false;
    }
    if( mouseX >340 && mouseX < 340+100 && mouseY > height -20 && mouseY < height && selected.nv > 0) {
      selectedEdit.onPoint();
      
    }
    if( mouseX >440 && mouseX < 440+20 && mouseY > height -20 && mouseY < height) {
      selectedEdit.up();
      notChoosen = false;
    }
    if( mouseX >460 && mouseX < 460+20 && mouseY > height -20 && mouseY < height) {
      for(int i =0; i<10; i++) selectedEdit.up();
      notChoosen = false;
    }
  }
  if (notChoosen) {
    selectedEdit = null;
  }
  return notChoosen;
}