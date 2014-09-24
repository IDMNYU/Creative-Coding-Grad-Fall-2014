

var theSound = new p5.SoundFile();

var isClicked = 0;

function preload() {
  theSound = loadSound('drums.mp3');

}

function setup() {
  // put setup code here
  createCanvas(640, 480); 
	background(0);
	theSound.play();
}

function draw() {
	fill(255, 0, 0, 30);
	stroke(255);
  // put drawing code here
  ellipse(mouseX, mouseY, 20, 20);

}

function keyPressed()
{
	background(0);
  if(key=='A') {
    theSound.jump(0., 1.);
  }
  else if(key=='S') {
    theSound.jump(1., 2.);
  }
  else if(key=='D') {
    theSound.jump(2., 3.);
  }
  else if(key=='F') {
    theSound.jump(3., 4.);
  }


}

function mousePressed()
{

}

function mouseReleased()
{
}