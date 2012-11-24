var async = require('async');				// Allows waterfall cascade of async ops

function parse(req, res)
{
	var Parse = require('parse').Parse;
	Parse.initialize("oqMegxam44o7Bnqw0osiRGEkheO9aMHm7mEGrKhb", "TzhNqjKrx2TOpvVqNEh3ppBJmcqMUkBq9AMvBjxi");

	async.waterfall([
		// 1) Find all games
		function(callback) {
			var gameQuery = new Parse.Query("Game");
			var games = gameQuery.collection();
			games.fetch(
			{
				success:
					function(games)
					{
						// For each game...
						games.each( function(game)
						{
							// Find all turns related to this game
							console.log("Game ID: " + game.id);
							var key = game.id;
							var turnQuery = new Parse.Query("Turn");
							// var turns = turnQuery.collection();
							var turns = turnQuery.equalTo("Game", key).collection();
							turns.fetch(
							{
								success:
									function(turns)
									{
										// For each turn...
										turns.each( function(turn) { console.log("Turn ID: " + turn.id) } );
									},
								error: function(collection, error) { console.log(error); }
							});
						});
					},
				error: function(collection, error) {  console.log(error); }
			});
			callback(null, games);
		},
/*
		// 1) Find all games
		function(callback) {	
			var Obj = Parse.Object.extend("Game");
			var GameCollection = Parse.Collection.extend({
			  model: Obj
			});
			var collection = new GameCollection();
			collection.fetch({
				success: function(collection) {
					collection.each(function(object) {
						console.log(object.id);
//						callback(null, object);
					});
				},
				error: function(collection, error) {
				}
			});
		},
		// 2) For each game, find all turns, and display them
		function(game, callback) {
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
			
/*
			// 2) For each game, find all turns, and display them
			var Obj = Parse.Object.extend("Turn");
			var query = new Parse.Query(Obj);
//			query.equalTo("
			query.find({
			  success: function(data) {
				for (var i = 0; i < data.length; ++i) {
				  console.log(data[i].get('turn'));
				}
				callback(null, data);
			  }
			});
		},
*/
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