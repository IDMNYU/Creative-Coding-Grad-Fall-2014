void dodotsandlines()
{
  PVector dot = new PVector();

  // render the stops
  for (int i=0; i<stops.size (); i++)
  {
    stroke(255);
    lukeStop s = (lukeStop) stops.get(i);
    dot = mapscale(s.stop_long, s.stop_lat);
    ellipse(dot.x, dot.y, 5, 5);
  }

  // render the lines
  String previd = "";
  int startedshape = 0;
  for (int i=0; i<shapes.size (); i++)
  {
    lukeShape s = (lukeShape) shapes.get(i);
    dot = mapscale(s.shape_long, s.shape_lat);
    if (previd.equals(s.shape_id)==false)
    {
      if (startedshape==1)
      {
        endShape();
      }
      beginShape();
      previd = s.shape_id;
      startedshape=1;
    } 
    vertex(dot.x, dot.y);
  }
  endShape();
}

float dotrains()
{
  PVector dot = new PVector();

  // draw trains as they appear on the clock
  float tfcount = 0;
  float x, y;
  for (int i=0; i<trains.size (); i++)
  {
    lukeTrain s = (lukeTrain) trains.get(i);
    if (SOON>=s.departure_time&&NOW<=s.departure_time)
    {
      tfcount++;
      checkcolors(s.trip_id);
      String id = s.stop_id;
      for (int j = 0; j<stops.size (); j++)
      {
        lukeStop p = (lukeStop) stops.get(j);
        if (id.equals(p.stop_id))
        {
          dot = mapscale(p.stop_long, p.stop_lat);
          ellipse(dot.x, dot.y, 20, 20);
          text(p.stop_name, dot.x, dot.y);
        }
      }
    }
  }
  return(tfcount);
}

// this draws the time and number of trains in the upper-left
void dotoplabels(float tfcount)
{
  // top labels: clock and average train count in station
  textSize(18);
  Time t = new Time(NOW/3600, (NOW/60)%60, NOW%60);
  text("time: " + t.toString(), 20, 30);
  tcount = 0.9*tcount + 0.1*tfcount;
  text("avg in station: " + round(tcount), 20, 50);
}

