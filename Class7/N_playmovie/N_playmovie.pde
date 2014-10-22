import processing.video.*; // import the movie stuff

String filename = "duck.mp4";
Movie mov; // this is the movie object

void setup() {
  size(640, 480); // the right size
  background(0); // we don't really have to do this
  mov = new Movie(this, filename); // duck and cover
  mov.play(); // start playing
  mov.jump(0); // rewind to the beginning
}

void draw() {
  if (mov.available()) { // check to see if there's new video data
    mov.read(); // copy the current frame to an internal PImage or texture
  }  
  image(mov, 0, 0, width, height); // draw it to the screen
  float speed = (mouseX/float(width)) * 2.;
  mov.speed(speed);
}

