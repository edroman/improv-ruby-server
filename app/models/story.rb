class Story < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_stories    # many-to-many

  accepts_nested_attributes_for :users, :allow_destroy => true

  def name
    "Story-#{number}-#{sentences}"
  end

  def name=(attributes)
  end
end
