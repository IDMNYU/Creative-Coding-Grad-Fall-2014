

var foo = new p5.Oscillator(200., 'Sine');
var theEnv = new p5.Env(0.2,1.0,0.1,0.8,1.,0.8,0.2,0.);

var isClicked = 0;

function setup() {
  // put setup code here
  createCanvas(640, 480); 
	background(0);
	foo.amp(theEnv);
	foo.start();
}

function draw() {
	fill(255, 0, 0, 30);
	stroke(255);
  // put drawing code here
  ellipse(mouseX, mouseY, 20, 20);
  var thefreq = map(mouseX, 0, width, 200, 1000);
  foo.freq(thefreq);
  var theamp = 1.0-mouseY/height;
  theEnv.set(0.2,1.0*theamp,0.1,0.8*theamp,1.,0.8*theamp,0.2,0.);

}

function keyPressed()
{
	background(0);

}

function mousePressed()
{
	theEnv.play();

}

function mouseReleased()
{
}