//
// interactions
//

void keyPressed()
{
  if (keyCode==61) view_scale*=1.1;
  if (keyCode==45) view_scale*=0.9;
  if (keyCode==38) {
    view_y+=view_y_increment;
    view_y_increment*=acceleration;
    if (view_y_increment>50) view_y_increment=50;
  }
  if (keyCode==40) {
    view_y-=view_y_increment;
    view_y_increment*=acceleration;
    if (view_y_increment>50) view_y_increment=50;
  }
  if (keyCode==37) {
    view_x+=view_x_increment;
    view_x_increment*=acceleration;
    if (view_x_increment>50) view_x_increment=50;
  }
  if (keyCode==39) {
    view_x-=view_x_increment;
    view_x_increment*=acceleration;
    if (view_x_increment>50) view_x_increment=50;
  }
  if (keyCode==10) { // RETURN KEY resets
    view_scale=1.0;
    view_x = width/2.;
    view_y = height/2.;
  }
}

void keyReleased()
{
  view_x_increment = 1;
  view_y_increment = 1;
}

