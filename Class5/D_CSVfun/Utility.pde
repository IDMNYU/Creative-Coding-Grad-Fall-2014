// utility

PVector mapscale(float x, float y)
{
  PVector t = new PVector();
  t.x = map(x, longmin, longmax, -width/2+border, width/2-border);
  t.y = map(y, latmin, latmax, height/2-border, -height/2+border);
  return(t);
}

void checkcolors(String id)
{
  // lookup route colors
  for (int i = 0; i<routes.size (); i++)
  {
    lukeRoute r = (lukeRoute) routes.get(i);
    if (id.contains(r.route_id))
    {
      stroke(r.route_color);
    }
  }
}


