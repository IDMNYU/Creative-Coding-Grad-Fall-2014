
int NUMCIRCLES = 1000;

// variables
float[] thex = new float[NUMCIRCLES];
float[] they = new float[NUMCIRCLES];
float[] thev = new float[NUMCIRCLES];
float[] thet = new float[NUMCIRCLES];

int i; // THE GREAT COUNTER VARIABLE

float dia = 15; // diameter

void setup()
{
  size(1000, 800);
  
  thex = random(0, width);
  they = random(0, height);
  
  thev = random(5, 20); // how much to move?
  thet = random(0, TWO_PI);
  
}

void draw()
{
  background(0);
  fill(255);
  
  ellipse(thex, they, 30, 30);
  
  // increment the position in polar coordinates
  thex = thex + thev*cos(thet);
  they = they + thev*sin(thet);
  
  // bounce off the walls
  if(thex > width) thet = PI - thet;
  if(thex < 0) thet = PI - thet;
  if(they > height) thet = TWO_PI - thet;
  if(they < 0) thet = TWO_PI - thet;
  
}
