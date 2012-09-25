//Danny Morris
//Graphics and Computational Geometry Final

int NUM_POINTS = 50000;
float x[];  // point x
float y[];  // point y
color c[];  // point color

// background image
PImage ab;

color readBackground(float x, float y) {
  
  // translate into ba image dimensions
  int ax = int(x * (ab.width*1.0)/1920);
  int ay = int(y * (ab.height*1.0)/1080);

  color c = ab.pixels[ay*ab.width+ax];
  return c;
}

void setup() {
  size(1920,1080,P3D);
  
  ortho(-width/2,width/2,-height/2,height/2,-10,10);
  
  x = new float[NUM_POINTS];
  y = new float[NUM_POINTS];
  c = new color[NUM_POINTS];
  
  ab = loadImage("Wish You Were Here LPs.jpg");
  
  for (int i = 0; i < NUM_POINTS; i++) {
    x[i] = random(width);
    y[i] = random(height);
    c[i] = readBackground(x[i],y[i]);
  }
}

void draw() {

  background(0);
  
  // draw the cones
  pushMatrix();
  // -10 means the cones are below the surface
  // (so we can draw on top of them later)
  translate(0,0,-10);
  for (int i = 0; i < NUM_POINTS; i++) {
    fill(c[i]);
    noStroke();
    cone(x[i],y[i],50.0,10.0); // if you have more points, use a smaller radius (but you risk having gaps)
  }
  popMatrix();
  
  save("output.png");
}

static float unitConeX[];
static float unitConeY[];
static int coneDetail;

static {
  coneDetail(24);
}

// just inits the points of a circle, 
// if you're doing lots of cones the same size then you'll want to cache height and radius too
static void coneDetail(int det) {
  coneDetail = det;
  unitConeX = new float[det+1];
  unitConeY = new float[det+1];
  for (int i = 0; i <= det; i++) {
    float a1 = TWO_PI * i / det;
    unitConeX[i] = (float)Math.cos(a1);
    unitConeY[i] = (float)Math.sin(a1);
  }
}

// places a cone with it's base centred at (x,y), beight h in positive z, radius r.
void cone(float x, float y, float r, float h) {
  pushMatrix();
  translate(x,y);
  scale(r,r);
  beginShape(TRIANGLES);
  for (int i = 0; i < coneDetail; i++) {
    vertex(unitConeX[i],unitConeY[i],0.0);
    vertex(unitConeX[i+1],unitConeY[i+1],0.0);
    vertex(0,0,h);
  }
  endShape();
  popMatrix();
}

