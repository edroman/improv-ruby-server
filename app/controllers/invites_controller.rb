class InvitesController < ApplicationController
  def new
    # TODO: grab user_token

    # TODO: Use api-read.facebook.com for this
    friends = FbGraph::Query.new(
        'select name, email, phone from user where uid in (select uid2 from friend where uid1=me())'
    ).fetch(user_token)

    friends.each do |friend|
      puts friend[:name] + ": " + (friend[:email] ? friend[:email] : "") + (friend[:phone] ? friend[:phone] : "")
    end
  end

  def create
  end
end
