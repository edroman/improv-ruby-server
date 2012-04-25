require 'test/unit'
require 'twilio-ruby'

# TODO: Add validation logic for constraints
class Story < ActiveRecord::Base
  # users[0] is the person who created the story and adds the first sentence
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
    result = (self.turn % 2 == 1) ? (self.users[0].id == user.id) : (self.users[1].id == user.id)
    return result
  end

  def curr_waiting_user
    self.users[self.turn % 2]
  end

  def curr_playing_user
    self.users[(self.turn+1) % 2]
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
    sentence[0] = sentence[0].upcase if self.turn > 1
    sentence += "." if !last_letter.match(/[.?!]/)

    self.sentences += "  "
    self.sentences += sentence

    # order matters here
    send_notification(sentence)
    self.turn += 1
  end

  def init
      self.turn = 1
      self.number = 1
      self.constraints = Array.new

      # Select a random intro
      # TODO: optimize this performance, since it loads entire table
      self.intro = (Intro).all.sample(1).first.name
      self.sentences = intro

      # Select random constraints
      # TODO: optimize this performance, since it loads entire table
      nouns = Noun.all.sample(2)
      verbs = Verb.all.sample(3)
      (0..5).each do |n|
        case n
          when 0..1
            self.constraints[n] = nouns[n].name
          when 2..4
            self.constraints[n] = verbs[n-2].name
          when 5
            self.constraints[n] = self.constraints[0]
        end
      end
    end

  private

    # gets our IP address
    def get_ip
      # heroku - code can't get IP since it's a local IP address, so need to hard-code it
      if Rails.env.production? || Rails.env.staging?
        return "http://#{APP_CONFIG['server_host']}"
      # local - can't just hardcode localhost, since other machines on local network can't access this one, so need code
      else
        require 'socket'
        return "http://#{Socket.gethostname}:#{APP_CONFIG['local_port']}"
      end
    end

    def send_notification(sentence)
      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new(APP_CONFIG['twilio_account_sid'], APP_CONFIG['twilio_auth_token'])

      # send an sms

      line_ending = " Your turn! #{get_ip}/stories/#{self.id}/edit"

      if turn == 1
        line = "#{curr_playing_user.first_name} wants to create a story with you!"
        if line.length + " \"#{self.sentences}\"".length + line_ending.length <= 160
          line += " \"#{self.sentences}\""
        elsif line.length + self.intro.length + line_ending.length <= 160
          line += " \"#{self.intro}\""
        end
      else
        line = "#{curr_playing_user.first_name} added to your story!"
        if line.length + " \"#{sentence}\"".length + line_ending.length <= 160
          line += " \"#{sentence}\""
        end
      end

      line += line_ending

      if curr_waiting_user.phone != ''
        @client.account.sms.messages.create(
          :from => APP_CONFIG['sms_source'],
          :to => "#{curr_waiting_user.phone}",
          :body => line
        )
      end
    end

end
