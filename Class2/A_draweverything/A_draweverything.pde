int columns = 9;
int rows = 12;

float red, green, blue;

float squarepct = 0.9;

// this runs once when ya start
void setup()
{
  size(800, 800);
  frameRate(15);

  red = random(0, 255);
  green = random(0, 255);
  blue = random(0, 255);

  drawEverything();
}

// this runs every frame
void draw()
{
  drawEverything();
}

void keyPressed()
{
  drawEverything();
}

void drawEverything()
{
  background(255);
  // fill up the screen with a grid of squares

  float xstep = width/columns;
  float ystep = height/rows;
  println("we have a " + columns + " by " + rows + " grid!");
  println("the xstep is " + xstep + " and the ystep is " + ystep + "!!!");

  for (int i = 0; i<columns; i++)
  {
    for (int j = 0; j<rows; j++)
    {
      // draw the squares:
      println("drawing column " + i + " and row " + j + ".");
      fill(red, green, blue); 
      rect(i*xstep + xstep/2, j*ystep + ystep/2, xstep*squarepct, ystep*squarepct);
      // shift the color:
      shiftColor();
    }
    shiftColor();
  }
  shiftColor();
}

void shiftColor()
{
  red = constrain(red + random(-10, 10), 0, 255);
  green = constrain(green + random(-10, 10), 0, 255);
  blue = constrain(blue + random(-10, 10), 0, 255);
}

