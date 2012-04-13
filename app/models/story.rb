class Story < ActiveRecord::Base
  belongs_to :team						          # many-to-one: Each story has exactly one team
  has_many :users, :through => :teams		# for convenience, can access users directly

  accepts_nested_attributes_for :users, :allow_destroy => true

  def name
    "Team: #{team.name}, Story: #{number}"
  end

  def name=(attributes)
  end
end
