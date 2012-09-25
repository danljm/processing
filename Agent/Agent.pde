Agent test = new Agent(new PVector(100,100), new PVector(5,5), new PVector(1,1));

void setup() {
  size(600,800);
  smooth();
  
}

void draw() {
  background(0);
  fill(255);
  test.update();
  test.render();
}

class Agent {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  public Agent(PVector loc, PVector vel, PVector acc) {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = acc; 
  }
 
  public Agent(PVector loc, PVector vel) {
    Agent(loc, vel, new PVector());
  }  
  
  public Agent(PVector loc) {
    Agent(loc, new PVector(), new PVector());
  }
  
  void update() {
    location.add(velocity);
    velocity.add(acceleration); 
  }
  
  void render() {
    ellipse(location.x, location.y, 5, 5); 
  }
}


