// load a text file and spit it out into a new one for working with

// no draw()... nothing to see here

void setup()
{
  
  //
  // step 1: load the file
  //
  
  String[] raw = loadStrings("austen_raw.txt");

  // let's look at it:
  // printarray(raw);

  //
  // step 2: fix the text
  //
  
  String cooked = "";

  // concatenate into one string
  for (int i = 0; i<raw.length; i++)
  {
    cooked+=raw[i]+"\n";
  }

  // view:
  //println(cooked);

  // strip all punctuation
  cooked = cooked.replaceAll("[^a-zA-Z0-9' ]", " ");
  // move to lowercase
  cooked = cooked.toLowerCase();
  // strip extra whitespace
  cooked = cooked.trim().replaceAll(" +", " ");

  // view:
  // println(cooked);

  //
  // step 3: split by chapter into new lines
  //
  
  String[] chapters = cooked.split("chapter [0-9]+ ");

  // how many chapters?
  // println(chapters.length);

  // view each one
  // printarray(chapters); 

  //
  // step 4: output to "cooked" file
  //
  
  PrintWriter output = createWriter("austin_cooked.txt");

  // write line-by-line, trimming extra whitespace (again)
  for (int i = 0; i<chapters.length; i++)
  {
    output.println(chapters[i].trim());
  }

  // finish up
  output.flush();
  output.close();

  //
  // step 5: exit program
  //
  
  exit();
}

// utility function to print out an array of strings to the console
void printarray(String[] p)
{
  for (int i = 0; i<p.length; i++)
  {
    println(p[i]);
  }
}

