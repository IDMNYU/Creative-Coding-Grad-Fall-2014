
// this is our sphere class of goodness

class mySphere
{
  // these are the properties
  PVector s = new PVector(0, 0); // where am i?
  float v = 5; // velocity?
  float a = 0; // angle?
  float d = 5; // diameter

  // constructor : provide a diameter
  mySphere(float diameter)
  {
    d = diameter;
    s.x = random(0, width);
    s.y = random(0, height);
    a = random(0, TWO_PI);
    v = random(0.3, 4);
  }

  void go() // this draw the sphere
  {
    fill(255);
    noStroke();
    pushMatrix();
    translate(s.x, s.y);
    //sphere(d);
    image(mittens, 0, 0, 20, 20);
    popMatrix();
  }

  void update(PVector q) // this moves the sphere
  {
    a = atan((q.y-s.y)/(q.x-s.x));
    if (q.x<s.x) a+=PI;
    float distance = sqrt((s.x-q.x)*(s.x-q.x) + (s.y-q.y)*(s.y-q.y));

    v = constrain(1000-distance, 0, 1000);
    v = v*0.001;

    s.x = (s.x + v*cos(a)+width)%width; 
    s.y = (s.y + v*sin(a)+height)%height;
  }
}

