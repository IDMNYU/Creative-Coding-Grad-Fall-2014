
String[] chapters; // this is gonna be the book
int whichchapter = 1; // what chapter are we looking at?

lukeTFIDF thestuff; // this stores all the data and does all the work

PFont thefont; // this is our font
ArrayList<String> viswords;
ArrayList<Float> xpos;
ArrayList<Float> ypos;

float noisecounter;

float thresh = 0.2;

void setup()
{
  size(800, 600);
  thefont = loadFont("ACaslonPro-Italic-96.vlw");
  textFont(thefont);
  textAlign(CENTER);

  // blankify our arraylists
  viswords = new ArrayList<String>();
  xpos = new ArrayList<Float>();
  ypos = new ArrayList<Float>();

  // load in our text file
  chapters = loadStrings("austin_cooked.txt");

  // create a TFIDF object and preload it up with the stuff
  thestuff = new lukeTFIDF(chapters);

  // do chapter 1's TFIDF at the beginning
  thestuff.setLine(whichchapter); // do the TFIDF
}

void draw()
{
  background(0);
  stroke(255);

  for (int i = 0; i<viswords.size (); i++)
  {
    String theword = viswords.get(i);
    float x = xpos.get(i);
    float y = ypos.get(i);

    if (float(height-mouseY)/height > float(i)/viswords.size())  
    {  
    textSize(48*thestuff.getValue(theword)*float(mouseX)/width*2.0);    
    text(theword, x, y);
    }

    xpos.set(i, x+noise(noisecounter+i)-0.5);
    ypos.set(i, y+noise(noisecounter+i+5000.)-0.5);
  }
  noisecounter+=0.001;
}

void keyReleased()
{
  println("doing the TFIDF for chapter " + whichchapter + "!!!!");

  // blankify our arraylists
  viswords = new ArrayList<String>();
  xpos = new ArrayList<Float>();
  ypos = new ArrayList<Float>();

  thestuff.setLine(whichchapter); // do the TFIDF

  String[] keys = thestuff.getKeys();
  int i = 0;
  while (true)
  {
    if (thestuff.getValue(keys[i])<thresh) break;
    float val = thestuff.getValue(keys[i]);
    viswords.add(keys[i]);
    xpos.add(width/2.0);
    ypos.add(height/2.0);
    println(keys[i] + ": " + val);
    i++;
  }

  whichchapter = (whichchapter + 1) % chapters.length;
}

