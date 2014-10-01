


JSONArray foo = loadJSONArray("http://data.cityofnewyork.us/resource/erm2-nwe9.json");

//println(foo);
//println(foo.size());

for(int i = 0;i<foo.size();i++)
{
  JSONObject temp = foo.getJSONObject(i);
  try {
  JSONObject temploc = temp.getJSONObject("location");
  float x = temploc.getFloat("longitude");
  float y = temploc.getFloat("latitude");
  println(x + " by " + y);
  }
  catch (Exception e)
  {
     println("this didn't work!"); 
  }
  
  //println(temp.getString("borough") + ": " + temp.getString("complaint_type"));
}

