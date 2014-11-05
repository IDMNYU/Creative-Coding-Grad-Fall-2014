var midi = require('midi');

// Set up a new output.
var output = new midi.output();

// Count the available output ports.
output.getPortCount();

// Get the name of a specified output port.
output.getPortName(0);

// Open the first available output port.
output.openPort(0);

// Send a MIDI message.
output.sendMessage([144,60,100]);

var sleep = require('sleep');

sleep.usleep(0.1*1000000);

output.sendMessage([144,60,0]);

// Close the port when done.
output.closePort();
