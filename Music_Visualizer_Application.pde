import java.util.LinkedHashSet;
import java.util.Comparator;
import java.util.Collections;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.TreeSet;
import java.util.Random;
import ddf.minim.analysis.*;
import ddf.minim.*;

//natural number
float eMath =  2.71828;
float pi = 3.1415;

//color------------------------
final int black = 0;
final int white = 255;
final int white2 = color(255,255,255,50);

final int red = #FF0000;
final int green = #00FF00;
final int blue = #0000FF;
final int pink = #FF99FF;
final int pink2 = color(255,99,255,50);
final int green2 = color(0,255,0,50);
final int lightBlue= color(135,206,250);
final int lightBlue2 = color(135,206,250,50);
color  // set more colors using Menu >  Tools > Color Selector
     yellow=#FEFF00, cyan=#00FDFF, magenta=#FF00FB,
   grey=#818181, orange=#FFA600, brown=#B46005, metal=#B5CCDE, 
   lime=#A4FA83,  dgreen=#057103,
   lightWood=#F5DEA6, darkWood=#D8BE7A,
    orange2=color(255,182,0,50);
//-----------------------------

pts P = new pts(); // class containing array of points, used to standardize GUI
pts selected = new pts(); 


Point origin = new Point(0, 0);

boolean backgroundOn = true;

String songFile ="Perfect_views.mp3";
//String songFile ="Bangarang.mp3";

MusicPlayer player;
Background background;

LinkedHashSet<Point> allPoints = new LinkedHashSet<Point>();
LinkedHashSet<Spiral> allSpirals = new LinkedHashSet<Spiral>();
LinkedHashSet<FreqCircle> allFreqCircles= new LinkedHashSet<FreqCircle>();
LinkedHashSet<Lerp> allLerps= new LinkedHashSet<Lerp>();
LinkedHashSet<Rotation> allRotations= new LinkedHashSet<Rotation>();
LinkedHashSet<ElementHolder> elements= new LinkedHashSet<ElementHolder>();
LinkedHashSet<RandomPoint> allRandomPoints= new LinkedHashSet<RandomPoint>();
LinkedHashSet<FreqLine> allFreqLines= new LinkedHashSet<FreqLine>();




Point p0 = new Point(1500/2, 1000/2, red);
Point p1 = new Point(p0, 5, -5, red);
Point p2 = new Point(p1, -5, 5, green);
Point p3 = new Point(p1, 500, 0, blue);
Point p4 = new Point(p1, 353, 353, pink);
Point p5 = new Point(p1, 701, 199, pink);




Point q0 = new Point(1500/2, 1000/2, red);
Point q1 = new Point(q0, 0, 0, red);
Point q2 = new Point(q1, -5, 40, green);
Point q3 = new Point(q1, -400, -10, blue);
Point q4 = new Point(q1, -280, 220, pink);
Point q5 = new Point(q1, -701, 199, pink);




Spiral s1 = new Spiral(p1, p2, p3, p4);
Spiral s2 = new Spiral(q4, q3, q2, q1);



FreqCircle f1, f2,f3, f4;

Time time = new Time(200);


Point A = new Point (100, 200);
Point B = new Point (1200, 320);
Point C = new Point (170, 215);



void setup()               // executed once at the begining 
{
  size(1500, 1000);
  frameRate(30);
  background(0);

  //audio
  Minim minim =new Minim(this);
  player = new MusicPlayer(minim, true); //true means audio input, false means play file
  background = new Background("mandelbrot.jpg");
    
  P.declare();

}
int countx = 0;
void draw() {     // executed at each frame

  println(player.fft.getBand(100));
  
  if (backgroundOn) {
    //background(0);
    
    strokeWeight(1);
    fill(0,0,0,3);
    rect(-1,-1,width+2,height+2);
    countx++;
    pen(color(black,50),2); 
  }

//  if(countx > player.getFramesPerBeat()) {
//      fill(255,255,255,50);
//      rect(-1,-1,width+2,height+2);
//      pen(color(255,255,255,50),2);
//      countx = 0;
//  }
//
background.update();

   

  time.setMax((int)player.getFramesPerBeat() * 4);
  
  for (Point x : allPoints) {
    x.update();
  }
  for (Point x : allPoints) {
    x.show();
  }
  
  elements.clear();
  
  int spiralCount = 1;
  int freqCircleCount = 1;
  int lerpCount = 1;
  int rotationCount = 1;
  int randomPCount =1;
  int freqLineCount =1;
  
  
  for (Spiral x : allSpirals) {
    x.update();
    elements.add(new ElementHolder (x, 1, "Spiral " + spiralCount++));
  }
  for (FreqCircle x : allFreqCircles) {
    x.update();
    elements.add(new ElementHolder (x, 1, "FreqCricle " + freqCircleCount++));
  }
  for (Lerp x : allLerps) {
    x.update();
    elements.add(new ElementHolder (x, 1, "Lerp " + lerpCount++));
  }
  for (Rotation x : allRotations) {
    x.update();
    elements.add(new ElementHolder (x, 1, "Rotation " + rotationCount++));
  }
  for (RandomPoint x : allRandomPoints) {
    x.update();
    elements.add(new ElementHolder (x, 1, "RandomPoint " + randomPCount++));
  }
  for (FreqLine x : allFreqLines) {
    x.update();
    elements.add(new ElementHolder (x, 1, "Frequency Line " + freqLineCount++));
  }
  
  

  selected.drawVertices();
  allOptions.clear();

  if (selected.nv == 1) {
    allOptions.add( new Option(1,"Make FreqCircle",new makeFreqCircle()));
  }
  if (selected.nv  == 2) {
    allOptions.add(new Option(1,"Make Lerp", new makeLerp()));
    allOptions.add(new Option(2,"Make Rotation", new makeRotation()));
    allOptions.add(new Option(3,"Make RandomPoint", new makeRandomPoint()));
    allOptions.add(new Option(4,"Make Freqency Line", new makeFreqLine()));

  }
  if (selected.nv  == 3) {
    allOptions.add(new Option(1,"Make Lerp", new makeLerp2()));
  }
  if (selected.nv == 4) {
    allOptions.add( new Option(1,"Make Spiral",new makeSpiral(false)));
    allOptions.add( new Option(2,"Make Spiral with Music",new makeSpiral(true)));
  }
  for (Option x : allOptions) {
    x.show();
  }
  int row = 1;
  for (ElementHolder x : elements) {
    if (x.elem == selectedElement) x.selected = true;
    x.show(row++);
  }
  
  if(selectedElement != null){
    showMenu(); 
  }
  
  //background.verticalSymmetry();
  player.update();
  time.update();
  drawInfo();
}