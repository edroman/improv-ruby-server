# Manages stories -- creating new ones, adding lines to current ones, deleting, and viewing completed story w/audio
class StoriesController < ApplicationController

  # Make sure the user is logged in via Devise before doing any operation
  before_filter :authenticate_user!, :except => [:show_archived]

  # GET /stories
  # Lobby, showing list of current games
  def index
    @stories = current_user.stories

    respond_to do |format|
      format.html # index.slim
      format.json { render json: @stories }
    end
  end

  # GET /stories/1
  # TODO: Show the user the completed story and playback audio button
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.slim
      format.json { render json: @story }
    end
  end

  # GET /stories/1/show_archived
  # TODO: Show the user the completed story and playback audio button
  def show_archived
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show_archived.slim
      format.json { render json: @story }
    end
  end

  # GET /stories/new
  # Displays a drop-down box where user can select a partner who has already registered, and make a new story.
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.slim
      format.json { render json: @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])

    if (@story.finished)
      # TODO: json
      render "show"
    end

    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (@story.curr_playing_user.id != current_user.id)
      redirect_to stories_url
      return
    end
  end

  # POST /stories
  #
  # Called when user clicks "submit" on the "new story" screen.  Makes an actual story.
  def create
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

  # PUT /stories/1
  # This is how users play the game -- adding sentences
  def update
    @story = Story.find(params[:id])

    success = @story.add_sentence(params[:sentence])
    @story.save if success

    respond_to do |format|
      if success && @story.update_attributes(params[:story])
        if @story.finished
          # Make new story
          # TODO: Do we check success of save?
          #new_story = Story.new(params[:story])
          #new_story.users[0] = current_user
          #new_story.users[1] = @story.partner(current_user)
          #new_story.save
          # TODO: json
          #format.html { redirect_to "/stories/#{new_story.id}/edit", notice: 'Here is your next story!' }

          format.html { redirect_to story_path(@story) }
        else
          format.html { redirect_to stories_path, notice: 'Story was successfully updated.' }
          format.json { head :ok }
        end
      else
        format.html { render "edit" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :ok }
    end
  end

  # GET /stories/1/nudge_partner
  def nudge_partner
    @story = Story.find(params[:id])
    @story.nudge_partner
    flash[:notice] = "You nudged your partner!"
    redirect_to stories_path
  end

  # GET /stories/1/survey
  def survey
    @story = Story.find(params[:id])
    @story.survey_comments = params[:survey_comments]
    @story.survey_rating = params[:survey_rating]
    @story.save

    unfinished_story = Story.find_unfinished_by_partner(current_user, @story.partner(current_user).id)
    if unfinished_story
      # When partner views story, the next story has already been made
      redirect_to edit_story_path(unfinished_story)
    else
      # When user who completes the story, it should create the next story
      params[:partner] = @story.partner(current_user).id
      redirect_to create_story_path
    end
  end
end
