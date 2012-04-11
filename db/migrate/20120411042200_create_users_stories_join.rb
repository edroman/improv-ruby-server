class CreateUsersStoriesJoin < ActiveRecord::Migration
  def self.up
    create_table 'users_stories', :id => false do |t|
      t.column :user_id, :integer
      t.column :story_id, :integer
    end
  end

  def self.down
    drop_table 'users_stories'
  end
end
