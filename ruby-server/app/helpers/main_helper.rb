module MainHelper
  # The following 3 methods are for Devise and allows users to login via the homepage

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
