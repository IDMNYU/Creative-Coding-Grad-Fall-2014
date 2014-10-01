//
// data structure loading
//

void loadStops()
{
  // stops
  String[] stopraw = loadStrings("stops.txt");
  stops = new ArrayList();
  for (int i = 1; i<stopraw.length; i++)
  {
    String[] t = split(stopraw[i], ",");
    stops.add(new lukeStop());
    lukeStop s = (lukeStop) stops.get(stops.size()-1);
    s.stop_id = t[0];
    s.stop_name = t[1];
    s.stop_lat = float(t[2]);
    s.stop_long = float(t[3]);
    s.location_type = int(t[4]);
    s.parent_station = int(t[5]);
    if (s.stop_lat<latmin) latmin=s.stop_lat;
    if (s.stop_lat>latmax) latmax=s.stop_lat;
    if (s.stop_long<longmin) longmin=s.stop_long;
    if (s.stop_long>longmax) longmax=s.stop_long;
  }
}

void loadShapes()
{
  // shapes
  String[] shaperaw = loadStrings("shapes.txt");
  shapes = new ArrayList();
  for (int i = 1; i<shaperaw.length; i++)
  {
    String[] t = split(shaperaw[i], ",");
    shapes.add(new lukeShape());
    lukeShape s = (lukeShape) shapes.get(shapes.size()-1);
    s.shape_id = t[0];
    s.shape_seq = int(t[1]);
    s.shape_lat = float(t[2]);
    s.shape_long = float(t[3]);
  }
}

void loadTrains()
{
  // train database (load weekday only)
  String[] trainsraw = loadStrings("stop_times.txt");
  trains = new ArrayList();

  for (int i = 0; i<trainsraw.length; i++)
  {
    String[] t = split(trainsraw[i], ",");
    if (t[0].contains("WKD")) {
      trains.add(new lukeTrain());
      lukeTrain s = (lukeTrain) trains.get(trains.size()-1);
      s.trip_id = t[0];
      s.stop_id = t[1];
      Time temp = Time.valueOf(t[2]);
      s.arrival_time = temp.getSeconds() + temp.getMinutes()*60 + temp.getHours()*3600;
      temp = Time.valueOf(t[3]);
      s.departure_time = temp.getSeconds() + temp.getMinutes()*60 + temp.getHours()*3600;
      s.stop_sequence = int(t[4]);
    }
  }
}

void loadRoutes()
{
  // routes
  String[] routesraw = loadStrings("routes.txt");
  routes = new ArrayList();
  for (int i = 1; i<routesraw.length; i++)
  {
    String[] t = routesraw[i].split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)");
    routes.add(new lukeRoute());
    lukeRoute r = (lukeRoute) routes.get(routes.size()-1);
    r.route_id = "_"+t[1]+".";
    if (t.length>7) {
      r.route_color = unhex("FF"+t[7]);
    } else 
    {
      r.route_color = unhex("FF9999FF");
    }
  }
}

