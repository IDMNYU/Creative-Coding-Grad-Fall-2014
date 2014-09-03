
// this is a comment
/*
this
is
a
comment
*/

float r, g, b, a, radius, x1, y1, x2, y2; // GLOBAL variables


// this runs at the beginning
void setup()
{
  size(800, 600); // change the size
  
  rectMode(CENTER); // change the way rectangles draw
  
  background(255); // start with a white background
  
  x1 = width/2;
  y1 = height/2;
  
}

// this runs every frame
void draw()
{

  // give me some random values
  r = random(128, 255);
  g = random(0, 192);
  b = random(0, 50);
  a = random(50, 100);
  
  x2 = x1+random(-20, 20);
  y2 = y1+random(-20, 20);
  
  radius = 0;
  radius+= random(0, 30);
  radius+= random(0, 30);
  radius+= random(0, 30);
  radius = radius/3.;
  
  stroke(r, g, b, a);
  line(x1, y1, x2, y2);
  
  // this is the key part:
  x1 = x2;
  y1 = y2;
  
  // draw the stuff
  fill(r, g, b, a); // interior fill color
  ellipse(x2, y2, radius, radius); // circle that chases the mouse
  
  if(x1>width) x1 = 0;
  if(x1<0) x1 = width-1;
  if(y1>height) y1 = 0;
  if(y1<0) y1 = height-1;
}

// run whenever i release a key
void keyReleased()
{
   background(255); // white out the screen
}

