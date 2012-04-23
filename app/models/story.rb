# TODO: Add validation logic for constraints
class Story < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_stories    # many-to-many

  accepts_nested_attributes_for :users, :allow_destroy => true

# TODO: not working for now since initialize() is being called at other random times
#  validates_presence_of :turn, :number
#  after_initialize :set_defaults

  before_create :init


  def name
    "Story-#{number}-#{sentences}"
  end

  def name=(attributes)
  end

  def my_turn?(user)
    self.turn % 2
    result = (self.turn % 2 == 1) ? (self.users[0].id == user.id) : (self.users[1].id == user.id)
    return result
  end

  # returns the partner for the user specified of this story
  def partner(user)
    users[0].first_name == user.name ? users[1].first_name : users[0].first_name
  end

  def add_sentence(sentence)
    last_letter = sentence[sentence.length-1]

    sentence[0] = sentence[0].upcase

    self.sentences += "  "
    self.sentences += sentence

    if !last_letter.match(/[.?!]/)
      self.sentences += "."
    end

    self.turn += 1
  end

  private
    def init
      self.turn = 1
      self.number = 1

      # Select a random intro
      offset = rand(Intro.count)
      self.sentences = Intro.first(:offset => offset).name
    end

end
