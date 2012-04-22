class User < ActiveRecord::Base
  has_and_belongs_to_many :stories, :join_table => :users_stories			# many-to-many

  accepts_nested_attributes_for :stories, :allow_destroy => true

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
end
