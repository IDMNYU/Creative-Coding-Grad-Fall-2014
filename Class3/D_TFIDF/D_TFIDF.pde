
String[] chapters; // this is gonna be the book
int whichchapter = 1; // what chapter are we looking at?

lukeTFIDF thestuff; // this stores all the data and does all the work

float thresh = 0.5;

void setup()
{
  
  
  // load in our text file
  chapters = loadStrings("austin_cooked.txt");

  // create a TFIDF object and preload it up with the stuff
  thestuff = new lukeTFIDF(chapters);
  


}

void draw()
{
  
}

void keyReleased()
{
  println("doing the TFIDF for chapter " + whichchapter + "!!!!");
  thestuff.setLine(whichchapter);
  
  String[] keys = thestuff.getKeys();
  int i = 0;
  while (true)
  {
    if(thestuff.getValue(keys[i])<thresh) break;
    float val = thestuff.getValue(keys[i]);
    println(keys[i] + ": " + val);
    i++;
  }
  
  whichchapter = (whichchapter + 1) % chapters.length;
  
}
