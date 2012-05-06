# Manages sentences
class SentencesController < ApplicationController

  # Make sure the user is logged in via Devise before doing any operation
  before_filter :authenticate_user!

  # GET /sentences/1/edit
  def edit
    @sentence = Sentence.find(params[:id])

    if (@sentence.finished)
      # TODO: json
      render "show"
    end

    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (@sentence.story.curr_playing_user.id != current_user.id)
      redirect_to stories_url
      return
    end
  end

  # PUT /sentences/1
  # This is how users play the game -- modifying sentences
  def update
    @sentence = Sentence.find(params[:id])

    success = @sentence.add_sentence(params[:sentence])
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

end
