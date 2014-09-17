
PFont thefont;
lukeMarkov mc;

void setup()
{
  size(800, 600);
  frameRate(1);
  thefont = loadFont("MatrixNarrow-128.vlw");
  textFont(thefont);
  textSize(128);
  textAlign(CENTER);
  
  String chapters[] = loadStrings("austin_cooked.txt");
  mc = new lukeMarkov(chapters);
}

void draw()
{
  background(0);
  stroke(255);
  mc.tick();
  text(mc.current, width/2, height/2);
}

