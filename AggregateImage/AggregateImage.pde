/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */
 
PImage a, b, c, d, e, f, g, h, i, j, k;  // Declare variable "a" of type PImage

void setup() {
  size(704, 939);
  // The file "jelly.jpg" must be in the data folder
  // of the current sketch to load successfully
  a = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01242.JPG");  // Load the image into the program
  b = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01243.JPG");   
  c = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01244.JPG"); 
  d = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01245.JPG"); 
  e = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01246.JPG");
  f = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01247.JPG");
  g = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01248.JPG");
  h = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01249.JPG");
  i = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01250.JPG");
  j = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01251.JPG");
  k = loadImage("C:\\Users\\Danny\\Pictures\\Spring Break 2008\\DSC01252.JPG");
  noLoop();  // Makes draw() only run once
}

void draw() {
  // Displays the image at its actual size at point (0,0)
  tint(255,30);
  image(a, 0, 0, a.width/3, a.height/3); 
  image(b, 0, 0, a.width/3, a.height/3); 
  image(c, 0, 0, a.width/3, a.height/3); 
  image(d, 0, 0, a.width/3, a.height/3); 
  image(e, 0, 0, a.width/3, a.height/3);
  image(f, 0, 0, a.width/3, a.height/3); 
  image(g, 0, 0, a.width/3, a.height/3); 
  image(h, 0, 0, a.width/3, a.height/3); 
  image(i, 0, 0, a.width/3, a.height/3); 
  image(j, 0, 0, a.width/3, a.height/3); 
  image(k, 0, 0, a.width/3, a.height/3); 
 

}
