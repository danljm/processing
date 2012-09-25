/**
 * Stippling algorithm inspired by Robert Hodgin flight404.com
 */
 
import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;

int NUM_PARTICLES = 1000;

VerletPhysics2D physics;
AttractionBehavior mouseAttractor;
RectConstraint boundingBox;

Vec2D mousePos;

PImage img;

void setup() {
  size(972, 1184, P2D);
  // setup physics with 10% drag
  physics = new VerletPhysics2D();
  physics.setDrag(0.1f);
  physics.setWorldBounds(new Rect(5, 5, width-10, height-10));
  // the NEW way to add gravity to the simulation, using behaviors
  //physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.05f)));
  
  //load the image background
  img = loadImage("C:/Users/Danny/Documents/Processing/Stippling/Portrait_of_George_Washington.jpeg");
  img.loadPixels();
  
  boundingBox = new RectConstraint(new Vec2D(0, width), new Vec2D(0, height));
  
  //if (physics.particles.size() < NUM_PARTICLES) {
  //  addParticle();
  //}
}

void addParticle() {
  VerletParticle2D p = new VerletParticle2D(Vec2D.randomVector().scale(5).addSelf(width / 2, height / 2));
  boundingBox.apply(p);
  physics.addParticle(p);
  // add a negative attraction force field around the new particle
  physics.addBehavior(new AttractionBehavior(p, 10, -.25f));
  
}

void addParticle(float x, float y) {
  VerletParticle2D p = new VerletParticle2D(Vec2D.randomVector().scale(5).addSelf(x, y));
  //physics.addParticle(p);
  // add a negative attraction force field around the new particle
  //physics.addBehavior(new AttractionBehavior(p, 10, -.05f));
  
  StipplingParticle stipplingPart = new StipplingParticle(p, physics);
  
}

void draw() {
  background(0);  
  noStroke();
  smooth();  
  
  for (VerletParticle2D p : physics.particles) {
    color c = readBackground((int)p.x, (int)p.y);
    //p.removeAllBehaviors();
    
    float pSize = particleSize(red(c));
    ellipse(p.x, p.y, pSize, pSize);
  }
  
  physics.update(); 
}

color readBackground(int x, int y) {
  // translate into ba image dimensions
  int ax = int(x * (img.width*1.0)/width);
  int ay = int(y * (img.height*1.0)/height);

  color c = img.pixels[y*img.width+x];
  return c;
}



void mouseDragged() {
  addParticle(mouseX, mouseY);
}

class StipplingParticle{
 
  VerletParticle2D particle;
  VerletPhysics2D physics;
  AttractionBehavior charge;
  Vec2D location;
  float particleScale;  
  
 public StipplingParticle(VerletParticle2D particle, VerletPhysics2D physics) {
   this.particle = particle;
   this.physics = physics;
   
   physics.addParticle(particle);
   
   update(0);
 }

 public void update(float greyValue) {
  physics.removeBehavior(charge);
  particleScale = particleSize(greyValue);
  charge = new AttractionBehavior(p, 10 * particleScale, -.05f);
  
  physics.addBehavior(charge);
  
  ellipse(particle.x, particle.y, particleScale, particleScale);
  
 }

 private float particleSize(float greyValue) {
  return ((greyValue/255) * 10);
} 
}

