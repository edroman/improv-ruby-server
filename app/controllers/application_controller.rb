class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :authenticate

  private

  # This encapsulates access to session[:user_id] and is called from children
  # It's a helper method so it's also available from views
  # Since ActiveRecord caches, there's no performance hit.  No reason to ever call session[:user_id] directly
  def current_user

    # This is the or-equals operator.  Don't bother looking up the user if one already exists
    if (@current_user == nil && session[:user_id])
      @current_user = User.find_by_id(session[:user_id])
    end

    if (@current_user)
      puts @current_user.first_name
    else
      puts "NO CURRENT USER"
    end

    return @current_user
  end

  def authenticate
    redirect_to root_path, :alert => "Sorry, you don't have access!" unless current_user
  end

end
