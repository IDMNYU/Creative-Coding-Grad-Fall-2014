
float r = 0;

void setup()
{
  size(800, 600, OPENGL);
  
  
}

void draw()
{
  background(0);
  stroke(255);
  noFill();

  translate(mouseX, mouseY);
  rotate(r, 0.43253, -0.31432, 0.534512);
  scale(2.);
  
  beginShape(); // starts a shape
  vertex(-50, -50, 0); // add a point
  vertex(0, 0, -25); // add a point
  vertex(50, 0, 0); // add a point
  vertex(-50, 50, 25); // add a point
  endShape(CLOSE); // ends the shape

  r+=0.1;
}
