
//var servername = 'https://fast-bastion-1770.herokuapp.com';
var servername = 'http://localhost:5000/';

var portname = "/dev/tty.usbmodem1411";
var com = require("serialport");

var serialPort = new com.SerialPort(portname, {
    baudrate: 9600,
    parser: com.parsers.readline('\r\n')
  });

serialPort.on('open',function() {
  console.log('Port open');
});

serialPort.on('data', function(data) {
  parseData(data);
});

var io = require('socket.io-client');
//console.log(io);
//var socket = io.connect('http://localhost:7000/');
var socket = io.connect(servername);
socket.on('connect', function() {
	console.log("Connected");
});


function parseData(d)
{
	var elements = d.split(" ");
	var lightValue = elements[0];
	var soundValue = elements[1];
	var humidity = elements[2];
	var celsius = elements[3];
	var fahrenheit = elements[4];
	var heatIndex = elements[5];
	var proximityValue = elements[6];

 	console.log("light: " + lightValue); 
 	console.log("sound: " + soundValue);
 	console.log("humid: " + humidity);
 	console.log("tempC: " + celsius);
 	console.log("tempF: " + fahrenheit);
 	console.log("heatI: " + heatIndex);
 	console.log("proxi: " + proximityValue);

	socket.emit('light', lightValue);
 	socket.emit('sound', soundValue);
 	socket.emit('humid', humidity);
 	socket.emit('tempC', celsius);
 	socket.emit('tempF', fahrenheit);
 	socket.emit('heatI', heatIndex);
 	socket.emit('proxi', proximityValue);

}
