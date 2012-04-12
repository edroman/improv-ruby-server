class User < ActiveRecord::Base
  has_and_belongs_to_many :teams, :join_table => :users_teams			# many-to-many
  has_many :stories, :through => :teams                           # For convenience, can access stories directly
end
