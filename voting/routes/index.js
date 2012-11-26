var async = require('async');				// Allows waterfall cascade of async ops

function parse(req, res)
{
	var Parse = require('parse').Parse;
	Parse.initialize("oqMegxam44o7Bnqw0osiRGEkheO9aMHm7mEGrKhb", "TzhNqjKrx2TOpvVqNEh3ppBJmcqMUkBq9AMvBjxi");

	// Declaring our object model via sublclassing Parse objects.  We can optionally add instance methods / class methods too.
	var Turn = Parse.Object.extend("Turn",
	{
	});
	var Turns = Parse.Collection.extend(
	{
		model: Turn
	});
	var Game = Parse.Object.extend("Game",
	{
		turns: Turns
	});
	var Games = Parse.Collection.extend(
	{
		model: Game,
	});
	
	// Instantiate the game tree
	var recentGames = new Games();
	var otherGames = new Games();

	async.waterfall([
		// 1) Find recent games
		function(callback) {
			recentGames.fetch(
			{
				success: function(games)
				{
					// For each game...
					games.each( function(game)
					{
						// Find all turns related to this game
						game.turns = new Parse.Query("Turn").equalTo("Game", game).collection();
						game.turns.fetch(
						{
							success:
								function(turns)
								{
									// For each turn...
									turns.each( function(turn)
									{
										console.log("Game ID: " + turn.get("Game").id + " Turn ID: " + turn.id + " creator = " + game.get("creator"));
										
										// TODO: Async nested call to get User data
										// var user = game.get("creator").fetch();

										// If we've done an async call to retrieve the last turn of the last game,
										// then invoke callback so we reply with HTTP response
										if (turn == turns.last() && game == games.last())
										{
											console.log("callback!");
											callback(null, recentGames);
										}
									});
								},
							error: function(collection, error) { console.log(error); }
						});
					});
				},
				error: function(collection, error) {  console.log(error); }
			});
		},

		// 2) Find random games
		// TODO
		function(recentGames, callback) {
			otherGames.fetch(
			{
				success: function(games)
				{
					// For each game...
					games.each( function(game)
					{
						// Find all turns related to this game
						game.turns = new Parse.Query("Turn").equalTo("Game", game).collection();
						game.turns.fetch(
						{
							success:
								function(turns)
								{
									// For each turn...
									turns.each( function(turn)
									{
										console.log("Game ID: " + turn.get("Game").id + " Turn ID: " + turn.id + " creator = " + game.get("creator"));
										
										// TODO: Async nested call to get User data
										// var user = game.get("creator").fetch();

										// If we've done an async call to retrieve the last turn of the last game,
										// then invoke callback so we reply with HTTP response
										if (turn == turns.last() && game == games.last())
										{
											console.log("callback!");
											callback(null, recentGames, otherGames);
										}
									});
								},
							error: function(collection, error) { console.log(error); }
						});
					});
				},
				error: function(collection, error) {  console.log(error); }
			});
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
		function(recentGames, otherGames, callback) {
			res.render('index', { recentGames: recentGames, otherGames: otherGames, currentUser: req.user });
		}
	]);

}

/*
 * GET home page.
 */

exports.index = function(req, res){
	parse(req,res);
};