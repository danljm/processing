// Box Fitting Image
// j.tarbell   May, 2004
// Albuquerque, New Mexico
// complexification.net

// Processing 0085 Beta syntax update 
// j.tarbell   April, 2005

int num = 0;
int maxnum = 10000;
int dimx = 1680;
int dim = 1050;
int dimborder = 20;
int time;

Box[] boxes;

// background image
PImage ab;



// MAIN -----------------------------------------------------------

void setup() {
  //size(1680,1050,P3D);
  size(dimx,dim,P3D);
  rectMode(CENTER);
  noStroke();
  
  // create boxes
  boxes = new Box[maxnum];
  
  // load background image
  ab = loadImage("supper.jpg");

  resetAll();
}

void draw() {
  for (int n=0;n<num;n++) {
    boxes[n].draw();     
  }  
}

void mousePressed() {
  resetAll();
}

void resetAll() {      
  // stop drawing
  num=0;
  
  // clear screen, prepare canvas
  background(0);
  drawWhiteBorder();
  
  // initialize just five starting boxes
  for(int i=0;i<1000;i++){
    makeNewBox();
  }
 
}


void makeNewBox() {
  if (num<maxnum) {
    boxes[num] = new Box();
    num++;
  }
}

void drawWhiteBorder() {
  // draw white border
  rectMode(CORNER);
  noStroke();
  fill(255);
  rect(0,0,dimx,dimborder);
  rect(0,0,dimborder,dim);
  rect(0,dim-dimborder,dimx,dimborder);
  rect(dimx-dimborder,0,dimborder,dim);
  rectMode(CENTER);
}


color readBackground(int x, int y) {
  // translate into ba image dimensions
  int ax = int(x * (ab.width*1.0)/dimx);
  int ay = int(y * (ab.height*1.0)/dim);

  color c = ab.pixels[ay*ab.width+ax];
  return c;
}


// OBJECTS ------------------------------------------------------


// space filling box
class Box {

  int x;
  int y;
  int d;

  color myc;
  boolean okToDraw;
  boolean chaste = true;

  Box() {
    // random initial conditions
    selfinit();
  }
  
  void selfinit() {
    // position
    okToDraw = false;    
    x = int(dimborder+random(dimx-dimborder*2));
    y = int(dimborder+random(dim-dimborder*2));
    d = 0;
    myc = readBackground(x,y);
  }

  void draw() {
    expand();
    if (okToDraw) {
      fill(myc);
      noStroke();
      
      rect(x,y,d,d);

    }
  }

  void expand() {
    // assume expansion is ok
    d+=2;
    
    // look for obstructions around perimeter at width d
    int obstructions = 0;
    for (int j=int(x-d/2-1);j<int(x+d/2);j++) {
      int k=int(y-d/2-1);
      obstructions += checkPixel(j,k);
      k=int(y+d/2);
      obstructions += checkPixel(j,k);
    }      
    for (int k=int(y-d/2-1);k<int(y+d/2);k++) {
      int j=int(x-d/2-1);
      obstructions += checkPixel(j,k);
      j=int(x+d/2);
      obstructions += checkPixel(j,k);
    }      
      
    if (obstructions>0) {
      // reset
      selfinit();    
      if (chaste) {
        makeNewBox();
        chaste = false;
      }
    } else {
      okToDraw = true;
    }
  }

  int checkPixel(int x, int y) {
    if ((x>dimborder) && (x<dimx-dimborder) || (x==0) || (x==dimx-1)) {
      if ((y>dimborder) && (y<dim-dimborder) || (y==0) || (y==dim-1)) {
        color c = get(x, y);
        if ((red(c)+blue(c)+green(c))>0) {
          // a lit pixel has been found
          return 1;
        } else {
          return 0;
        }
      }
    }
    return 0;
  }
}

// j.tarbell   May, 2004
