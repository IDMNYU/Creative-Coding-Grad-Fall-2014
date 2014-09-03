
// this is a comment
/*
this
is
a
comment
*/

float r, g, b, a, w, h; // GLOBAL variables


// this runs at the beginning
void setup()
{
  size(800, 600); // change the size
  
  rectMode(CENTER); // change the way rectangles draw
  
  background(255); // start with a white background
  
}

// this runs every frame
void draw()
{

  // give me some random values
  r = random(0, 255);
  g = random(0, 255);
  b = random(0, 255);
  a = random(0, 255);
  w = random(0, 100);
  h = random(0, 100);
  
  // draw the stuff
  fill(r, g, b, a); // interior fill color
  rect(mouseX, mouseY, w, h); // rectangle that chases the mouse
}

// run whenever i release a key
void keyReleased()
{
   background(255); // white out the screen
}

