# Shows the top players by votes
class LeaderboardController < ApplicationController

  # TODO: This is a security issue, but was the only way I could figure out how to allow HTTP DELETE to work via cURL since there's no authenticity tokens
  skip_before_filter :verify_authenticity_token

  # Make sure the user is logged in via Devise before doing any operation
  # before_filter :check_authentication, :except => [:show]

  # GET /leaderboard
  # Shows the leaderboard
  def index
  end

end
