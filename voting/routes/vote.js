var async = require('async');				// Allows waterfall cascade of async ops
var Parse = require('parse').Parse;
Parse.initialize("oqMegxam44o7Bnqw0osiRGEkheO9aMHm7mEGrKhb", "TzhNqjKrx2TOpvVqNEh3ppBJmcqMUkBq9AMvBjxi");

/*
 * vote on a story
 * TODO: Make a separate view for this.  Should link user to download the app.
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
			var msg = "Congrats, you've voted for story " + req.params.id;
			console.log(msg);
			res.render('vote', { result: msg });
		},
		error: function(vote, error)
		{
			var msg = "Voting failed for story " + req.params.id + " Error: " + error.code + " " + error.message;
			console.log(msg);
			res.render('vote', { result: msg });
		}
	});
};