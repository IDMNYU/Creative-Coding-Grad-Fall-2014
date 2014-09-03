
// my dog has fleas
/*
my
dog
has
fleas
*/

  float r, g, b, a, w, h; // GLOBAL variables


void setup()
{
  size(800, 600); // change the size
  
  rectMode(CENTER);
  
  r = 255;
  g = 255;
  b = 255;
  a = 255;
  
  background(255);
  
}

void draw()
{
  
  fill(255, 255, 255, 5);
  rectMode(CORNER);
  rect(0, 0, width, height);

  r = random(0, 255);
  g = random(0, 255);
  b = random(0, 255);
  a = random(0, 255);
  w = random(0, 100);
  h = random(0, 100);
  
  fill(r, g, b, a);
  rectMode(CENTER);
  rect(mouseX, mouseY, w, h);
}

