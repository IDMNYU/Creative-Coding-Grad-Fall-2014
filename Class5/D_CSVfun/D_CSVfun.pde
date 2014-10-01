// GTFS transit visualizer - shows the static MTA GTFS subway and SIRR feed
// r. luke dubois - dubois@nyu.edu, 9.30.14

// '=' and '-' zoom.  arrows pan.  retun resets

// includes
import java.sql.Time;

// font
PFont font;

// data structures
ArrayList stops;
ArrayList shapes;
ArrayList trains;
ArrayList routes;

// variables

// scaling and borders
float latmin = 1000.;
float latmax = -1000.;
float longmin = 1000.;
float longmax = -1000.;
int border = 20;

// zooming/panning...
float view_x = 0.;
float view_y = 0.;
float view_scale = 1.0; // zoom scaling
int view_x_increment = 1;
int view_y_increment = 1;
float acceleration = 2.; // acceleration factor for keypresses

// avg train count
float tcount = 0.;

// clock
Time START = new Time(0, 0, 0);
int NOW = START.getSeconds() + START.getMinutes()*60 + 
  START.getHours()*3600;
int SOON = NOW+60;

// auto present -- make sketch go fullscreen automatically
boolean sketchFullScreen() {
  return true;
}

void setup()
{
  // fill screen (auto-present)
  size(displayWidth, displayHeight, OPENGL); // make the whole screen
  hint(DISABLE_DEPTH_TEST); // shuts of some bullshit that slows everything down
  view_x = width/2.;
  view_y = height/2.;

  // setup font
  font = createFont("Geneva", 24);
  textFont(font);

  // load data structures
  loadStops();
  loadShapes();
  loadTrains();
  loadRoutes();

  // end setup
}

void draw()
{
  // set up sketch
  background(0);
  noFill();
  stroke(255);
  textSize(18.0/view_scale);

  // draw assets inside openGL stack
  pushMatrix();
  translate(view_x, view_y);
  scale(view_scale, view_scale, view_scale);

  dodotsandlines();

  float tfcount = dotrains();

  popMatrix();

  // draw top labels outside openGL stack
  dotoplabels(tfcount);  

  // increment time
  NOW = (NOW+30) % (60*60*24);
  SOON = NOW+60;
}


