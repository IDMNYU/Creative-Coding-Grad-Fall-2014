
float r = 0;

void setup()
{

  size(800, 600, OPENGL);

  sphereDetail(20); // how crappy is the sphere?

  lights();
}

void draw()
{
  background(0);
  stroke(255, 50);
  fill(192, 100, 0);

  translate(mouseX, mouseY);
  rotate(r, 0.43253, -0.31432, 0.534512);
  sphere(50);

  r+=0.01;
}

