
int MAXWORDS = 10000;
int MAXITERS = 10000;

String markovkey[] = new String[MAXWORDS];
String markovchain[][] = new String[MAXWORDS][MAXITERS];
int markovcount[] = new int[MAXWORDS];
int totalwords; // how may words are in the database
String currentword;

void setup()
{
  String chapters[] = loadStrings("austin_cooked.txt");

  //println("there are " + chapters.length + " lines");
  
  totalwords = 0;
  for (int i=0; i < chapters.length; i++) {
    String[] words = chapters[i].split(" ");
    // go through all the words in each line, adding to database
    for (int j=0; j<words.length-1; j++)
    {
      // look for words already there
      int match = 0;
      for (int k=0; k<totalwords; k++)
      {
        if (words[j].equals(markovkey[k])) // match
        {
          match = 1; // we found a match
          markovchain[k][markovcount[k]]=words[j+1];
          //println("adding: " + markovchain[k][c[k]] + " to " + markovkey[k] + ".");
          markovcount[k]++;
          break;
        }
      }
      
      // no match... add new entry to chain
      if (match==0) // add
      {
        markovkey[totalwords] = words[j];
        markovchain[totalwords][0] = words[j+1];
        //println("starting: " + markovchain[totalwords][0] + " to " + markovkey[totalwords] + ".");
        markovcount[totalwords] = 1;
        totalwords++;
      }
    }


    //print(totalwords + "... ");
  }
  
  currentword = markovkey[int(random(0,totalwords))];
}

void draw()
{
    
  
    int match = 0;
  String newword = "";
  // find current word
  for(int i=0;i<totalwords;i++)
  {
    if(currentword.equals(markovkey[i])) // match
    {
      match = 1;
      newword = markovchain[i][(int)random(markovcount[i])];
      break;
    }
  }
  if(match==1)
  {
     currentword = newword; 
  }
  else
  {
  currentword = markovkey[int(random(0,totalwords))];
     
  }
  println(currentword);

}

