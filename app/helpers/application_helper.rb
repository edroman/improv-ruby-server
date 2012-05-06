module ApplicationHelper
  # gets our IP address
  def get_ip
    # heroku - code can't get IP since it's a local IP address, so need to hard-code it
    if Rails.env.production? || Rails.env.staging?
      return "http://#{APP_CONFIG['server_host']}"
      # local - can't just hardcode localhost, since other machines on local network can't access this one, so need code
    else
      require 'socket'
      return "http://#{Socket.gethostname}:#{APP_CONFIG['local_port']}"
    end
  end
end
