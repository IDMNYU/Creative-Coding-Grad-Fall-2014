

JSONArray foo = loadJSONArray("http://data.cityofnewyork.us/resource/erm2-nwe9.json");

ArrayList<Complaint> complaints; // store complaints here

float xmin = 10000;
float xmax = -10000;
float ymin = 10000;
float ymax = -10000;

PFont thefont;

// viewing setup
float view_x; // pan x
float view_y; // pan y
float view_scale = 1.0; // zoom
float view_x_increment = 1.0;
float view_y_increment = 1.0;
float view_scale_factor = 1.1;
float acceleration = 2.0; // acceleration for keypresses
float acc_max = 50; // max acceleration


void setup()
{
  size(800, 600, OPENGL);
  
  view_x = width/2;
  view_y = height/2;

  thefont = loadFont("Bello-SmCp-48.vlw");
  textFont(thefont);

  // blows out the array list and starts over:
  complaints = new ArrayList<Complaint>(); 

  // load off of the JSON object into our data structure
  for (int i = 0; i<foo.size (); i++)
  {
    JSONObject temp = foo.getJSONObject(i);
    // some records have no location... try and catch
    try {
      JSONObject temploc = temp.getJSONObject("location");
      float x = temploc.getFloat("longitude");
      float y = temploc.getFloat("latitude");
      String issue = temp.getString("complaint_type");
      complaints.add(new Complaint(x, y, issue));
    }
    catch (Exception e)
    {
      // println("no location!");
    }
  }

  // make sure all the data got there
  for (int i = 0; i<complaints.size (); i++)
  {
    float x = complaints.get(i).x;
    float y = complaints.get(i).y;
    String issue = complaints.get(i).issue;
    if (x<xmin) xmin=x;
    if (x>xmax) xmax=x;
    if (y<ymin) ymin=y;
    if (y>ymax) ymax=y;
    println(x + " by " + y + ": " + issue);
  }
  println("boundary x: " + xmin + " by " + xmax);
  println("boundary y: " + ymin + " by " + ymax);
}

void draw()
{
  background(255);
  
  translate(view_x, view_y);
  scale(view_scale);

  for (int i = 0; i<complaints.size (); i++)
  {
    float x = map(complaints.get(i).x, xmin, xmax, -2*width, 2*width);
    float y = map(complaints.get(i).y, ymax, ymin, -2*height, 2*height);
    noFill();
    stroke(255, 0, 0);
    ellipse(x, y, 5, 5);
    fill(0, 0, 255);
    noStroke();
    textSize(9);
    text(complaints.get(i).issue, x, y);
  }
}


class Complaint
{
  float x;
  float y;
  String issue;

  Complaint(float _x, float _y, String _issue)
  {
    x = _x;
    y = _y;
    issue = _issue;
  }
}

