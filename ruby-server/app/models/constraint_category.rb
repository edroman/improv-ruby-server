class ConstraintCategory < ActiveRecord::Base
  has_many :constraints

  def name
    self.value
  end
end
