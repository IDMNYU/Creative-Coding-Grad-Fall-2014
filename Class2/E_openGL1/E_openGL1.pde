
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
  ellipse(0, 0, 50, 50);

}
