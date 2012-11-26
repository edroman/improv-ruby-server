var async = require('async');				// Allows waterfall cascade of async ops
var Parse = require('parse').Parse;
Parse.initialize("oqMegxam44o7Bnqw0osiRGEkheO9aMHm7mEGrKhb", "TzhNqjKrx2TOpvVqNEh3ppBJmcqMUkBq9AMvBjxi");

/*
 * vote on a story
 */

exports.create = function(req, res)
{
	async.waterfall([
		// 1) Find game
		function(callback) {
			var gameQuery = new Parse.Query("Game");
			gameQuery.get(req.params.id, {
			  success: function(game) {
				console.log("Successfully retrieved " + game);
				callback(null, game);
			  },
			  error: function(error) {
				console.log("Error: " + error.code + " " + error.message);
			  }
			});
		},

		// 2) Make new vote
		function(game, callback) {
			var Vote = Parse.Object.extend("Vote");
			var vote = new Vote();
			vote.set("User", Parse.User.current());
			vote.set("Game", game);
			vote.save(null,
			{
				success: function(vote)
				{
					var msg = "Successfully created vote for " + game.id;
					console.log(msg);
					callback(null, game);
				},
				error: function(vote, error)
				{
					var msg = "Voting failed for story " + game.id + " Error: " + error.code + " " + error.message;
					console.log(msg);
					response.send(msg);
				}
			});
		},

		// 3) Add to vote count in game
		function(game, callback) {
			game.set("votes", game.get("votes") + 1);
			game.save(null,
			{
				success: function(game)
				{
					var msg = "Congrats, you voted!";
					console.log(msg);
					res.render('vote', { result: msg });
				},
				error: function(vote, error)
				{
					var msg = "Voting failed, error: " + error.code + " " + error.message;
					console.log(msg);
					res.render('vote', { result: msg });
				}
			});
		},

	]);
};