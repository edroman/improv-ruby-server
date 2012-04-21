class UsersController < ApplicationController
  # Note: The routing URLs here have been changed since this is a singular resource

  # GET /user/new
  # GET /user/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.haml
# These don't make sense since there's no index/show
#      format.xml { render xml: @user }
#      format.json { render json: @user }
    end
  end

  # GET /user/edit
  def edit
    @user = current_user
  end

  # POST /user
  # POST /user.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'User was successfully created.' }
# These don't make sense since there's no index/show
#        format.xml { render xml: @user, status: :created, location: @user }
#        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
# These don't make sense since there's no index/show
#        format.xml { render xml: @user.errors, status: :unprocessable_entity }
#        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user
  # PUT /user.json
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.xml { head :ok }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user
  # DELETE /user.json
  def destroy
    @user = current_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.xml { head :ok }
      format.json { head :ok }
    end
  end
end
