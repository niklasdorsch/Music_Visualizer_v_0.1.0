class Edge {

  Point point1, point2;

  Edge(Point x1, Point x2) {
    this.point1 = x1;
    this.point2 = x2;
  }

  void show() {
    line(point1.x, point1.y, point2.x, point2.y);
  }


  float angle (Edge e2) {

    return anglePoints(point1, point2, e2.point1, e2.point2);
  }
}