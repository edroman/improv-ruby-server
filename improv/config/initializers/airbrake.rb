if Rails.env.production?
  Airbrake.configure do |config|
    config.api_key = '5a9884263cad82bdafb2cd0e4137317c'
    config.development_lookup = false
  end
end