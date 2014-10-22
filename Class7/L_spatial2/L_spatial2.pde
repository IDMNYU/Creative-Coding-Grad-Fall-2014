
PImage inpic, outpic;
int w, h;
float r, g, b;

void setup()
{
  size(1024, 576);
  inpic = loadImage("sunrise.jpg");
  w = inpic.width;
  h = inpic.height;
  outpic = new PImage(w, h);
}

void draw()
{
  inpic.loadPixels(); // load pixels array from texture
  int howmanypixels = inpic.pixels.length;
  //println(howmanypixels);
  int ncols = int(map(mouseX, 0, width, 1, 32));
  int nrows = int(map(mouseY, 0, height, 1, 32));
  for (int i = 0; i<h; i++) { // these are all the rows
    for (int j = 0; j<w; j++) { // these are all the columns
      int xpos = (j*ncols)%w;
      int ypos = (i*nrows)%h;
      color src = inpic.pixels[ypos*w + xpos]; // src pixel
      
      int colstep = w/ncols;
      int rowstep = h/nrows;
      int xpos2 = round(j/colstep) * colstep;
      int ypos2 = round(i/rowstep) * rowstep;
      color src2 = inpic.pixels[ypos2*w + xpos2]; // other src pixel (straight up)
      r = (red(src) * red(src2)/255.);
      g = (green(src) * green(src2)/255.);
      b = (blue(src) * blue(src2)/255.);
      //r = red(src);
      //g = green(src);
      //b = blue(src);
      //r = red(src2);
      //g = green(src2);
      //b = blue(src2);
      outpic.pixels[i*w + j] = color(r, g, b);
    }
  }
  outpic.updatePixels(); // update picture texture
  image(outpic, 0, 0); // show it
}

void keyReleased()
{
  inpic = loadImage("sunrise.jpg");
}

