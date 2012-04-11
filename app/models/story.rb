class Story < ActiveRecord::Base
  belongs_to :team						          # many-to-one: Each story has exactly one team
  has_many :users, :through => :teams		# for convenience, can access users directly
end
