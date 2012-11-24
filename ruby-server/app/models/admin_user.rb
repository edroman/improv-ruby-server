class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

# When in final production, could send out password reset instructions when the admin user is created
#  after_create { |admin| admin.send_reset_password_instructions }

  def password_required?
    new_record? ? false : super
  end
end
