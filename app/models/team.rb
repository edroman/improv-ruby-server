class Team < ActiveRecord::Base
  has_many :stories						                                # one-to-many
  has_and_belongs_to_many :users, :join_table => :users_teams	# many-to-many

  accepts_nested_attributes_for :stories, :allow_destroy => true
  accepts_nested_attributes_for :users, :allow_destroy => true

  def find_all_by_user(user)
    user.teams
  end

  def name
    str = ""
    if (users.size == 0)
      str = "Empty-Team-#{id}"
    else
      users.each do |user|
        if (user != users.first)
          str += "+"
        end
        str += user.first_name
      end
    end
    return str
  end

  def name=(attributes)
  end
end
