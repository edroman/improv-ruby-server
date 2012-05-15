# Manages surveys for user experience so developer can get feedback
class SurveysController < ApplicationController

  # TODO: This is a security issue, but was the only way I could figure out how to allow HTTP DELETE to work via cURL since there's no authenticity tokens
  skip_before_filter :verify_authenticity_token

  # Make sure the user is logged in via Devise before doing any operation
  before_filter :authenticate_user!, :except => [:edit]

  # GET /surveys/new
  # Creates a new survey based on a particular story.
  # The story_id is a parameter which the view takes and passes as a hidden_field to create.
  def new
    @survey = Survey.new

    respond_to do |format|
      format.html # new.slim
      format.json { render json: @survey }
    end
  end

  # POST /surveys
  # Submits the survey once the user fills it out
  def create
    @survey = Survey.new(params[:survey])
    @survey.user_id = current_user.id
    @survey.save

    unfinished_story = Story.find_unfinished_by_partner(current_user, @survey.story.partner(current_user).id)
    # If this is the 2nd survey to be filled out, then there's already a new story in progress, so edit that one
    if unfinished_story
      redirect_to edit_story_path(unfinished_story) and return
    else
      # Otherwise make a new story

      # redirect_to create_a_story_path(:partner => @survey.story.partner(current_user).id) and return
      params[:partner] = @survey.story.partner(current_user).id

      # if a story already exists for this team, then create an error
      # TODO: move to model for validation
      # TODO: respond_to json too, and optimize this better
      if Story.find_unfinished_by_partner(current_user, params[:partner][0].to_i)
        redirect_to stories_path, :notice => "You already have an unfinished story with that partner -- finish that one first!"
        return
      end

      @story = Story.new(params[:story])
      @story.users[0] = current_user
      @story.users[1] = User.find_by_id(params[:partner])
      success = @story.save

      respond_to do |format|
        if success
          format.html { redirect_to "/stories/#{@story.id}/edit", notice: 'Story was successfully created.' }
          format.json { render json: @story, status: :created, location: @story }
        else
          format.html { render action: "new" }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    end
  end

end
