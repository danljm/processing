int DIM_X = 2727;
int DIM_Y = 1443;
int count = 0;
PImage ab;

void setup() {
  size(DIM_X, DIM_Y);
  ab = loadImage("C:/Users/Danny/Pictures/The-Last-Supper.jpg");  
  background(255);
  //image(ab,0,0);
  smooth();
  // don't show where control points are
  noFill();
  
  
  randomSeed(0);
  for(int i = 0; i < 1000; ++i) {
      strokeWeight(random(4));
      RandomCurve curve = new RandomCurve(3, 600);
      curve.drawCurve();
  }
  
  save("TheLastSupper.png");
}

/*void draw() {
  if((keyPressed == true) && (key == 'd')) {
    strokeWeight(random(5));
    RandomCurve curve = new RandomCurve(50, 600);
    curve.drawCurve();
  }

}*/

color readBackground(int x, int y) {
  // translate into ba image dimensions
  int ax = int(x * (ab.width*1.0)/DIM_X);
  int ay = int(y * (ab.height*1.0)/DIM_Y);

  color c = ab.pixels[ay*ab.width+ax];
  return c;
}

class RandomCurve {
  int points = 0;
  float boundRatio = 0.8;
  float bound = 0;
  Point [] vertexPoints;
  BezierControl [] controlPoints;
  
  RandomCurve(int points, float bound) {
    this.points = points;
    this.bound = bound;
    controlPoints = new BezierControl[points];
    vertexPoints = new Point[points];
    
    generatePoints();
  }
  
  void generatePoints() {
    for(int i = 0; i < points; ++i) {
      bound *= boundRatio;
      
      int x;
      int y;
      if (i == 0) {
        x = (int) random(DIM_X);
        y = (int) random(DIM_Y);
      } else {
        x = vertexPoints[i-1].x;
        y = vertexPoints[i-1].y;
      }
      
      
      int lowerBoundX = getLowerBound(x, (int) bound);
      int highBoundX = getHigherBoundX(x, (int) bound);
      int lowerBoundY = getLowerBound(y, (int) bound);
      int highBoundY = getHigherBoundY(y, (int) bound);
      
      vertexPoints[i] = new Point((int) random(lowerBoundX, highBoundX), (int) random(lowerBoundY, highBoundY));
      controlPoints[i] = new BezierControl(new Point((int) random(lowerBoundX, highBoundX), (int) random(lowerBoundY, highBoundY)), new Point((int) random(lowerBoundX, highBoundX), (int) random(lowerBoundY, highBoundY))); 
    }
  }
  
  int getHigherBoundX(int val, int bound) {
    if((val + bound) > DIM_X) {
      return (int) random(DIM_X);
    } else {
      return (val + bound);
    }
  }
  
  int getHigherBoundY(int val, int bound) {
    if((val + bound) > 0) {
      return (int) random(DIM_Y);
    } else {
      return (val + bound);
    }
  }
  
  int getLowerBound(int val, int bound) {
    if((val - bound) < 0) {
      return 0;
    } else {
      return (val - bound);
    }
  }
  
  void drawCurve() {
    color c = readBackground(vertexPoints[0].x, vertexPoints[0].y);
    stroke(c);
    beginShape();
    vertex(vertexPoints[0].x, vertexPoints[0].y);
    for(int i = 1; i < points; ++i) {
      bezierVertex(controlPoints[i].c1.x, controlPoints[i].c1.y, controlPoints[i].c2.x, controlPoints[i].c2.y, vertexPoints[i].x, vertexPoints[i].y);
    }
    endShape();
  }
}

class Point {
   int x;
   int y;
  
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

class BezierControl {
  Point c1;
  Point c2;

  BezierControl(Point c1, Point c2) {
    this.c1 = new Point(c1.x, c1.y);
    this.c2 = new Point(c2.x, c2.y);
  }
}
