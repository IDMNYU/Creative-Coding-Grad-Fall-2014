// do a term frequency inverse document frequency analysis and show it

String[] chapters;
FloatDict df; // document (corpus) frequency
FloatDict tf; // term frequency for specific chapter
int whichchapter = 1;

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
  
  // create new (blank) dictionary
  df = new FloatDict();

  // create new (blank) arraylists
  viswords = new ArrayList<String>();
  xpos = new ArrayList<Float>();
  ypos = new ArrayList<Float>();

  // load our text file
  chapters = loadStrings("austin_cooked.txt");
  // how many lines?
  // println("loaded... " + chapters.length + " lines!");

  // create document frequency array of entire corpus
  for (int i = 0; i<chapters.length; i++)
  {
    String[] words = chapters[i].split(" ");
    // println("chapter " + i + " has " + words.length + " words."); 

    // add words to dictionary
    for (int j = 0; j<words.length; j++)
    {
      String currentword = words[j];
      if (df.hasKey(currentword)) // word exists in dictionary
      {
        df.add(currentword, 1);
      } else // new word, add '1' for initial value
      {
        df.set(currentword, 1);
      }
    }
  }
  // sort dictionary
  df.sortValuesReverse();
  // dump entire dictionary
  // println(df);
  // print top 100 words
  // String[] keys = df.keyArray(); // copy keylist into an array
  // for (int i = 0; i<100; i++)
  // {
  //   float val = df.get(keys[i]);
  //   println(keys[i] + ": " + val);
  // }
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
    textSize(48*tf.get(theword)*(float(mouseX)/width+0.5));
    text(theword, x, y);
    }
    
    xpos.set(i, x+noise(ncoeff+i)-0.5);
    ypos.set(i, y+noise(ncoeff+i+5000.)-0.5);
  }
  
  ncoeff+=0.001;
}

void keyReleased()
{
  println("doing TFIDF for chapter " + whichchapter + "...");

  // flush our arraylist
  viswords = new ArrayList<String>();
  xpos = new ArrayList<Float>();
  ypos = new ArrayList<Float>();

  tf = TFIDF(chapters[whichchapter], df);
  // dump entire dictionary
  // println(tf);
  // print words above thresh
  String[] keys = tf.keyArray(); // copy keylist into an array
  int i = 0;
  while (true)
  {
    if (tf.get(keys[i])<thresh) break;
    float val = tf.get(keys[i]);
    println(keys[i] + ": " + val);
    viswords.add(keys[i]);
    xpos.add(width/2.0);
    ypos.add(height/2.0);
    i++;
  }

  whichchapter = (whichchapter+1) % chapters.length;
}


FloatDict TFIDF(String s, FloatDict d)
{
  FloatDict t = new FloatDict();
  String[] words = s.split(" ");

  // add words to dictionary
  for (int i = 0; i<words.length; i++)
  {
    String currentword = words[i];
    if (t.hasKey(currentword)) // word exists in dictionary
    {
      t.add(currentword, 1);
    } else // new word, add '1' for initial value
    {
      t.set(currentword, 1);
    }
  }

  // divide by master dictionary
  String[] keys = t.keyArray(); // copy keylist into an array
  for (int i = 0; i<keys.length; i++)
  {
    float docfreq = d.get(keys[i]);
    t.div(keys[i], docfreq);
  }

  // sort dictionary
  t.sortValuesReverse();

  // return the TFIDF for this string
  return(t);
}

