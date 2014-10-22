
PImage cat;
int w, h;
int xpos = 0;
float scale = 1.0;

void setup()
{
  size(800, 600);
  background(0);
  cat = loadImage("cat.jpg");
  w = cat.width;
  h = cat.height;
  println("the image is: " + w + " by " + h);
}

void draw()
{
  // image, srcx, srcy, srcw, srch, dstx, dsty, dstw, dth, MODE
  blend(cat, xpos, 50, 50, 50, mouseX, mouseY, int(50*scale), int(50*scale), BLEND); 
  xpos = xpos+1;
  if(xpos>w-50) xpos = 0;
  scale = scale*1.1;
  if(scale>3.) scale = 1.;
}
