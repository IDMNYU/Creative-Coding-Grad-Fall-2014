
int NUMCIRCLES = 1000;

// variables
float[] thex = new float[NUMCIRCLES];
float[] they = new float[NUMCIRCLES];
float[] thev = new float[NUMCIRCLES];
float[] thet = new float[NUMCIRCLES];

int i; // THE GREAT COUNTER VARIABLE

float dia = 15; // diameter

float decay = 0.99; // velocity decay
float bounce = 2.0; // velocity bounce

void setup()
{
  size(1000, 800);

  for (i = 0; i < NUMCIRCLES; i++)
  {
    thex[i] = random(0, width);
    they[i] = random(0, height);

    thev[i] = random(5, 20); // how much to move?
    thet[i] = random(0, TWO_PI);
  }
}

void draw()
{
  background(0);
  fill(255, 80);

  float mousemotion = sqrt((pmouseX-mouseX)*(pmouseX-mouseX) + (pmouseY-mouseY)*(pmouseY-mouseY));
  println(mousemotion);

  mousemotion = map(mousemotion, 0., 150., 1., 1.5);

  for (i = 0; i<NUMCIRCLES; i++)
  {
    thex[i] = (thex[i] + width) % width;
    they[i] = (they[i] + height) % height;

    ellipse(thex[i], they[i], 30, 30);

    // increment the position in polar coordinates
    thex[i] = thex[i] + thev[i]*cos(thet[i]);
    they[i] = they[i] + thev[i]*sin(thet[i]);

    // bounce off the walls
    if (thex[i] > width || thex[i] < 0)
    {
      thet[i] = PI - thet[i];
      thev[i] = thev[i];
    }
    if (they[i] > height || they[i] < 0)
    { 
      thet[i] = TWO_PI - thet[i];
      thev[i] = thev[i];
    }
   
    thev[i] = thev[i] * decay;
    thev[i] = thev[i] * mousemotion;
  }
}

void keyPressed()
{

  for (i = 0; i < NUMCIRCLES; i++)
  {
    thex[i] = random(0, width);
    they[i] = random(0, height);

    thev[i] = random(5, 20); // how much to move?
    thet[i] = random(0, TWO_PI);
  }
}

