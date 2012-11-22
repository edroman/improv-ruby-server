var async = require('async');				// Allows waterfall cascade of async ops

function parse(req, res)
{
	var https = require('https');
	
	var optionsget = {
		host : 'api.parse.com', // here only the domain name, no http/https
		port : 443,
		path : '/1/classes/Game', // the rest of the url with parameters if needed
		method : 'GET',
		headers : {
			'X-Parse-Application-Id' : 'oqMegxam44o7Bnqw0osiRGEkheO9aMHm7mEGrKhb',
			'X-Parse-REST-API-Key' : '28QgsPQBhzLPABB4KlgEFMb3q7OM8Ya4GaDOHXER'
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
			res.render('index', { games: data });
		}
	]);

}

/*
 * GET home page.
 */

exports.index = function(req, res){
	parse(req,res);
};