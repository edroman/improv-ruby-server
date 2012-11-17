# Many-to-many join model between users and stories
class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
end
