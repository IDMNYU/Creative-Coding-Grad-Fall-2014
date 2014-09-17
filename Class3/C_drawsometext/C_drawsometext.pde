
PFont pf, pf2;

void setup()
{
  size(600, 600);

  pf = loadFont("Gotham-Medium-96.vlw");
  pf2 = loadFont("InfoText-SemiBold-96.vlw");
  textFont(pf); // use pf as my font
  textAlign(CENTER);
  textSize(48);
}

void draw()
{
  background(0);
  float tw = 50.;
  float scalar = float(mouseX)/width + 1.;

  textFont(pf); // use pf as my font
  textSize(32.*scalar);
  text("my ", tw, 50);
  tw+= textWidth("my "); 
  
  textFont(pf2); // use pf as my font  
  textSize(40.*scalar);
  text("dog ", tw, 100);
  tw+= textWidth("dog "); 
  
  textFont(pf); // use pf as my font  
  textSize(60.*scalar);
  text("has ", tw, 150);
  tw+= textWidth("has "); 

  textFont(pf2); // use pf as my font  
  textSize(22.*scalar);
  text("fleas!", tw, 200);

  //text("my dog has fleas", width/2, height/2);
}

