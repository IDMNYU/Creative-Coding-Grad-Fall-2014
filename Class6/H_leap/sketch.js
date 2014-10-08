
var controller;

var myFrame;

      var o = new Array(2);
      for(var i = 0;i<2;i++) 
      {
      o[i] = new p5.Oscillator('sine');
      o[i].freq(200.);
      o[i].amp(0.1);
      o[i].start();
      }



function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(800, 600); 
  controller = new Leap.Controller();
  controller.connect();
  controller.on('frame', onFrame);
}

function draw() {
  // put drawing code here
  background(255);

    fill(255, 0, 0);
   for(var i = 0;i<myFrame.hands.length;i++)
    {
      var hand = myFrame.hands[i];
      var x = map(hand.palmPosition[0], -1000, 1000, 0, width);
      var y = map(hand.palmPosition[1], -1000, 1000, height, 0);
      var z = map(hand.palmPosition[2], -1000, 1000, 5, 40);
      ellipse(x, y, z, z);
      o[i].freq(map(hand.palmPosition[1], -1000, 1000, 1000, 100));

    }

    fill(0, 0, 255);
    for(var i = 0;i<myFrame.pointables.length;i++)
    {
      var pointable = myFrame.pointables[i];
      var x = map(pointable.tipPosition[0], -1000, 1000, 0, width);
      var y = map(pointable.tipPosition[1], -1000, 1000, height, 0);
      var z = map(pointable.tipPosition[2], -1000, 1000, 1, 8);
      ellipse(x, y, z, z);
    }




  }

// this fires when the Leap fires
function onFrame(frame)
{
    myFrame = frame;
}
