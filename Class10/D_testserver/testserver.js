
//
// THIS IS THE WEB SERVICE
//

var http = require('http');

// this is the GUTS of the server:
var httpServer = http.createServer(callback);

// process.env.PORT is some heroku magic crap
httpServer.listen(process.env.PORT || 5000);


function callback(req, res)
{
	console.log("GOT REQUEST FROM SOMEONE!!!");
	// this is the HTTP header block (200 is all is good):
	res.writeHead(200, {'Content-Type': 'text/html'}); 
	res.end('<html><body><b>AWESOME</b> <i>GROOVINESS</i></body></html>');
}

console.log('Server running!!!');

//
// THIS IS THE SOCKET SERVICE
//

var io = require('socket.io').listen(httpServer);

io.sockets.on('connection',
	function(socket) {
		console.log("WE HAVE A CLIENT!!!!" + socket.id);
		socket.on('hello', function(data) {
			console.log("hello back!!!" + data);
		});

		socket.on('disconnect', function() {
			console.log("CLIENT DEAD: " + socket.id);
		});


});

