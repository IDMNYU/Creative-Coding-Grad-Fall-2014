// the grand scheme of things
var http = require('http');
var httpServer = http.createServer(dothestuff);

// port mojo
httpServer.listen(5000);

//
// HTTP Portion - this deals with HTTP requests from everyone's browsers
//

var fs = require('fs'); // Using the filesystem module

// this responds to browsers:
function dothestuff(req, res) {
	// serve up index.html
	fs.readFile(__dirname + '/index.html', 
		// Callback function for reading
		function (err, data) {
			if (err) {
				res.writeHead(500);
				return res.end('No index file... toast.');
			}
			res.writeHead(200);
			res.end(data);
  		}
  	);
}

//
// SOCKET STUFF - this responds to websocket data from the raspberry pi
//

var io = require('socket.io').listen(httpServer);

io.sockets.on('connection', 
	function (socket) {
	
		console.log("We have a new client: " + socket.id);

		socket.on('light', function(data) {
			io.emit('light', data);
		});
		socket.on('sound', function(data) {
			io.emit('sound', data);
		});
		socket.on('humid', function(data) {
			io.emit('humid', data);
		});
		socket.on('tempC', function(data) {
			io.emit('tempC', data);
		});
		socket.on('tempF', function(data) {
			io.emit('tempF', data);
		});
		socket.on('heatI', function(data) {
			io.emit('heatI', data);
		});
		socket.on('proxi', function(data) {
			io.emit('proxi', data);
		});


		socket.on('disconnect', function() {
			console.log("Client has disconnected " + socket.id);
		});
	}
);

