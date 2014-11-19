
var http = require('http');

var fs = require('fs');

// this is the GUTS of the server:
http.createServer(callback).listen(8000, '127.0.0.1');

function callback(req, res)
{
	// read a file
	fs.readFile(__dirname + '/index.html',
		// this is the callback for the file read
		function(err, data) {
			if(err) { // this means we screwed up
				res.writeHead(500); // bad mojo
				return res.end('oops!');
			}
			// this is the HTTP header block (200 is all is good):
			res.writeHead(200, {'Content-Type': 'text/html'}); 
			res.end(data);
		}
	);

}

console.log('Server running!!!');
