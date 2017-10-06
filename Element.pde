abstract class Element {
  int red =255, green =255, blue = 255;
  abstract void update();
  abstract Point[] returnPoints();
}