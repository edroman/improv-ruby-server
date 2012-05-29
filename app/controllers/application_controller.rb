class ApplicationController < ActionController::Base
  protect_from_forgery

  # Stores some stuff in the session for later, then redirects to another URL
  def store_and_redirect
    session[:return_path] = params[:return_path]
    session[:data] = params[:data]
    redirect_to params[:destination_path]
  end

  # This filter is called selectively within each controller to check if the user is logged in
  def check_authentication
    # Store current page in session
    # TODO: Should this be request.referrer, which is the page origin rather than the page destination -- request.fullpath?
    if current_user == nil
      # In application_helper.rb too, so it's available to views as well
      session[:resource_return_to] = request.fullpath
    end

    # Devise check for authentication
    authenticate_user!
  end

  # This is called by Devise after the user logs in, so that we can redirect them back to the proper starting page
  # Technically this is not needed, the default version inspects session[:resource_return_to], but we can extend if needed
  def after_sign_in_path_for(resource)
    # Extract previous page from session
    stored_location = session[:resource_return_to]
    session[:resource_return_to] = nil

    return stored_location if stored_location != nil
    return request.env['omniauth.origin'] if request.env['omniauth.origin'] != nil
    return root_path
  end

end
