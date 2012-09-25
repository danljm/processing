// Peter de Jong
// j.tarbell   January, 2004
// Albuquerque, New Mexico
// complexification.net

// based on code by p. bourke
// http://astronomy.swin.edu.au/~pbourke/

// Processing 0085 Beta syntax update
// j.tarbell   April, 2005

static final int DIM_X = 1920;
static final int DIM_Y = 1080;

float a, b, c, d;
float gs = 3.5;
float gx = 0.5;
float gy = 0.75;
int fadebg;
int exposures;
int maxage = 128;  

int num = 0;
int maxnum = 4000;
TravelerHenon[] travelers = new TravelerHenon[maxnum];

// frame counter for animation
float time;

void setup() {
  size(DIM_X, DIM_Y, P3D);
  background(255);
  rectMode(CORNER);
  noStroke();

  // bourke constants
  a = 2.01;
  b = -2.53;
  c = 1.61;
  d = -0.33  ;
  
  // make some travelers
  for (int i=0;i<maxnum;i++) {
    travelers[i] = new TravelerHenon();
    num++;
  } 
}

void draw() {
  for (int i=0;i<num;i++) {
    travelers[i].draw();
  }
  exposures+=num;
}

void mousePressed() {
  // reset the image  
  reset();
}



void reset() {
  background(255);
  exposures = 0;
  gs = 3.0;
  gx = 0.5;
  gy = 0.5;
  a = random(-2.5,2.5);
  b = random(-2.5,2.5);
  c = random(-2.5,2.5);
  d = random(-2.5,2.5);
  
  for (int i=0;i<num;i++) {
    travelers[i].rebirth();
  }

}


class TravelerHenon {
  float x, y;
  float xn, yn;

  int age = 0;
  
  TravelerHenon() {
    // constructor
    x = random(-1.0,1.0);
    y = random(-1.0,1.0);
  }
  
  void draw() {
      // move through time
      xn = sin(a*y) - cos(b*x);
      yn = sin(c*x) - cos(d*y);
      
      float d = sqrt((xn-x)*(xn-x) + (yn-y)*(yn-y));
      x = xn;
      y = yn;
      
      // render single transparent pixel
      stroke(0,5);
      point((x/gs+gx)*DIM_X,(y/gs+gy)*DIM_Y);
      
      // age
      age++;
      if (age>maxage) {
        // begin anew
        rebirth();
      }
        
  }  
  
      
  
  void rebirth() {
    x = random(0.0,1.0);
    y = random(-1.0,1.0);
    age = 0;
  }    
 
}    


// Peter de Jong
// j.tarbell   January, 2004
