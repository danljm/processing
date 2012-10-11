Agent [] agents;
PImage img;
static int AGENT_SIZE = 1;
static int NUM_AGENTS = 50;

void setup() {
  size(1000,1000);
  smooth();
  noStroke();
  background(255);
  
  agents = new Agent[NUM_AGENTS];

  for (int i=0; i < NUM_AGENTS; ++i) {
    agents[i] = new Agent(random(0,width),random(0,height));
  }
}

void draw() {
  //background(255);
  for (int i=0; i < NUM_AGENTS; ++i) {
    agents[i].move();
  }
}

class Agent {
  PVector loc;

  Agent(float xpos, float ypos) {
    loc = new PVector(xpos, ypos);
  }

  void move() {

    fill(0, 30);
    //rect(loc.x, loc.y, AGENT_SIZE, AGENT_SIZE);
    ellipse(loc.x, loc.y, AGENT_SIZE, AGENT_SIZE);

    float moveX = int(random(-2, 2)) * AGENT_SIZE;
    float moveY = int(random(-2, 2)) * AGENT_SIZE;

    PVector move = new PVector(moveX, moveY);
    loc.add(move);
    
    checkBounds();    
  }
  
  void checkBounds() {
    if (loc.x > width) {
      loc.x = 0;
    } else if (loc.x < 0) {
      loc.x = width;
    }

    if (loc.y > height) {
      loc.y = 0;
    } else if (loc.y < 0) {
      loc.y = height;
    }
  }
}