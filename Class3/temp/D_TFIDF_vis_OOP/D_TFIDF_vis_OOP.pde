// do a term frequency inverse document frequency analysis and show it

String[] chapters;
int whichchapter = 1;

lukeTFIDF thestuff;
PFont thefont;
ArrayList<String> viswords;
ArrayList<Float> xpos;
ArrayList<Float> ypos;
float ncoeff;

float thresh = 0.2; // threshold for vis

void setup()
{
  size(800, 600);
  thefont = loadFont("Courier-48.vlw");
  textFont(thefont);
  textAlign(CENTER);
  
  // create new (blank) arraylists
  viswords = new ArrayList<String>();
  xpos = new ArrayList<Float>();
  ypos = new ArrayList<Float>();

  // load our text file
  chapters = loadStrings("austin_cooked.txt");
  
  thestuff = new lukeTFIDF(chapters);
}

void draw()
{
  background(0);
  stroke(255);

  for (int i = 0; i<viswords.size(); i++)
  {
    String theword = viswords.get(i);
    float x = xpos.get(i);
    float y = ypos.get(i);
    
    if(float(height-mouseY)/height > float(i)/viswords.size()) {
    textSize(48*thestuff.getValue(theword)*(float(mouseX)/width+0.5));
    text(theword, x, y);
    }
    
    xpos.set(i, x+noise(ncoeff+i)-0.5);
    ypos.set(i, y+noise(ncoeff+i+5000.)-0.5);
  }
  
  ncoeff+=0.001;
}

void keyReleased()
{
  println("doing thestuff for chapter " + whichchapter + "...");

  // flush our arraylist
  viswords = new ArrayList<String>();
  xpos = new ArrayList<Float>();
  ypos = new ArrayList<Float>();

  thestuff.setLine(whichchapter);

  String[] keys = thestuff.getKeys(); // copy keylist into an array
  int i = 0;
  while (true)
  {
    if (thestuff.getValue(keys[i])<thresh) break;
    float val = thestuff.getValue(keys[i]);
    println(keys[i] + ": " + val);
    viswords.add(keys[i]);
    xpos.add(width/2.0);
    ypos.add(height/2.0);
    i++;
  }

  whichchapter = (whichchapter+1) % chapters.length;
}


