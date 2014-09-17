// however far away

int LINKNUM = 100; // number of links to grab - normally 100
int MAXWORDS = 350; // max number of words to go through
int MINLOOPLEN = 150; // minimum number of frames in a search loop
int LOOPLEN = 200; // actual number of frames in a search loop
float WPM = 300.; // how fast do we read?

// master list of searched cities
String[] cityURLs;
String[] citytexts;
int[][] cityrects; // bounding boxes for mouse interaction

// setups for URLs
String city = "newyork.craigslist.org";
String citytext = "new york";
String url1 = "/search/mis?query=w4m&s=0";
String url2 = "/search/mis?query=m4w&s=0";
String w4m_main[];
String m4w_main[];

// text string for additional info
String eline = "more information";
String eURL = "http://lukedubois.com/missed/info.html";

// parts of speech
String[][] pos = new String[3][]; 

// data structures (global)
int t1, t2;
String[][] links1;
String[][] links2;
String[][] w4m = new String[100][];
String[][] m4w = new String[100][];

// data structures (per match)
int girl;
int boy;
int gsize, bsize;
int matchcount; // # of matching words
// spatial data for words and lines
float wgx[] = new float[10];
float wgy[] = new float[10];
float wbx[] = new float[10];
float wby[] = new float[10];
float mgx[] = new float[10];
float mgy[] = new float[10];
float mbx[] = new float[10];
float mby[] = new float[10];
// unique match list for determining score
String mmm[] = new String[10]; 
// matching score
int thescore;
int firedlinks; // use for opening urls at end
float triggerpoint = 85.; // percent that will trigger a match

// set to 0 for first menu, otherwise will just load new york
int started = 1;

// 'are we ready' flags - set these low to restart loading screen
int parsed = 0;
int loaded = 0;
int loadptr1 = 0;
int loadptr2 = 0;

int frameptr = 0; // frame position
int nummatches = 0; // how many matches have we run?
int matchloop = 100; // how many matches trigger a reload of the database?

PFont font; // our lovely font

String fontfile = "Courier-24.vlw";
int fontsize = 24;

// get us going
void setup()
{
  size(displayWidth, displayHeight);
  frameRate(24);
  background(0);

  noCursor(); // comment this out in normal use

  font = loadFont(fontfile);
  textFont(font, fontsize); 
  textAlign(LEFT, BASELINE);

  // load cities
  loadcities();

  // load pos database on launch
  loadpos(); 

  // make sure the console works
  println("aisle of view");
}

void draw()
{
  textFont(font, fontsize); 
  fill(255);

  // selection screen
  if (started==0)
  {
    doselectionscreen();
  }
  // load main CL pages
  if (started==1&&parsed==0)
  {
    println("STARTING LOAD...");
    w4m_main = loadStrings("http://"+city+url1);
    //println(w4m_main);
    m4w_main = loadStrings("http://"+city+url2);
    parsemainurl();
  }
  // load subpages and sort all the data
  if (started==1&&parsed==1&&loaded==0)
  {
    doloadingscreen();
  }

  // we're going!!!

  // parse new match and predraw
  if (started==1&&loaded==1&&frameptr==0) 
  {
    donewmatch();
    dopredraw();
  }
  // draw matching words
  if (started==1&&loaded==1&&frameptr>=0&&frameptr<=(int)(LOOPLEN*0.25)) 
  {
    domatchwords();
  }
  // draw other words
  if (started==1&&loaded==1&&frameptr>=(int)(LOOPLEN*0.25)&&frameptr<=(int)(LOOPLEN*0.4)) 
  {
    dootherwords();
  }
  // draw lines and pos glyphs
  if (started==1&&loaded==1&&frameptr>=(int)(LOOPLEN*0.4)&&frameptr<=(int)(LOOPLEN*0.8)) 
  {
    dolines();
  }
  // draw ending
  if (started==1&&loaded==1&&frameptr>LOOPLEN*0.9) 
  {
    doending();
  }

  // increment frame pointer
  frameptr++;
  if (frameptr>LOOPLEN) {
    frameptr=0;
    println("LOOPING... " + nummatches);
    // do a reload
    if (nummatches>=matchloop)
    {
      nummatches = 0;
      parsed = 0;
      loaded = 0;
      loadptr1 = 0;
      loadptr2 = 0;
      println("RELOADING...");
    }
  }
}

// click advances, also handles intro selection
void mousePressed()
{
  if (started==0)
  {
    checkselection();
  }
  if (started==1&&loaded==1&&frameptr==0)
  {
    println("CHILL!");
  }
  else if (loaded==1&&(frameptr<LOOPLEN*0.8)) {
    frameptr=(int)(LOOPLEN*0.8);
  }
  else if (loaded==1&&(frameptr>=LOOPLEN*0.8)) {
    frameptr=LOOPLEN;
  }
}

