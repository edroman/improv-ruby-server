class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model (devise)
  attr_accessible :first_name, :phone, :email, :password, :password_confirmation, :remember_me

  has_and_belongs_to_many :stories, :join_table => :users_stories			# many-to-many.  TODO: figure out how to do cascading delete with HABTM

  accepts_nested_attributes_for :stories, :allow_destroy => true

  validates_presence_of :first_name, :email

  # Returns a list of all users other than one
  scope :all_except, lambda{|user| user ? {:conditions => ["id != ?", user.id]} : {} }

  def name
    first_name
  end

  def name=(attributes)
  end

  def self.create_with_omniauth(auth)
    # Create a user and pass a block to initialize it
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.first_name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
    end
  end

  before_validation :downcase_email
  before_validation :format_phone

  private

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end

  def format_phone
    return if !self.phone
    return if self.phone.length == 0

    self.phone = "+1 " + self.phone if (self.phone[0] != '+')
  end
end
