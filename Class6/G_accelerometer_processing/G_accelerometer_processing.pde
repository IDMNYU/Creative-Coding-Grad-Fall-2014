
import processing.serial.*; // this is a library to use serial

int whichport = 5; // change to your serial port

Serial myPort;      // The serial port
String inPut = "";    // Incoming (string) serial data
int x, y, z; // stash *actual* serial data
int xmin = 50000;
int ymin = 50000;
int zmin = 50000;
int xmax = -50000;
int ymax = -50000;
int zmax = -50000;

int i;

void setup() {
  size(400, 300);
  // create a font with a random front:
  PFont myFont = createFont(PFont.list()[int(random(0,100))], 24);
  textFont(myFont);

  // List all the available serial ports:
  println(Serial.list());

  // open the serial port to the arduino
  String portName = Serial.list()[whichport];
  myPort = new Serial(this, portName, 9600);

  background(0);
  
}

void draw() {


  if ( myPort.available() > 0) {  // If data is available,
    inPut = myPort.readStringUntil('\n');
    //myPort.clear();
    if (inPut!=null) { // only run if not bogus
      inPut = trim(inPut); // gets rid of white space
      String[] stuff = split(inPut, " ");
      if(stuff[0]!=null) {
        x = parseInt(stuff[0]);
        if(x>xmax) xmax=x;
        if(x<xmin) xmin=x;
      }
      if(stuff[1]!=null) {
        y = parseInt(stuff[1]);
        if(y>ymax) ymax=y;
        if(y<ymin) ymin=y;
      }
      if(stuff[2]!=null) {
        z = parseInt(stuff[2]);
        if(z>zmax) zmax=z;
        if(z<zmin) zmin=z;
      }
      //println(inPut);
    }
  }

  float realx = map(x, xmin, xmax, height, 0);
  float realy = map(y, ymin, ymax, height, 0);
  float realz = map(z, zmin, zmax, height, 0);
  fill(255, 0, 0);
  ellipse(i, realx, 10, 10);
  fill(0, 255, 0);
  ellipse(i, realy, 10, 10);
  fill(0, 0, 255);
  ellipse(i, realz, 10, 10);

  //text("X: " + x, 10, 130);
  //text("Y: " + y, 10, 150);
  //text("Z: " + z, 10, 170);
  i++;
  if(i>width) {
    background(0);
    i = 0;
  }
}

