var express = require('express');
var app = express();
var port = process.env.PORT || 3000;

app.configure('development', function() {
	app.use(express.logger());				// Use the logger
	app.use(express.errorHandler({			// Use an error handler
		dumpExceptions: true,
		showStack: true
	}));
});

app.get('/', function(req, res) {
	res.send('hello');

	var https = require('https');
	
	var optionsget = {
		host : 'api.parse.com', // here only the domain name, no http/https
		port : 443,
		path : '/1/classes/GameScore/Cna3lfUJ7A', // the rest of the url with parameters if needed
		method : 'GET',
		headers : {
			'X-Parse-Application-Id' : 'kxxywjgJSceZiqh5aTEie7cWLsc9MAEDruAP6BCl',
			'X-Parse-REST-API-Key' : 'GYNuMDvkhEpxq05ZXkLWroivoAYVXmv9As1RV1U2'
		}
	};
	
	console.info('Options prepared:');
	console.info(optionsget);
	console.info('Do the GET call');
	
	// do the GET request
	var reqGet = https.request(optionsget, function(res) {
		console.log("statusCode: ", res.statusCode);
		// uncomment it for header details
	//	console.log("headers: ", res.headers);
	
	
		res.on('data', function(d) {
			console.info('GET result:\n');
			process.stdout.write(d);
			console.info('\n\nCall completed');
		});
	
	});

	reqGet.end();
	reqGet.on('error', function(e) {
		console.error(e);
	});
});

app.listen(port);
console.log('Listening on port ', port);
