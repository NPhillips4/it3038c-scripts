var http = require("http");
var fs = require("fs");
var os = require("os")
var ip = require('ip');

http.createServer(function(req, res){
	
	if (req.url === "/") {
		fs.readFile("./Public/index.html", "UTF-8", function(err, body){
		res.writeHead(200, {"Content-Type": "text/html"});
		res.end(body);
		});
	}
	
	else if(req.url.match("/sysinfo")) {
		myHostName = os.hostname();
		
		const totalMem = os.totalmem();
		totalMemMB = totalMem / 1048576;
		totalMemMB = Math.floor(totalMemMB);
		
		const freeMem = os.freemem();
		freeMemMB = freeMem / 1048576;
		freeMemMB = Math.floor(freeMemMB);
		
		var uptimeSec = os.uptime();
	
		var uptimeDay = Math.floor(uptimeSec / (3600*24));
		uptimeSec -= uptimeDay*3600*24
		var uptimeHr = Math.floor(uptimeSec / 3600);
		uptimeSec -= uptimeHr*3600
		var uptimeMin = Math.floor(uptimeSec / 60);
		uptimeSec -= uptimeMin*60;
		uptimeSec = Math.floor(uptimeSec);
		
		var cpuCores = os.cpus().length;
		
		html=`
		<!DOCTYPE html>
        <html>
			<head>
				<title>Node JS Response</title>
			</head>
			<body>
				<p>Hostname: ${myHostName}</p>
				<p>IP: ${ip.address()}</p>
				<p>Server Uptime: ${uptimeDay} Days, ${uptimeHr} Hours, ${uptimeMin} Minutes, and ${uptimeSec} seconds</p>
				<p>Total Memory: ${totalMemMB} MB </p>
				<p>Free Memory: ${freeMemMB} MB</p>
				<p>Number of CPUs: ${cpuCores} </p>
			</body>
		</html>`
		res.writeHead(200, {"Content-Type": "text/html"});
		res.end(html);
	}
		
	else {
		res.writeHead(404, {"Content-Type": "text/plain"});
		res.end(`404 File Not Found at ${req.url}`);
	}
	
}).listen(3000)

console.log("Server listening on port 3000")