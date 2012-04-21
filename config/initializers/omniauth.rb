Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, APP_CONFIG['facebook_token'], APP_CONFIG['faecbook_secret']
  #, :scope => 'email,offline_access,read_stream' #, :display => 'popup'
  provider :twitter, APP_CONFIG['twitter_token'], APP_CONFIG['twitter_secret']
end