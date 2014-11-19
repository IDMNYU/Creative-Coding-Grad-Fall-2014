
// web stuff (for later)
var servername = 'http://localhost:5000'; // this is our server name


//
// networking stuff - socket.io
//

var io = require('socket.io-client');
var socket = io.connect(servername);
socket.on('connect', function() {
	console.log('YAAAY!!! NETWORK ALIVE!!!!!');
	socket.emit('hello', 12345);

});
