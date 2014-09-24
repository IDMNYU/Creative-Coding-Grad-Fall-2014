

var foo = new p5.Oscillator(200., 'Sine');

var isClicked = 0;

function setup() {
  // put setup code here
  createCanvas(640, 480); 
	background(0);
	foo.amp(1.0);
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
  foo.amp(theamp*isClicked);

}

function keyPressed()
{
	background(0);

}

function mousePressed()
{
	isClicked = 1;
}

function mouseReleased()
{
	isClicked = 0;
}