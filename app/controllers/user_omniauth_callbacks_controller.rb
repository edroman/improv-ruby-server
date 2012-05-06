class UserOmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # TODO: Save user's credentials
    @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
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
    Twitter.update(session[:data])

    flash[:notice] = "Tweet sent successfully!"
    redirect_to session[:return_path]
    # session["devise.twitter_data"] = auth
    # sign_in_and_redirect @current_user, :event => :authentication
  end
end