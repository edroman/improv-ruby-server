module ApplicationHelper
  # gets our IP address
  def get_ip
    # heroku - code can't get IP since it's a local IP address, so need to hard-code it
    # also since Facebook has callbacks, we can't use localhost -- we need to use no-ip.org for local dev
    if (Rails.env == "development")
      return "http://#{ENV['DEV_MACHINE']}"
    else
      return "http://#{APP_CONFIG['server_host']}"
    end
  end

  # Stores current page (used by views).  Works with application_controller.rb::after_sign_in_path_for
  def store_location
    session[:resource_return_to] = request.fullpath
  end

end
