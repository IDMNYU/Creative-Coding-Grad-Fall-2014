// key commands
// go here

void keyPressed()
{
  if(keyCode==61) // +
  {
    view_scale*=view_scale_factor;
  }
  else if(keyCode==45) // -
  {
     view_scale/=view_scale_factor;
  }
  else if(keyCode==38) // DOWN
  {
     view_y+=view_y_increment;
     view_y_increment*=acceleration;
     if(view_y_increment>acc_max) view_y_increment=acc_max;
  }
  else if(keyCode==40) // DOWN
  {
     view_y-=view_y_increment;
     view_y_increment*=acceleration;
     if(view_y_increment>acc_max) view_y_increment=acc_max;
  }
  else if(keyCode==37) // LEFT
  {
     view_x+=view_x_increment;
     view_x_increment*=acceleration;
     if(view_x_increment>acc_max) view_x_increment=acc_max;
  }
  else if(keyCode==39) // RIGHT
  {
     view_x-=view_x_increment;
     view_x_increment*=acceleration;
     if(view_x_increment>acc_max) view_x_increment=acc_max;
  }
  else if(keyCode==32) // SPACE BAR
  {
     view_scale = 1.0;
    view_x = width/2.0;
    view_y = height/2.0; 
  }
  
}

void keyReleased()
{
   view_x_increment = 1.;
   view_y_increment = 1.;
   
}
