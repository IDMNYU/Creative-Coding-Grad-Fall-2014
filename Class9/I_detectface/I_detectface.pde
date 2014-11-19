import processing.video.*;  // this is the video library
import gab.opencv.*;
import java.awt.Rectangle;

Capture cam; // this represents a camera

OpenCV opencv;
Rectangle[] faces;

int firsttime = 0;

void setup() {

  opencv = new OpenCV(this, 640, 360);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  cam = new Capture(this); // this makes a new camera object
  cam.start(); // this starts the camera going
  size(1280, 720);
}

void draw() {
  if (cam.available()) { // is there a frame to be read
    cam.read(); // reads a frame
    opencv.loadImage(cam);

    image(opencv.getInput(), 0, 0);
    faces = opencv.detect();

    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    for (int i = 0; i < faces.length; i++) {
      println("found face!");
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
  }
}

