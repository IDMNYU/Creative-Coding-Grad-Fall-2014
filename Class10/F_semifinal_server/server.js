
// HTTP Portion
var http = require('http');
var httpServer = http.createServer(callback);

var fs = require('fs'); // Using the filesystem module

httpServer.listen(process.env.PORT || 5000);

	var lightValue = 0;
	var soundValue = 0;
	var humidity = 0;
	var celsius = 0;
	var fahrenheit = 0;
	var heatIndex = 0;
	var proximityValue = 0;


function callback(req, res) {
	console.log('got data!');
	var data = '';
	data+='<html><body>'

	data+='Light: ';
	data+=lightValue;
	data+='<br>';

	data+='Sound: ';
	data+=soundValue;
	data+='<br>';

	data+='Humidity: ';
	data+=humidity;
	data+='<br>';

	data+='Temp (C): ';
	data+=celsius;
	data+='<br>';

	data+='Temp (F): ';
	data+=fahrenheit;
	data+='<br>';

	data+='Heat Index: ';
	data+=heatIndex;
	data+='<br>';

	data+='Proximity Value: ';
	data+=proximityValue;
	data+='<br>';

	data+='</body></html>';


 	console.log("light: " + lightValue); 
 	console.log("sound: " + soundValue);
 	console.log("humid: " + humidity);
 	console.log("tempC: " + celsius);
 	console.log("tempF: " + fahrenheit);
 	console.log("heatI: " + heatIndex);
 	console.log("proxi: " + proximityValue);

	res.writeHead(200);
	res.end(data);
}


var io = require('socket.io').listen(httpServer);

io.sockets.on('connection', 
	function (socket) {
	
		console.log("We have a new client: " + socket.id);


		socket.on('light', function(data) {
			lightValue = data;
		});
		socket.on('sound', function(data) {
			soundValue = data;
		});
		socket.on('humid', function(data) {
			humidity = data;
		});
		socket.on('tempC', function(data) {
			celsius = data;
		});
		socket.on('tempF', function(data) {
			fahrenheit = data;
		});
		socket.on('heatI', function(data) {
			heatIndex = data;
		});
		socket.on('proxi', function(data) {
			proximityValue = data;
		});

		socket.on('disconnect', function() {
			console.log("Client has disconnected " + socket.id);
		});
	}
);
