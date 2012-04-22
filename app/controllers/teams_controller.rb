class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.json
  def index
    @teams = current_user.teams

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
=begin
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @team }
    end
  end
=end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
=begin
  def edit
    @team = Team.find(params[:id])
  end
=end

  # POST /teams
  # POST /teams.json
  def create
    # params[:team][:users][0] = current_user
    # params[:team][:users][1] = params[:partner]
    @team = Team.new(params[:team])
    @team.users[0] = current_user
    @team.users[1] = User.find_by_id(params[:partner])

    respond_to do |format|
      if @team.save
        format.html { redirect_to stories_path, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
=begin
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :ok }
    end
  end
end
