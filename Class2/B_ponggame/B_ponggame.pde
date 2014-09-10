
float thex, they, thev, thet; // variables

void setup()
{
  size(800, 400);
  
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
