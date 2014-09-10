
int NUMSPHERES = 100;

PImage mittens;

PVector t = new PVector(0, 0);

mySphere p[] = new mySphere[NUMSPHERES];

int i; // THE AMAZING COUNTER VARIABLE

void setup()
{
   size(1000, 500, OPENGL); 
   
   sphereDetail(10);
   
   for(i=0;i<NUMSPHERES;i++)
   {
     p[i] = new mySphere(random(1,20));
   }
   
   mittens = loadImage("mitt.jpg");
  
}

void draw()
{
  background(0);
  lights();
  
  t.x = mouseX;
  t.y = mouseY;
  
  for(i=0;i<NUMSPHERES;i++)
  {
     p[i].go(); 
     p[i].update(t);
  }
  
}

void keyPressed()
{
    for(i=0;i<NUMSPHERES;i++)
   {
     p[i] = new mySphere(random(1,20));
   }
 
  
}
