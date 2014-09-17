// load a text file and spit it out again, all cleaned up
// no draw() loop


void setup()
{
  //
  // step 1: load the text file 
  //

  String[] raw = loadStrings("austen_raw.txt");
  //printarray(raw);

  //
  // step 2: fix up the text
  //

  String cooked = "";
  for (int i = 0; i<raw.length; i++)
  {
    cooked+=raw[i]+"\n";
  }
  // println(cooked);

  //
  // for more fun with regex... check this out:
  // http://atarininja.org/~wxs/dump/ref/reference.html
  //

  // strip all punctuation (regex)
  cooked = cooked.replaceAll("[^a-zA-Z0-9' ]", " ");
  // move to lowercase
  cooked = cooked.toLowerCase();
  // strip extra whitespace (regex)
  cooked = cooked.trim().replaceAll(" +", " ");

  // view:
  //println(cooked);

  //
  // step 3: split by chapter into a new array
  //

  String[] chapters = cooked.split("chapter [0-9]+ ");

  // how many chapters?
  // println(chapters.length);

  // view each one
  // printarray(chapters);
  
  // step 4: output a "cooked" text file
  PrintWriter output = createWriter("austin_cooked.txt");
  
  // write line-by-line, trimming leading and trailing space
  for (int i = 0;i<chapters.length;i++)
  {
     output.println(chapters[i].trim()); 
  }
  
  output.flush(); // wait for file to finish reading
  output.close(); // close the file
  
  exit(); // kill program
  
}


void printarray(String[] p)
{
  for (int i= 0; i<p.length; i++)
  {
    println(p[i]);
  }
}

