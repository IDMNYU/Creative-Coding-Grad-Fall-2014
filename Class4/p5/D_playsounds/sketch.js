

var BD = new p5.SoundFile();
var SD = new p5.SoundFile();
var OH = new p5.SoundFile();
var CH = new p5.SoundFile();
var steve = new p5.SoundFile();

var isClicked = 0;

var frameClock = 0;

function preload() {
  BD = loadSound('BD.mp3');
  SD = loadSound('SD.mp3');
  OH = loadSound('OH.mp3');
  CH = loadSound('CH.mp3');
  steve = loadSound('SJ.mp3');
}

function setup() {
  // put setup code here
  createCanvas(640, 480); 
	background(0);

}

function draw() {

  console.log(frameClock);
  if(frameClock%24==0) BD.play();
  if(frameClock%12==0) {
    if(random(0., 1.)<0.3) SD.play();
  }
  if(frameClock%6==0) {
    var rand = random(0., 1.);
    if(rand<0.6) {
      if(rand<0.5) CH.play();
      else OH.play();
    }
  }

	fill(255, 0, 0, 30);
	stroke(255);
  // put drawing code here
  ellipse(mouseX, mouseY, 20, 20);

  frameClock = (frameClock+1) % 96;

}

function keyPressed()
{
	background(0);
 
}

function mousePressed()
{
  steve.play();
}

function mouseReleased()
{
  steve.pause();
}