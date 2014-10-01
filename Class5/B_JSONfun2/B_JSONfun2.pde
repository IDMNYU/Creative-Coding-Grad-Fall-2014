

JSONArray foo = loadJSONArray("http://data.cityofnewyork.us/resource/erm2-nwe9.json");

ArrayList<Complaint> complaints; // store complaints here

float xmin = 10000;
float xmax = -10000;
float ymin = 10000;
float ymax = -10000;

void setup()
{
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

