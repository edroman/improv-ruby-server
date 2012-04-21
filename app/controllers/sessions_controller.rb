class SessionsController < ApplicationController

  def get_auth
    auth = request.env["omniauth.auth"]
  end

  def create
    auth = get_auth
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if !user
      user = User.create_with_omniauth(auth)
    else
      flash[:notice] = "You've signed in! I rejoice at your return!"
    end
	  session[:user_id] = user.id if user != nil
    redirect_to root_url, :notice => "You've signed in! I rejoice at your return!"
	end

	def destroy
	  reset_session
	  redirect_to root_url, :notice => "You've signed out! I will weep until your return."
  end

  def failure
    redirect_to root_url, :alert => "Oops...something bad happened and I couldn't log you in."
  end

end
