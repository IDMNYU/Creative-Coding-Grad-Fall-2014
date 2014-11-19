var http = require('http');

// this is the GUTS of the server:
http.createServer(callback).listen(8000, '127.0.0.1');

function callback(req, res)
{
  // this is the HTTP header block (200 is all is good):
  res.writeHead(200, {'Content-Type': 'text/html'}); 
  res.end('<html><body><b>Hello</b> <i>World</i></body></html>');
}

console.log('Server running!!!');
