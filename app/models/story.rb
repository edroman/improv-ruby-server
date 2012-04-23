require 'test/unit'

# TODO: Add validation logic for constraints
class Story < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_stories    # many-to-many

  serialize :constraints
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

  def curr_constraint
    constraints[turn-1]
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
    def random(model)
      count = model.count
      raise unless count > 0
      offset = rand(count)
      return model.first(:offset => offset)
    end

  def init
      self.turn = 1
      self.number = 1
      self.constraints = Array.new

      # Select a random intro
      self.sentences = random(Intro).name

      # Select random constraints
      (0..5).each do |n|
        case n
          when 0..1
            self.constraints[n] = random(Noun).name
          when 2..4
            self.constraints[n] = random(Verb).name
          when 5
            self.constraints[n] = self.constraints[0]
        end
      end
    end

end
