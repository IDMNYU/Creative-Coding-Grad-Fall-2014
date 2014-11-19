
// web stuff (for later)
var servername = 'http://localhost:5000'; // this is our server name

//
// serial stuff - read from arduino
//
var portname = '/dev/tty.usbmodem1411'; // luke's arduino
var com = require('serialport'); // this is a serial object

// start the serial port cooking
var serialPort = new com.SerialPort(portname, {
	baudrate: 9600,
	parser: com.parsers.readline('\r\n')
});

// what happens when we get an open
serialPort.on('open', function() {
	console.log('SERIAL PORT OPENED!!!!!');
});

// what happens when we get some data
serialPort.on('data', function(data) {
	parseData(data);
});

//
// networking stuff - socket.io
//

var io = require('socket.io-client');
var socket = io.connect(servername);
socket.on('connect', function() {
	console.log('YAAAY!!! NETWORK ALIVE!!!!!');
});

// custom callback for data
function parseData(d)
{
	console.log(d); // feel good move

	// parse the crap
	var elements = d.split(" ");
	var lightValue = elements[0];
	var soundValue = elements[1];
	var humidity = elements[2];
	var celsius = elements[3];
	var fahrenheit = elements[4];
	var heatIndex = elements[5];
	var proximityValue = elements[6];

	// emit the crap
	socket.emit('light', lightValue);
	socket.emit('sound', soundValue);
	socket.emit('humid', humidity);
	socket.emit('tempC', celsius);
	socket.emit('tempF', fahrenheit);
	socket.emit('heatI', heatIndex);
	socket.emit('proxi', proximityValue);
}
