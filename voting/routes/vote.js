var async = require('async');				// Allows waterfall cascade of async ops
var Parse = require('parse').Parse;
Parse.initialize("oqMegxam44o7Bnqw0osiRGEkheO9aMHm7mEGrKhb", "TzhNqjKrx2TOpvVqNEh3ppBJmcqMUkBq9AMvBjxi");

/*
 * vote on a story
 */

exports.create = function(req, res)
{
	var Vote = Parse.Object.extend("Vote");
	var vote = new Vote();
	vote.set("User", Parse.User.current());
	vote.set("Game", "#{req.params.id}");
	vote.save(null,
	{
		success: function(vote)
		{
			console.log("Vote for " + req.params.id + " created.");
			res.send("Congrats, you've voted for story " + req.params.id);
		},
		error: function(vote, error)
		{
			console.log("Vote for " + req.params.id + " failed: " + error);
			res.send("Voting failed for story " + req.params.id + " Error: " + error.code + " " + error.message);
		}
	});
};