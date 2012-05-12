class Constraint < ActiveRecord::Base
  belongs_to :constraint_category
  accepts_nested_attributes_for :constraint_category
  has_many :sentences

  def name
    self.phrase
  end
end
