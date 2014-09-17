// do a term frequency inverse document frequency analysis

String[] chapters;
FloatDict df; // document (corpus) frequency
FloatDict tf; // term frequency for specific chapter
int whichchapter = 1;

void setup()
{
  // create new (blank) dictionary
  df = new FloatDict();

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
}

void keyReleased()
{
  println("doing TFIDF for chapter " + whichchapter + "...");
  tf = TFIDF(chapters[whichchapter], df);
  // dump entire dictionary
  // println(tf);
  // print words above 0.75
  String[] keys = tf.keyArray(); // copy keylist into an array
  float thresh = 0.5;
  int i = 0;
  while(true)
  {
    if(tf.get(keys[i])<thresh) break;
    float val = tf.get(keys[i]);
    println(keys[i] + ": " + val);
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

