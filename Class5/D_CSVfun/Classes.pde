//
// classes
//

class lukeStop
{
  String stop_id;
  String stop_name;
  float stop_lat;
  float stop_long;
  int location_type;
  int parent_station;
  
}

class lukeShape
{
  String shape_id;
  float shape_lat;
  float shape_long; 
  int shape_seq;
}

class lukeTrain
{
  String trip_id;
  int arrival_time;
  int departure_time;
  String stop_id;
  int stop_sequence;
}

class lukeRoute
{
  String route_id;
  int route_color;
}

