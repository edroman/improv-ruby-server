# Manages votes for user experience so developer can get feedback
class VotesController < ApplicationController

  # TODO: This is a security issue, but was the only way I could figure out how to allow HTTP DELETE to work via cURL since there's no authenticity tokens
  skip_before_filter :verify_authenticity_token

  # Make sure the user is logged in via Devise before doing any operation
  before_filter :check_authentication

  # GET /votes/new
  # Creates a new vote based on a particular story.
  # The story_id is a parameter which the view takes and passes as a hidden_field to create.
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.slim
      format.json { render json: @vote }
    end
  end

  # POST /votes
  # Submits the vote once the user fills it out
  def create
    if Vote.where(:story_id => params[:story_id], :user_id => current_user.id).size > 0
      respond_to do |format|
        format.html { redirect_to stories_path, notice: 'You already voted on that story!' }
        format.json { render json: @story, status: :created, location: @story }
      end
      return
    end

    @vote = Vote.new(params[:vote])
    @vote.user_id = current_user.id
    @vote.story_id = params[:story_id]
    success = @vote.save

    respond_to do |format|
      if success
        format.html { redirect_to stories_path, notice: 'Vote successfully cast!' }
        format.json { render json: @story, status: :created, location: @story }
      else
        format.html { render action: "new" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

end
