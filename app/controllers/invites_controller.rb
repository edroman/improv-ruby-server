class InvitesController < ApplicationController
  def index
    # TODO: Use api-read.facebook.com for this
    @friends = FbGraph::Query.new(
        'select name, uid, pic_square from user where uid in (select uid2 from friend where uid1=me())'
    ).fetch(current_user.facebook_token)

    @friends.sort! { |a,b| a[:name] <=> b[:name] }

    # @friends.each do |friend|
    #   puts "#{friend[:name]} : #{friend[:uid]}"
    # end
  end

  def create
  end
end
