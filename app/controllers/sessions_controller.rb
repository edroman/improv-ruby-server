class SessionsController < ApplicationController

  def get_auth
    auth = request.env["omniauth.auth"]
  end

  # Creates a new session for the user
  # Either finds an existing user or creates a new one.
  #
  # This method is called from one of two places:
  # 1) Callback function that Facebook calls when user logs in through facebook
  # 2) Screen where user creates a session manually by logging in via email
  # 3) Native iOS interface
  #
  # TODO: Convert this all to use Devise -- see rails notes for Railcasts links for this
  def create
    authenticated = false

    # Get the auth stuff passed in from facebook
    auth = get_auth

    # If we're logging in through facebook..
    if auth
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      if !user
        user = User.create_with_omniauth(auth)
      else
        authenticated = true
      end
    # If we're logging in through a web form, or native iOS, process that via login/pass params submitted via form, which invokes this callback
    else
      user = User.find_by_email(params[:newuser][:email])
      if !user
        redirect_to root_url, :notice => "Invalid email"
      elsif params[:newuser][:password] != user.password
        redirect_to root_url, :notice => "Invalid password"
      else
        authenticated = true
      end
    end

    if authenticated
      session[:user_id] = user.id if user != nil
      redirect_to root_url, :notice => "You've signed in! I rejoice at your return!"
    end
	end

	def destroy
	  reset_session
	  redirect_to root_url, :notice => "You've signed out! I will weep until your return."
  end

  def failure
    redirect_to root_url, :alert => "Oops...something bad happened and I couldn't log you in."
  end

end
