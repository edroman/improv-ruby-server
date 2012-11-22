var async = require('async');				// Allows waterfall cascade of async ops

function parse(req, res)
{
	var Parse = require('parse').Parse;
	Parse.initialize("oqMegxam44o7Bnqw0osiRGEkheO9aMHm7mEGrKhb", "TzhNqjKrx2TOpvVqNEh3ppBJmcqMUkBq9AMvBjxi");

	async.waterfall([
		function(callback) {	
			var Obj = Parse.Object.extend("Turn");
			var query = new Parse.Query(Obj);
			query.find({
			  success: function(data) {
				for (var i = 0; i < data.length; ++i) {
				  console.log(data[i].get('turn'));
				}
				callback(null, data);
			  }
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