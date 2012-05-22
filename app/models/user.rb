class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for model (devise) -- for mass assignment
  # attr_accessible :first_name, :phone, :email, :password, :password_confirmation, :remember_me, :facebook_uid, :super_user
  # attr_protected

  has_many :players, :dependent => :destroy
  has_many :stories, :through => :players			# many-to-many.  TODO: figure out how to do cascading delete with HABTM
  accepts_nested_attributes_for :stories, :allow_destroy => true

  validates_presence_of :first_name, :email

  # Returns a list of all users other than one
  scope :all_except, lambda{|user| user ? {:conditions => ["id != ?", user.id]} : {} }

  def name
    first_name
  end

  def name=(attributes)
  end

  # Returns a list of potential partners
  # Should only be your Facebook friends, unless you're a "super user"
  # Should not return users you're already in a game with
  def available_partners
    # TODO: Use api-read.facebook.com for this

    # Ask Facebook for all uids of all my FB friends
    fb_friend_list = FbGraph::Query.new('select uid from user where uid in (select uid2 from friend where uid1=me())').fetch(self.facebook_token)
    fb_uid_list = Array.new
    fb_friend_list.each do |friend|
      fb_uid_list.push friend[:uid]
    end

    # Find all user accounts who have a facebook UID in that list
    fb_friend_partners = User.where('facebook_uid in (?)', fb_uid_list).all

    # Find all superuser test accounts if we're a super user
    super_user_partners = User.find_all_by_super_user(true) if self.super_user

    # Find all my current unfinished game partners
    unfinished_partners = Array.new
    self.stories.each do |story|
      if !story.finished
        unfinished_partners.push story.partner_of(self)
      end
    end

    # Remove current unfinished game partners from superuser list
    super_user_partners.delete_if do |super_user_partner|
      dupe = false
      unfinished_partners.each do |unfinished_partner|
        dupe = true if (unfinished_partner && super_user_partner && unfinished_partner.id == super_user_partner.id)
      end

      # Don't allow yourself to be a superuser partner
      dupe = true if (super_user_partner.id == self.id)

      dupe
    end

    # Remove current unfinished game partners from Facebook friends list
    fb_friend_partners.delete_if do |fb_friend_partner|
      dupe = false
      unfinished_partners.each do |unfinished_partner|
        dupe = true if (unfinished_partner && fb_friend_partner && unfinished_partner.id == fb_friend_partner.id)
      end
      dupe
    end

    # De-dupe
    super_user_partners.delete_if do |super_user_partner|
      dupe = false
      fb_friend_partners.each do |friend_partner|
        dupe = true if (super_user_partner.id == friend_partner.id || super_user_partner.id == self.id)
      end
      dupe
    end

    # Merge the combined results
    partners = fb_friend_partners + super_user_partners

    return partners
  end

  # Get detailed facebook data about a list of users
  def User.facebook_data(users)
    # TODO: Use api-read.facebook.com for this

    user_uids = Array.new
    users.each do |user|
      user_uids.push user[:facebook_uid]
    end

    detailed_accounts = FbGraph::Query.new(
        "select name, uid, pic_square from user where uid in (#{user_uids})"
    ).fetch(self.facebook_token)

    detailed_accounts.sort! { |a,b| a[:name] <=> b[:name] }

    return detailed_accounts
  end

  before_validation :downcase_email
  before_validation :format_phone

  private

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end

  def format_phone
    return if !self.phone
    return if self.phone.length == 0

    self.phone = "+1 " + self.phone if (self.phone[0] != '+')
  end
end
