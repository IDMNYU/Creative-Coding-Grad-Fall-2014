// load a text file and spit it out again, all cleaned up
// no draw() loop

int currentline = 0;
String[] raw;
void setup()
{
  //
  // step 1: load the text file 
  //

  raw = loadStrings("austen_raw.txt");
  //printarray(raw);
}

void draw()
{
  
}
void printarray(String[] p)
{
  for (int i= 0; i<p.length; i++)
  {
    println(p[i]);
  }
}

void keyPressed()
{
   println(raw[currentline]);
   currentline = (currentline+1) % raw.length;
}

