/**
Inspired on work by Holger Lippmann
http://e-art.co
**/

int DIM_X = 3200;
int DIM_Y = 2400;
int BOUND = 800;
PImage ab;

void setup() {
  size(DIM_X, DIM_Y);
  ab = loadImage("C:/Users/Danny/Pictures/Random Curves/candy.jpg");  
  background(255);
  //image(ab,0,0);
  smooth();
  // don't show where control points are
  noFill();
  
  
  randomSeed(0);
    for(int i = 0; i < 15000; ++i) {
      float x = random(DIM_X);
      float y = random(DIM_Y);
      color c = readBackground((int)x, (int)y);
      stroke(c);
      strokeWeight(random(6));
      drawCurve(x, y, (int) random(200, 800));
  }
  
  save("candy.png");
}

/*void draw() {
  if(mousePressed == true) {
    float x = mouseX; //random(DIM_X);
    float y = mouseY; //random(DIM_Y);
    color c = readBackground((int)x, (int)y);
    stroke(c);
    strokeWeight(random(5));
    drawCurve(x, y);
  }
  
  if((keyPressed == true) && (key == 's')) {
    save("Flowers3.png");
  }
}*/

void drawCurve(float x, float y, int bound) {
  beginShape();
  vertex(x, y); // first point
  float lowerBoundX = x - bound;
  float highBoundX = x + bound;
  float lowerBoundY = y - bound;
  float highBoundY = y + bound;
  bezierVertex(random(lowerBoundX, highBoundX), random(lowerBoundY, highBoundY), random(lowerBoundX, highBoundX), random(lowerBoundY, highBoundY), random(lowerBoundX, highBoundX), random(lowerBoundY, highBoundY));
  endShape();
}

color readBackground(int x, int y) {
  // translate into ba image dimensions
  int ax = int(x * (ab.width*1.0)/DIM_X);
  int ay = int(y * (ab.height*1.0)/DIM_Y);

  color c = ab.pixels[ay*ab.width+ax];
  return c;
}
