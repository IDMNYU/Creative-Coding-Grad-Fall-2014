
PImage mittens;

float r = 0;

PVector t = new PVector(0, 0, 0);
PVector s = new PVector(30, 30, 0);

float v = 5; // this is a velocity

void setup()
{

  size(800, 600, OPENGL);

  sphereDetail(20); // how crappy is the sphere?

  lights();
  
  mittens = loadImage("mitt.jpg");
  
}

void draw()
{
  background(0);
  stroke(255, 50);
  
  t.x = mouseX;
  t.y = mouseY;

  fill(255, 0, 0);
  pushMatrix();
  translate(t.x, t.y);
  rotate(r, 0, 0, 1);
  image(mittens, 0, 0, 150, 150);
  popMatrix();
  
  fill(0, 255, 0);
  pushMatrix();
  translate(s.x, s.y);
  rotate(r, 1, 0, 0);
  image(mittens, 0, 0, 150, 150);
  popMatrix();
  
  float angle = atan((t.y-s.y)/(t.x-s.x));
  if(t.x<s.x) angle+=PI;
  float distance = sqrt((s.x-t.x)*(s.x-t.x) + (s.y-t.y)*(s.y-t.y));
  
  distance = distance*0.1;
  v = constrain(50-distance, 0, 50);
  
  s.x = s.x + v*cos(angle);
  s.y = s.y + v*sin(angle);
  
  line(s.x, s.y, t.x, t.y);
  
  

  r+=0.01;
}

