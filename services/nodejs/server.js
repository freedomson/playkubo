var util = require('util');
 
util.debug("Starting...");
 
var http = require('http');
var port = process.env.port || 3000;
http.createServer(function (req, res) {
    util.debug("Got a get");
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello World\n');
    util.debug("Send response");
}).listen(port);
 
util.debug("Started");
