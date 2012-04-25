class StoriesController < ApplicationController
  # Manages stories -- creating new ones, adding lines to current ones, deleting, and viewing completed story w/audio

  # GET /stories
  # Lobby, showing list of current games
  def index
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
      return
    end

    @stories = current_user.stories

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @stories }
    end
  end

  # GET /stories/1
  # TODO: Show the user the completed story and playback audio button
  def show
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
      return
    end

    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @story }
    end
  end

  # GET /stories/new
  # Displays a drop-down box where user can select a partner who has already registered, and make a new story.
  def new
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
      return
    end

    @story = Story.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @story }
    end
  end

  # GET /stories/1/edit
  def edit
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
      return
    end

    @story = Story.find(params[:id])

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
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
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
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
      return
    end

    @story = Story.find(params[:id])

    # Check if sentence has constraint inside it. If not, display an error.
    if (!params[:sentence].upcase.match(@story.curr_constraint.upcase))
      redirect_to "/stories/#{@story.id}/edit", :notice => "Error: You didn't use the word #{@story.curr_constraint}!"
      return
    end

    @story.add_sentence(params[:sentence])
    @story.save

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to stories_path, notice: 'Story was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render "edit" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  def destroy
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
      return
    end

    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :ok }
    end
  end
end
