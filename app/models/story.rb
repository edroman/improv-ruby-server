# TODO: Add validation logic for constraints
class Story < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_stories    # many-to-many

  accepts_nested_attributes_for :users, :allow_destroy => true

  before_create :setup_intro
  before_create :setup_constraints

  def name
    "Story-#{number}-#{sentences}"
  end

  def name=(attributes)
  end

  # returns the partner for the user specified of this story
  def partner(user)
    users[0].first_name == user.name ? users[1].first_name : users[0].first_name
  end

  def add_sentence(sentence)
    self.sentences += sentence
  end

  private
    def setup_intro
      offset = rand(Intro.count)
      self.sentences = Intro.first(:offset => offset).name
    end

    def setup_constraints

    end
end
