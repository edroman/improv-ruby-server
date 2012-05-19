module ApplicationHelper
  # gets our IP address
  def get_ip
    # heroku - code can't get IP since it's a local IP address, so need to hard-code it
    # also since Facebook has callbacks, we can't use localhost -- we need to use no-ip.org for local dev
    return "http://#{APP_CONFIG['server_host']}"
  end
end
