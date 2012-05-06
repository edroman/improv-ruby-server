class ApplicationController < ActionController::Base
  protect_from_forgery

  # Stores some stuff in the session for later, then redirects to another URL
  def store_and_redirect
    session[:return_path] = params[:return_path]
    session[:data] = params[:data]
    redirect_to params[:destination_path]
  end
end
