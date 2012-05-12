require 'test/unit'
require 'twilio-ruby'

class Story < ActiveRecord::Base
  # users[0] is the person who created the story and adds the first sentence
  has_and_belongs_to_many :users, :join_table => :users_stories    # many-to-many
  accepts_nested_attributes_for :users, :allow_destroy => true

  has_many :sentences, :dependent => :destroy
  accepts_nested_attributes_for :sentences, :allow_destroy => true

  has_many :surveys, :dependent => :destroy

# TODO: not working for now since initialize() is being called at other random times
#  validates_presence_of :turn, :number
#  after_initialize :set_defaults

  before_create :init_before_save
  after_create :init_after_save

  # finds the unfinished story currently being worked on by a certain team of users
  def Story.find_unfinished_by_partner(user, partner_id)
    user.stories.each do |my_story|
      if (my_story.partner(user).id == partner_id && !my_story.finished)
        return my_story
      end
    end

    return nil
  end

  def name
    "Story \##{number} [#{self.users[0].first_name} + #{self.users[1].first_name}] #{self.all_sentences}"
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

  def finished
    return self.turn > 6
  end

  # Note: this does a database lookup, and doesn't use any 'in-memory' sentences objects, since all
  # active record objects are stateless.
  def curr_sentence
    self.sentences.find_by_turn(self.turn)
  end

  def all_sentences
    body_text = self.intro

    self.sentences.each do |sentence|
      body_text += "  #{sentence.body}"
    end

    return body_text
  end

  def all_sentences_preview
    smart_truncate(all_sentences.gsub(/['"]/, ''), { :words => 20 } ) + '...'
  end

  def add_sentence(sentence_text)
    # Add punctuation to last word in sentence
    sentence_text[0] = sentence_text[0].upcase if sentence_text.length > 0 && self.turn > 1

    # Set sentence to that text and save it
    sentence = sentences.find_by_turn(self.turn)
    sentence.body = sentence_text
    puts "Saving Sentence for turn #{sentence.turn}: #{sentence.body}"
    if (!sentence.save)
      sentence.errors.full_messages.each do |msg|
        errors.add :base, msg
      end

      return false
    end

    #
    # Increment turn and send SMS -- order matters here
    #
    send_turn_notification(sentence.body)
    self.turn += 1
    return true
  end

  # returns the partner for the user specified of this story
  def partner(user)
    users[0].email == user.email ? users[1] : users[0]
  end

  # Finish initializing this object
  def init_before_save
    self.turn = 1
    self.number = 1
    self.intro = (Intro).all.sample(1).first.name
  end

  # Create sentences which depend on this record's id that is database generated
  def init_after_save
    # Select intro and random constraints
    # TODO: Make this more generic
    subjects = Constraint.joins(:constraint_category).where('constraints.active = ? and constraint_categories.value = ?', true, 'Subject').sample(1)
    nouns = Constraint.joins(:constraint_category).where('constraints.active = ? and constraint_categories.value = ?', true, 'Noun').sample(2)
    verbs = Constraint.joins(:constraint_category).where('constraints.active = ? and constraint_categories.value = ?', true, 'Verb').sample(3)
    initial_constraint = nil
    (1..6).each do |n|
      sentence = Sentence.new
      sentence.story_id = self.id
      sentence.turn = n

      # Set constraints
      case n
        when 1
          sentence.constraint_id = subjects[n-1].id
          initial_constraint = subjects[n-1] if (n == 1)
        when 2
          sentence.constraint_id = nouns[n-1].id
        when 3..5
          sentence.constraint_id = verbs[n-1-2].id
        when 6
          sentence.constraint_id = initial_constraint.id
      end
      sentence.save
    end
  end

  # This is sent AFTER the story is persisted, so it is sent FROM curr_waiting_user TO curr_playing_user
  def nudge_partner

    send_facebook_notification(curr_waiting_user, curr_playing_user, "#{curr_waiting_user.first_name} has nudged you to help finish your story!")
    send_sms "#{curr_waiting_user.first_name} has nudged you to help finish your story! #{get_ip}/stories/#{self.id}/edit", curr_playing_user

    # TODO: Other types of notifications
  end

  private

    def smart_truncate(s, opts = {})
      opts = {:words => 12}.merge(opts)
      if opts[:sentences]
        return s.split(/\.(\s|$)+/)[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
      else
        a = s.split(/\s/) # or /[ ]+/ to only split on spaces
        n = opts[:words]
        return a[0...n].join(' ')
      end
    end

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

    def send_sms(body, user)

      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new(APP_CONFIG['twilio_account_sid'], APP_CONFIG['twilio_auth_token'])

      if user.phone != nil && user.phone != ''
        puts ("Attempting to send SMS: " + body)
        @client.account.sms.messages.create(:from => APP_CONFIG['sms_source'], :to => "#{user.phone}", :body => body)
      end
    end

    def send_facebook_notification(from_user, to_user, msg)
      return if !to_user.token

      # user = FbGraph::User.new('me', :access_token => session[:omniauth]["credentials"]["token"])
      # user.fetch
      # facebook_user = FbGraph::User.new('me', :access_token => from_user.token).fetch
      # facebook_user.friends
    end

    # This is sent BEFORE the add_sentence is persisted, so it comes FROM curr_playing_user TO curr_waiting_user
    def send_turn_notification(sentence)

      if (turn == 6)
        line_ending = " #{get_ip}/stories/#{self.id}"
      else
        line_ending = " Your turn! #{get_ip}/stories/#{self.id}/edit"
      end

      if turn == 1
        # Send an SMS that 'I created a new story' if its turn 1
        line = "#{curr_playing_user.first_name} wants to create a story with you!"
        if line.length + " \"#{self.all_sentences}\"".length + line_ending.length <= 160
          line += " \"#{self.all_sentences}\""
        elsif line.length + " \"#{self.intro}\"".length + line_ending.length <= 160
          line += " \"#{self.intro}\""
        end
        # Special SMS for last sentence.
        # Note: Could modify such that it doesn't do this for turn 6, since we viral loop a new story SMS,
        # so it sends 2 SMSes.  But it could cause issues since what if he never starts a new story?  Then user will never
        # be notified of completing previous one.
      elsif turn == 6
        line = "#{curr_playing_user.first_name} completed your story!"
        if line.length + " \"#{sentence}\"".length + line_ending.length <= 160
          line += " \"#{sentence}\""
        end
      else
        # Send an SMS that 'I added to your story' otherwise.
        line = "#{curr_playing_user.first_name} added to your story!"
        if line.length + " \"#{sentence}\"".length + line_ending.length <= 160
          line += " \"#{sentence}\""
        end
      end

      line += line_ending
      puts "SENDING SMS: \'#{line}\'"
      send_sms(line, curr_waiting_user)

      # TODO: Other types of notifications
    end
end
