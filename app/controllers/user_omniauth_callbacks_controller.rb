class UserOmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]

    # Make a new user if one doesn't exist
    @user = User.find_by_email(auth.extra.raw_info.email)
    if @user == nil
      @user = User.create!(:first_name => auth.extra.raw_info.name,
                           :email => auth.extra.raw_info.email,
                           :password => Devise.friendly_token[0,20])
    end

    # Update the user's facebook stuff (he might have made an account by email, or his token might be old)
    # TODO: Mass assignment vulnerability.  Secure this.
    @user.update_attributes( { :facebook_token => auth['credentials']['token'], :facebook_uid => auth['uid'] }, :without_protection => true )

    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    sign_in_and_redirect @user, :event => :authentication

    # Old code if user didn't exist:
    # session["devise.facebook_data"] = request.env["omniauth.auth"]
    # redirect_to new_user_registration_url
  end

  def twitter
    # TODO: Should we load these credentials at any point?
    # TODO: Should we not persist tokens each time?
    auth = request.env["omniauth.auth"]
    current_user.twitter_token = auth['credentials']['token']
    current_user.twitter_secret = auth['credentials']['secret']
    current_user.save

    Twitter.configure do |config|
      config.consumer_key = Rails.configuration.twitter_token
      config.consumer_secret = Rails.configuration.twitter_secret
      config.oauth_token = current_user.twitter_token
      config.oauth_token_secret = current_user.twitter_secret
    end
    puts "TWEETING " + session[:data]
    Twitter.update(session[:data])

    flash[:notice] = "Tweet sent successfully!"
    redirect_to session[:return_path]
    # session["devise.twitter_data"] = auth
    # sign_in_and_redirect @current_user, :event => :authentication
  end
end