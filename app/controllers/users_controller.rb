class UsersController < ApplicationController
  # Note: The routing URLs here have been changed since this is a singular resource

  # GET /user/new
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
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
      return
    end

    @user = current_user
  end

  # POST /user
  def create
    @user = User.new(params[:user])
    @user.facebook_token = session["devise.facebook_data"]['credentials']['token']
    @user.facebook_uid = session["devise.facebook_data"]['uid']

    respond_to do |format|
      if @user.save
        # TODO: Instead of redirecting to root, figure out how to pass parameters properly to sessions#create
        format.html { redirect_to root_url, notice: 'User was successfully created.', :newuser => @user }
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
  def update
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
      return
    end

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
  def destroy
    # TODO: should this use "render" instead, and how do we respond via JSON?
    if (!current_user)
      redirect_to root_url
      return
    end

    @user = current_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.xml { head :ok }
      format.json { head :ok }
    end
  end
end
