
float x, y, r, g, b, a;
float currentangle = 270;
float step = 20;
float angle = 45;
float radius;



void setup()
{
  size(800, 600);
  background(255);
  stroke(0, 0, 0, 255);
  
  x = width/2;
  y = height/2;
}

void draw()
{
  
  // give me some random values
  r = random(128, 255);
  g = random(0, 192);
  b = random(0, 50);
  a = random(50, 100);

  radius = 0;
  radius+= random(0, 15);
  radius+= random(0, 15);
  radius+= random(0, 15);
  radius = radius/3.;
  // draw the stuff
  fill(r, g, b, a); // interior fill color
  ellipse(x, y, radius, radius); // circle that chases the mouse


}

void keyReleased()
{
   if(key=='F')
   {
     float x1 = x + step*cos(radians(currentangle));
     float y1 = y + step*sin(radians(currentangle));
      line(x, y, x1, y1);
      x = x1;
      y = y1;
   }
   else if(key=='+')
   {
     currentangle+=angle;
   }
   else if(key=='-')
   {
     currentangle-=angle;     
   }
  
}


