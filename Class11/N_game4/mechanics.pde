void makeHarder()
{
  NUMWORDS*=HARDFACTOR;
  VELOCITY*=HARDFACTOR;
  LEVEL++;
}

void addWall()
{
  int orientation = int(random(0, 2));
  float longway = random(100, 300);
  float shortway = random(2, 10);
  if (orientation==0) {
    lukeWall temp = new lukeWall(random(0, width), random(0, height), longway, shortway);
    thewalls.add(temp);
  } else 
  {
    lukeWall temp = new lukeWall(random(0, width), random(0, height), shortway, longway);
    thewalls.add(temp);
  }
}

