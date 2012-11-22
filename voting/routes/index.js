var async = require('async');				// Allows waterfall cascade of async ops
var count = 0;

function parse(req, res)
{
	var https = require('https');
	
	var optionsget = {
		host : 'api.parse.com', // here only the domain name, no http/https
		port : 443,
		path : '/1/classes/Story/uE65hjWZVz', // the rest of the url with parameters if needed
		method : 'GET',
		headers : {
			'X-Parse-Application-Id' : 'kxxywjgJSceZiqh5aTEie7cWLsc9MAEDruAP6BCl',
			'X-Parse-REST-API-Key' : 'GYNuMDvkhEpxq05ZXkLWroivoAYVXmv9As1RV1U2'
		}
	};
	
	console.info('Options prepared:');
	console.info(optionsget);
	console.info('Do the GET call');

	async.waterfall([
		function(callback) {	
			// do the GET request
			var reqGet = https.request(
				optionsget,
				function(rsp) {
					console.log("statusCode: ", rsp.statusCode);
					// uncomment for header details
					// console.log("headers: ", res.headers);
				
					rsp.on('data', function(d) {
						console.info('GET result:\n');
						process.stdout.write(d);
						console.info('\n\nCall completed');
						callback(null, d);
				});
			});
			
			reqGet.end();
			reqGet.on('error', function(e) {
				console.error(e);
			});
		},
		function(data, callback) {
			res.render('index', { title: data });
		}
	]);

}

/*
 * GET home page.
 */

exports.index = function(req, res){
	parse(req,res);
//  res.render('index', { title: 'Express' });
};